From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:31 +0300
Subject: [PATCH 19/19] ARM: imx legacy: pca100: move peripheral initialization
 to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-19-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-pca100.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 2d1c50b..ed67586 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -362,12 +362,8 @@ static void __init pca100_init(void)
 	if (ret)
 		printk(KERN_ERR "pca100: Failed to setup pins (%d)\n", ret);
 
-	imx27_add_imx_ssi(0, &pca100_ssi_pdata);
-
 	imx27_add_imx_uart0(&uart_pdata);
 
-	imx27_add_mxc_mmc(1, &sdhc_pdata);
-
 	imx27_add_mxc_nand(&pca100_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
@@ -382,6 +378,19 @@ static void __init pca100_init(void)
 				ARRAY_SIZE(pca100_spi_board_info));
 	imx27_add_spi_imx0(&pca100_spi0_data);
 
+	imx27_add_imx_fb(&pca100_fb_data);
+
+	imx27_add_fec(NULL);
+	imx27_add_imx2_wdt();
+	imx27_add_mxc_w1();
+}
+
+static void __init pca100_late_init(void)
+{
+	imx27_add_imx_ssi(0, &pca100_ssi_pdata);
+
+	imx27_add_mxc_mmc(1, &sdhc_pdata);
+
 	gpio_request(OTG_PHY_CS_GPIO, "usb-otg-cs");
 	gpio_direction_output(OTG_PHY_CS_GPIO, 1);
 	gpio_request(USBH2_PHY_CS_GPIO, "usb-host2-cs");
@@ -403,12 +412,6 @@ static void __init pca100_init(void)
 
 	if (usbh2_pdata.otg)
 		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
-
-	imx27_add_imx_fb(&pca100_fb_data);
-
-	imx27_add_fec(NULL);
-	imx27_add_imx2_wdt();
-	imx27_add_mxc_w1();
 }
 
 static void __init pca100_timer_init(void)
@@ -421,7 +424,8 @@ MACHINE_START(PCA100, "phyCARD-i.MX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
-	.init_machine = pca100_init,
+	.init_machine	= pca100_init,
+	.init_late	= pca100_late_init,
 	.init_time	= pca100_timer_init,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
