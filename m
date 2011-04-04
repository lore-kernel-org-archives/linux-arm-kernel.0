From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 4 Apr 2011 14:06:46 -0300
Subject: [PATCH v2 2/2] ARM: mx5/mx53_evk.c: Add LED support
In-Reply-To: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
References: <1301936806-9116-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1301936806-9116-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the mx53evk board there is an LED connected to GPIO7_7.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
-Changes since v1:

Use imx_add_gpio_leds to register gpio_leds

 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 159340d..74b4e92 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -139,6 +139,7 @@ config MACH_MX51_EFIKASB
 config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_GPIO_LEDS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 2af3f43..6ffeb42 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -37,6 +37,7 @@
 #define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
 #define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
 #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
+#define MX53EVK_LED		IMX_GPIO_NR(7, 7)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -60,6 +61,8 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	/* ecspi chip select lines */
 	MX53_PAD_EIM_EB2__GPIO2_30,
 	MX53_PAD_EIM_D19__GPIO3_19,
+	/* LED */
+	MX53_PAD_PATA_DA_1__GPIO7_7,
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
@@ -117,6 +120,20 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
 };
 
+static struct gpio_led mx53_evk_leds[] = {
+	{
+		.name			= "led-green",
+		.default_trigger	= "heartbeat",
+		.active_low		= 0,
+		.gpio			= MX53EVK_LED,
+	},
+};
+
+static struct gpio_led_platform_data mx53_evk_leds_data = {
+	.leds = mx53_evk_leds,
+	.num_leds = ARRAY_SIZE(mx53_evk_leds),
+};
+
 static void __init mx53_evk_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
@@ -135,6 +152,7 @@ static void __init mx53_evk_board_init(void)
 		ARRAY_SIZE(mx53_evk_spi_board_info));
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
 	imx53_add_imx2_wdt(0, NULL);
+	imx_add_gpio_leds(&mx53_evk_leds_data);
 }
 
 static void __init mx53_evk_timer_init(void)
-- 
1.6.0.4
