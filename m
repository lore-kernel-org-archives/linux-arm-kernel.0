From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:21 +0300
Subject: [PATCH 09/19] ARM: imx legacy: mx31moboard: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-9-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx31moboard.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 4f2d998..cc86768 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -526,11 +526,9 @@ static void __init mx31moboard_init(void)
 		"moboard");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-	gpio_led_register_device(-1, &mx31moboard_led_pdata);
 
 	imx31_add_imx2_wdt();
 
-	moboard_uart0_init();
 	imx31_add_imx_uart0(&uart0_pdata);
 	imx31_add_imx_uart4(&uart4_pdata);
 
@@ -540,6 +538,19 @@ static void __init mx31moboard_init(void)
 	imx31_add_spi_imx1(&moboard_spi1_pdata);
 	imx31_add_spi_imx2(&moboard_spi2_pdata);
 
+	mx31moboard_init_cam();
+
+	imx31_add_imx_ssi(0, &moboard_ssi_pdata);
+
+	pm_power_off = mx31moboard_poweroff;
+}
+
+static void __init mx31moboard_late(void)
+{
+	gpio_led_register_device(-1, &mx31moboard_led_pdata);
+
+	moboard_uart0_init();
+
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	moboard_spi_board_info[0].irq =
@@ -549,18 +560,11 @@ static void __init mx31moboard_init(void)
 
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
-	mx31moboard_init_cam();
-
 	usb_xcvr_reset();
-
 	moboard_usbh2_init();
 
-	imx31_add_imx_ssi(0, &moboard_ssi_pdata);
-
 	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 
-	pm_power_off = mx31moboard_poweroff;
-
 	switch (mx31moboard_baseboard) {
 	case MX31NOBOARD:
 		break;
@@ -601,5 +605,6 @@ MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	.init_irq = mx31_init_irq,
 	.init_time	= mx31moboard_timer_init,
 	.init_machine = mx31moboard_init,
+	.init_late	= mx31moboard_late,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
