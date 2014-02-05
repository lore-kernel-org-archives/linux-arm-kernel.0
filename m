From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 5 Feb 2014 17:47:24 +0200
Subject: [PATCH v4] gpio: davinci: reuse for keystone soc
Message-ID: <1391615244-12014-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The similar GPIO HW block is used by keystone SoCs as
in Davinci SoCs.
Hence, reuse Davinci GPIO driver for Keystone taking into
account that Keystone contains ARM GIC IRQ controller which
is implemented using IRQ Chip.

Documentation:
	http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v4:
- rebased on top of v3.14 +
  [patch] gpio: davinci: signedness bug in davinci_gpio_irq_setup()

 .../devicetree/bindings/gpio/gpio-davinci.txt      |    4 +-
 drivers/gpio/gpio-davinci.c                        |   48 ++++++++++++++++----
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
index a2e839d..4ce9862 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
@@ -1,7 +1,7 @@
-Davinci GPIO controller bindings
+Davinci/Keystone GPIO controller bindings
 
 Required Properties:
-- compatible: should be "ti,dm6441-gpio"
+- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
 
 - reg: Physical base address of the controller and the size of memory mapped
        registers.
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index b0e98d3..5c97f61 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -37,6 +37,8 @@ struct davinci_gpio_regs {
 	u32	intstat;
 };
 
+typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
+
 #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
 
 #define chip2controller(chip)	\
@@ -413,6 +415,26 @@ static const struct irq_domain_ops davinci_gpio_irq_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
+{
+	static struct irq_chip_type gpio_unbanked;
+
+	gpio_unbanked = *container_of(irq_get_chip(irq),
+				      struct irq_chip_type, chip);
+
+	return &gpio_unbanked.chip;
+};
+
+static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
+{
+	static struct irq_chip gpio_unbanked;
+
+	gpio_unbanked = *irq_get_chip(irq);
+	return &gpio_unbanked;
+};
+
+static const struct of_device_id davinci_gpio_ids[];
+
 /*
  * NOTE:  for suspend/resume, probably best to make a platform_device with
  * suspend_late/resume_resume calls hooking into results of the set_wake()
@@ -434,6 +456,18 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	struct davinci_gpio_regs __iomem *g;
 	struct irq_domain	*irq_domain = NULL;
 	int		irq;
+	const struct of_device_id *match;
+	struct irq_chip *irq_chip;
+	gpio_get_irq_chip_cb_t gpio_get_irq_chip;
+
+	/*
+	 * Use davinci_gpio_get_irq_chip by default to handle non DT cases
+	 */
+	gpio_get_irq_chip = davinci_gpio_get_irq_chip;
+	match = of_match_device(of_match_ptr(davinci_gpio_ids),
+				dev);
+	if (match)
+		gpio_get_irq_chip = (gpio_get_irq_chip_cb_t)match->data;
 
 	ngpio = pdata->ngpio;
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -490,8 +524,6 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	 * IRQ mux conflicts; gpio_irq_type_unbanked() is only for GPIOs.
 	 */
 	if (pdata->gpio_unbanked) {
-		static struct irq_chip_type gpio_unbanked;
-
 		/* pass "bank 0" GPIO IRQs to AINTC */
 		chips[0].chip.to_irq = gpio_to_irq_unbanked;
 		chips[0].gpio_irq = bank_irq;
@@ -500,10 +532,9 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
 		irq = bank_irq;
-		gpio_unbanked = *container_of(irq_get_chip(irq),
-					      struct irq_chip_type, chip);
-		gpio_unbanked.chip.name = "GPIO-AINTC";
-		gpio_unbanked.chip.irq_set_type = gpio_irq_type_unbanked;
+		irq_chip = gpio_get_irq_chip(irq);
+		irq_chip->name = "GPIO-AINTC";
+		irq_chip->irq_set_type = gpio_irq_type_unbanked;
 
 		/* default trigger: both edges */
 		g = gpio2regs(0);
@@ -512,7 +543,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 
 		/* set the direct IRQs up to use that irqchip */
 		for (gpio = 0; gpio < pdata->gpio_unbanked; gpio++, irq++) {
-			irq_set_chip(irq, &gpio_unbanked.chip);
+			irq_set_chip(irq, irq_chip);
 			irq_set_handler_data(irq, &chips[gpio / 32]);
 			irq_set_status_flags(irq, IRQ_TYPE_EDGE_BOTH);
 		}
@@ -555,7 +586,8 @@ done:
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id davinci_gpio_ids[] = {
-	{ .compatible = "ti,dm6441-gpio", },
+	{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
+	{ .compatible = "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, davinci_gpio_ids);
-- 
1.7.9.5
