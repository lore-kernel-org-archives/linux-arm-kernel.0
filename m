From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Jun 2011 09:25:27 -0300
Subject: [PATCH v2 5/6] ARM: mach-imx/mx27_3ds: Use the standard gpio_to_irq
	function
In-Reply-To: <1308745528-22089-4-git-send-email-fabio.estevam@freescale.com>
References: <1308745528-22089-1-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-2-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-3-git-send-email-fabio.estevam@freescale.com>
	<1308745528-22089-4-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1308745528-22089-5-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the standard gpio_to_irq function instead of a dedicated IRQ_GPIOx macro.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased on Sascha's for-next branch

 arch/arm/mach-imx/mach-mx27_3ds.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index aefe751..e6d811d 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -51,6 +51,7 @@
 #define SPI1_SS0		IMX_GPIO_NR(4, 28)
 #define LCD_RESET		IMX_GPIO_NR(1, 3)
 #define LCD_ENABLE		IMX_GPIO_NR(1, 31)
+#define SD1_CD			IMX_GPIO_NR(2, 26)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -170,13 +171,13 @@ static const struct matrix_keymap_data mx27_3ds_keymap_data __initconst = {
 static int mx27_3ds_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 				void *data)
 {
-	return request_irq(IRQ_GPIOB(26), detect_irq, IRQF_TRIGGER_FALLING |
-			IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
+	return request_irq(gpio_to_irq(SD1_CD), detect_irq,
+	IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
 }
 
 static void mx27_3ds_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOB(26), data);
+	free_irq(gpio_to_irq(SD1_CD), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
@@ -357,7 +358,7 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 0, /* SS0 */
 		.platform_data	= &mc13783_pdata,
-		.irq = IRQ_GPIOC(14),
+		.irq = gpio_to_irq(PMIC_INT),
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
-- 
1.6.0.4
