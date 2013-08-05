From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 5 Aug 2013 19:21:00 +0800
Subject: [PATCH V2 4/8] ARM: tegra: add common LP1 suspend support
In-Reply-To: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
References: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
Message-ID: <1375701664-14965-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP1 suspending mode on Tegra means CPU rail off, devices and PLLs are
clock gated and SDRAM in self-refresh mode. That means the low level LP1
suspending and resuming code couldn't be run on DRAM and the CPU must
switch to the always on clock domain (a.k.a. CLK_M 12MHz oscillator). And
the system clock (SCLK) would be switched to CLK_S, a 32KHz oscillator.
The LP1 low level handling code need to be moved to IRAM area first. And
marking the LP1 mask for indicating the Tegra device is in LP1. The CPU
power timer needs to be re-calculated based on 32KHz that was originally
based on PCLK.

When resuming from LP1, the LP1 reset handler will resume PLLs and then
put DRAM to normal mode. Then jumping to the "tegra_resume" that will
restore full context before back to kernel. The "tegra_resume" handler
was expected to be found in PMC_SCRATCH41 register.

This is common LP1 procedures for Tegra, so we do these jobs mainly in
this patch:
* moving LP1 low level handling code to IRAM
* marking LP1 mask
* copying the physical address of "tegra_resume" to PMC_SCRATCH41
* re-calculate the CPU power timer based on 32KHz

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* don't duplicate tegraXX_lp1_iram for different SoC
* unify the suspend func call to cpu_suspend with "tegra_sleep_func"
---
 arch/arm/mach-tegra/pm.c    | 108 ++++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-tegra/pm.h    |   7 +++
 arch/arm/mach-tegra/pmc.c   |  21 +++++++++
 arch/arm/mach-tegra/pmc.h   |   3 ++
 arch/arm/mach-tegra/reset.h |   4 ++
 5 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 5792872..09cfa4b 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -37,12 +37,19 @@
 #include "reset.h"
 #include "flowctrl.h"
 #include "fuse.h"
+#include "pm.h"
 #include "pmc.h"
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
 static DEFINE_SPINLOCK(tegra_lp2_lock);
+static void __iomem *iram_code = IO_ADDRESS(TEGRA_IRAM_CODE_AREA);
+static u32 iram_save_size;
+static void *iram_save_addr;
+struct tegra_lp1_iram tegra_lp1_iram;
 void (*tegra_tear_down_cpu)(void);
+void (*tegra_sleep_core_finish)(unsigned long v2p);
+static int (*tegra_sleep_func)(unsigned long v2p);
 
 static void tegra_tear_down_cpu_init(void)
 {
@@ -174,14 +181,75 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode)
 {
 	/*
-	 * The Tegra devices only support suspending to LP2 currently.
+	 * The Tegra devices support suspending to LP1 or lower currently.
 	 */
-	if (mode > TEGRA_SUSPEND_LP2)
-		return TEGRA_SUSPEND_LP2;
+	if (mode > TEGRA_SUSPEND_LP1)
+		return TEGRA_SUSPEND_LP1;
 
 	return mode;
 }
 
+static int tegra_sleep_core(unsigned long v2p)
+{
+	setup_mm_for_reboot();
+	tegra_sleep_core_finish(v2p);
+
+	/* should never here */
+	BUG();
+
+	return 0;
+}
+
+/*
+ * tegra_lp1_iram_hook
+ *
+ * Hooking the address of LP1 reset vector and SDRAM self-refresh code in
+ * SDRAM. These codes not be copied to IRAM in this fuction. We need to
+ * copy these code to IRAM before LP0/LP1 suspend and restore the content
+ * of IRAM after resume.
+ */
+static bool tegra_lp1_iram_hook(void)
+{
+	if (!tegra_lp1_iram.start_addr || !tegra_lp1_iram.end_addr)
+		return false;
+
+	iram_save_size = tegra_lp1_iram.end_addr - tegra_lp1_iram.start_addr;
+	iram_save_addr = kmalloc(iram_save_size, GFP_KERNEL);
+	if (!iram_save_addr)
+		return false;
+
+	return true;
+}
+
+static bool tegra_sleep_core_init(void)
+{
+	if (!tegra_sleep_core_finish)
+		return false;
+
+	return true;
+}
+
+static void tegra_suspend_enter_lp1(void)
+{
+	tegra_pmc_suspend();
+
+	/* copy the reset vector & SDRAM shutdown code into IRAM */
+	memcpy(iram_save_addr, iram_code, iram_save_size);
+	memcpy(iram_code, tegra_lp1_iram.start_addr, iram_save_size);
+
+	*((u32 *)tegra_cpu_lp1_mask) = 1;
+}
+
+static void tegra_suspend_exit_lp1(void)
+{
+	tegra_pmc_resume();
+
+	/* restore IRAM */
+	memcpy(iram_code, iram_save_addr, iram_save_size);
+
+	*(u32 *)tegra_cpu_lp1_mask = 0;
+}
+
 static const char *lp_state[TEGRA_MAX_SUSPEND_MODE] = {
 	[TEGRA_SUSPEND_NONE] = "none",
 	[TEGRA_SUSPEND_LP2] = "LP2",
@@ -205,6 +273,9 @@ static int tegra_suspend_enter(suspend_state_t state)
 
 	suspend_cpu_complex();
 	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		tegra_suspend_enter_lp1();
+		break;
 	case TEGRA_SUSPEND_LP2:
 		tegra_set_cpu_in_lp2();
 		break;
@@ -212,9 +283,12 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
-	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
 	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		tegra_suspend_exit_lp1();
+		break;
 	case TEGRA_SUSPEND_LP2:
 		tegra_clear_cpu_in_lp2();
 		break;
@@ -235,12 +309,36 @@ static const struct platform_suspend_ops tegra_suspend_ops = {
 
 void __init tegra_init_suspend(void)
 {
-	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NONE)
+	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
+
+	if (mode == TEGRA_SUSPEND_NONE)
 		return;
 
 	tegra_tear_down_cpu_init();
 	tegra_pmc_suspend_init();
 
+	if (mode >= TEGRA_SUSPEND_LP1) {
+		if (!tegra_lp1_iram_hook() || !tegra_sleep_core_init()) {
+			pr_err("%s: unable to allocate memory for SDRAM"
+			       "self-refresh -- LP0/LP1 unavailable\n",
+			       __func__);
+			tegra_pmc_set_suspend_mode(TEGRA_SUSPEND_LP2);
+			mode = TEGRA_SUSPEND_LP2;
+		}
+	}
+
+	/* set up sleep function for cpu_suspend */
+	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		tegra_sleep_func = tegra_sleep_core;
+		break;
+	case TEGRA_SUSPEND_LP2:
+		tegra_sleep_func = tegra_sleep_cpu;
+		break;
+	default:
+		break;
+	}
+
 	suspend_set_ops(&tegra_suspend_ops);
 }
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 94c4b9d..478706e 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -23,6 +23,13 @@
 
 #include "pmc.h"
 
+struct tegra_lp1_iram {
+	void	*start_addr;
+	void	*end_addr;
+};
+extern struct tegra_lp1_iram tegra_lp1_iram;
+extern void (*tegra_sleep_core_finish)(unsigned long v2p);
+
 extern unsigned long l2x0_saved_regs_addr;
 
 void save_cpu_arch_register(void);
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 03e6405..8acb881 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -196,6 +196,24 @@ enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
 	return pmc_pm_data.suspend_mode;
 }
 
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
+{
+	if (mode < TEGRA_SUSPEND_NONE || mode >= TEGRA_MAX_SUSPEND_MODE)
+		return;
+
+	pmc_pm_data.suspend_mode = mode;
+}
+
+void tegra_pmc_suspend(void)
+{
+	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH41);
+}
+
+void tegra_pmc_resume(void)
+{
+	tegra_pmc_writel(0x0, PMC_SCRATCH41);
+}
+
 void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
 {
 	u32 reg, csr_reg;
@@ -219,6 +237,9 @@ void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
 	}
 
 	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		rate = 32768;
+		break;
 	case TEGRA_SUSPEND_LP2:
 		rate = clk_get_rate(tegra_pclk);
 		break;
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index e1c2df2..549f8c7 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -28,6 +28,9 @@ enum tegra_suspend_mode {
 
 #ifdef CONFIG_PM_SLEEP
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+void tegra_pmc_suspend(void);
+void tegra_pmc_resume(void);
 void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
 void tegra_pmc_suspend_init(void);
 #endif
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index c90d8e9..76a9343 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -39,6 +39,10 @@ void __tegra_cpu_reset_handler_end(void);
 void tegra_secondary_startup(void);
 
 #ifdef CONFIG_PM_SLEEP
+#define tegra_cpu_lp1_mask \
+	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
+	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_LP1] - \
+	 (u32)__tegra_cpu_reset_handler_start)))
 #define tegra_cpu_lp2_mask \
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
 	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_LP2] - \
-- 
1.8.3.4
