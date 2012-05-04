From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:22 +0800
Subject: [PATCH v2 5/9] gpio: pxa: parse gpio from DTS file
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse GPIO numbers from DTS file. Allocate interrupt according to
GPIO numbers.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/gpio/gpio-pxa.c |  116 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index fc3ace3..58a6a63 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -11,13 +11,17 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
@@ -56,6 +60,10 @@
 
 int pxa_last_gpio;
 
+#ifdef CONFIG_OF
+static struct irq_domain *domain;
+#endif
+
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem	*regbase;
@@ -81,7 +89,6 @@ enum {
 	PXA3XX_GPIO,
 	PXA93X_GPIO,
 	MMP_GPIO = 0x10,
-	MMP2_GPIO,
 };
 
 static DEFINE_SPINLOCK(gpio_lock);
@@ -475,22 +482,92 @@ static int pxa_gpio_nums(void)
 		gpio_type = MMP_GPIO;
 	} else if (cpu_is_mmp2()) {
 		count = 191;
-		gpio_type = MMP2_GPIO;
+		gpio_type = MMP_GPIO;
 	}
 #endif /* CONFIG_ARCH_MMP */
 	return count;
 }
 
+static struct of_device_id pxa_gpio_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-gpio" },
+	{ .compatible = "mrvl,mmp-gpio", .data = (void *)MMP_GPIO },
+	{}
+};
+
+static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+const struct irq_domain_ops pxa_irq_domain_ops = {
+	.map	= pxa_irq_domain_map,
+};
+
+#ifdef CONFIG_OF
+static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev)
+{
+	int ret, nr_banks, nr_gpios, irq_base;
+	struct device_node *prev, *next, *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
+
+	if (!of_id) {
+		dev_err(&pdev->dev, "Failed to find gpio controller\n");
+		return -EFAULT;
+	}
+	gpio_type = (int)of_id->data;
+
+	next = of_get_next_child(np, NULL);
+	prev = next;
+	if (!next) {
+		dev_err(&pdev->dev, "Failed to find child gpio node\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	for (nr_banks = 1; ; nr_banks++) {
+		next = of_get_next_child(np, prev);
+		if (!next)
+			break;
+		prev = next;
+	}
+	of_node_put(prev);
+	nr_gpios = nr_banks << 5;
+	pxa_last_gpio = nr_gpios - 1;
+
+	irq_base = irq_alloc_descs(-1, 0, nr_gpios, 0);
+	if (irq_base < 0) {
+		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
+		goto err;
+	}
+	domain = irq_domain_add_legacy(np, nr_gpios, irq_base, 0,
+				       &pxa_irq_domain_ops, NULL);
+	return 0;
+err:
+	iounmap(gpio_reg_base);
+	return ret;
+}
+#else
+#define pxa_gpio_probe_dt(pdev)		(-1)
+#endif
+
 static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
 	struct resource *res;
 	struct clk *clk;
 	struct pxa_gpio_platform_data *info;
-	int gpio, irq, ret;
+	int gpio, irq, ret, use_of = 0;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
-	pxa_last_gpio = pxa_gpio_nums();
+	ret = pxa_gpio_probe_dt(pdev);
+	if (ret < 0)
+		pxa_last_gpio = pxa_gpio_nums();
+	else
+		use_of = 1;
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
@@ -545,25 +622,27 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
 	}
 
+	if (!use_of) {
 #ifdef CONFIG_ARCH_PXA
-	irq = gpio_to_irq(0);
-	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
-
-	irq = gpio_to_irq(1);
-	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
-#endif
+		irq = gpio_to_irq(0);
+		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+					 handle_edge_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
 
-	for (irq  = gpio_to_irq(gpio_offset);
-		irq <= gpio_to_irq(pxa_last_gpio); irq++) {
+		irq = gpio_to_irq(1);
 		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 					 handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
+#endif
+
+		for (irq  = gpio_to_irq(gpio_offset);
+			irq <= gpio_to_irq(pxa_last_gpio); irq++) {
+			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+						 handle_edge_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
 	}
 
 	irq_set_chained_handler(irq_mux, pxa_gpio_demux_handler);
@@ -574,6 +653,7 @@ static struct platform_driver pxa_gpio_driver = {
 	.probe		= pxa_gpio_probe,
 	.driver		= {
 		.name	= "pxa-gpio",
+		.of_match_table = pxa_gpio_dt_ids,
 	},
 };
 
-- 
1.7.5.4
