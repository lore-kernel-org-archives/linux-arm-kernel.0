From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:54 +0100
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for irqdomains
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq domain support to the gpio-nomadik GPIO driver. This
enables its users to support dynamic IRQ assignment, which is
requried by Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu.c   |    1 +
 drivers/gpio/gpio-nomadik.c |   40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11f389..af12139 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -30,6 +30,7 @@
 
 void __iomem *_PRCMU_BASE;
 
+/* FIXME: should we set up the GPIO domain here? */
 static const struct of_device_id ux500_dt_irq_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{},
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 2c2b53c..1322ca8 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 
 #include <asm/mach/irq.h>
@@ -677,7 +678,6 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	bitmask = nmk_gpio_get_bitmask(gpio);
 	if (!nmk_chip)
 		return -EINVAL;
-
 	if (type & IRQ_TYPE_LEVEL_HIGH)
 		return -EINVAL;
 	if (type & IRQ_TYPE_LEVEL_LOW)
@@ -782,6 +782,33 @@ static void nmk_gpio_secondary_irq_handler(unsigned int irq,
 	__nmk_gpio_irq_handler(irq, desc, status);
 }
 
+#ifdef CONFIG_IRQ_DOMAIN
+int nmk_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+			  irq_hw_number_t hwirq)
+{
+	return 0;
+}
+
+const struct irq_domain_ops nmk_gpio_irq_simple_ops = {
+	.map = nmk_gpio_irq_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+struct irq_domain *nmk_gpio_irq_domain_add(struct device_node *np,
+					struct nmk_gpio_platform_data *pdata)
+{
+	return irq_domain_add_legacy(np, NMK_GPIO_PER_CHIP,
+			NOMADIK_GPIO_TO_IRQ(pdata->first_gpio),
+			0, &nmk_gpio_irq_simple_ops, NULL);
+}
+#else
+struct irq_domain *nmk_gpio_irq_domain_add(struct device_node *np,
+					struct nmk_gpio_platform_data *pdata)
+{
+	return NULL;
+}
+#endif
+
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
 {
 	unsigned int first_irq;
@@ -1072,6 +1099,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 {
 	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
 	struct device_node *np = dev->dev.of_node;
+	struct irq_domain *domain = NULL;
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
 	struct resource *res;
@@ -1096,13 +1124,20 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 		if (of_property_read_u32(np, "gpio-bank", &dev->id)) {
 			dev_err(&dev->dev, "gpio-bank property not found\n");
 			ret = -EINVAL;
-			goto out_dt;
+			goto out;
 		}
 
 		pdata->first_gpio = dev->id * NMK_GPIO_PER_CHIP;
 		pdata->num_gpio   = NMK_GPIO_PER_CHIP;
 	}
 
+	domain = nmk_gpio_irq_domain_add(np, pdata);
+	if (!domain) {
+		pr_err("%s: Failed to create irqdomain - required for DT\n",
+			np->full_name);
+		return -ENOSYS;
+	}
+
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENOENT;
@@ -1189,7 +1224,6 @@ out_release:
 out:
 	dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
 		  pdata->first_gpio, pdata->first_gpio+31);
-out_dt:
 	if (np)
 		kfree(pdata);
 
-- 
1.7.9.1
