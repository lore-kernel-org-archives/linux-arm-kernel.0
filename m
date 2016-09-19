From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:17 +0300
Subject: [PATCH 05/19] ARM: imx legacy: pcm037: move peripheral initialization
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-pcm037.c | 67 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 6d87941..d071ced 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -576,8 +576,6 @@ static struct regulator_consumer_supply dummy_supplies[] = {
  */
 static void __init pcm037_init(void)
 {
-	int ret;
-
 	imx31_soc_init();
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
@@ -621,20 +619,6 @@ static void __init pcm037_init(void)
 
 	imx31_add_mxc_w1();
 
-	/* LAN9217 IRQ pin */
-	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
-	if (ret)
-		pr_warn("could not get LAN irq gpio\n");
-	else {
-		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
-		smsc911x_resources[1].start =
-			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
-		smsc911x_resources[1].end =
-			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
-		platform_device_register(&pcm037_eth);
-	}
-
-
 	/* I2C adapters and devices */
 	i2c_register_board_info(1, pcm037_i2c_devices,
 			ARRAY_SIZE(pcm037_i2c_devices));
@@ -643,26 +627,9 @@ static void __init pcm037_init(void)
 	imx31_add_imx_i2c2(&pcm037_i2c2_data);
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
-	imx31_add_mxc_mmc(0, &sdhc_pdata);
 	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
-	/* CSI */
-	/* Camera power: default - off */
-	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), "mt9t031-power");
-	if (!ret)
-		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
-	else
-		iclink_mt9t031.power = NULL;
-
-	pcm037_init_camera();
-
-	pcm970_sja1000_resources[1].start =
-			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
-	pcm970_sja1000_resources[1].end =
-			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
-	platform_device_register(&pcm970_sja1000);
-
 	if (otg_mode_host) {
 		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
 				ULPI_OTG_DRVVBUS_EXT);
@@ -677,7 +644,6 @@ static void __init pcm037_init(void)
 
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&otg_device_pdata);
-
 }
 
 static void __init pcm037_timer_init(void)
@@ -694,6 +660,39 @@ static void __init pcm037_reserve(void)
 
 static void __init pcm037_init_late(void)
 {
+	int ret;
+
+	/* LAN9217 IRQ pin */
+	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
+	if (!ret) {
+		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		smsc911x_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		smsc911x_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		platform_device_register(&pcm037_eth);
+	} else {
+		pr_warn("could not get LAN irq gpio\n");
+	}
+
+	imx31_add_mxc_mmc(0, &sdhc_pdata);
+
+	/* CSI */
+	/* Camera power: default - off */
+	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), "mt9t031-power");
+	if (!ret)
+		gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
+	else
+		iclink_mt9t031.power = NULL;
+
+	pcm037_init_camera();
+
+	pcm970_sja1000_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
+	pcm970_sja1000_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
+	platform_device_register(&pcm970_sja1000);
+
 	pcm037_eet_init_devices();
 }
 
-- 
2.8.1
