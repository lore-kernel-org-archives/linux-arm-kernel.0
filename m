From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 16 Oct 2018 17:15:15 +0800
Subject: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating SPIs
In-Reply-To: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with
5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
we can support MBIGEN to generate message based SPIs by writing GICD_SETSPIR.

The first 64-pins of each MBIGEN chip is used to generate SPIs, and each
MBIGEN chip has several MBIGEN nodes, every node has 128 pins for generating
LPIs. The total pins are: 64(SPIs) + 128 * node_nr(LPIs). So we can translate
the pin index in a unified way in mbigen_domain_translate().

Also Add TYPE and VEC registers that used by generating SPIs, the driver can
access them when MBIGEN is used to generate SPIs.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f05998f..37c1932 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -48,6 +48,7 @@
 #define MBIGEN_NODE_OFFSET		0x1000
 
 /* offset of vector register in mbigen node */
+#define REG_MBIGEN_SPI_VEC_OFFSET	0x500
 #define REG_MBIGEN_LPI_VEC_OFFSET	0x200
 
 /**
@@ -62,6 +63,7 @@
  * This register is used to configure interrupt
  * trigger type
  */
+#define REG_MBIGEN_SPI_TYPE_OFFSET	0x400
 #define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
 
 /**
@@ -79,6 +81,9 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
 
+	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP)
+		return (hwirq * 4 + REG_MBIGEN_SPI_VEC_OFFSET);
+
 	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
@@ -92,6 +97,13 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 {
 	unsigned int nid, irq_ofst, ofst;
 
+	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
+		*mask = 1 << (hwirq % 32);
+		ofst = hwirq / 32 * 4;
+		*addr = ofst + REG_MBIGEN_SPI_TYPE_OFFSET;
+		return;
+	}
+
 	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
@@ -162,6 +174,12 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	u32 val;
 
 	base += get_mbigen_vec_reg(d->hwirq);
+
+	if (d->hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
+		writel_relaxed(msg->data, base);
+		return;
+	}
+
 	val = readl_relaxed(base);
 
 	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
@@ -182,8 +200,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count != 2)
 			return -EINVAL;
 
-		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
-			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
+		if (fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM)
 			return -EINVAL;
 		else
 			*hwirq = fwspec->param[0];
-- 
1.8.3
