From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:24 +0300
Subject: [PATCH 12/19] ARM: imx legacy: mx27-3ds: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-12-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 9ef4640..7ba651a 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -485,17 +485,32 @@ static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 
 static void __init mx27pdk_init(void)
 {
-	int ret;
 	imx27_soc_init();
 
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
-	mx27_3ds_sdhc1_enable_level_translator();
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
-	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 	imx27_add_imx2_wdt();
+
+	imx27_add_spi_imx1(&spi2_pdata);
+	imx27_add_spi_imx0(&spi1_pdata);
+
+	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx27_add_imx_fb(&mx27_3ds_fb_data);
+
+	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
+}
+
+static void __init mx27pdk_late_init(void)
+{
+	int ret;
+
+	mx27_3ds_sdhc1_enable_level_translator();
+	imx27_add_mxc_mmc(0, &sdhc1_pdata);
+
 	otg_phy_init();
 
 	if (otg_mode_host) {
@@ -509,17 +524,12 @@ static void __init mx27pdk_init(void)
 	if (!otg_mode_host)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 
-	imx27_add_spi_imx1(&spi2_pdata);
-	imx27_add_spi_imx0(&spi1_pdata);
 	mx27_3ds_spi_devs[0].irq = gpio_to_irq(PMIC_INT);
 	spi_register_board_info(mx27_3ds_spi_devs,
-						ARRAY_SIZE(mx27_3ds_spi_devs));
+				ARRAY_SIZE(mx27_3ds_spi_devs));
 
 	if (mxc_expio_init(MX27_CS5_BASE_ADDR, IMX_GPIO_NR(3, 28)))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
-	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	imx27_add_imx_fb(&mx27_3ds_fb_data);
 
 	ret = gpio_request_array(mx27_3ds_camera_gpios,
 				 ARRAY_SIZE(mx27_3ds_camera_gpios));
@@ -529,7 +539,6 @@ static void __init mx27pdk_init(void)
 	}
 
 	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
-	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
 
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
@@ -547,5 +556,6 @@ MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	.init_irq = mx27_init_irq,
 	.init_time	= mx27pdk_timer_init,
 	.init_machine = mx27pdk_init,
+	.init_late	= mx27pdk_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
