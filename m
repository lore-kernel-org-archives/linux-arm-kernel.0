From: rogerq@ti.com (Roger Quadros)
Date: Thu, 10 Jan 2013 18:51:33 +0200
Subject: [PATCH 13/14] ARM: OMAP2+: omap4panda: Adapt HUB reset to regulator
 framework
In-Reply-To: <1357836694-30788-1-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
Message-ID: <1357836694-30788-14-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We model the HUB_RESET GPIO as a fixed regulator device. This regulator
is then used as "reset" supply for the USB PHY device and is managed
by the PHY driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   48 ++++++++++++++++++++++----------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a4831cc..fd2f907 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -132,6 +132,38 @@ static struct platform_device btwilink_device = {
 	.id	= -1,
 };
 
+/* Regulator for USB HUB/PHY reset */
+static struct regulator_consumer_supply hub_reset_supplies[] = {
+/* Link PHY device to reset supply so it gets used in the PHY driver */
+	REGULATOR_SUPPLY("reset", "nop_usb_xceiv.0"),
+};
+
+static struct regulator_init_data hub_reset_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies	= hub_reset_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(hub_reset_supplies),
+};
+
+static struct fixed_voltage_config hub_reset_config = {
+	.supply_name    = "hub_reset",
+	.microvolts = 3300000,
+	.gpio = GPIO_HUB_NRESET,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,	/* keep in RESET */
+	.init_data = &hub_reset_data,
+};
+
+static struct platform_device hub_reset_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 3,
+	.dev = {
+		.platform_data = &hub_reset_config,
+	},
+};
+
 /* Regulator for USB HUB supply */
 static struct regulator_consumer_supply hub_power_supplies[] = {
 /* Link PHY device to USB HUB supply so it gets enabled in the PHY driver */
@@ -171,6 +203,7 @@ static struct platform_device *panda_devices[] __initdata = {
 	&panda_hdmi_audio_codec,
 	&btwilink_device,
 	&hub_power_device,
+	&hub_reset_device,
 };
 
 static struct nop_usb_xceiv_platform_data phy_pdata0 = {
@@ -196,25 +229,10 @@ static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
 	.phy_config[0] = &phy_config0,
 };
 
-static struct gpio panda_ehci_gpios[] __initdata = {
-	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
-};
-
 static void __init omap4_ehci_init(void)
 {
 	int ret;
 
-	/* disable the power to the usb hub prior to init and reset phy+hub */
-	ret = gpio_request_array(panda_ehci_gpios,
-				 ARRAY_SIZE(panda_ehci_gpios));
-	if (ret) {
-		pr_err("Unable to initialize EHCI power/reset\n");
-		return;
-	}
-
-	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 1);
-
 	/* FREF_CLK3 provides the 19.2 MHz reference clock to the PHY */
 	ret = clk_add_alias("main_clk", "nop_usb_xceiv.0", "auxclk3_ck", NULL);
 	if (ret)
-- 
1.7.4.1
