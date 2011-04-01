From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 1 Apr 2011 16:29:48 -0300
Subject: [PATCH 3/3] ARM: mx5/mx53_evk: Add write-protect and card-detect for
	SD1 and SD3
In-Reply-To: <1301686188-14827-2-git-send-email-fabio.estevam@freescale.com>
References: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
	<1301686188-14827-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1301686188-14827-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index a6e0cad..7c240fc 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -33,10 +33,15 @@
 #include <asm/mach/time.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/esdhc.h>
 
 #define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
 #define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
 #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
+#define EVK_SD1_CD		IMX_GPIO_NR(3, 13)
+#define EVK_SD1_WP		IMX_GPIO_NR(3, 14)
+#define EVK_SD3_CD		IMX_GPIO_NR(3, 11)
+#define EVK_SD3_WP		IMX_GPIO_NR(3, 12)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -60,6 +65,11 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	/* ecspi chip select lines */
 	MX53_PAD_EIM_EB2__GPIO2_30,
 	MX53_PAD_EIM_D19__GPIO3_19,
+
+	MX53_PAD_EIM_DA11__GPIO3_11,	/* SD3 Card-Detect */
+	MX53_PAD_EIM_DA12__GPIO3_12,	/* SD3 Write-Protect */
+	MX53_PAD_EIM_DA13__GPIO3_13,	/* SD1 Card-Detect */
+	MX53_PAD_EIM_DA14__GPIO3_14,	/* SD1 Write-Protect */
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
@@ -117,6 +127,16 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.wp_gpio = EVK_SD1_WP,
+	.cd_gpio = EVK_SD1_CD,
+};
+
+static struct esdhc_platform_data sd3_pdata = {
+	.wp_gpio = EVK_SD3_WP,
+	.cd_gpio = EVK_SD3_CD,
+};
+
 static void __init mx53_evk_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
@@ -128,8 +148,8 @@ static void __init mx53_evk_board_init(void)
 	imx53_add_imx_i2c(0, &mx53_evk_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_evk_i2c_data);
 
-	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_sdhci_esdhc_imx(0, &sd1_pdata);
+	imx53_add_sdhci_esdhc_imx(2, &sd3_pdata);
 
 	spi_register_board_info(mx53_evk_spi_board_info,
 		ARRAY_SIZE(mx53_evk_spi_board_info));
-- 
1.6.0.4
