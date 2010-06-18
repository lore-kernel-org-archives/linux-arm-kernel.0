From: l.fu@pengutronix.de (Luotao Fu)
Date: Fri, 18 Jun 2010 09:23:19 +0200
Subject: [PATCH 2/2 V2] pca100: clean up GPIO pin multiplexing
In-Reply-To: <1275573348-26564-3-git-send-email-l.fu@pengutronix.de>
References: <1275573348-26564-3-git-send-email-l.fu@pengutronix.de>
Message-ID: <1276845799-6122-3-git-send-email-l.fu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cleaned up some duplicated mxc_gpio_mode calls and move the correpsonding
pin multiplexing either into the initial pin config table or ifdef blocks.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
V2 Changes: removed undefined LVDS_PWR macro.

 arch/arm/mach-mx2/mach-pca100.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 47173d1..5357020 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -55,6 +55,9 @@
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
 #define USBH2_PHY_CS_GPIO (GPIO_PORTB + 24)
+#define SPI1_SS0 (GPIO_PORTD + 28)
+#define SPI1_SS1 (GPIO_PORTD + 27)
+#define SD2_CD (GPIO_PORTC + 29)
 
 static int pca100_pins[] = {
 	/* UART1 */
@@ -69,6 +72,7 @@ static int pca100_pins[] = {
 	PB7_PF_SD2_D3,
 	PB8_PF_SD2_CMD,
 	PB9_PF_SD2_CLK,
+	SD2_CD | GPIO_GPIO | GPIO_IN,
 	/* FEC */
 	PD0_AIN_FEC_TXD0,
 	PD1_AIN_FEC_TXD1,
@@ -156,6 +160,10 @@ static int pca100_pins[] = {
 	PA28_PF_HSYNC,
 	PA29_PF_VSYNC,
 	PA31_PF_OE_ACD,
+	/* free GPIO */
+	GPIO_PORTC | 31 | GPIO_GPIO | GPIO_IN, /* GPIO0_IRQ */
+	GPIO_PORTC | 25 | GPIO_GPIO | GPIO_IN, /* GPIO1_IRQ */
+	GPIO_PORTE | 5 | GPIO_GPIO | GPIO_IN, /* GPIO2_IRQ */
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -214,7 +222,7 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 	},
 };
 
-static int pca100_spi_cs[] = {GPIO_PORTD + 28, GPIO_PORTD + 27};
+static int pca100_spi_cs[] = {SPI1_SS0, SPI1_SS1};
 
 static struct spi_imx_master pca100_spi_0_data = {
 	.chipselect	= pca100_spi_cs,
@@ -386,7 +394,6 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 
-	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 
 	mxc_register_device(&imx27_nand_device, &pca100_nand_board_info);
@@ -397,17 +404,9 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&mxc_i2c_device1, &pca100_i2c_1_data);
 
-	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
-	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_OUT);
-
-	/* GPIO0_IRQ */
-	mxc_gpio_mode(GPIO_PORTC | 31 | GPIO_GPIO | GPIO_IN);
-	/* GPIO1_IRQ */
-	mxc_gpio_mode(GPIO_PORTC | 25 | GPIO_GPIO | GPIO_IN);
-	/* GPIO2_IRQ */
-	mxc_gpio_mode(GPIO_PORTE | 5 | GPIO_GPIO | GPIO_IN);
-
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
+	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_IN);
+	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
 	mxc_register_device(&mxc_spi_device0, &pca100_spi_0_data);
-- 
1.7.1
