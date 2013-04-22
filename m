From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:52:06 +0200
Subject: [PATCH 05/23] pinctrl: coh901: add device tree support
Message-ID: <1366624326-6259-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes it possible to probe the COH901 pinctrl driver from
the device tree, and assigned the device tree node in the
gpio_chip so we can look up cross-references from the device
tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-stericsson-coh901.txt          | 9 +++++++++
 drivers/pinctrl/pinctrl-coh901.c                                 | 9 +++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt b/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt
new file mode 100644
index 0000000..355f8ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-stericsson-coh901.txt
@@ -0,0 +1,9 @@
+ST-Ericsson COH 901 571/3 GPIO controller
+
+Required properties:
+- compatible: Compatible property value should be "stericsson,gpio-coh901"
+- reg: Physical base address of the controller and length of memory mapped
+  region.
+- interrupts: the 0...n interrupts assigned to the different GPIO ports/banks.
+- interrupt-names: name the interrupts after port/bank, "gpio0", "gpio1" etc.
+
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 8b7e7bc..bed47ab 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -808,6 +808,9 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 	}
 	dev_dbg(gpio->dev, "initialized %d GPIO ports\n", portno);
 
+#ifdef CONFIG_OF_GPIO
+	gpio->chip.of_node = pdev->dev.of_node;
+#endif
 	err = gpiochip_add(&gpio->chip);
 	if (err) {
 		dev_err(gpio->dev, "unable to add gpiochip: %d\n", err);
@@ -861,9 +864,15 @@ static int __exit u300_gpio_remove(struct platform_device *pdev)
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
