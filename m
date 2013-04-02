From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 2 Apr 2013 19:19:43 +0800
Subject: [PATCH V3 3/3] ARM: tegra: moving the CPU power timer function to PMC
 driver
In-Reply-To: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
References: <1364901583-24867-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364901583-24867-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU power timer set up fucntion was related to PMC register. Now moving
it to PMC driver. And it also help to clean up the PM related code later.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* the PCLK is from DT not hard code
---
 arch/arm/mach-tegra/pm.c  | 37 +------------------------------------
 arch/arm/mach-tegra/pmc.c | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h |  4 ++++
 3 files changed, 37 insertions(+), 36 deletions(-)

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
index dbe2577..8abf02f 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -28,6 +28,9 @@
 #define PMC_REMOVE_CLAMPING		0x34
 #define PMC_PWRGATE_STATUS		0x38
 
+#define PMC_CPUPWRGOOD_TIMER	0xc8
+#define PMC_CPUPWROFF_TIMER	0xcc
+
 #define TEGRA_POWERGATE_PCIE	3
 #define TEGRA_POWERGATE_VDEC	4
 #define TEGRA_POWERGATE_CPU1	9
@@ -135,6 +138,35 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
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
+#endif
+
 static const struct of_device_id matches[] __initconst = {
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{ .compatible = "nvidia,tegra30-pmc" },
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
