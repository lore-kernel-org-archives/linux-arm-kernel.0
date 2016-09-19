From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:20 +0300
Subject: [PATCH 08/19] ARM: imx legacy: armadillo5x0: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-8-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-armadillo5x0.c | 39 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index eaee47a..17a97ba 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -493,24 +493,12 @@ static void __init armadillo5x0_init(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
-	armadillo5x0_smc911x_resources[1].start =
-			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
-	armadillo5x0_smc911x_resources[1].end =
-			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	imx_add_gpio_keys(&armadillo5x0_button_data);
 	imx31_add_imx_i2c1(NULL);
 
 	/* Register UART */
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_imx_uart1(&uart_pdata);
 
-	/* SMSC9118 IRQ pin */
-	gpio_direction_input(MX31_PIN_GPIO1_0);
-
-	/* Register SDHC */
-	imx31_add_mxc_mmc(0, &sdhc_pdata);
-
 	/* Register FB */
 	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
@@ -527,21 +515,39 @@ static void __init armadillo5x0_init(void)
 	/* set NAND page size to 2k if not configured via boot mode pins */
 	imx_writel(imx_readl(mx3_ccm_base + MXC_CCM_RCSR) | (1 << 30),
 		   mx3_ccm_base + MXC_CCM_RCSR);
+}
+
+static void __init armadillo5x0_late(void)
+{
+	armadillo5x0_smc911x_resources[1].start =
+		gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
+	armadillo5x0_smc911x_resources[1].end =
+		gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	imx_add_gpio_keys(&armadillo5x0_button_data);
+
+	/* SMSC9118 IRQ pin */
+	gpio_direction_input(MX31_PIN_GPIO1_0);
+
+	/* Register SDHC */
+	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
 	/* RTC */
 	/* Get RTC IRQ and register the chip */
-	if (gpio_request(ARMADILLO5X0_RTC_GPIO, "rtc") == 0) {
-		if (gpio_direction_input(ARMADILLO5X0_RTC_GPIO) == 0)
-			armadillo5x0_i2c_rtc.irq = gpio_to_irq(ARMADILLO5X0_RTC_GPIO);
+	if (!gpio_request(ARMADILLO5X0_RTC_GPIO, "rtc")) {
+		if (!gpio_direction_input(ARMADILLO5X0_RTC_GPIO))
+			armadillo5x0_i2c_rtc.irq =
+				gpio_to_irq(ARMADILLO5X0_RTC_GPIO);
 		else
 			gpio_free(ARMADILLO5X0_RTC_GPIO);
 	}
+
 	if (armadillo5x0_i2c_rtc.irq == 0)
 		pr_warn("armadillo5x0_init: failed to get RTC IRQ\n");
 	i2c_register_board_info(1, &armadillo5x0_i2c_rtc, 1);
 
 	/* USB */
-
 	usbotg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
 			ULPI_OTG_DRVVBUS_EXT);
 	if (usbotg_pdata.otg)
@@ -565,5 +571,6 @@ MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	.init_irq = mx31_init_irq,
 	.init_time	= armadillo5x0_timer_init,
 	.init_machine = armadillo5x0_init,
+	.init_late	= armadillo5x0_late,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
2.8.1
