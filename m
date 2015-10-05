From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Oct 2015 00:42:13 +0800
Subject: [PATCH v2 1/2] irqchip: sunxi-nmi: Use driver name instead of DT node
 name for identification
In-Reply-To: <1444063334-19832-1-git-send-email-wens@csie.org>
References: <1444063334-19832-1-git-send-email-wens@csie.org>
Message-ID: <1444063334-19832-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree node name is typically "interrupt-controller", which is
rather useless when used in printk messages and irq chip names for
identification purposes. Use the driver name "sunxi-nmi" instead.

While at it move the identifier from pr_err() calls to the pr_fmt macro.

Also remove the "__func__" identifier from the error message in the
interrupt type setting callback, sunxi_sc_nmi_set_type(). The driver
name in the pr_fmt macro should be enough.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index c143dd58410c..c4f719664c63 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -8,6 +8,9 @@
  * warranty of any kind, whether express or implied.
  */
 
+#define DRV_NAME	"sunxi-nmi"
+#define pr_fmt(fmt)	DRV_NAME ": " fmt
+
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -96,8 +99,8 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 		break;
 	default:
 		irq_gc_unlock(gc);
-		pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",
-			__func__, data->irq);
+		pr_err("Cannot assign multiple trigger modes to IRQ %d.\n",
+			data->irq);
 		return -EBADR;
 	}
 
@@ -130,22 +133,21 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 
 	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
 	if (!domain) {
-		pr_err("%s: Could not register interrupt domain.\n", node->name);
+		pr_err("Could not register interrupt domain.\n");
 		return -ENOMEM;
 	}
 
-	ret = irq_alloc_domain_generic_chips(domain, 1, 2, node->name,
+	ret = irq_alloc_domain_generic_chips(domain, 1, 2, DRV_NAME,
 					     handle_fasteoi_irq, clr, 0,
 					     IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
-		 pr_err("%s: Could not allocate generic interrupt chip.\n",
-			 node->name);
-		 goto fail_irqd_remove;
+		pr_err("Could not allocate generic interrupt chip.\n");
+		goto fail_irqd_remove;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
-		pr_err("%s: unable to parse irq\n", node->name);
+		pr_err("unable to parse irq\n");
 		ret = -EINVAL;
 		goto fail_irqd_remove;
 	}
@@ -153,7 +155,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = of_iomap(node, 0);
 	if (!gc->reg_base) {
-		pr_err("%s: unable to map resource\n", node->name);
+		pr_err("unable to map resource\n");
 		ret = -ENOMEM;
 		goto fail_irqd_remove;
 	}
-- 
2.5.3
