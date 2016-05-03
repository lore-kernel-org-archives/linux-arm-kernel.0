From: ray.jui@broadcom.com (Ray Jui)
Date: Tue,  3 May 2016 16:47:25 -0700
Subject: [PATCH 2/2] irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m
 erratum
In-Reply-To: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
References: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1462319245-32532-3-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
implementation has an erratum where the MSI data needs to be the SPI
number subtracted by an offset of 32, for the correct MSI interrupt to
be triggered.

We are aware that APM X-Gene GICv2m has a similar erratum where the
MSI data needs to be the offset from the spi_start. While APM's workaround
is triggered based on readings from the MSI_IIDR register, this patch
contains a more general solution by allowing this offset to be
specified with an optional DT property 'arm,msi-offset-spi'. This patch
also maintains compatibility with existing APM platforms

Reported-by: Alex Barba <alex.barba@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Alex Barba <alex.barba@broadcom.com>
---
 drivers/irqchip/irq-gic-v2m.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 28f047c..7f58b87 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -62,6 +62,7 @@ struct v2m_data {
 	void __iomem *base;	/* GICv2m virt address */
 	u32 spi_start;		/* The SPI number that MSIs start */
 	u32 nr_spis;		/* The number of SPIs for MSIs */
+	u32 spi_offset;		/* offset to be subtracted from SPI number */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
 };
@@ -102,7 +103,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data = data->hwirq;
 
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
-		msg->data -= v2m->spi_start;
+		msg->data -= v2m->spi_offset;
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -294,7 +295,7 @@ static int gicv2m_allocate_domains(struct irq_domain *parent)
 }
 
 static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
-				  u32 spi_start, u32 nr_spis,
+				  u32 spi_start, u32 nr_spis, u32 spi_offset,
 				  struct resource *res)
 {
 	int ret;
@@ -341,8 +342,24 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	 * the MSI data is the absolute value within the range from
 	 * spi_start to (spi_start + num_spis).
 	 */
-	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
+	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR) {
 		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+		v2m->spi_offset = v2m->spi_start;
+	}
+
+	/*
+	 * Various GICv2m implementations may require the MSI data to be the SPI
+	 * number subtracted by an offset, in order to trigger the correct MSI
+	 * interrupt. This offset can be different depending on how gicv2m is
+	 * integrated into an SoC.
+	 *
+	 * 'spi_offset' becomes non-zero here if optional DT property
+	 * 'arm,msi-offset-spi' is specified (with an non-zero offset)
+	 */
+	if (spi_offset) {
+		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+		v2m->spi_offset = spi_offset;
+	}
 
 	v2m->bm = kzalloc(sizeof(long) * BITS_TO_LONGS(v2m->nr_spis),
 			  GFP_KERNEL);
@@ -378,7 +395,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 	for (child = of_find_matching_node(node, gicv2m_device_id); child;
 	     child = of_find_matching_node(child, gicv2m_device_id)) {
-		u32 spi_start = 0, nr_spis = 0;
+		u32 spi_start = 0, nr_spis = 0, spi_offset = 0;
 		struct resource res;
 
 		if (!of_find_property(child, "msi-controller", NULL))
@@ -396,7 +413,13 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
 				spi_start, nr_spis);
 
-		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
+		if (!of_property_read_u32(child, "arm,msi-offset-spi",
+					  &spi_offset))
+			pr_info("DT configuring V2M spi offset:%u\n",
+				spi_offset);
+
+		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
+				      spi_offset, &res);
 		if (ret) {
 			of_node_put(child);
 			break;
@@ -460,7 +483,7 @@ acpi_parse_madt_msi(struct acpi_subtable_header *header,
 		return -EINVAL;
 	}
 
-	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, 0, &res);
 	if (ret)
 		irq_domain_free_fwnode(fwnode);
 
-- 
2.1.4
