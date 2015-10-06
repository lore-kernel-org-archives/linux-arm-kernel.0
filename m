From: dhdang@apm.com (Duc Dang)
Date: Tue,  6 Oct 2015 15:32:38 -0700
Subject: [PATCH v2 1/1] irqchip/GICv2m: Add workaround for APM X-Gene GICv2m
 erratum
In-Reply-To: <20151003142650.16b291b4@arm.com>
References: <20151003142650.16b291b4@arm.com>
Message-ID: <b0fcb89a51a86b5edb85d2b03cf26ca60bd51f01.1444069886.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APM X-Gene GICv2m implementation has an erratum where the
MSI data needs to be the offset from the spi_start in order to
trigger the correct MSI interrupt. This is different from the
standard GICv2m implementation where the MSI data is the absolute
value within the range from spi_start to (spi_start + num_spis)
of each v2m frame.

This patch reads MSI_IIDR register (present in all GICv2m
implementations) to identify X-Gene GICv2m implementation and
apply workaround to change the data portion of MSI vector.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
Changes since v1:
        + Group V2M_MSI_IIDR definition to V2M register group
        + Set v2m flag during init to indicate the erratum and
        use that flag to manipulate the MSI data when composing MSI msg.

 drivers/irqchip/irq-gic-v2m.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index db04fc1..4c17c18 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -37,12 +37,19 @@
 #define V2M_MSI_SETSPI_NS	       0x040
 #define V2M_MIN_SPI		       32
 #define V2M_MAX_SPI		       1019
+#define V2M_MSI_IIDR		       0xFCC
 
 #define V2M_MSI_TYPER_BASE_SPI(x)      \
 	       (((x) >> V2M_MSI_TYPER_BASE_SHIFT) & V2M_MSI_TYPER_BASE_MASK)
 
 #define V2M_MSI_TYPER_NUM_SPI(x)       ((x) & V2M_MSI_TYPER_NUM_MASK)
 
+/* APM X-Gene with GICv2m MSI_IIDR register value */
+#define XGENE_GICV2M_MSI_IIDR		0x06000170
+
+/* List of flags for specific v2m implementation */
+#define GICV2M_NEEDS_SPI_OFFSET		0x00000001
+
 struct v2m_data {
 	spinlock_t msi_cnt_lock;
 	struct resource res;	/* GICv2m resource */
@@ -50,6 +57,7 @@ struct v2m_data {
 	u32 spi_start;		/* The SPI number that MSIs start */
 	u32 nr_spis;		/* The number of SPIs for MSIs */
 	unsigned long *bm;	/* MSI vector bitmap */
+	u32 flags;		/* v2m flags for specific implementation */
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -98,6 +106,9 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = (u32) (addr >> 32);
 	msg->address_lo = (u32) (addr);
 	msg->data = data->hwirq;
+
+	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
+		msg->data -= v2m->spi_start;
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -266,6 +277,17 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_iounmap;
 	}
 
+	/*
+	 * APM X-Gene GICv2m implementation has an erratum where
+	 * the MSI data needs to be the offset from the spi_start
+	 * in order to trigger the correct MSI interrupt. This is
+	 * different from the standard GICv2m implementation where
+	 * the MSI data is the absolute value within the range from
+	 * spi_start to (spi_start + num_spis).
+	 */
+	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
+		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+
 	v2m->bm = kzalloc(sizeof(long) * BITS_TO_LONGS(v2m->nr_spis),
 			  GFP_KERNEL);
 	if (!v2m->bm) {
-- 
1.9.1
