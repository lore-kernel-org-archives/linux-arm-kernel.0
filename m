From: ray.jui@broadcom.com (Ray Jui)
Date: Thu,  5 May 2016 09:32:01 -0700
Subject: [PATCH v3] irqchip/gic-v2m: Add workaround for Broadcom NS2 GICv2m
 erratum
In-Reply-To: <1462465921-3220-1-git-send-email-ray.jui@broadcom.com>
References: <1462465921-3220-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1462465921-3220-2-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Barba <alex.barba@broadcom.com> discovered Broadcom NS2 GICv2m
implementation has an erratum where the MSI data needs to be the SPI
number subtracted by an offset of 32, for the correct MSI interrupt
to be triggered.

Here we are adding the workaround based on readings from the MSI_IIDR
register, which contains a value unique to Broadcom NS2 GICv2m

Reported-by: Alex Barba <alex.barba@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/irqchip/irq-gic-v2m.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 28f047c..ad0d296 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -49,6 +49,9 @@
 /* APM X-Gene with GICv2m MSI_IIDR register value */
 #define XGENE_GICV2M_MSI_IIDR		0x06000170
 
+/* Broadcom NS2 GICv2m MSI_IIDR register value */
+#define BCM_NS2_GICV2M_MSI_IIDR		0x0000013f
+
 /* List of flags for specific v2m implementation */
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
 
@@ -62,6 +65,7 @@ struct v2m_data {
 	void __iomem *base;	/* GICv2m virt address */
 	u32 spi_start;		/* The SPI number that MSIs start */
 	u32 nr_spis;		/* The number of SPIs for MSIs */
+	u32 spi_offset;		/* offset to be subtracted from SPI number */
 	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
 };
@@ -102,7 +106,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data = data->hwirq;
 
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
-		msg->data -= v2m->spi_start;
+		msg->data -= v2m->spi_offset;
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -340,9 +344,20 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	 * different from the standard GICv2m implementation where
 	 * the MSI data is the absolute value within the range from
 	 * spi_start to (spi_start + num_spis).
+	 *
+	 * Broadom NS2 GICv2m implementation has an erratum where the MSI data
+	 * is 'spi_number - 32'
 	 */
-	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
+	switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
+	case XGENE_GICV2M_MSI_IIDR:
+		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+		v2m->spi_offset = v2m->spi_start;
+		break;
+	case BCM_NS2_GICV2M_MSI_IIDR:
 		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+		v2m->spi_offset = 32;
+		break;
+	}
 
 	v2m->bm = kzalloc(sizeof(long) * BITS_TO_LONGS(v2m->nr_spis),
 			  GFP_KERNEL);
-- 
2.1.4
