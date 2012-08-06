From: gcembed@gmail.com (=?UTF-8?q?Ga=C3=ABtan=20Carlier?=)
Date: Mon,  6 Aug 2012 15:07:27 +0200
Subject: [PATCH 1/1] mx27_3ds: Add sound support
Message-ID: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I have ported code "Enable sound on mx31_3ds" from Philippe R?tornaz to
MX27 3DS platform on master branch of linux-next (tag next-20120806).
I also applied patch "dma: imx-dma: Fix kernel crash due to missing clock
conversion" of Fabio Estevam which is not yet merged in linux-next.
Thanks to them, everything is working good on MX27 3DS platform except that
sound is played too fast.
Which parameter must be adjusted to have sound playing at normal speed ?
In mc13783 codec driver, imx_add_imx_ssi(), clock configuration in
mach-mx27_3ds file ?

Thanks for your help.

Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |   19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index afd542a..63f64f1 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -302,6 +302,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MX2_CAMERA
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 58c24c1..a5d4080 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -158,6 +158,11 @@ static const int mx27pdk_pins[] __initconst = {
 	PB21_PF_CSI_HSYNC,
 	CSI_PWRDWN | GPIO_GPIO | GPIO_OUT,
 	CSI_RESET | GPIO_GPIO | GPIO_OUT,
+	/* SSI */
+	PC16_PF_SSI4_FS,
+	PC17_PF_SSI4_RXD,
+	PC18_PF_SSI4_TXD,
+	PC19_PF_SSI4_CLK,
 };
 
 static struct gpio mx27_3ds_camera_gpios[] = {
@@ -329,13 +334,23 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
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
+	.codec = &mx27_3ds_codec,
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC | MC13XXX_USE_CODEC,
+};
+
+static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
+		.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
 /* SPI */
@@ -512,6 +527,8 @@ static void __init mx27pdk_init(void)
 	}
 
 	imx27_add_mx2_camera(&mx27_3ds_cam_pdata);
+	imx27_add_imx_ssi(0, &mx27_3ds_ssi_pdata);
+	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.7.7.4
