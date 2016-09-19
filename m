From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:16 +0300
Subject: [PATCH 04/19] ARM: imx legacy: mx31lilly: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx31lilly.c | 50 ++++++++++++++++++++++++++++----------
 arch/arm/mach-imx/mx31lilly-db.c   | 20 ---------------
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index e9549a3..6fd4636 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -56,6 +56,26 @@
  * appropriate baseboard support code.
  */
 
+static unsigned int mx31lilly_pins[] __initdata = {
+	MX31_PIN_CTS1__CTS1,
+	MX31_PIN_RTS1__RTS1,
+	MX31_PIN_TXD1__TXD1,
+	MX31_PIN_RXD1__RXD1,
+	MX31_PIN_CTS2__CTS2,
+	MX31_PIN_RTS2__RTS2,
+	MX31_PIN_TXD2__TXD2,
+	MX31_PIN_RXD2__RXD2,
+	MX31_PIN_CSPI3_MOSI__RXD3,
+	MX31_PIN_CSPI3_MISO__TXD3,
+	MX31_PIN_CSPI3_SCLK__RTS3,
+	MX31_PIN_CSPI3_SPI_RDY__CTS3,
+};
+
+/* UART */
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
 /* SMSC ethernet support */
 
 static struct resource smsc91x_resources[] = {
@@ -252,16 +272,12 @@ static void __init mx31lilly_board_init(void)
 {
 	imx31_soc_init();
 
-	switch (mx31lilly_baseboard) {
-	case MX31LILLY_NOBOARD:
-		break;
-	case MX31LILLY_DB:
-		mx31lilly_db_init();
-		break;
-	default:
-		printk(KERN_ERR "Illegal mx31lilly_baseboard type %d\n",
-			mx31lilly_baseboard);
-	}
+	mxc_iomux_setup_multiple_pins(mx31lilly_pins,
+				      ARRAY_SIZE(mx31lilly_pins), "mx31lily");
+
+	imx31_add_imx_uart0(&uart_pdata);
+	imx31_add_imx_uart1(&uart_pdata);
+	imx31_add_imx_uart2(&uart_pdata);
 
 	mxc_iomux_alloc_pin(MX31_PIN_CS4__CS4, "Ethernet CS");
 
@@ -284,10 +300,17 @@ static void __init mx31lilly_board_init(void)
 
 	imx31_add_spi_imx0(&spi0_pdata);
 	imx31_add_spi_imx1(&spi1_pdata);
-	mc13783_dev.irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
-	spi_register_board_info(&mc13783_dev, 1);
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+}
+
+static void __init mx31lilly_late_init(void)
+{
+	if (mx31lilly_baseboard == MX31LILLY_DB)
+		mx31lilly_db_init();
+
+	mc13783_dev.irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+	spi_register_board_info(&mc13783_dev, 1);
 
 	smsc91x_resources[1].start =
 			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
@@ -310,6 +333,7 @@ MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.init_time	= mx31lilly_timer_init,
-	.init_machine = mx31lilly_board_init,
+	.init_machine	= mx31lilly_board_init,
+	.init_late	= mx31lilly_late_init,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 649fe49..231f900 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -43,18 +43,6 @@
  */
 
 static unsigned int lilly_db_board_pins[] __initdata = {
-	MX31_PIN_CTS1__CTS1,
-	MX31_PIN_RTS1__RTS1,
-	MX31_PIN_TXD1__TXD1,
-	MX31_PIN_RXD1__RXD1,
-	MX31_PIN_CTS2__CTS2,
-	MX31_PIN_RTS2__RTS2,
-	MX31_PIN_TXD2__TXD2,
-	MX31_PIN_RXD2__RXD2,
-	MX31_PIN_CSPI3_MOSI__RXD3,
-	MX31_PIN_CSPI3_MISO__TXD3,
-	MX31_PIN_CSPI3_SCLK__RTS3,
-	MX31_PIN_CSPI3_SPI_RDY__CTS3,
 	MX31_PIN_SD1_DATA3__SD1_DATA3,
 	MX31_PIN_SD1_DATA2__SD1_DATA2,
 	MX31_PIN_SD1_DATA1__SD1_DATA1,
@@ -86,11 +74,6 @@ static unsigned int lilly_db_board_pins[] __initdata = {
 	MX31_PIN_CONTRAST__CONTRAST,
 };
 
-/* UART */
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
 /* MMC support */
 
 static int mxc_mmc1_get_ro(struct device *dev)
@@ -203,9 +186,6 @@ void __init mx31lilly_db_init(void)
 	mxc_iomux_setup_multiple_pins(lilly_db_board_pins,
 					ARRAY_SIZE(lilly_db_board_pins),
 					"development board pins");
-	imx31_add_imx_uart0(&uart_pdata);
-	imx31_add_imx_uart1(&uart_pdata);
-	imx31_add_imx_uart2(&uart_pdata);
 	imx31_add_mxc_mmc(0, &mmc_pdata);
 	mx31lilly_init_fb();
 }
-- 
2.8.1
