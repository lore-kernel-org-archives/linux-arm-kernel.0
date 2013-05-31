From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:39 +0200
Subject: [PATCH 04/39] pinctrl: coh901: add device tree support
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-5-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes it possible to probe the COH901 pinctrl driver from
the device tree, and assigned the device tree node in the
gpio_chip so we can look up cross-references from the device
tree. Start grabbing the per-port (bank) IRQs by index instead
of by name so we don't have to look up the IRQs by name going
forward.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Alter the driver to look up IRQ by index.
- Alter the bindings accordingly.
---
 .../devicetree/bindings/gpio/gpio-stericsson-coh901.txt      |  7 +++++++
 drivers/pinctrl/pinctrl-coh901.c                             | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt b/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt
new file mode 100644
index 0000000..fd665b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt
@@ -0,0 +1,7 @@
+ST-Ericsson COH 901 571/3 GPIO controller
+
+Required properties:
+- compatible: Compatible property value should be "stericsson,gpio-coh901"
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+- interrupts: the 0...n interrupts assigned to the different GPIO ports/banks.
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index edde3ac..d4f8afd 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -773,8 +773,7 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 		port->number = portno;
 		port->gpio = gpio;
 
-		port->irq = platform_get_irq_byname(pdev,
-						    port->name);
+		port->irq = platform_get_irq(pdev, portno);
 
 		dev_dbg(gpio->dev, "register IRQ %d for port %s\n", port->irq,
 			port->name);
@@ -811,6 +810,9 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 	}
 	dev_dbg(gpio->dev, "initialized %d GPIO ports\n", portno);
 
+#ifdef CONFIG_OF_GPIO
+	gpio->chip.of_node = pdev->dev.of_node;
+#endif
 	err = gpiochip_add(&gpio->chip);
 	if (err) {
 		dev_err(gpio->dev, "unable to add gpiochip: %d\n", err);
@@ -864,9 +866,15 @@ static int __exit u300_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id u300_gpio_match[] = {
+	{ .compatible = "stericsson,gpio-coh901" },
+	{},
+};
+
 static struct platform_driver u300_gpio_driver = {
 	.driver		= {
 		.name	= "u300-gpio",
+		.of_match_table = u300_gpio_match,
 	},
 	.remove		= __exit_p(u300_gpio_remove),
 };
-- 
1.7.11.3
