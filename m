From: andre.silva@freescale.com (Andre Silva)
Date: Wed, 22 Jun 2011 16:33:05 -0300
Subject: [PATCH 2/2] ARM:mach-mx5/mx53_ard: Add I2C2 and I2C3 support
In-Reply-To: <1308771185-4491-1-git-send-email-andre.silva@freescale.com>
References: <1308771185-4491-1-git-send-email-andre.silva@freescale.com>
Message-ID: <1308771185-4491-2-git-send-email-andre.silva@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Silva <andre.silva@freescale.com>

---
Add support for I2C2 and I2C3 on i.MX53 ARD Board.
Also removes a space in a comment.

 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c |   21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 5b16f39..6a47d4c 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -213,6 +213,7 @@ config MACH_MX53_ARD
 	bool "Support MX53 ARD platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 7dd54b9..eff2a57 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -84,6 +84,12 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 	MX53_PAD_PATA_DATA11__ESDHC1_DAT7,
 	MX53_PAD_GPIO_1__GPIO1_1,
 	MX53_PAD_GPIO_9__GPIO1_9,
+	/* I2C2 */
+	MX53_PAD_EIM_EB2__I2C2_SCL,
+	MX53_PAD_KEY_ROW3__I2C2_SDA,
+	/* I2C3 */
+	MX53_PAD_GPIO_3__I2C3_SCL,
+	MX53_PAD_GPIO_16__I2C3_SDA,
 };
 
 static struct resource ard_smsc911x_resources[] = {
@@ -120,6 +126,14 @@ static const struct esdhc_platform_data mx53_ard_sd1_data __initconst = {
 	.wp_gpio = ARD_SD1_WP,
 };
 
+static struct imxi2c_platform_data mx53_ard_i2c2_data = {
+	.bitrate = 50000,
+};
+
+static struct imxi2c_platform_data mx53_ard_i2c3_data = {
+	.bitrate = 400000,
+};
+
 static void __init mx53_ard_io_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
@@ -127,9 +141,12 @@ static void __init mx53_ard_io_init(void)
 
 	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
 	gpio_direction_input(ARD_ETHERNET_INT_B);
+
+	gpio_request(ARD_I2CPORTEXP_B, "i2cptexp-rst");
+	gpio_direction_output(ARD_I2CPORTEXP_B, 1);
 }
 
- /* Config CS1 settings for ethernet controller */
+/* Config CS1 settings for ethernet controller */
 static int weim_cs_config(void)
 {
 	u32 reg;
@@ -179,6 +196,8 @@ static void __init mx53_ard_board_init(void)
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
 	imx53_add_imx2_wdt(0, NULL);
+	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
+	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
