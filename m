From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Tue, 11 Jan 2011 20:54:22 +0800
Subject: [PATCH v2 2/4] ARM: i.MX53 EVK: add spi device
In-Reply-To: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
References: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294750464-8660-3-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. add platform data for spi device
2. Kconfig change

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 23b0e3f..777740b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -126,6 +126,7 @@ config MACH_MX53_EVK
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 4043451..739bc62 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -33,6 +33,8 @@
 #include <mach/iomux-mx53.h>
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
+#define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -52,6 +54,13 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	MX53_PAD_ATA_CS_1__UART3_RXD,
 	MX53_PAD_ATA_DA_1__UART3_CTS,
 	MX53_PAD_ATA_DA_2__UART3_RTS,
+
+	MX53_PAD_EIM_D16__GPIO_3_16,
+	MX53_PAD_EIM_D17__GPIO_3_17,
+	MX53_PAD_EIM_D18__GPIO_3_18,
+
+	MX53_PAD_EIM_EB2__GPIO_2_30,
+	MX53_PAD_EIM_D19__GPIO_3_19,
 };
 
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
@@ -89,6 +98,16 @@ static struct fec_platform_data mx53_evk_fec_pdata = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static int mx53_evk_spi_cs[] = {
+	EVK_ECSPI1_CS0,
+	EVK_ECSPI1_CS1,
+};
+
+static const struct spi_imx_master mx53_evk_spi_data __initconst = {
+	.chipselect     = mx53_evk_spi_cs,
+	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
+};
+
 static void __init mx53_evk_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
@@ -102,6 +121,8 @@ static void __init mx53_evk_board_init(void)
 
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
+
+	imx53_add_ecspi(0, &mx53_evk_spi_data);
 }
 
 static void __init mx53_evk_timer_init(void)
-- 
1.7.1
