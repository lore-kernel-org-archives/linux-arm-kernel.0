From: andre.silva@freescale.com (Andre Silva)
Date: Fri, 10 Jun 2011 13:15:19 -0300
Subject: [PATCH 2/2] ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs
Message-ID: <1307722520-12952-1-git-send-email-andre.silva@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Silva <andre.silva@freescale.com>

---
 arch/arm/mach-mx5/board-mx53_loco.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index e5e8c85..52cb150 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -39,6 +39,9 @@
 #define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 #define LOCO_LED			IMX_GPIO_NR(7, 7)
+#define LOCO_SD3_CD			IMX_GPIO_NR(3, 11)
+#define LOCO_SD3_WP			IMX_GPIO_NR(3, 12)
+#define LOCO_SD1_CD			IMX_GPIO_NR(3, 13)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	/* FEC */
@@ -71,6 +74,8 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
 	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
 	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* SD1_CD */
+	MX53_PAD_EIM_DA13__GPIO3_13,
 	/* SD3 */
 	MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
 	MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
@@ -203,6 +208,15 @@ static const struct gpio_keys_platform_data loco_button_data __initconst = {
 	.nbuttons       = ARRAY_SIZE(loco_buttons),
 };
 
+static const struct esdhc_platform_data mx53_loco_sd1_data __initconst = {
+	.cd_gpio = LOCO_SD1_CD,
+};
+
+static const struct esdhc_platform_data mx53_loco_sd3_data __initconst = {
+	.cd_gpio = LOCO_SD3_CD,
+	.wp_gpio = LOCO_SD3_WP,
+};
+
 static inline void mx53_loco_fec_reset(void)
 {
 	int ret;
@@ -249,8 +263,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
-	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_sdhci_esdhc_imx(0, &mx53_loco_sd1_data);
+	imx53_add_sdhci_esdhc_imx(2, &mx53_loco_sd3_data);
 	imx_add_gpio_keys(&loco_button_data);
 	gpio_led_register_device(-1, &mx53loco_leds_data);
 }
-- 
1.7.1
