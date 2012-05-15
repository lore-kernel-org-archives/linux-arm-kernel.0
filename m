From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 18:42:26 +0200
Subject: [PATCH 1/1] mx31_3ds: Add sound support
In-Reply-To: <1337100146-16459-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1337100146-16459-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1337100146-16459-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0d75480..472d47b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -151,6 +151,7 @@ config MACH_MX25_3DS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 4d1aab1..4eafdf2 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -156,6 +156,11 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
 	MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
 	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */
+	/* SSI */
+	MX31_PIN_STXD4__STXD4,
+	MX31_PIN_SRXD4__SRXD4,
+	MX31_PIN_SCK4__SCK4,
+	MX31_PIN_SFS4__SFS4,
 };
 
 /*
@@ -488,12 +493,23 @@ static struct mc13xxx_regulator_init_data mx31_3ds_regulators[] = {
 };
 
 /* MC13783 */
+static struct mc13xxx_codec_platform_data mx31_3ds_codec = {
+	.dac_ssi_port = MC13783_SSI1_PORT,
+	.adc_ssi_port = MC13783_SSI1_PORT,
+};
+
 static struct mc13xxx_platform_data mc13783_pdata = {
 	.regulators = {
 		.regulators = mx31_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
+	.codec = &mx31_3ds_codec,
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC | MC13XXX_USE_CODEC,
+
+};
+
+static struct imx_ssi_platform_data mx31_3ds_ssi_pdata = {
+	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
 /* SPI */
@@ -741,6 +757,10 @@ static void __init mx31_3ds_init(void)
 	}
 
 	mx31_3ds_init_camera();
+
+	imx31_add_imx_ssi(0, &mx31_3ds_ssi_pdata);
+
+	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.7.0.4
