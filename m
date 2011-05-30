From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 30 May 2011 12:42:26 -0300
Subject: [PATCH v3] ARM: mx5/mx53_evk: Add support for LED
Message-ID: <1306770146-20870-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:

- Use the new gpio helper function to register gpio_led

 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 7976512..3c98455 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -180,6 +180,7 @@ config MACH_MX53_EVK
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
 	help
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index f87d571..787cde8 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -35,6 +35,7 @@
 #define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
 #define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
 #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
+#define MX53EVK_LED		IMX_GPIO_NR(7, 7)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -58,12 +59,27 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	/* ecspi chip select lines */
 	MX53_PAD_EIM_EB2__GPIO2_30,
 	MX53_PAD_EIM_D19__GPIO3_19,
+	/* LED */
+	MX53_PAD_PATA_DA_1__GPIO7_7,
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
+static const struct gpio_led mx53evk_leds[] __initconst = {
+	{
+		.name			= "green",
+		.default_trigger	= "heartbeat",
+		.gpio			= MX53EVK_LED,
+	},
+};
+
+static const struct gpio_led_platform_data mx53evk_leds_data __initconst = {
+	.leds		= mx53evk_leds,
+	.num_leds	= ARRAY_SIZE(mx53evk_leds),
+};
+
 static inline void mx53_evk_init_uart(void)
 {
 	imx53_add_imx_uart(0, NULL);
@@ -133,6 +149,7 @@ static void __init mx53_evk_board_init(void)
 		ARRAY_SIZE(mx53_evk_spi_board_info));
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
 	imx53_add_imx2_wdt(0, NULL);
+	gpio_led_register_device(-1, &mx53evk_leds_data);
 }
 
 static void __init mx53_evk_timer_init(void)
-- 
1.6.0.4
