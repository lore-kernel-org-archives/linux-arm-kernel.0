From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Feb 2012 05:35:35 +0100
Subject: [PATCH 1/4 v2] ARM: at91: usb ohci add dt support
In-Reply-To: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
References: <1329235109-6688-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1329280535-21284-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-usb at vger.kernel.org
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:

	use devm_kzalloc

Best Regards,
J.
 .../devicetree/bindings/usb/atmel-usb.txt          |   19 ++++
 drivers/usb/host/ohci-at91.c                       |  101 +++++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/atmel-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
new file mode 100644
index 0000000..6c7f728
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -0,0 +1,19 @@
+Atmel SOC USB controllers
+
+OHCI
+
+Required properties:
+ - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
+   used in host mode.
+ - num-ports: Number of ports.
+ - atmel,vbus-gpio: If present, specifies a gpio that needs to be
+   activated for the bus to be powered.
+ - atmel,oc-gpio: If present, specifies a gpio that needs to be
+   activated for the overcurrent detection.
+
+usb0: ohci at 00500000 {
+	compatible = "atmel,at91rm9200-ohci", "usb-ohci";
+	reg = <0x00500000 0x100000>;
+	interrupts = <20 4>;
+	num-ports = <2>;
+};
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 8e855eb..db8963f 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -14,6 +14,8 @@
 
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/gpio.h>
@@ -477,13 +479,109 @@ static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id at91_ohci_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-ohci" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_ohci_dt_ids);
+
+static u64 at91_ohci_dma_mask = DMA_BIT_MASK(32);
+
+static int __devinit ohci_at91_of_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int i, ret, gpio;
+	enum of_gpio_flags flags;
+	struct at91_usbh_data	*pdata;
+	u32 ports;
+
+	if (!np)
+		return 0;
+
+	/* Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &at91_ohci_dma_mask;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	if (!of_property_read_u32(np, "num-ports", &ports))
+		pdata->ports = ports;
+
+	for (i = 0; i < 2; i++) {
+		gpio = of_get_named_gpio_flags(np, "atmel,vbus-gpio", i, &flags);
+		pdata->vbus_pin[i] = gpio;
+		if (!gpio_is_valid(gpio))
+			continue;
+		pdata->vbus_pin_active_low[i] = flags & OF_GPIO_ACTIVE_LOW;
+		ret = gpio_request(gpio, "ohci_vbus");
+		if (ret) {
+			dev_warn(&pdev->dev, "can't request vbus gpio %d", gpio);
+			continue;
+		}
+		ret = gpio_direction_output(gpio, !(flags & OF_GPIO_ACTIVE_LOW) ^ 1);
+		if (ret)
+			dev_warn(&pdev->dev, "can't put vbus gpio %d as output %d",
+				 !(flags & OF_GPIO_ACTIVE_LOW) ^ 1, gpio);
+	}
+
+	for (i = 0; i < 2; i++) {
+		gpio = of_get_named_gpio_flags(np, "atmel,oc-gpio", i, &flags);
+		pdata->overcurrent_pin[i] = gpio;
+		if (!gpio_is_valid(gpio))
+			continue;
+		ret = gpio_request(gpio, "ohci_overcurrent");
+		if (ret) {
+			dev_err(&pdev->dev, "can't request overcurrent gpio %d", gpio);
+			continue;
+		}
+
+		ret = gpio_direction_input(gpio);
+		if (ret) {
+			dev_err(&pdev->dev, "can't configure overcurrent gpio %d as input", gpio);
+			continue;
+		}
+
+		ret = request_irq(gpio_to_irq(gpio),
+				  ohci_hcd_at91_overcurrent_irq,
+				  IRQF_SHARED, "ohci_overcurrent", pdev);
+		if (ret) {
+			gpio_free(gpio);
+			dev_warn(& pdev->dev, "cannot get GPIO IRQ for overcurrent\n");
+		}
+	}
+
+	pdev->dev.platform_data = pdata;
+
+	return 0;
+}
+#else
+static int __devinit ohci_at91_of_init(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 {
-	struct at91_usbh_data	*pdata = pdev->dev.platform_data;
+	struct at91_usbh_data	*pdata;
 	int			i;
 
+	i = ohci_at91_of_init(pdev);
+
+	if (i)
+		return i;
+
+	pdata = pdev->dev.platform_data;
+
 	if (pdata) {
 		for (i = 0; i < ARRAY_SIZE(pdata->vbus_pin); i++) {
 			if (!gpio_is_valid(pdata->vbus_pin[i]))
@@ -596,5 +694,6 @@ static struct platform_driver ohci_hcd_at91_driver = {
 	.driver		= {
 		.name	= "at91_ohci",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
 	},
 };
-- 
1.7.7
