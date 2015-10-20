From: majun258@huawei.com (MaJun)
Date: Tue, 20 Oct 2015 16:41:59 +0800
Subject: [PATCH v6 3/4] irqchip:create irq domain for each mbigen device
In-Reply-To: <1445330520-11960-1-git-send-email-majun258@huawei.com>
References: <1445330520-11960-1-git-send-email-majun258@huawei.com>
Message-ID: <1445330520-11960-4-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

For peripheral devices which connect to mbigen,mbigen is a interrupt
controller. So, we create irq domain for each mbigen device and add
mbigen irq domain into irq hierarchy structure.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |  152 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 152 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f18132f..211b3c8 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -16,27 +16,164 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+/* Interrupt numbers per mbigen node supported */
+#define IRQS_PER_MBIGEN_NODE		128
+
+/* 16 irqs (Pin0-pin15) are reserved for each mbigen chip */
+#define RESERVED_IRQ_PER_MBIGEN_CHIP	16
+
+/**
+ * In mbigen vector register
+ * bit[21:12]:	event id value
+ * bit[11:0]:	device id
+ */
+#define IRQ_EVENT_ID_SHIFT		12
+#define IRQ_EVENT_ID_MASK		0x3ff
+
+/* register range of each mbigen node */
+#define MBIGEN_NODE_OFFSET		0x1000
+
+/* offset of vector register in mbigen node */
+#define REG_MBIGEN_VEC_OFFSET		0x200
 /**
  * struct mbigen_device - holds the information of mbigen device.
  *
  * @pdev:		pointer to the platform device structure of mbigen chip.
  * @base:		mapped address of this mbigen chip.
+ * @domain:		pointer to the irq domain
  */
 struct mbigen_device {
 	struct platform_device	*pdev;
 	void __iomem		*base;
+	struct irq_domain	*domain;
+};
+
+/**
+ * struct mbigen_irq_data - private data of each irq
+ *
+ * @base:		mapped address of mbigen chip
+ * @reg_vec:		addr offset of interrupt vector register.
+ */
+struct mbigen_irq_data {
+	void __iomem		*base;
+	unsigned int		reg_vec;
+};
+
+static inline int get_mbigen_vec_reg(u32 nid, u32 offset)
+{
+	return (offset * 4) + nid * MBIGEN_NODE_OFFSET
+			+ REG_MBIGEN_VEC_OFFSET;
+}
+
+static struct irq_chip mbigen_irq_chip = {
+	.name =			"mbigen-v2",
+	.irq_mask =		irq_chip_mask_parent,
+	.irq_unmask =		irq_chip_unmask_parent,
+	.irq_eoi =		mbigen_eoi_irq,
+	.irq_set_type =		mbigen_set_type,
+	.irq_set_affinity =	irq_chip_set_affinity_parent,
+};
+
+static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct mbigen_irq_data *mgn_irq_data = irq_get_chip_data(desc->irq);
+	u32 val;
+
+	val = readl_relaxed(mgn_irq_data->reg_vec + mgn_irq_data->base);
+
+	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
+	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
+
+	writel_relaxed(val, mgn_irq_data->reg_vec + mgn_irq_data->base);
+}
+
+static struct mbigen_irq_data *set_mbigen_irq_data(int hwirq)
+{
+	struct mbigen_irq_data *datap;
+	unsigned int nid, pin_offset;
+
+	datap = kzalloc(sizeof(*datap), GFP_KERNEL);
+	if (!datap)
+		return NULL;
+
+	/* get the mbigen node number */
+	nid = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP) / IRQS_PER_MBIGEN_NODE + 1;
+
+	pin_offset = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP)
+					% IRQS_PER_MBIGEN_NODE;
+
+	datap->reg_vec = get_mbigen_vec_reg(nid, pin_offset);
+	return datap;
+}
+
+static int mbigen_domain_translate(struct irq_domain *d,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int mbigen_irq_domain_alloc(struct irq_domain *domain,
+					unsigned int virq,
+					unsigned int nr_irqs,
+					void *args)
+{
+	struct irq_fwspec *fwspec = args;
+	irq_hw_number_t hwirq = fwspec->param[0];
+	struct mbigen_device *mgn_chip;
+	struct mbigen_irq_data *mgn_irq_data;
+	int i, err;
+
+	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	if (err)
+		return err;
+
+	/* set related information of this irq */
+	mgn_irq_data = set_mbigen_irq_data(hwirq);
+	if (!mgn_irq_data)
+		return err;
+
+	mgn_chip = platform_msi_get_host_data(domain);
+	mgn_irq_data->base = mgn_chip->base;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+				      &mbigen_irq_chip, mgn_irq_data);
+
+	return 0;
+}
+
+static struct irq_domain_ops mbigen_domain_ops = {
+	.translate	= mbigen_domain_translate,
+	.alloc		= mbigen_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 static int mbigen_device_probe(struct platform_device *pdev)
 {
 	struct mbigen_device *mgn_chip;
+	struct irq_domain *domain;
+	u32 num_msis;
 
 	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
 	if (!mgn_chip)
@@ -45,6 +182,20 @@ static int mbigen_device_probe(struct platform_device *pdev)
 	mgn_chip->pdev = pdev;
 	mgn_chip->base = of_iomap(pdev->dev.of_node, 0);
 
+	/* If there is no "num-msi" property, assume 64... */
+	if (of_property_read_u32(pdev->dev.of_node, "num-msis", &num_msis) < 0)
+		num_msis = 64;
+
+	domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
+							mbigen_write_msg,
+							&mbigen_domain_ops,
+							mgn_chip);
+
+	if (!domain)
+		return -ENOMEM;
+
+	mgn_chip->domain = domain;
+
 	platform_set_drvdata(pdev, mgn_chip);
 
 	return 0;
@@ -54,6 +205,7 @@ static int mbigen_device_remove(struct platform_device *pdev)
 {
 	struct mbigen_device *mgn_chip = platform_get_drvdata(pdev);
 
+	irq_domain_remove(mgn_chip->domain);
 	iounmap(mgn_chip->base);
 
 	return 0;
-- 
1.7.1
