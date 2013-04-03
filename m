From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:28 +0800
Subject: [PATCH V4 2/2] ARM: tegra: moving the CPU power timer function to PMC
 driver
In-Reply-To: <1364988688-24613-1-git-send-email-josephl@nvidia.com>
References: <1364988688-24613-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988688-24613-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU power timer set up function was related to PMC register. Now moving
it to PMC driver. And it also help to clean up the PM related code later.

The timer was calculated based on the input clock of PMC. In this patch, we
also get the clock from DT.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* move the c code from previous patch to here
V3:
* no change
V2:
* the PCLK is from DT not hard code
---
 arch/arm/mach-tegra/common.c |  2 +-
 arch/arm/mach-tegra/pm.c     | 37 +------------------------------------
 arch/arm/mach-tegra/pmc.c    | 35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h    |  4 ++++
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f0315c9..b02ebe7 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -61,6 +61,7 @@ u32 tegra_uart_config[4] = {
 void __init tegra_dt_init_irq(void)
 {
 	tegra_clocks_init();
+	tegra_pmc_init();
 	tegra_init_irq();
 	irqchip_init();
 }
@@ -100,7 +101,6 @@ void __init tegra_init_early(void)
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra_init_cache();
-	tegra_pmc_init();
 	tegra_powergate_init();
 	tegra_hotplug_init();
 }
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index acacbe8..ef12c0d 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -22,7 +22,6 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/cpu_pm.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/clk/tegra.h>
 
@@ -37,52 +36,18 @@
 #include "reset.h"
 #include "flowctrl.h"
 #include "fuse.h"
+#include "pmc.h"
 #include "sleep.h"
 
 #define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
 
 #define PMC_CTRL		0x0
-#define PMC_CPUPWRGOOD_TIMER	0xc8
-#define PMC_CPUPWROFF_TIMER	0xcc
 
 #ifdef CONFIG_PM_SLEEP
 static DEFINE_SPINLOCK(tegra_lp2_lock);
 static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
-static struct clk *tegra_pclk;
 void (*tegra_tear_down_cpu)(void);
 
-static void set_power_timers(unsigned long us_on, unsigned long us_off)
-{
-	unsigned long long ticks;
-	unsigned long long pclk;
-	unsigned long rate;
-	static unsigned long tegra_last_pclk;
-
-	if (tegra_pclk == NULL) {
-		tegra_pclk = clk_get_sys(NULL, "pclk");
-		WARN_ON(IS_ERR(tegra_pclk));
-	}
-
-	rate = clk_get_rate(tegra_pclk);
-
-	if (WARN_ON_ONCE(rate <= 0))
-		pclk = 100000000;
-	else
-		pclk = rate;
-
-	if ((rate != tegra_last_pclk)) {
-		ticks = (us_on * pclk) + 999999ull;
-		do_div(ticks, 1000000);
-		writel((unsigned long)ticks, pmc + PMC_CPUPWRGOOD_TIMER);
-
-		ticks = (us_off * pclk) + 999999ull;
-		do_div(ticks, 1000000);
-		writel((unsigned long)ticks, pmc + PMC_CPUPWROFF_TIMER);
-		wmb();
-	}
-	tegra_last_pclk = pclk;
-}
-
 /*
  * restore_cpu_complex
  *
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index b30e921..faa33e8 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -27,6 +28,9 @@
 #define PMC_REMOVE_CLAMPING		0x34
 #define PMC_PWRGATE_STATUS		0x38
 
+#define PMC_CPUPWRGOOD_TIMER	0xc8
+#define PMC_CPUPWROFF_TIMER	0xcc
+
 #define TEGRA_POWERGATE_PCIE	3
 #define TEGRA_POWERGATE_VDEC	4
 #define TEGRA_POWERGATE_CPU1	9
@@ -43,6 +47,7 @@ static DEFINE_SPINLOCK(tegra_powergate_lock);
 
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
+static struct clk *tegra_pclk;
 
 static inline u32 tegra_pmc_readl(u32 reg)
 {
@@ -133,6 +138,34 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 	return tegra_pmc_powergate_remove_clamping(id);
 }
 
+#ifdef CONFIG_PM_SLEEP
+void set_power_timers(unsigned long us_on, unsigned long us_off)
+{
+	unsigned long long ticks;
+	unsigned long long pclk;
+	unsigned long rate;
+	static unsigned long tegra_last_pclk;
+
+	rate = clk_get_rate(tegra_pclk);
+	if (WARN_ON_ONCE(rate <= 0))
+		pclk = 100000000;
+	else
+		pclk = rate;
+
+	if ((rate != tegra_last_pclk)) {
+		ticks = (us_on * pclk) + 999999ull;
+		do_div(ticks, 1000000);
+		tegra_pmc_writel((unsigned long)ticks, PMC_CPUPWRGOOD_TIMER);
+
+		ticks = (us_off * pclk) + 999999ull;
+		do_div(ticks, 1000000);
+		tegra_pmc_writel((unsigned long)ticks, PMC_CPUPWROFF_TIMER);
+		wmb();
+	}
+	tegra_last_pclk = pclk;
+}
+#endif
+
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
@@ -151,6 +184,8 @@ static void tegra_pmc_parse_dt(void)
 
 	tegra_pmc_invert_interrupt = of_property_read_bool(np,
 				     "nvidia,invert-interrupt");
+	tegra_pclk = of_clk_get_by_name(np, "pclk");
+	WARN_ON(IS_ERR(tegra_pclk));
 }
 
 void __init tegra_pmc_init(void)
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 7d44710..22f16c9 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -18,6 +18,10 @@
 #ifndef __MACH_TEGRA_PMC_H
 #define __MACH_TEGRA_PMC_H
 
+#ifdef CONFIG_PM_SLEEP
+void set_power_timers(unsigned long us_on, unsigned long us_off);
+#endif
+
 bool tegra_pmc_cpu_is_powered(int cpuid);
 int tegra_pmc_cpu_power_on(int cpuid);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
-- 
1.8.2
