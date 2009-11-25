From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:28 +0100
Subject: [PATCH 14/17] ARM: pxa/raumfeld: add power supply framework
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-15-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |  119 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 1b54778..9a234e7 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -35,6 +35,8 @@
 #include <linux/lis3lv02d.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pda_power.h>
+#include <linux/power_supply.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -675,6 +677,107 @@ static struct pxamci_platform_data raumfeld_mci_platform_data = {
 	.gpio_power		= -1,
 };
 
+/*
+ * External power / charge logic
+ */
+
+static int gpio_charge_dc_ok;
+static int gpio_charge_usb_ok;
+static int gpio_charge_usb_susp;
+static int gpio_charge_ind;
+
+static int power_supply_init(struct device *dev)
+{
+	return 0;
+}
+
+static void power_supply_exit(struct device *dev)
+{
+}
+
+static int raumfeld_is_ac_online(void)
+{
+	return !gpio_get_value(gpio_charge_dc_ok);
+}
+
+static int raumfeld_is_usb_online(void)
+{
+	return 0;
+}
+
+static char *raumfeld_power_supplicants[] = { "ds2760-battery.0" };
+
+static struct pda_power_pdata power_supply_info = {
+	.init			= power_supply_init,
+	.is_ac_online		= raumfeld_is_ac_online,
+	.is_usb_online		= raumfeld_is_usb_online,
+	.exit			= power_supply_exit,
+	.supplied_to		= raumfeld_power_supplicants,
+	.num_supplicants	= ARRAY_SIZE(raumfeld_power_supplicants)
+};
+
+static struct resource power_supply_resources[] = {
+	{
+		.name  = "ac",
+		.flags = IORESOURCE_IRQ |
+			 IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+		.start = GPIO_CHARGE_DC_OK,
+		.end   = GPIO_CHARGE_DC_OK,
+	},
+};
+
+static irqreturn_t charge_done_irq(int irq, void *dev_id)
+{
+	struct power_supply *psy;
+
+	psy = power_supply_get_by_name("ds2760-battery.0");
+
+	if (psy)
+		power_supply_set_battery_charged(psy);
+
+	return IRQ_HANDLED;
+}
+
+static struct platform_device raumfeld_power_supply = {
+	.name = "pda-power",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &power_supply_info,
+	},
+	.resource      = power_supply_resources,
+	.num_resources = ARRAY_SIZE(power_supply_resources),
+};
+
+static void __init raumfeld_power_init(void)
+{
+	int err;
+
+	/* Set PEN2 high to enable maximum charge current */
+	gpio_request(mfp_to_gpio(GPIO_CHRG_PEN2), "CHRG_PEN2");
+	gpio_direction_output(mfp_to_gpio(GPIO_CHRG_PEN2), 1);
+
+	gpio_charge_ind = mfp_to_gpio(GPIO_CHARGE_IND);
+	gpio_charge_dc_ok = mfp_to_gpio(GPIO_CHARGE_DC_OK);
+	gpio_charge_usb_ok = mfp_to_gpio(GPIO_CHARGE_USB_OK);
+	gpio_charge_usb_susp = mfp_to_gpio(GPIO_CHARGE_USB_SUSP);
+
+	gpio_request(gpio_charge_ind, "CHARGE_IND");
+	gpio_request(gpio_charge_dc_ok, "CABLE_DC_OK");
+	gpio_request(gpio_charge_usb_ok, "CABLE_USB_OK");
+	gpio_request(gpio_charge_usb_susp, "CHARGE_USB_SUSP");
+	gpio_direction_output(gpio_charge_usb_susp, 0);
+
+	err = request_irq(mfp_to_gpio(gpio_to_irq(GPIO_CHARGE_DONE)),
+			&charge_done_irq, IORESOURCE_IRQ_LOWEDGE,
+			"charge_done", NULL);
+
+	if (err < 0)
+		printk(KERN_ERR "%s: unable to register irq %d\n", __func__,
+			GPIO_CHARGE_DONE);
+	else
+		platform_device_register(&raumfeld_power_supply);
+}
+
 static struct platform_device *raumfeld_common_devices[] = {
 	&raumfeld_gpio_keys_device,
 	&raumfeld_led_device,
@@ -718,10 +821,26 @@ static void __init raumfeld_controller_init(void)
 		&rotary_encoder_device,
 	};
 
+	mfp_cfg_t raumfeld_controller_pin_config[] = {
+		/* CHRG_USB_OK */
+		GPIO101_GPIO | MFP_PULL_HIGH,
+		/* CHRG_USB_OK */
+		GPIO112_GPIO | MFP_PULL_HIGH,
+		/* CHRG_USB_SUSP */
+		GPIO102_GPIO,
+		/* DISPLAY_ENABLE */
+		GPIO106_GPIO,
+	};
+
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_controller_devices));
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
 
+	gpio_request(mfp_to_gpio(GPIO_SHUTDOWN_BATT), "battery shutdown");
+	gpio_direction_output(mfp_to_gpio(GPIO_SHUTDOWN_BATT), 0);
+
 	raumfeld_common_init();
+	raumfeld_power_init();
 	raumfeld_lcd_init();
 	raumfeld_w1_init();
 }
-- 
1.6.5.2
