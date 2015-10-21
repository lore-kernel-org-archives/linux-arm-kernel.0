From: majun258@huawei.com (MaJun)
Date: Wed, 21 Oct 2015 14:04:32 +0800
Subject: [PATCH v7 4/4] irqchip:implement the mbigen irq chip operation
 functions
In-Reply-To: <1445407472-6120-1-git-send-email-majun258@huawei.com>
References: <1445407472-6120-1-git-send-email-majun258@huawei.com>
Message-ID: <1445407472-6120-5-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Add the interrupt controller chip operation functions of mbigen chip.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |  102 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index a0bbc2d..729e6ac 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -47,6 +47,20 @@
 #define REG_MBIGEN_VEC_OFFSET		0x200
 
 /**
+ * offset of clear register in mbigen node
+ * This register is used to clear the status
+ * of interrupt
+ */
+#define REG_MBIGEN_CLEAR_OFFSET		0xa00
+
+/**
+ * offset of interrupt type register
+ * This register is used to configure interrupt
+ * trigger type
+ */
+#define REG_MBIGEN_TYPE_OFFSET		0x0
+
+/**
  * struct mbigen_device - holds the information of mbigen device.
  *
  * @pdev:		pointer to the platform device structure of mbigen chip.
@@ -63,11 +77,19 @@ struct mbigen_device {
  * struct mbigen_irq_data - private data of each irq
  *
  * @base:		mapped address of mbigen chip
+ * @pin_offset:		local pin offset of interrupt.
  * @reg_vec:		addr offset of interrupt vector register.
+ * @reg_type:		addr offset of interrupt trigger type register.
+ * @reg_clear:		addr offset of interrupt clear register.
+ * @type:		interrupt trigger type.
  */
 struct mbigen_irq_data {
 	void __iomem		*base;
+	unsigned int		pin_offset;
 	unsigned int		reg_vec;
+	unsigned int		reg_type;
+	unsigned int		reg_clear;
+	unsigned int		type;
 };
 
 static inline int get_mbigen_vec_reg(u32 nid, u32 offset)
@@ -76,9 +98,68 @@ static inline int get_mbigen_vec_reg(u32 nid, u32 offset)
 			+ REG_MBIGEN_VEC_OFFSET;
 }
 
+static int get_mbigen_type_reg(u32 nid, u32 offset)
+{
+	int ofst;
+
+	ofst = offset / 32 * 4;
+	return ofst + nid * MBIGEN_NODE_OFFSET
+		+ REG_MBIGEN_TYPE_OFFSET;
+}
+
+static int get_mbigen_clear_reg(u32 nid, u32 offset)
+{
+	int ofst;
+
+	ofst = offset / 32 * 4;
+	return ofst + nid * MBIGEN_NODE_OFFSET
+		+ REG_MBIGEN_CLEAR_OFFSET;
+}
+
+static void mbigen_eoi_irq(struct irq_data *data)
+{
+	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(data);
+	u32 mask;
+
+	/* only level triggered interrupt need to clear status */
+	if (mgn_irq_data->type == IRQ_TYPE_LEVEL_HIGH) {
+		mask = 1 << (mgn_irq_data->pin_offset % 32);
+		writel_relaxed(mask, mgn_irq_data->reg_clear + mgn_irq_data->base);
+	}
+
+	irq_chip_eoi_parent(data);
+}
+
+static int mbigen_set_type(struct irq_data *d, unsigned int type)
+{
+	struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(d);
+	u32 mask;
+	int val;
+
+	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	mask = 1 << (mgn_irq_data->pin_offset % 32);
+
+	val = readl_relaxed(mgn_irq_data->reg_type + mgn_irq_data->base);
+
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val |= mask;
+	else if (type == IRQ_TYPE_EDGE_RISING)
+		val &= ~mask;
+
+	writel_relaxed(val, mgn_irq_data->reg_type + mgn_irq_data->base);
+
+	return 0;
+}
 
 static struct irq_chip mbigen_irq_chip = {
 	.name =			"mbigen-v2",
+	.irq_mask =		irq_chip_mask_parent,
+	.irq_unmask =		irq_chip_unmask_parent,
+	.irq_eoi =		mbigen_eoi_irq,
+	.irq_set_type =		mbigen_set_type,
+	.irq_set_affinity =	irq_chip_set_affinity_parent,
 };
 
 static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
@@ -94,10 +175,11 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(val, mgn_irq_data->reg_vec + mgn_irq_data->base);
 }
 
-static struct mbigen_irq_data *set_mbigen_irq_data(int hwirq)
+static struct mbigen_irq_data *set_mbigen_irq_data(int hwirq,
+						unsigned int type)
 {
 	struct mbigen_irq_data *datap;
-	unsigned int nid, pin_offset;
+	unsigned int nid;
 
 	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
 	if (!datap)
@@ -106,11 +188,20 @@ static struct mbigen_irq_data *set_mbigen_irq_data(int hwirq)
 	/* get the mbigen node number */
 	nid = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP) / IRQS_PER_MBIGEN_NODE + 1;
 
-	pin_offset = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP)
+	datap->pin_offset = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP)
 					% IRQS_PER_MBIGEN_NODE;
 
-	datap->reg_vec = get_mbigen_vec_reg(nid, pin_offset);
+	datap->reg_vec = get_mbigen_vec_reg(nid, datap->pin_offset);
+	datap->reg_type = get_mbigen_type_reg(nid, datap->pin_offset);
+
+	/* no clear register for edge triggered interrupt */
+	if (type == IRQ_TYPE_EDGE_RISING)
+		datap->reg_clear = 0;
+	else
+		datap->reg_clear = get_mbigen_clear_reg(nid,
+					datap->pin_offset);
 
+	datap->type = type;
 	return datap;
 }
 
@@ -138,6 +229,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 {
 	struct irq_fwspec *fwspec = args;
 	irq_hw_number_t hwirq = fwspec->param[0];
+	unsigned int type = fwspec->param[1];
 	struct mbigen_device *mgn_chip;
 	struct mbigen_irq_data *mgn_irq_data;
 	int i, err;
@@ -147,7 +239,7 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 		return err;
 
 	/* set related information of this irq */
-	mgn_irq_data = set_mbigen_irq_data(hwirq);
+	mgn_irq_data = set_mbigen_irq_data(hwirq, type);
 	if (!mgn_irq_data)
 		return err;
 
-- 
1.7.1
