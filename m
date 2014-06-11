From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Jun 2014 13:48:05 +0200
Subject: [PATCH] ARM: tegra: powergate: Use PMC register accessors
Message-ID: <1402487285-5626-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Instead of I/O remapping the registers itself, make the powergate API
use the PMC register accessors from the PMC implementation.

This is necessary to allow these drivers to be moved out of arch/arm,
which in turn will be needed to share code with 64-bit Tegra SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/pmc.c       | 13 +------------
 arch/arm/mach-tegra/pmc.h       | 13 +++++++++++++
 arch/arm/mach-tegra/powergate.c | 40 ++++++++++++++--------------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 7c7123e7557b..f8c86b49a1db 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -17,7 +17,6 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/tegra-powergate.h>
@@ -60,9 +59,9 @@ static u8 tegra_cpu_domains[] = {
 };
 static DEFINE_SPINLOCK(tegra_powergate_lock);
 
-static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
 static struct clk *tegra_pclk;
+void __iomem *tegra_pmc_base;
 
 struct pmc_pm_data {
 	u32 cpu_good_time;	/* CPU power good time in uS */
@@ -80,16 +79,6 @@ struct pmc_pm_data {
 };
 static struct pmc_pm_data pmc_pm_data;
 
-static inline u32 tegra_pmc_readl(u32 reg)
-{
-	return readl(tegra_pmc_base + reg);
-}
-
-static inline void tegra_pmc_writel(u32 val, u32 reg)
-{
-	writel(val, tegra_pmc_base + reg);
-}
-
 static int tegra_pmc_get_cpu_powerdomain_id(int cpuid)
 {
 	if (cpuid <= 0 || cpuid >= num_possible_cpus())
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 59e19c344298..139a30867cb2 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -18,6 +18,7 @@
 #ifndef __MACH_TEGRA_PMC_H
 #define __MACH_TEGRA_PMC_H
 
+#include <linux/io.h>
 #include <linux/reboot.h>
 
 enum tegra_suspend_mode {
@@ -37,6 +38,18 @@ void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
 void tegra_pmc_suspend_init(void);
 #endif
 
+extern void __iomem *tegra_pmc_base;
+
+static inline u32 tegra_pmc_readl(u32 reg)
+{
+	return readl(tegra_pmc_base + reg);
+}
+
+static inline void tegra_pmc_writel(u32 val, u32 reg)
+{
+	writel(val, tegra_pmc_base + reg);
+}
+
 bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 4cefc5cd6bed..f5fe5c5fa3f5 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -32,7 +32,7 @@
 #include <linux/tegra-powergate.h>
 
 #include "fuse.h"
-#include "iomap.h"
+#include "pmc.h"
 
 #define DPD_SAMPLE		0x020
 #define  DPD_SAMPLE_ENABLE	(1 << 0)
@@ -85,18 +85,6 @@ static const u8 tegra124_cpu_domains[] = {
 
 static DEFINE_SPINLOCK(tegra_powergate_lock);
 
-static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
-
-static u32 pmc_read(unsigned long reg)
-{
-	return readl(pmc + reg);
-}
-
-static void pmc_write(u32 val, unsigned long reg)
-{
-	writel(val, pmc + reg);
-}
-
 static int tegra_powergate_set(int id, bool new_state)
 {
 	bool status;
@@ -104,14 +92,14 @@ static int tegra_powergate_set(int id, bool new_state)
 
 	spin_lock_irqsave(&tegra_powergate_lock, flags);
 
-	status = pmc_read(PWRGATE_STATUS) & (1 << id);
+	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
 
 	if (status == new_state) {
 		spin_unlock_irqrestore(&tegra_powergate_lock, flags);
 		return 0;
 	}
 
-	pmc_write(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
+	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
 	spin_unlock_irqrestore(&tegra_powergate_lock, flags);
 
@@ -142,7 +130,7 @@ int tegra_powergate_is_powered(int id)
 	if (id < 0 || id >= tegra_num_powerdomains)
 		return -EINVAL;
 
-	status = pmc_read(PWRGATE_STATUS) & (1 << id);
+	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
 	return !!status;
 }
 
@@ -159,7 +147,7 @@ int tegra_powergate_remove_clamping(int id)
 	 */
 	if (tegra_chip_id == TEGRA124) {
 		if (id == TEGRA_POWERGATE_3D) {
-			pmc_write(0, GPU_RG_CNTRL);
+			tegra_pmc_writel(0, GPU_RG_CNTRL);
 			return 0;
 		}
 	}
@@ -175,7 +163,7 @@ int tegra_powergate_remove_clamping(int id)
 	else
 		mask = (1 << id);
 
-	pmc_write(mask, REMOVE_CLAMPING);
+	tegra_pmc_writel(mask, REMOVE_CLAMPING);
 
 	return 0;
 }
@@ -425,12 +413,12 @@ static int tegra_io_rail_prepare(int id, unsigned long *request,
 	rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	pmc_write(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
+	tegra_pmc_writel(DPD_SAMPLE_ENABLE, DPD_SAMPLE);
 
 	/* must be@least 200 ns, in APB (PCLK) clock cycles */
 	value = DIV_ROUND_UP(1000000000, rate);
 	value = DIV_ROUND_UP(200, value);
-	pmc_write(value, SEL_DPD_TIM);
+	tegra_pmc_writel(value, SEL_DPD_TIM);
 
 	return 0;
 }
@@ -443,7 +431,7 @@ static int tegra_io_rail_poll(unsigned long offset, unsigned long mask,
 	timeout = jiffies + msecs_to_jiffies(timeout);
 
 	while (time_after(timeout, jiffies)) {
-		value = pmc_read(offset);
+		value = tegra_pmc_readl(offset);
 		if ((value & mask) == val)
 			return 0;
 
@@ -455,7 +443,7 @@ static int tegra_io_rail_poll(unsigned long offset, unsigned long mask,
 
 static void tegra_io_rail_unprepare(void)
 {
-	pmc_write(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
+	tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
 }
 
 int tegra_io_rail_power_on(int id)
@@ -470,11 +458,11 @@ int tegra_io_rail_power_on(int id)
 
 	mask = 1 << bit;
 
-	value = pmc_read(request);
+	value = tegra_pmc_readl(request);
 	value |= mask;
 	value &= ~IO_DPD_REQ_CODE_MASK;
 	value |= IO_DPD_REQ_CODE_OFF;
-	pmc_write(value, request);
+	tegra_pmc_writel(value, request);
 
 	err = tegra_io_rail_poll(status, mask, 0, 250);
 	if (err < 0)
@@ -498,11 +486,11 @@ int tegra_io_rail_power_off(int id)
 
 	mask = 1 << bit;
 
-	value = pmc_read(request);
+	value = tegra_pmc_readl(request);
 	value |= mask;
 	value &= ~IO_DPD_REQ_CODE_MASK;
 	value |= IO_DPD_REQ_CODE_ON;
-	pmc_write(value, request);
+	tegra_pmc_writel(value, request);
 
 	err = tegra_io_rail_poll(status, mask, mask, 250);
 	if (err < 0)
-- 
1.9.2
