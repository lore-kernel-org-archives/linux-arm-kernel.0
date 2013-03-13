From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 16:27:24 +0800
Subject: [PATCH 1/3] ARM: tegra: moving the CPU power timer function to PMC
 driver
Message-ID: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU power timer set up fucntion was related to PMC register. Now moving
it to PMC driver. And it also help to clean up the PM related code later.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
This series was based on the patch set of suspending support.
---
 arch/arm/mach-tegra/pm.c  | 36 ------------------------------------
 arch/arm/mach-tegra/pmc.c | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h |  1 +
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 915e13b..b7cc637 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/cpu_pm.h>
 #include <linux/suspend.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/clk/tegra.h>
 
@@ -44,47 +43,12 @@
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
index f0c5435..bb1fe8e 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/clk.h>
 
 #include "fuse.h"
 #include "pmc.h"
@@ -52,6 +53,9 @@ static DEFINE_SPINLOCK(tegra_powergate_lock);
 static void __iomem *tegra_pmc_base;
 static bool tegra_pmc_invert_interrupt;
 
+#define PMC_CPUPWRGOOD_TIMER	0xc8
+#define PMC_CPUPWROFF_TIMER	0xcc
+
 struct pmc_pm_data {
 	u32 cpu_good_time;	/* CPU power good time in uS */
 	u32 cpu_off_time;	/* CPU power off time in uS */
@@ -158,6 +162,40 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static struct clk *tegra_pclk;
+
+void set_power_timers(unsigned long us_on, unsigned long us_off)
+{
+	unsigned long long ticks;
+	unsigned long long pclk;
+	unsigned long rate;
+	static unsigned long tegra_last_pclk;
+
+	if (tegra_pclk == NULL) {
+		tegra_pclk = clk_get_sys(NULL, "pclk");
+		WARN_ON(IS_ERR(tegra_pclk));
+	}
+
+	rate = clk_get_rate(tegra_pclk);
+
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
+
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
 {
 	return pmc_pm_data.suspend_mode;
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 72b2cee..9413a44 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -27,6 +27,7 @@ enum tegra_suspend_mode {
 };
 
 #ifdef CONFIG_PM_SLEEP
+void set_power_timers(unsigned long us_on, unsigned long us_off);
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
 void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
 u32 tegra_pmc_get_cpu_good_time(void);
-- 
1.8.1.5
