From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  5 Jan 2015 12:52:21 +0900
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: Store SYSC base address in
 rmobile_pm_domain
In-Reply-To: <cover.1420429758.git.horms+renesas@verge.net.au>
References: <cover.1420429758.git.horms+renesas@verge.net.au>
Message-ID: <1208da38e78f54566c1f930ca59ac050e616ee80.1420429758.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the hardcoded addresses for accessing the SYSC PM domain
registers by register offsets, relative to the SYSC base address stored
in struct rmobile_pm_domain.

In the future, the SYSC base address will come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 14 ++++++++++++++
 arch/arm/mach-shmobile/pm-rmobile.c | 24 +++++++++++++-----------
 arch/arm/mach-shmobile/pm-rmobile.h |  1 +
 arch/arm/mach-shmobile/pm-sh7372.c  | 11 +++++++++++
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index ac2eecd..34608fc 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -9,10 +9,14 @@
  * for more details.
  */
 #include <linux/console.h>
+#include <linux/io.h>
 #include <linux/suspend.h>
+
 #include "common.h"
 #include "pm-rmobile.h"
 
+#define SYSC_BASE	IOMEM(0xe6180000)
+
 #if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static int r8a7740_pd_a3sm_suspend(void)
 {
@@ -45,41 +49,51 @@ static int r8a7740_pd_d4_suspend(void)
 static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	{
 		.genpd.name	= "A4LC",
+		.base		= SYSC_BASE,
 		.bit_shift	= 1,
 	}, {
 		.genpd.name	= "A4MP",
+		.base		= SYSC_BASE,
 		.bit_shift	= 2,
 	}, {
 		.genpd.name	= "D4",
+		.base		= SYSC_BASE,
 		.bit_shift	= 3,
 		.gov		= &pm_domain_always_on_gov,
 		.suspend	= r8a7740_pd_d4_suspend,
 	}, {
 		.genpd.name	= "A4R",
+		.base		= SYSC_BASE,
 		.bit_shift	= 5,
 	}, {
 		.genpd.name	= "A3RV",
+		.base		= SYSC_BASE,
 		.bit_shift	= 6,
 	}, {
 		.genpd.name	= "A4S",
+		.base		= SYSC_BASE,
 		.bit_shift	= 10,
 		.no_debug	= true,
 	}, {
 		.genpd.name	= "A3SP",
+		.base		= SYSC_BASE,
 		.bit_shift	= 11,
 		.gov		= &pm_domain_always_on_gov,
 		.no_debug	= true,
 		.suspend	= r8a7740_pd_a3sp_suspend,
 	}, {
 		.genpd.name	= "A3SM",
+		.base		= SYSC_BASE,
 		.bit_shift	= 12,
 		.gov		= &pm_domain_always_on_gov,
 		.suspend	= r8a7740_pd_a3sm_suspend,
 	}, {
 		.genpd.name	= "A3SG",
+		.base		= SYSC_BASE,
 		.bit_shift	= 13,
 	}, {
 		.genpd.name	= "A4SU",
+		.base		= SYSC_BASE,
 		.bit_shift	= 20,
 	},
 };
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 4ea458d..a4fcd2c 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -20,9 +20,9 @@
 #include "pm-rmobile.h"
 
 /* SYSC */
-#define SPDCR		IOMEM(0xe6180008)
-#define SWUCR		IOMEM(0xe6180014)
-#define PSTR		IOMEM(0xe6180080)
+#define SPDCR		0x08	/* SYS Power Down Control Register */
+#define SWUCR		0x14	/* SYS Wakeup Control Register */
+#define PSTR		0x80	/* Power Status Register */
 
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
@@ -39,12 +39,12 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 			return ret;
 	}
 
-	if (__raw_readl(PSTR) & mask) {
+	if (__raw_readl(rmobile_pd->base + PSTR) & mask) {
 		unsigned int retry_count;
-		__raw_writel(mask, SPDCR);
+		__raw_writel(mask, rmobile_pd->base + SPDCR);
 
 		for (retry_count = PSTR_RETRIES; retry_count; retry_count--) {
-			if (!(__raw_readl(SPDCR) & mask))
+			if (!(__raw_readl(rmobile_pd->base + SPDCR) & mask))
 				break;
 			cpu_relax();
 		}
@@ -52,7 +52,8 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 
 	if (!rmobile_pd->no_debug)
 		pr_debug("%s: Power off, 0x%08x -> PSTR = 0x%08x\n",
-			 genpd->name, mask, __raw_readl(PSTR));
+			 genpd->name, mask,
+			 __raw_readl(rmobile_pd->base + PSTR));
 
 	return 0;
 }
@@ -64,13 +65,13 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 	unsigned int retry_count;
 	int ret = 0;
 
-	if (__raw_readl(PSTR) & mask)
+	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
 		goto out;
 
-	__raw_writel(mask, SWUCR);
+	__raw_writel(mask, rmobile_pd->base + SWUCR);
 
 	for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
-		if (!(__raw_readl(SWUCR) & mask))
+		if (!(__raw_readl(rmobile_pd->base + SWUCR) & mask))
 			break;
 		if (retry_count > PSTR_RETRIES)
 			udelay(PSTR_DELAY_US);
@@ -82,7 +83,8 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 
 	if (!rmobile_pd->no_debug)
 		pr_debug("%s: Power on, 0x%08x -> PSTR = 0x%08x\n",
-			 rmobile_pd->genpd.name, mask, __raw_readl(PSTR));
+			 rmobile_pd->genpd.name, mask,
+			 __raw_readl(rmobile_pd->base + PSTR));
 
 out:
 	if (ret == 0 && rmobile_pd->resume && do_resume)
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 8f66b34..0602130 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -21,6 +21,7 @@ struct rmobile_pm_domain {
 	struct dev_power_governor *gov;
 	int (*suspend)(void);
 	void (*resume)(void);
+	void __iomem *base;
 	unsigned int bit_shift;
 	bool no_debug;
 };
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 0e37da6..c0293ae 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -45,6 +45,8 @@
 #define PLLC01STPCR IOMEM(0xe61500c8)
 
 /* SYSC */
+#define SYSC_BASE IOMEM(0xe6180000)
+
 #define SBAR IOMEM(0xe6180020)
 #define WUPRMSK IOMEM(0xe6180028)
 #define WUPSMSK IOMEM(0xe618002c)
@@ -118,24 +120,28 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
 		.genpd.name = "A4LC",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 1,
 	},
 	{
 		.genpd.name = "A4MP",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 2,
 	},
 	{
 		.genpd.name = "D4",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 3,
 	},
 	{
 		.genpd.name = "A4R",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 5,
 		.suspend = sh7372_a4r_pd_suspend,
 		.resume = sh7372_intcs_resume,
@@ -144,18 +150,21 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
 		.genpd.name = "A3RV",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 6,
 	},
 	{
 		.genpd.name = "A3RI",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 8,
 	},
 	{
 		.genpd.name = "A4S",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 10,
 		.gov = &pm_domain_always_on_gov,
 		.no_debug = true,
@@ -166,6 +175,7 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
 		.genpd.name = "A3SP",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 11,
 		.gov = &pm_domain_always_on_gov,
 		.no_debug = true,
@@ -175,6 +185,7 @@ static struct rmobile_pm_domain sh7372_pm_domains[] = {
 		.genpd.name = "A3SG",
 		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.base = SYSC_BASE,
 		.bit_shift = 13,
 	},
 };
-- 
2.1.3
