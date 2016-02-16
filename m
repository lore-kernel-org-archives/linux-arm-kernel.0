From: majun258@huawei.com (MaJun)
Date: Tue, 16 Feb 2016 14:37:27 +0800
Subject: [PATCH v2 4/5] irqchip:create irq domain for each mbigen device
In-Reply-To: <1455604648-20668-1-git-send-email-majun258@huawei.com>
References: <1455604648-20668-1-git-send-email-majun258@huawei.com>
Message-ID: <1455604648-20668-5-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

For peripheral devices which connect to mbigen,mbigen is a interrupt
controller. So, we create irq domain for each mbigen device and add
mbigen irq domain into irq hierarchy structure.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen-v1.c |  136 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen-v1.c b/drivers/irqchip/irq-mbigen-v1.c
index 9445658..61e7ad0 100644
--- a/drivers/irqchip/irq-mbigen-v1.c
+++ b/drivers/irqchip/irq-mbigen-v1.c
@@ -16,11 +16,30 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
 #include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+/* The maximum IRQ pin number of mbigen chip(start from 0) */
+#define MAXIMUM_IRQ_PIN_NUM		640
+
+/**
+ * In mbigen vector register
+ * bit[31:16]:	device id
+ * bit[15:0]:	event id value
+ */
+#define IRQ_EVENT_ID_MASK		0xffff
+
+/* offset of vector register in mbigen node */
+#define REG_MBIGEN_VEC_OFFSET		0x300
+#define REG_MBIGEN_EXT_VEC_OFFSET		0x320
+
 /**
  * struct mbigen_device - holds the information of mbigen device.
  *
@@ -32,10 +51,112 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
+static int get_mbigen_nid(unsigned int offset)
+{
+	int nid = 0;
+
+	if (offset < 256)
+		nid = offset / 64;
+	else if (offset < 384)
+		nid = 4;
+	else if (offset < 640)
+		nid = 5;
+
+	return nid;
+}
+
+static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
+{
+	unsigned int nid;
+
+	nid = get_mbigen_nid(hwirq);
+
+	if (nid < 4)
+		return (nid * 4) + REG_MBIGEN_VEC_OFFSET;
+	else
+		return (nid - 4) * 4 + REG_MBIGEN_EXT_VEC_OFFSET;
+}
+
+static struct irq_chip mbigen_irq_chip = {
+	.name =			"mbigen-v1",
+};
+
+static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	/* The address of doorbell is encoded in mbigen register by default
+	 * So,we don't need to program the doorbell address@here
+	 * Besides, the event ID is decided by the hardware pin number,
+	 * we can't change it in software.So, we don't need to encode the
+	 * event ID in mbigen register.
+	 */
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
+		if (fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+
+		/* If there is no valid irq type, just use the default type */
+		if ((fwspec->param[1] == IRQ_TYPE_EDGE_RISING) ||
+			(fwspec->param[1] == IRQ_TYPE_LEVEL_HIGH))
+			*type = fwspec->param[1];
+		else
+			return -EINVAL;
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
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	struct mbigen_device *mgn_chip;
+	int i, err;
+
+	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
+
+	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	if (err)
+		return err;
+
+	mgn_chip = platform_msi_get_host_data(domain);
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+				      &mbigen_irq_chip, mgn_chip->base);
+
+	return 0;
+}
+
+static struct irq_domain_ops mbigen_domain_ops = {
+	.translate	= mbigen_domain_translate,
+	.alloc		= mbigen_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
 static int mbigen_device_probe(struct platform_device *pdev)
 {
 	struct mbigen_device *mgn_chip;
 	struct resource *res;
+	struct irq_domain *domain;
+	u32 num_pins;
 
 	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
 	if (!mgn_chip)
@@ -48,8 +169,23 @@ static int mbigen_device_probe(struct platform_device *pdev)
 	if (IS_ERR(mgn_chip->base))
 		return PTR_ERR(mgn_chip->base);
 
+	if (of_property_read_u32(pdev->dev.of_node, "num-pins", &num_pins) < 0) {
+		dev_err(&pdev->dev, "No num-pins property\n");
+		return -EINVAL;
+	}
+
+	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
+							mbigen_write_msg,
+							&mbigen_domain_ops,
+							mgn_chip);
+
+	if (!domain)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, mgn_chip);
 
+	dev_info(&pdev->dev, "Allocated %d MSIs\n", num_pins);
+
 	return 0;
 }
 
-- 
1.7.1
