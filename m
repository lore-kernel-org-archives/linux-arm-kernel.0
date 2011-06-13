From: andre.silva@freescale.com (Andre Silva)
Date: Mon, 13 Jun 2011 14:31:57 -0300
Subject: [PATCH 1/2] ARM:mach-mx5/mx53_ard: Add ESDHC support
Message-ID: <1307986318-16324-1-git-send-email-andre.silva@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Silva <andre.silva@freescale.com>

---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 695cdf0..9a8e6f8 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -213,6 +213,7 @@ config MACH_MX53_ARD
 	bool "Support MX53 ARD platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX53 ARD platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 7e1859b..6049fda 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -36,6 +36,8 @@
 #include "devices-imx53.h"
 
 #define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
+#define ARD_SD1_CD		IMX_GPIO_NR(1, 1)
+#define ARD_SD1_WP		IMX_GPIO_NR(1, 9)
 
 static iomux_v3_cfg_t mx53_ard_pads[] = {
 	/* UART1 */
@@ -69,6 +71,19 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 	MX53_PAD_EIM_OE__EMI_WEIM_OE,
 	MX53_PAD_EIM_RW__EMI_WEIM_RW,
 	MX53_PAD_EIM_CS1__EMI_WEIM_CS_1,
+	/* SDHC1 */
+	MX53_PAD_SD1_CMD__ESDHC1_CMD,
+	MX53_PAD_SD1_CLK__ESDHC1_CLK,
+	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
+	MX53_PAD_PATA_DATA8__ESDHC1_DAT4,
+	MX53_PAD_PATA_DATA9__ESDHC1_DAT5,
+	MX53_PAD_PATA_DATA10__ESDHC1_DAT6,
+	MX53_PAD_PATA_DATA11__ESDHC1_DAT7,
+	MX53_PAD_GPIO_1__GPIO1_1,
+	MX53_PAD_GPIO_9__GPIO1_9,
 };
 
 static struct resource ard_smsc911x_resources[] = {
@@ -100,6 +115,11 @@ static struct platform_device ard_smsc_lan9220_device = {
 	},
 };
 
+static const struct esdhc_platform_data mx53_ard_sd1_data __initconst = {
+	.cd_gpio = ARD_SD1_CD,
+	.wp_gpio = ARD_SD1_WP,
+};
+
 static void __init mx53_ard_io_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
@@ -156,6 +176,8 @@ static void __init mx53_ard_board_init(void)
 	mx53_ard_io_init();
 	weim_cs_config();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
