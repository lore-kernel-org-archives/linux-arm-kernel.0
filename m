From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 24 Nov 2016 16:28:29 +0100
Subject: [PATCH v2 1/3] ARM: davinci: da830: Handle vbus with a regulator
In-Reply-To: <20161124152831.26678-1-ahaslam@baylibre.com>
References: <20161124152831.26678-1-ahaslam@baylibre.com>
Message-ID: <20161124152831.26678-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb driver can now take a regulator instead of the platform
callbacks for vbus handling. Lets use a regulator so we can remove
the callbacks in a later patch.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 109 ++++++++++++--------------------
 1 file changed, 39 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 5db0901..253d9af 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -14,6 +14,7 @@
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
@@ -28,6 +29,7 @@
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,72 +40,48 @@
 #include <mach/da8xx.h>
 
 #define DA830_EVM_PHY_ID		""
-/*
- * USB1 VBUS is controlled by GPIO1[15], over-current is reported on GPIO2[4].
- */
-#define ON_BD_USB_DRV	GPIO_TO_PIN(1, 15)
-#define ON_BD_USB_OVC	GPIO_TO_PIN(2, 4)
 
 static const short da830_evm_usb11_pins[] = {
 	DA830_GPIO1_15, DA830_GPIO2_4,
 	-1
 };
 
-static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
-
-static int da830_evm_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(ON_BD_USB_DRV, on);
-	return 0;
-}
-
-static int da830_evm_usb_get_power(unsigned port)
-{
-	return gpio_get_value(ON_BD_USB_DRV);
-}
-
-static int da830_evm_usb_get_oci(unsigned port)
-{
-	return !gpio_get_value(ON_BD_USB_OVC);
-}
-
-static irqreturn_t da830_evm_usb_ocic_irq(int, void *);
+static struct regulator_consumer_supply usb_ohci_consumer_supply =
+	REGULATOR_SUPPLY("vbus", "ohci-da8xx");
 
-static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq 	= gpio_to_irq(ON_BD_USB_OVC);
-	int error	= 0;
-
-	if (handler != NULL) {
-		da830_evm_usb_ocic_handler = handler;
-
-		error = request_irq(irq, da830_evm_usb_ocic_irq,
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    "OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch over-current indicator changes\n",
-			       __func__);
-	} else
-		free_irq(irq, NULL);
-
-	return error;
-}
+static struct regulator_init_data usb_ohci_initdata = {
+	.consumer_supplies = &usb_ohci_consumer_supply,
+	.num_consumer_supplies = 1,
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
 
-static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
-	.set_power	= da830_evm_usb_set_power,
-	.get_power	= da830_evm_usb_get_power,
-	.get_oci	= da830_evm_usb_get_oci,
-	.ocic_notify	= da830_evm_usb_ocic_notify,
+static struct fixed_voltage_config usb_ohci_config = {
+	.supply_name		= "vbus",
+	.microvolts		= 5000000,
+	.gpio			= GPIO_TO_PIN(1, 15),
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &usb_ohci_initdata,
+};
 
-	/* TPS2065 switch @ 5V */
-	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
+static struct platform_device da8xx_usb11_regulator = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &usb_ohci_config,
+	},
 };
 
-static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
-{
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
+static struct gpiod_lookup_table usb11_gpios_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		/* gpio chip 1 contains gpio range 32-63 */
+		GPIO_LOOKUP("davinci_gpio.1", 4, "over-current",
+				GPIO_ACTIVE_LOW),
+	},
+};
 
 static __init void da830_evm_usb_init(void)
 {
@@ -145,23 +123,14 @@ static __init void da830_evm_usb_init(void)
 		return;
 	}
 
-	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port power control: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_output(ON_BD_USB_DRV, 0);
+	gpiod_add_lookup_table(&usb11_gpios_table);
 
-	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port over-current indicator: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_input(ON_BD_USB_OVC);
+	ret = platform_device_register(&da8xx_usb11_regulator);
+	if (ret)
+		pr_warn("%s: USB 1.1 regulator register failed: %d\n",
+			__func__, ret);
 
-	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
+	ret = da8xx_register_usb11(NULL);
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
 }
-- 
2.9.3
