From: dhdang@apm.com (Duc Dang)
Date: Fri,  2 Oct 2015 15:16:49 -0700
Subject: [PATCH 1/1] irqchip/GICv2m: Add workaround for APM X-Gene GICv2m
 erratum
Message-ID: <1443824209-23611-1-git-send-email-dhdang@apm.com>
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
 drivers/irqchip/irq-gic-v2m.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index db04fc1..470972c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -43,6 +43,10 @@
 
 #define V2M_MSI_TYPER_NUM_SPI(x)       ((x) & V2M_MSI_TYPER_NUM_MASK)
 
+#define V2M_MSI_IIDR			0xFCC
+/* APM X-Gene with GICv2m MSI_IIDR register value */
+#define XGENE_GICV2M_MSI_IIDR		0x06000170
+
 struct v2m_data {
 	spinlock_t msi_cnt_lock;
 	struct resource res;	/* GICv2m resource */
@@ -98,6 +102,16 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = (u32) (addr >> 32);
 	msg->address_lo = (u32) (addr);
 	msg->data = data->hwirq;
+	/*
+	 * APM X-Gene GICv2m implementation has an erratum where
+	 * the MSI data needs to be the offset from the spi_start
+	 * in order to trigger the correct MSI interrupt. This is
+	 * different from the standard GICv2m implementation where
+	 * the MSI data is the absolute value within the range from
+	 * spi_start to (spi_start + num_spis).
+	 */
+	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
+		msg->data = data->hwirq - v2m->spi_start;
 }
 
 static struct irq_chip gicv2m_irq_chip = {
-- 
1.9.1
