From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:24:17 +0100
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
Message-ID: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
it becomes possible to cleanup the open-coded versions of the same
macro that have been added to some private irqchips implementations.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/suspend.c       | 3 ++-
 arch/arm/mach-imx/gpc.c              | 8 ++------
 arch/arm/mach-omap2/omap-wakeupgen.c | 8 ++------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index e00eb39..dfb1fcf 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -19,6 +19,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/err.h>
@@ -262,7 +263,7 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 	return 0;
 }
 
-#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+#define EXYNOS_PMU_IRQ(symbol, name)	IRQCHIP_DECLARE(symbol, name, exynos_pmu_irq_init)
 
 EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
 EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 8c4467f..f2783b0 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -268,12 +269,7 @@ static int __init imx_gpc_init(struct device_node *node,
 
 	return 0;
 }
-
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
+IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
 
 void __init imx_gpc_check_dt(void)
 {
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index e1d2e99..0f8c1d1 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -537,9 +538,4 @@ static int __init wakeupgen_init(struct device_node *node,
 
 	return 0;
 }
-
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
+IRQCHIP_DECLARE(ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
-- 
2.1.4
