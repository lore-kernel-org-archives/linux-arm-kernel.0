From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  3 Apr 2011 18:17:59 -0300
Subject: [PATCH] ARM: mx5/mx53_smd: Add esdhc support
Message-ID: <1301865479-21168-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_smd.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 31e1732..fac5d8f 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -28,6 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/esdhc.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -37,6 +38,8 @@
 #include "devices-imx53.h"
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define SMD_SD1_CD		IMX_GPIO_NR(3, 13)
+#define SMD_SD1_WP		IMX_GPIO_NR(4, 11)
 
 static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
@@ -52,6 +55,31 @@ static iomux_v3_cfg_t mx53_smd_pads[] = {
 	/* I2C1 */
 	MX53_PAD_CSI0_DAT8__I2C1_SDA,
 	MX53_PAD_CSI0_DAT9__I2C1_SCL,
+	/* SD1 */
+	MX53_PAD_SD1_CMD__ESDHC1_CMD,
+	MX53_PAD_SD1_CLK__ESDHC1_CLK,
+	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* SD2 */
+	MX53_PAD_SD2_CMD__ESDHC2_CMD,
+	MX53_PAD_SD2_CLK__ESDHC2_CLK,
+	MX53_PAD_SD2_DATA0__ESDHC2_DAT0,
+	MX53_PAD_SD2_DATA1__ESDHC2_DAT1,
+	MX53_PAD_SD2_DATA2__ESDHC2_DAT2,
+	MX53_PAD_SD2_DATA3__ESDHC2_DAT3,
+	/* SD3 */
+	MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
+	MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
+	MX53_PAD_PATA_DATA10__ESDHC3_DAT2,
+	MX53_PAD_PATA_DATA11__ESDHC3_DAT3,
+	MX53_PAD_PATA_DATA0__ESDHC3_DAT4,
+	MX53_PAD_PATA_DATA1__ESDHC3_DAT5,
+	MX53_PAD_PATA_DATA2__ESDHC3_DAT6,
+	MX53_PAD_PATA_DATA3__ESDHC3_DAT7,
+	MX53_PAD_PATA_IORDY__ESDHC3_CLK,
+	MX53_PAD_PATA_RESET_B__ESDHC3_CMD,
 };
 
 static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
@@ -88,6 +116,11 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct esdhc_platform_data sd1_pdata = {
+	.wp_gpio = SMD_SD1_WP,
+	.cd_gpio = SMD_SD1_CD,
+};
+
 static void __init mx53_smd_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
@@ -97,6 +130,9 @@ static void __init mx53_smd_board_init(void)
 	imx53_add_fec(&mx53_smd_fec_data);
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_smd_i2c_data);
+	imx53_add_sdhci_esdhc_imx(0, &sd1_pdata);
+	imx53_add_sdhci_esdhc_imx(1, NULL);
+	imx53_add_sdhci_esdhc_imx(2, NULL);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.6.0.4
