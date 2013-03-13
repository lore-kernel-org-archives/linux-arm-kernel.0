From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 16:27:25 +0800
Subject: [PATCH 2/3] ARM: tegra: refactor the pmc_pm_set function
In-Reply-To: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
References: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363163246-26368-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmc_pm_set function was designed for SoC to configure the related
settings when system going to some low power modes (e.g. platform
suspend or CPU idle powered-down mode). We refactor the function to make
it work on the usage.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
This series was based on the patch set of suspending support.
---
 arch/arm/mach-tegra/pm.c  | 18 ++----------------
 arch/arm/mach-tegra/pmc.c | 38 ++++++++++++++++++--------------------
 arch/arm/mach-tegra/pmc.h |  5 +----
 3 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index b7cc637..2a04dfc 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -40,13 +40,8 @@
 #include "sleep.h"
 #include "pmc.h"
 
-#define TEGRA_POWER_CPU_PWRREQ_OE	(1 << 16)  /* CPU pwr req enable */
-
-#define PMC_CTRL		0x0
-
 #ifdef CONFIG_PM_SLEEP
 static DEFINE_SPINLOCK(tegra_lp2_lock);
-static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
 void (*tegra_tear_down_cpu)(void);
 
 /*
@@ -146,14 +141,7 @@ static int tegra_sleep_cpu(unsigned long v2p)
 
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
@@ -181,9 +169,7 @@ static int __cpuinit tegra_suspend_enter(suspend_state_t state)
 
 	pr_info("Entering suspend state %s\n", lp_state[mode]);
 
-	tegra_pmc_pm_set();
-	set_power_timers(tegra_pmc_get_cpu_good_time(),
-			 tegra_pmc_get_cpu_off_time());
+	tegra_pmc_pm_set(mode);
 
 	local_fiq_disable();
 
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index bb1fe8e..118a465 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 
 #include "fuse.h"
 #include "pmc.h"
@@ -164,20 +165,12 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 #ifdef CONFIG_PM_SLEEP
 static struct clk *tegra_pclk;
 
-void set_power_timers(unsigned long us_on, unsigned long us_off)
+static void set_power_timers(u32 us_on, u32 us_off, unsigned long rate)
 {
 	unsigned long long ticks;
 	unsigned long long pclk;
-	unsigned long rate;
 	static unsigned long tegra_last_pclk;
 
-	if (tegra_pclk == NULL) {
-		tegra_pclk = clk_get_sys(NULL, "pclk");
-		WARN_ON(IS_ERR(tegra_pclk));
-	}
-
-	rate = clk_get_rate(tegra_pclk);
-
 	if (WARN_ON_ONCE(rate <= 0))
 		pclk = 100000000;
 	else
@@ -209,24 +202,26 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 	pmc_pm_data.suspend_mode = mode;
 }
 
-u32 tegra_pmc_get_cpu_good_time(void)
-{
-	return pmc_pm_data.cpu_good_time;
-}
-
-u32 tegra_pmc_get_cpu_off_time(void)
-{
-	return pmc_pm_data.cpu_off_time;
-}
-
-void tegra_pmc_pm_set(void)
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
 {
 	u32 reg;
+	unsigned long rate = 0;
 
 	reg = tegra_pmc_readl(PMC_CTRL);
 	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
 	reg &= ~TEGRA_POWER_EFFECT_LP0;
 
+	switch (mode) {
+	case TEGRA_SUSPEND_LP2:
+		rate = __clk_get_rate(tegra_pclk);
+		break;
+	default:
+		break;
+	}
+
+	set_power_timers(pmc_pm_data.cpu_good_time, pmc_pm_data.cpu_off_time,
+			 rate);
+
 	tegra_pmc_writel(reg, PMC_CTRL);
 }
 
@@ -234,6 +229,9 @@ void tegra_pmc_suspend_init(void)
 {
 	u32 reg;
 
+	tegra_pclk = clk_get_sys(NULL, "pclk");
+	WARN_ON(IS_ERR(tegra_pclk));
+
 	/* Always enable CPU power request; just normal polarity is supported */
 	reg = tegra_pmc_readl(PMC_CTRL);
 	BUG_ON(reg & TEGRA_POWER_CPU_PWRREQ_POLARITY);
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 9413a44..0ee22d9 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -27,12 +27,9 @@ enum tegra_suspend_mode {
 };
 
 #ifdef CONFIG_PM_SLEEP
-void set_power_timers(unsigned long us_on, unsigned long us_off);
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
 void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
-u32 tegra_pmc_get_cpu_good_time(void);
-u32 tegra_pmc_get_cpu_off_time(void);
-void tegra_pmc_pm_set(void);
+void tegra_pmc_pm_set(enum tegra_suspend_mode mode);
 void tegra_pmc_suspend_init(void);
 #endif
 
-- 
1.8.1.5
