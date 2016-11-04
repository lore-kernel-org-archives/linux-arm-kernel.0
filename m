From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 Nov 2016 10:45:53 +0100
Subject: [PATCH] ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx SoCs
Message-ID: <1478252753-8231-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA slave map tables for the remaining s3c24xx
SoC types so the whole platform can be switched to the new API.
A few devices for which there was no DMA support with current
code are omitted from the tables.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c24xx/common.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index f6c3f15..b59f4f4 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -345,10 +345,40 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 3), },
 };

+static const struct dma_slave_map s3c2410_dma_slave_map[] = {
+	{ "s3c2410-sdi", "rx-tx", (void *)DMACH_SDI },
+	{ "s3c2410-spi.0", "rx", (void *)DMACH_SPI0_RX },
+	{ "s3c2410-spi.0", "tx", (void *)DMACH_SPI0_TX },
+	{ "s3c2410-spi.1", "rx", (void *)DMACH_SPI1_RX },
+	{ "s3c2410-spi.1", "tx", (void *)DMACH_SPI1_TX },
+	/*
+	 * The DMA request source[1] (DMACH_UARTx_SRC2) are
+	 * not used in the UART driver.
+	 */
+	{ "s3c2410-uart.0", "rx", (void *)DMACH_UART0 },
+	{ "s3c2410-uart.0", "tx", (void *)DMACH_UART0 },
+	{ "s3c2410-uart.1", "rx", (void *)DMACH_UART1 },
+	{ "s3c2410-uart.1", "tx", (void *)DMACH_UART1 },
+	{ "s3c2410-uart.2", "rx", (void *)DMACH_UART2 },
+	{ "s3c2410-uart.2", "tx", (void *)DMACH_UART2 },
+	{ "s3c24xx-iis", "rx", (void *)DMACH_I2S_IN },
+	{ "s3c24xx-iis", "tx", (void *)DMACH_I2S_OUT },
+	{ "s3c-hsudc", "rx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "tx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "rx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "tx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "rx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "tx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "rx3", (void *)DMACH_USB_EP4 },
+	{ "s3c-hsudc", "tx3", (void *)DMACH_USB_EP4 }
+};
+
 static struct s3c24xx_dma_platdata s3c2410_dma_platdata = {
 	.num_phy_channels = 4,
 	.channels = s3c2410_dma_channels,
 	.num_channels = DMACH_MAX,
+	.slave_map = s3c2410_dma_slave_map,
+	.slavecnt = ARRAY_SIZE(s3c2410_dma_slave_map),
 };

 struct platform_device s3c2410_device_dma = {
@@ -388,10 +418,36 @@ struct platform_device s3c2410_device_dma = {
 	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, 16 },
 };

+static const struct dma_slave_map s3c2412_dma_slave_map[] = {
+	{ "s3c2412-sdi", "rx-tx", (void *)DMACH_SDI },
+	{ "s3c2412-spi.0", "rx", (void *)DMACH_SPI0_RX },
+	{ "s3c2412-spi.0", "tx", (void *)DMACH_SPI0_TX },
+	{ "s3c2412-spi.1", "rx", (void *)DMACH_SPI1_RX },
+	{ "s3c2412-spi.1", "tx", (void *)DMACH_SPI1_TX },
+	{ "s3c2440-uart.0", "rx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.0", "tx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.1", "rx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.1", "tx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.2", "rx", (void *)DMACH_UART2 },
+	{ "s3c2440-uart.2", "tx", (void *)DMACH_UART2 },
+	{ "s3c2412-iis", "rx", (void *)DMACH_I2S_IN },
+	{ "s3c2412-iis", "tx", (void *)DMACH_I2S_OUT },
+	{ "s3c-hsudc", "rx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "tx0", (void *)DMACH_USB_EP1 },
+	{ "s3c-hsudc", "rx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "tx1", (void *)DMACH_USB_EP2 },
+	{ "s3c-hsudc", "rx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "tx2", (void *)DMACH_USB_EP3 },
+	{ "s3c-hsudc", "rx3", (void *)DMACH_USB_EP4 },
+	{ "s3c-hsudc", "tx3", (void *)DMACH_USB_EP4 }
+};
+
 static struct s3c24xx_dma_platdata s3c2412_dma_platdata = {
 	.num_phy_channels = 4,
 	.channels = s3c2412_dma_channels,
 	.num_channels = DMACH_MAX,
+	.slave_map = s3c2412_dma_slave_map,
+	.slavecnt = ARRAY_SIZE(s3c2412_dma_slave_map),
 };

 struct platform_device s3c2412_device_dma = {
@@ -534,10 +590,30 @@ struct platform_device s3c2440_device_dma = {
 	[DMACH_MIC_IN] = { S3C24XX_DMA_APB, true, 29 },
 };

+static const struct dma_slave_map s3c2443_dma_slave_map[] = {
+	{ "s3c2440-sdi", "rx-tx", (void *)DMACH_SDI },
+	{ "s3c2443-spi.0", "rx", (void *)DMACH_SPI0_RX },
+	{ "s3c2443-spi.0", "tx", (void *)DMACH_SPI0_TX },
+	{ "s3c2443-spi.1", "rx", (void *)DMACH_SPI1_RX },
+	{ "s3c2443-spi.1", "tx", (void *)DMACH_SPI1_TX },
+	{ "s3c2440-uart.0", "rx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.0", "tx", (void *)DMACH_UART0 },
+	{ "s3c2440-uart.1", "rx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.1", "tx", (void *)DMACH_UART1 },
+	{ "s3c2440-uart.2", "rx", (void *)DMACH_UART2 },
+	{ "s3c2440-uart.2", "tx", (void *)DMACH_UART2 },
+	{ "s3c2440-uart.3", "rx", (void *)DMACH_UART3 },
+	{ "s3c2440-uart.3", "tx", (void *)DMACH_UART3 },
+	{ "s3c24xx-iis", "rx", (void *)DMACH_I2S_IN },
+	{ "s3c24xx-iis", "tx", (void *)DMACH_I2S_OUT },
+};
+
 static struct s3c24xx_dma_platdata s3c2443_dma_platdata = {
 	.num_phy_channels = 6,
 	.channels = s3c2443_dma_channels,
 	.num_channels = DMACH_MAX,
+	.slave_map = s3c2443_dma_slave_map,
+	.slavecnt = ARRAY_SIZE(s3c2443_dma_slave_map),
 };

 struct platform_device s3c2443_device_dma = {
--
1.9.1
