From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 07 Jul 2014 09:20:55 +0530
Subject: [PATCH v6 5/6] ARM: EXYNOS: Remove regs-pmu.h header dependency from
 pm_domain
In-Reply-To: <1404705056-11965-1-git-send-email-pankaj.dubey@samsung.com>
References: <1404705056-11965-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1404705056-11965-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current "pm_domain.c" file uses "S5P_INT_LOCAL_PWR_EN" definition from
"regs-pmu.h" and hence needs to include this header file. As there is
no other user of "S5P_INT_LOCAL_PWR_EN" definition other than pm_domain,
to remove "regs-pmu.h" header file dependency from "pm_domain.c"  it's
better we define this definition in "pm_domain.c" file itself and thus it
will help in removing header file inclusion from "pm_domain.c".
Also removing "S5P_" prefix from macro.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |    8 ++++----
 arch/arm/mach-exynos/regs-pmu.h   |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index fe6570e..bcd8dcf 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -22,7 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/sched.h>
 
-#include "regs-pmu.h"
+#define INT_LOCAL_PWR_EN       0x7
 
 /*
  * Exynos specific wrapper around the generic power domain
@@ -44,13 +44,13 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 	base = pd->base;
 
-	pwr = power_on ? S5P_INT_LOCAL_PWR_EN : 0;
+	pwr = power_on ? INT_LOCAL_PWR_EN : 0;
 	__raw_writel(pwr, base);
 
 	/* Wait max 1ms */
 	timeout = 10;
 
-	while ((__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN)	!= pwr) {
+	while ((__raw_readl(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
 		if (!timeout) {
 			op = (power_on) ? "enable" : "disable";
 			pr_err("Power domain %s %s failed\n", domain->name, op);
@@ -172,7 +172,7 @@ static __init int exynos4_pm_init_power_domain(void)
 
 		platform_set_drvdata(pdev, pd);
 
-		on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
+		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
 
 		pm_genpd_init(&pd->pd, NULL, !on);
 	}
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index e6fa6cf..e5e298c 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -128,7 +128,6 @@
 #define S5P_PAD_RET_EBIB_OPTION			S5P_PMUREG(0x31A8)
 
 #define S5P_CORE_LOCAL_PWR_EN			0x3
-#define S5P_INT_LOCAL_PWR_EN			0x7
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	S5P_PMUREG(0x1154)
-- 
1.7.9.5
