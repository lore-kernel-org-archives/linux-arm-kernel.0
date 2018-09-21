From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:45 +0100
Subject: [PATCH 01/10] irqchip/gic-v3-its: Change initialization ordering for
 LPIs
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently initialize the LPIs (and the ITS) fairly early, even
before the SMP support and the CPU interface. This is a bit odd
(as LPIs are not exactly crutial for the early boot process),
and is going to cause issues when reorganizing the probing code.

Let's move this initialization later.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec884..6232f98ef81b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -653,7 +653,9 @@ early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
 
 static int gic_dist_supports_lpis(void)
 {
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
+	return (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) &&
+		!!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
+		!gicv3_nolpi);
 }
 
 static void gic_cpu_init(void)
@@ -673,10 +675,6 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
-	/* Give LPIs a spin */
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_cpu_init();
-
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -689,6 +687,10 @@ static void gic_cpu_init(void)
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
+
+	if (gic_dist_supports_lpis())
+		its_cpu_init();
+
 	return 0;
 }
 
@@ -1127,14 +1129,16 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_vlpi_properties();
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(handle, &gic_data.rdists, gic_data.domain);
-
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
 	gic_cpu_pm_init();
 
+	if (gic_dist_supports_lpis()) {
+		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_cpu_init();
+	}
+
 	return 0;
 
 out_free:
-- 
2.18.0
