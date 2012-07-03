From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 15:44:57 -0300
Subject: [PATCH 1/2] ARM: mx27pdk: Add audio support
Message-ID: <1341341098-9510-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27pdk has a mc13783 audio codec.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |   21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0da882a..deb9f37 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -300,6 +300,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MX2_CAMERA
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index c6d385c..3dc944e 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -160,6 +160,11 @@ static const int mx27pdk_pins[] __initconst = {
 	PB21_PF_CSI_HSYNC,
 	CSI_PWRDWN | GPIO_GPIO | GPIO_OUT,
 	CSI_RESET | GPIO_GPIO | GPIO_OUT,
+	/* SSI4 */
+	PC16_PF_SSI4_FS,
+	PC17_PF_SSI4_RXD,
+	PC18_PF_SSI4_TXD,
+	PC19_PF_SSI4_CLK,
 };
 
 static struct gpio mx27_3ds_camera_gpios[] = {
@@ -331,13 +336,24 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 };
 
 /* MC13783 */
+static struct mc13xxx_codec_platform_data mx27_3ds_codec = {
+	.dac_ssi_port = MC13783_SSI1_PORT,
+	.adc_ssi_port = MC13783_SSI1_PORT,
+};
+
 static struct mc13xxx_platform_data mc13783_pdata = {
 	.regulators = {
 		.regulators = mx27_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
 
 	},
-	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC |
+						MC13XXX_USE_CODEC,
+	.codec = &mx27_3ds_codec,
+};
+
+static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
+	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
 /* SPI */
@@ -513,6 +529,9 @@ static void __init mx27pdk_init(void)
 	}
 
 	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
+	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
+
+	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.7.1
