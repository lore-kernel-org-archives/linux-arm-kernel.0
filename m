From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:37:14 +0300
Subject: [PATCH 02/19] ARM: imx legacy: mx31lite: move peripheral
 initialization to .init_late
In-Reply-To: <1474248988-10626-1-git-send-email-vz@mleia.com>
References: <1474248988-10626-1-git-send-email-vz@mleia.com>
Message-ID: <1474249051-10718-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change moves some of peripheral registrations and initializations
(all peripherals dependent on GPIOs) from .init_machine to .init_late
level, this allows to safely shift the shared GPIO controller driver
initialization level after init level of i.MX IOMUXC driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/mach-mx31lite.c | 68 +++++++++++++++++++++++++++------------
 arch/arm/mach-imx/mx31lite-db.c   | 33 -------------------
 2 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 4822a17..f033a57 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -52,6 +52,19 @@
  */
 
 static unsigned int mx31lite_pins[] = {
+	/* UART1 */
+	MX31_PIN_CTS1__CTS1,
+	MX31_PIN_RTS1__RTS1,
+	MX31_PIN_TXD1__TXD1,
+	MX31_PIN_RXD1__RXD1,
+	/* SPI 0 */
+	MX31_PIN_CSPI1_SCLK__SCLK,
+	MX31_PIN_CSPI1_MOSI__MOSI,
+	MX31_PIN_CSPI1_MISO__MISO,
+	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI1_SS0__SS0,
+	MX31_PIN_CSPI1_SS1__SS1,
+	MX31_PIN_CSPI1_SS2__SS2,
 	/* LAN9117 IRQ pin */
 	IOMUX_MODE(MX31_PIN_SFS6, IOMUX_CONFIG_GPIO),
 	/* SPI 1 */
@@ -64,6 +77,23 @@ static unsigned int mx31lite_pins[] = {
 	MX31_PIN_CSPI2_SS2__SS2,
 };
 
+/* UART */
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+/* SPI */
+static int spi0_internal_chipselect[] = {
+	MXC_SPI_CS(0),
+	MXC_SPI_CS(1),
+	MXC_SPI_CS(2),
+};
+
+static const struct spi_imx_master spi0_pdata __initconst = {
+	.chipselect	= spi0_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi0_internal_chipselect),
+};
+
 static const struct mxc_nand_platform_data
 mx31lite_nand_board_info __initconst  = {
 	.width = 1,
@@ -103,13 +133,13 @@ static struct platform_device smsc911x_device = {
  * The MC13783 is the only hard-wired SPI device on the module.
  */
 
-static int spi_internal_chipselect[] = {
+static int spi1_internal_chipselect[] = {
 	MXC_SPI_CS(0),
 };
 
 static const struct spi_imx_master spi1_pdata __initconst = {
-	.chipselect	= spi_internal_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
+	.chipselect	= spi1_internal_chipselect,
+	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
 
 static struct mc13xxx_platform_data mc13783_pdata __initdata = {
@@ -200,8 +230,6 @@ static struct platform_device physmap_flash_device = {
 	.num_resources = 1,
 };
 
-
-
 /*
  * This structure defines the MX31 memory map.
  */
@@ -233,29 +261,30 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init mx31lite_init(void)
 {
-	int ret;
-
 	imx31_soc_init();
 
-	switch (mx31lite_baseboard) {
-	case MX31LITE_NOBOARD:
-		break;
-	case MX31LITE_DB:
-		mx31lite_db_init();
-		break;
-	default:
-		printk(KERN_ERR "Illegal mx31lite_baseboard type %d\n",
-				mx31lite_baseboard);
-	}
-
 	mxc_iomux_setup_multiple_pins(mx31lite_pins, ARRAY_SIZE(mx31lite_pins),
 				      "mx31lite");
 
+	imx31_add_imx_uart0(&uart_pdata);
+	imx31_add_spi_imx0(&spi0_pdata);
+
 	/* NOR and NAND flash */
 	platform_device_register(&physmap_flash_device);
 	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
 	imx31_add_spi_imx1(&spi1_pdata);
+
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+}
+
+static void __init mx31lite_late(void)
+{
+	int ret;
+
+	if (mx31lite_baseboard == MX31LITE_DB)
+		mx31lite_db_init();
+
 	mc13783_spi_dev.irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
@@ -265,8 +294,6 @@ static void __init mx31lite_init(void)
 	if (usbh2_pdata.otg)
 		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
 	if (ret)
@@ -294,5 +321,6 @@ MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	.init_irq = mx31_init_irq,
 	.init_time	= mx31lite_timer_init,
 	.init_machine = mx31lite_init,
+	.init_late	= mx31lite_late,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index 5a160b7..c66a006 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -45,19 +45,6 @@
  */
 
 static unsigned int litekit_db_board_pins[] __initdata = {
-	/* UART1 */
-	MX31_PIN_CTS1__CTS1,
-	MX31_PIN_RTS1__RTS1,
-	MX31_PIN_TXD1__TXD1,
-	MX31_PIN_RXD1__RXD1,
-	/* SPI 0 */
-	MX31_PIN_CSPI1_SCLK__SCLK,
-	MX31_PIN_CSPI1_MOSI__MOSI,
-	MX31_PIN_CSPI1_MISO__MISO,
-	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
-	MX31_PIN_CSPI1_SS0__SS0,
-	MX31_PIN_CSPI1_SS1__SS1,
-	MX31_PIN_CSPI1_SS2__SS2,
 	/* SDHC1 */
 	MX31_PIN_SD1_DATA0__SD1_DATA0,
 	MX31_PIN_SD1_DATA1__SD1_DATA1,
@@ -67,11 +54,6 @@ static unsigned int litekit_db_board_pins[] __initdata = {
 	MX31_PIN_SD1_CMD__SD1_CMD,
 };
 
-/* UART */
-static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
 /* MMC */
 
 static int gpio_det, gpio_wp;
@@ -146,19 +128,6 @@ static const struct imxmmc_platform_data mmc_pdata __initconst = {
 	.exit	   = mxc_mmc1_exit,
 };
 
-/* SPI */
-
-static int spi_internal_chipselect[] = {
-	MXC_SPI_CS(0),
-	MXC_SPI_CS(1),
-	MXC_SPI_CS(2),
-};
-
-static const struct spi_imx_master spi0_pdata __initconst = {
-	.chipselect	= spi_internal_chipselect,
-	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
-};
-
 /* GPIO LEDs */
 
 static const struct gpio_led litekit_leds[] __initconst = {
@@ -187,9 +156,7 @@ void __init mx31lite_db_init(void)
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
 					ARRAY_SIZE(litekit_db_board_pins),
 					"development board pins");
-	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_mmc(0, &mmc_pdata);
-	imx31_add_spi_imx0(&spi0_pdata);
 	gpio_led_register_device(-1, &litekit_led_platform_data);
 	imx31_add_imx2_wdt();
 	imx31_add_mxc_rtc();
-- 
2.8.1
