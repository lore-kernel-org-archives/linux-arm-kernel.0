From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:20:08 +0800
Subject: [PATCH V5 4/9] ARM: tegra: pm: add platform suspend support
In-Reply-To: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901613-25080-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding suspend to RAM support for Tegra platform. There are three suspend
mode for Tegra. The difference were below.

* LP2: CPU voltage off
* LP1: CPU voltage off, DRAM in self-refresh
* LP0: CPU + Core voltage off, DRAM in self-refresh

After this patch, the LP2 suspend mode will be supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V5:
* move tegra_init_suspend() to tegra_init_late()
* remove useless BUG_ON for the polarity of CPU power request
V4:
* add tegra_pm_validate_suspend_mode() to validate the suspend mode config
  from DT
* squash the patch below that origianl being introduced after this series
  to clean up some PM related code
  [2/3] ARM: tegra: refactor the pmc_pm_set function
V3:
* add a protection for only support LP2 suspend mode
V2:
* add the PM_SLEEP protection for "tegra_init_suspend"
* remove "tegra_suspend_{enter/exit}_lp2"
* refactor the "tegra_pmc_pm_set" for non-used parameter
* replace "unsigned long" with "u32" for tegra_pmc_get_cpu_time
---
 arch/arm/mach-tegra/common.c |  1 +
 arch/arm/mach-tegra/pm.c     | 93 +++++++++++++++++++++++++++++++++++++-------
 arch/arm/mach-tegra/pm.h     | 15 +++++++
 arch/arm/mach-tegra/pmc.c    | 51 ++++++++++++++++++++++--
 arch/arm/mach-tegra/pmc.h    |  4 +-
 5 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index c84505c..eb1f3c8 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -109,5 +109,6 @@ void __init tegra_init_early(void)
 
 void __init tegra_init_late(void)
 {
+	tegra_init_suspend();
 	tegra_powergate_debugfs_init();
 }
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index ef12c0d..14957ff 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/cpu_pm.h>
+#include <linux/suspend.h>
 #include <linux/err.h>
 #include <linux/clk/tegra.h>
 
@@ -38,14 +39,10 @@
 #include "fuse.h"
 #include "pmc.h"
 #include "sleep.h"
-
-#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
-
-#define PMC_CTRL		0x0
+#include "pmc.h"
 
 #ifdef CONFIG_PM_SLEEP
 static DEFINE_SPINLOCK(tegra_lp2_lock);
-static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
 void (*tegra_tear_down_cpu)(void);
 
 /*
@@ -140,14 +137,7 @@ static int tegra_sleep_cpu(unsigned long v2p)
 
 void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
 {
-	u32 mode;
-
-	/* Only the last cpu down does the final suspend steps */
-	mode = readl(pmc + PMC_CTRL);
-	mode |= TEGRA_POWER_CPU_PWRREQ_OE;
-	writel(mode, pmc + PMC_CTRL);
-
-	set_power_timers(cpu_on_time, cpu_off_time);
+	tegra_pmc_pm_set(TEGRA_SUSPEND_LP2);
 
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
@@ -157,4 +147,81 @@ void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time)
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
+
+enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+				enum tegra_suspend_mode mode)
+{
+	/* Tegra114 didn't support any suspending mode yet. */
+	if (tegra_chip_id == TEGRA114)
+		return TEGRA_SUSPEND_NONE;
+
+	/*
+	 * The Tegra devices only support suspending to LP2 currently.
+	 */
+	if (mode > TEGRA_SUSPEND_LP2)
+		return TEGRA_SUSPEND_LP2;
+
+	return mode;
+}
+
+static const char *lp_state[TEGRA_MAX_SUSPEND_MODE] = {
+	[TEGRA_SUSPEND_NONE] = "none",
+	[TEGRA_SUSPEND_LP2] = "LP2",
+	[TEGRA_SUSPEND_LP1] = "LP1",
+	[TEGRA_SUSPEND_LP0] = "LP0",
+};
+
+static int __cpuinit tegra_suspend_enter(suspend_state_t state)
+{
+	enum tegra_suspend_mode mode = tegra_pmc_get_suspend_mode();
+
+	if (WARN_ON(mode < TEGRA_SUSPEND_NONE ||
+		    mode >= TEGRA_MAX_SUSPEND_MODE))
+		return -EINVAL;
+
+	pr_info("Entering suspend state %s\n", lp_state[mode]);
+
+	tegra_pmc_pm_set(mode);
+
+	local_fiq_disable();
+
+	suspend_cpu_complex();
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_set_cpu_in_lp2(0);
+		break;
+	default:
+		break;
+	}
+
+	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		tegra_clear_cpu_in_lp2(0);
+		break;
+	default:
+		break;
+	}
+	restore_cpu_complex();
+
+	local_fiq_enable();
+
+	return 0;
+}
+
+static const struct platform_suspend_ops tegra_suspend_ops = {
+	.valid		= suspend_valid_only_mem,
+	.enter		= tegra_suspend_enter,
+};
+
+void __init tegra_init_suspend(void)
+{
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NONE)
+		return;
+
+	tegra_pmc_suspend_init();
+
+	suspend_set_ops(&tegra_suspend_ops);
+}
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 787335c..73a45f1 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -21,6 +21,8 @@
 #ifndef _MACH_TEGRA_PM_H_
 #define _MACH_TEGRA_PM_H_
 
+#include "pmc.h"
+
 extern unsigned long l2x0_saved_regs_addr;
 
 void save_cpu_arch_register(void);
@@ -32,4 +34,17 @@ bool tegra_set_cpu_in_lp2(int phy_cpu_id);
 void tegra_idle_lp2_last(u32 cpu_on_time, u32 cpu_off_time);
 extern void (*tegra_tear_down_cpu)(void);
 
+#ifdef CONFIG_PM_SLEEP
+enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+				enum tegra_suspend_mode mode);
+void tegra_init_suspend(void);
+#else
+enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+				enum tegra_suspend_mode mode)
+{
+	return TEGRA_SUSPEND_NONE;
+}
+static inline void tegra_init_suspend(void) {}
+#endif
+
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 5323bca..0d50d34 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -21,7 +21,14 @@
 #include <linux/of_address.h>
 #include <linux/clk.h>
 
+#include "fuse.h"
+#include "pm.h"
 #include "pmc.h"
+#include "sleep.h"
+
+#define TEGRA_POWER_EFFECT_LP0		(1 << 14)  /* LP0 when CPU pwr gated */
+#define TEGRA_POWER_CPU_PWRREQ_POLARITY	(1 << 15)  /* CPU pwr req polarity */
+#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
 
 #define PMC_CTRL			0x0
 #define PMC_CTRL_INTR_LOW		(1 << 17)
@@ -157,15 +164,12 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 }
 
 #ifdef CONFIG_PM_SLEEP
-void set_power_timers(unsigned long us_on, unsigned long us_off)
+static void set_power_timers(u32 us_on, u32 us_off, unsigned long rate)
 {
 	unsigned long long ticks;
 	unsigned long long pclk;
-	unsigned long rate;
 	static unsigned long tegra_last_pclk;
 
-	rate = clk_get_rate(tegra_pclk);
-
 	if (WARN_ON_ONCE(rate <= 0))
 		pclk = 100000000;
 	else
@@ -183,6 +187,44 @@ void set_power_timers(unsigned long us_on, unsigned long us_off)
 	}
 	tegra_last_pclk = pclk;
 }
+
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return pmc_pm_data.suspend_mode;
+}
+
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
+{
+	u32 reg;
+	unsigned long rate = 0;
+
+	reg = tegra_pmc_readl(PMC_CTRL);
+	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
+	reg &= ~TEGRA_POWER_EFFECT_LP0;
+
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		rate = clk_get_rate(tegra_pclk);
+		break;
+	default:
+		break;
+	}
+
+	set_power_timers(pmc_pm_data.cpu_good_time, pmc_pm_data.cpu_off_time,
+			 rate);
+
+	tegra_pmc_writel(reg, PMC_CTRL);
+}
+
+void tegra_pmc_suspend_init(void)
+{
+	u32 reg;
+
+	/* Always enable CPU power request */
+	reg = tegra_pmc_readl(PMC_CTRL);
+	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
+	tegra_pmc_writel(reg, PMC_CTRL);
+}
 #endif
 
 static const struct of_device_id matches[] __initconst = {
@@ -229,6 +271,7 @@ static void tegra_pmc_parse_dt(void)
 			break;
 		}
 	}
+	suspend_mode = tegra_pm_validate_suspend_mode(suspend_mode);
 
 	if (of_property_read_u32(np, "nvidia,cpu-pwr-good-time", &prop))
 		suspend_mode = TEGRA_SUSPEND_NONE;
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 6bc0fc09..e1c2df2 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -27,7 +27,9 @@ enum tegra_suspend_mode {
 };
 
 #ifdef CONFIG_PM_SLEEP
-void set_power_timers(unsigned long us_on, unsigned long us_off);
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
+void tegra_pmc_suspend_init(void);
 #endif
 
 bool tegra_pmc_cpu_is_powered(int cpuid);
-- 
1.8.2
