From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 14:41:13 +0200
Subject: [PATCH 3/4] pinctrl: sunxi: Add custom irq_domain_ops
In-Reply-To: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437396074-15791-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437396074-15791-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current interrupt parsing code was working by accident, because the
default was actually parsing the first node of interrupts.

While that was mostly working (and the flags were actually ignored), this
binding has never been documented, and doesn't work with SoCs that have
multiple interrupt banks anyway.

Add a proper interrupt xlate function, that uses the same description than
the GPIOs (<bank> <pin> <flags>), that will make things less confusing.

The EINT number will still be used as the hwirq number, but won't be
exposed through the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   | 37 +++++++++++++++++++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              | 35 ++++++++++++++++++--
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 9462ab7ddd1f..3c821cda1ad0 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -48,7 +48,7 @@ Optional subnode-properties:
 
 Examples:
 
-pinctrl at 01c20800 {
+pio: pinctrl at 01c20800 {
 	compatible = "allwinner,sun5i-a13-pinctrl";
 	reg = <0x01c20800 0x400>;
 	#address-cells = <1>;
@@ -68,3 +68,38 @@ pinctrl at 01c20800 {
 		allwinner,pull = <0>;
 	};
 };
+
+
+GPIO and interrupt controller
+-----------------------------
+
+This hardware also acts as a GPIO controller and an interrupt
+controller.
+
+Consumers that would want to refer to one or the other (or both)
+should provide through the usual *-gpios and interrupts properties a
+cell with 3 arguments, first the number of the bank, then the pin
+inside that bank, and finally the flags for the GPIO/interrupts.
+
+Example:
+
+xio: gpio at 38 {
+	compatible = "nxp,pcf8574a";
+	reg = <0x38>;
+
+	gpio-controller;
+	#gpio-cells = <2>;
+
+	interrupt-parent = <&pio>;
+	interrupts = <6 0 IRQ_TYPE_EDGE_FALLING>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
+reg_usb1_vbus: usb1-vbus {
+	compatible = "regulator-fixed";
+	regulator-name = "usb1-vbus";
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+	gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>;
+};
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 87c327993afa..9beb7314d478 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -711,6 +711,37 @@ static struct irq_chip sunxi_pinctrl_level_irq_chip = {
 			  IRQCHIP_EOI_IF_HANDLED,
 };
 
+static int sunxi_pinctrl_irq_of_xlate(struct irq_domain *d,
+				      struct device_node *node,
+				      const u32 *intspec,
+				      unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{
+	struct sunxi_desc_function *desc;
+	int pin, base;
+
+	if (intsize < 3)
+		return -EINVAL;
+
+	base = PINS_PER_BANK * intspec[0];
+	pin = base + intspec[1];
+
+	desc = sunxi_pinctrl_desc_find_function_by_pin(d->host_data,
+						       pin, "irq");
+	if (!desc)
+		return -EINVAL;
+
+	*out_hwirq = desc->irqbank * PINS_PER_BANK + desc->irqnum;
+	*out_type = intspec[2];
+
+	return 0;
+}
+
+static struct irq_domain_ops sunxi_pinctrl_irq_domain_ops = {
+	.xlate		= sunxi_pinctrl_irq_of_xlate,
+};
+
 static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_get_chip(irq);
@@ -985,8 +1016,8 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 
 	pctl->domain = irq_domain_add_linear(node,
 					     pctl->desc->irq_banks * IRQ_PER_BANK,
-					     &irq_domain_simple_ops,
-					     NULL);
+					     &sunxi_pinctrl_irq_domain_ops,
+					     pctl);
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-- 
2.4.5
