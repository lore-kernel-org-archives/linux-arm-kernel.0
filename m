From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:26 +0200
Subject: [PATCH 25/30] ARM: OMAP3: omap3pandora: Adapt to ehci-omap changes
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-26-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform device for 'nop-usb-xceiv'. This will be used as a
PHY for HS USB Port 2, so provide binding information for it.

Model RESET for HS USB Port 2 as GPIO fixed regulator and link
it to the 'nop-usb-xceiv' PHY.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   54 +++++++++++++++++++++++++----
 1 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 145a6f8..c2cd1ea 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -23,6 +23,8 @@
 
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/usb/phy.h>
 #include <linux/i2c/twl.h>
 #include <linux/wl12xx.h>
 #include <linux/mtd/partitions.h>
@@ -560,23 +562,55 @@ fail:
 	printk(KERN_ERR "wl1251 board initialisation failed\n");
 }
 
+/* PHY device on HS USB Port 2 i.e. nop_usb_xceiv.2 */
+static struct platform_device hsusb2_phy_device = {
+	.name = "nop_usb_xceiv",
+	.id = 2,
+};
+
+/* Regulator for HS USB Port 2 PHY reset */
+static struct regulator_consumer_supply hsusb2_reset_supplies[] = {
+	/* Link PHY device to reset supply so it gets used in the PHY driver */
+	REGULATOR_SUPPLY("reset", "nop_usb_xceiv.2"),
+};
+
+static struct regulator_init_data hsusb2_reset_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = hsusb2_reset_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(hsusb2_reset_supplies),
+};
+
+static struct fixed_voltage_config hsusb2_reset_config = {
+	.supply_name = "hsusb2_reset",
+	.microvolts = 3300000,
+	.gpio = 16,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,   /* keep in RESET */
+	.init_data = &hsusb2_reset_data,
+};
+
+static struct platform_device hsusb2_reset_device = {
+	.name = "reg-fixed-voltage",
+	.id = PLATFORM_DEVID_AUTO,
+	.dev = {
+		.platform_data = &hsusb2_reset_config,
+	},
+};
+
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 	&pandora_vwlan_device,
 	&pandora_backlight,
+	&hsusb2_phy_device,
+	&hsusb2_reset_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-
-	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 16,
-	.reset_gpio_port[2]  = -EINVAL
 };
 
 #ifdef CONFIG_OMAP_MUX
@@ -601,6 +635,10 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap_ads7846_init(1, OMAP3_PANDORA_TS_GPIO, 0, NULL);
 	usbhs_init(&usbhs_bdata);
+
+	/* PHY on HSUSB Port 2 i.e. index 1 */
+	usb_bind_phy("ehci-omap.0", 1, "nop_usb_xceiv.2");
+
 	usb_musb_init(NULL);
 	gpmc_nand_init(&pandora_nand_data, NULL);
 
-- 
1.7.4.1
