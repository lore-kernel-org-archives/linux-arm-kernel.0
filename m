From: wuyun.wu@huawei.com (Yun Wu)
Date: Sun, 15 Feb 2015 17:32:03 +0800
Subject: [PATCH v2 6/6] irqchip: gicv3: skip ITS init when no ITS available
In-Reply-To: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1423992723-5028-7-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is one more condition that needs to be considered when judging
whether LPI feature is enabled or not, which is whether there is any
ITS available and correctly enabled.

This patch will fix this by caching ITS enabling status in the GIC
chip data structure.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1a146cc..e17faca 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -47,6 +47,7 @@ struct gic_chip_data {
 	u64			redist_stride;
 	u32			nr_redist_regions;
 	unsigned int		irq_nr;
+	int			lpi_enabled;
 };

 static struct gic_chip_data gic_data __read_mostly;
@@ -390,11 +391,6 @@ static void gic_cpu_sys_reg_init(void)
 	gic_write_grpen1(1);
 }

-static int gic_dist_supports_lpis(void)
-{
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
-}
-
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
@@ -410,7 +406,7 @@ static void gic_cpu_init(void)
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);

 	/* Give LPIs a spin */
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
+	if (gic_data.lpi_enabled)
 		its_cpu_init();

 	/* initialise system registers */
@@ -629,7 +625,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	}
 	/* LPIs */
 	if (hw >= 8192 && hw < GIC_ID_NR) {
-		if (!gic_dist_supports_lpis())
+		if (!gic_data.lpi_enabled)
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
@@ -785,8 +781,12 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare

 	set_handle_irq(gic_handle_irq);

-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(node, &gic_data.rdists, gic_data.domain);
+	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) &&
+	    !!(readl_relaxed(dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
+	    !its_init(node, &gic_data.rdists, gic_data.domain))
+		gic_data.lpi_enabled = 1;
+	else
+		gic_data.lpi_enabled = 0;

 	gic_smp_init();
 	gic_dist_init();
--
1.8.0
