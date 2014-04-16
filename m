From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 18:00:12 +0200
Subject: [PATCH v4 4/4] ARM: pxa: zeus: Replace OHCI init/exit functions with
 a regulator
In-Reply-To: <1397664012-28022-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397664012-28022-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397664012-28022-5-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-pxa/zeus.c | 89 ++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index b19d1c3..205f9bf 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -413,7 +413,7 @@ static struct fixed_voltage_config can_regulator_pdata = {
 
 static struct platform_device can_regulator_device = {
 	.name	= "reg-fixed-volage",
-	.id	= -1,
+	.id	= 0,
 	.dev	= {
 		.platform_data	= &can_regulator_pdata,
 	},
@@ -510,18 +510,6 @@ struct platform_device zeus_max6369_device = {
 	.num_resources	= 1,
 };
 
-static struct platform_device *zeus_devices[] __initdata = {
-	&zeus_serial_device,
-	&zeus_mtd_devices[0],
-	&zeus_dm9k0_device,
-	&zeus_dm9k1_device,
-	&zeus_sram_device,
-	&zeus_leds_device,
-	&zeus_pcmcia_device,
-	&zeus_max6369_device,
-	&can_regulator_device,
-};
-
 /* AC'97 */
 static pxa2xx_audio_ops_t zeus_ac97_info = {
 	.reset_gpio = 95,
@@ -532,44 +520,50 @@ static pxa2xx_audio_ops_t zeus_ac97_info = {
  * USB host
  */
 
-static int zeus_ohci_init(struct device *dev)
-{
-	int err;
-
-	/* Switch on port 2. */
-	if ((err = gpio_request(ZEUS_USB2_PWREN_GPIO, "USB2_PWREN"))) {
-		dev_err(dev, "Can't request USB2_PWREN\n");
-		return err;
-	}
-
-	if ((err = gpio_direction_output(ZEUS_USB2_PWREN_GPIO, 1))) {
-		gpio_free(ZEUS_USB2_PWREN_GPIO);
-		dev_err(dev, "Can't enable USB2_PWREN\n");
-		return err;
-	}
+static struct regulator_consumer_supply zeus_ohci_regulator_supplies[] = {
+	REGULATOR_SUPPLY("vbus2", "pxa27x-ohci"),
+};
 
-	/* Port 2 is shared between host and client interface. */
-	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
+static struct regulator_init_data zeus_ohci_regulator_data = {
+	.constraints = {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(zeus_ohci_regulator_supplies),
+	.consumer_supplies	= zeus_ohci_regulator_supplies,
+};
 
-	return 0;
-}
+static struct fixed_voltage_config zeus_ohci_regulator_config = {
+	.supply_name		= "vbus2",
+	.microvolts		= 5000000, /* 5.0V */
+	.gpio			= ZEUS_USB2_PWREN_GPIO,
+	.enable_high		= 1,
+	.startup_delay		= 0,
+	.init_data		= &zeus_ohci_regulator_data,
+};
 
-static void zeus_ohci_exit(struct device *dev)
-{
-	/* Power-off port 2 */
-	gpio_direction_output(ZEUS_USB2_PWREN_GPIO, 0);
-	gpio_free(ZEUS_USB2_PWREN_GPIO);
-}
+static struct platform_device zeus_ohci_regulator_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &zeus_ohci_regulator_config,
+	},
+};
 
 static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.port_mode	= PMM_NPS_MODE,
 	/* Clear Power Control Polarity Low and set Power Sense
 	 * Polarity Low. Supply power to USB ports. */
 	.flags		= ENABLE_PORT_ALL | POWER_SENSE_LOW,
-	.init		= zeus_ohci_init,
-	.exit		= zeus_ohci_exit,
 };
 
+static void zeus_register_ohci(void)
+{
+	/* Port 2 is shared between host and client interface. */
+	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
+
+	pxa_set_ohci_info(&zeus_ohci_platform_data);
+}
+
 /*
  * Flat Panel
  */
@@ -677,6 +671,19 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
 	.udc_command = zeus_udc_command,
 };
 
+static struct platform_device *zeus_devices[] __initdata = {
+	&zeus_serial_device,
+	&zeus_mtd_devices[0],
+	&zeus_dm9k0_device,
+	&zeus_dm9k1_device,
+	&zeus_sram_device,
+	&zeus_leds_device,
+	&zeus_pcmcia_device,
+	&zeus_max6369_device,
+	&can_regulator_device,
+	&zeus_ohci_regulator_device,
+};
+
 #ifdef CONFIG_PM
 static void zeus_power_off(void)
 {
@@ -847,7 +854,7 @@ static void __init zeus_init(void)
 
 	platform_add_devices(zeus_devices, ARRAY_SIZE(zeus_devices));
 
-	pxa_set_ohci_info(&zeus_ohci_platform_data);
+	zeus_register_ohci();
 
 	if (zeus_setup_fb_gpios())
 		pr_err("Failed to setup fb gpios\n");
-- 
1.8.3.2
