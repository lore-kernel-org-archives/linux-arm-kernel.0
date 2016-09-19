From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:18 +0300
Subject: [PATCH 06/19] ARM: imx legacy: mx31-3ds: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-6-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 65a0dc0..12b8a52 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -694,8 +694,6 @@ static struct platform_device *devices[] __initdata = {
 
 static void __init mx31_3ds_init(void)
 {
-	int ret;
-
 	imx31_soc_init();
 
 	/* Configure SPI1 IOMUX */
@@ -708,14 +706,31 @@ static void __init mx31_3ds_init(void)
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
 	imx31_add_spi_imx1(&spi1_pdata);
+
+	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
+
+	imx31_add_imx2_wdt();
+	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
+
+	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_ipu_core();
+	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
+
+	imx31_add_imx_ssi(0, &mx31_3ds_ssi_pdata);
+
+	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
+}
+
+static void __init mx31_3ds_late(void)
+{
+	int ret;
+
 	mx31_3ds_spi_devs[0].irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(mx31_3ds_spi_devs,
-						ARRAY_SIZE(mx31_3ds_spi_devs));
+				ARRAY_SIZE(mx31_3ds_spi_devs));
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
-
 	mx31_3ds_usbotg_init();
 	if (otg_mode_host) {
 		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
@@ -733,14 +748,9 @@ static void __init mx31_3ds_init(void)
 
 	if (mxc_expio_init(MX31_CS5_BASE_ADDR, IOMUX_TO_GPIO(MX31_PIN_GPIO1_1)))
 		printk(KERN_WARNING "Init of the debug board failed, all "
-				    "devices on the debug board are unusable.\n");
-	imx31_add_imx2_wdt();
-	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
-	imx31_add_mxc_mmc(0, &sdhc1_pdata);
+		       "devices on the debug board are unusable.\n");
 
-	imx31_add_spi_imx0(&spi0_pdata);
-	imx31_add_ipu_core();
-	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
+	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
 	/* CSI */
 	/* Camera power: default - off */
@@ -752,10 +762,6 @@ static void __init mx31_3ds_init(void)
 	}
 
 	mx31_3ds_init_camera();
-
-	imx31_add_imx_ssi(0, &mx31_3ds_ssi_pdata);
-
-	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
 
 static void __init mx31_3ds_timer_init(void)
@@ -778,6 +784,7 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.init_irq = mx31_init_irq,
 	.init_time	= mx31_3ds_timer_init,
 	.init_machine = mx31_3ds_init,
+	.init_late	= mx31_3ds_late,
 	.reserve = mx31_3ds_reserve,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
