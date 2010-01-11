From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:17 +0800
Subject: [PATCH 09/16] [ARM] pxa: add the missing AC97 pin configurations
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-10-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing AC97 pin configurations are added where pxa_set_ac97_info() are
called for all pxa25x/pxa27x platforms. Where no exact configuration is
provided, use the default as in sound/arm/pxa2xx-ac97-lib.c

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c         |   12 +++++++++++-
 arch/arm/mach-pxa/e740.c             |    6 ++++++
 arch/arm/mach-pxa/e750.c             |    6 ++++++
 arch/arm/mach-pxa/e800.c             |    9 +++++++++
 arch/arm/mach-pxa/lpd270.c           |    4 ++++
 arch/arm/mach-pxa/lubbock.c          |    6 ++++++
 arch/arm/mach-pxa/mainstone.c        |    4 ++++
 arch/arm/mach-pxa/mioa701.c          |    4 ++++
 arch/arm/mach-pxa/pcm990-baseboard.c |    6 ++++++
 arch/arm/mach-pxa/trizeps4.c         |    6 ++++++
 arch/arm/mach-pxa/viper.c            |    6 ++++++
 arch/arm/mach-pxa/zeus.c             |    6 ++++++
 12 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 6f813aa..f3b5ace 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -132,6 +132,14 @@ static void __init balloon3_init_irq(void)
 		"enabled\n", __func__, BALLOON3_AUX_NIRQ);
 }
 
+static unsigned long balloon3_ac97_pin_config[] = {
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+	GPIO113_AC97_nRESET,
+};
+
 static void balloon3_backlight_power(int on)
 {
 	pr_debug("%s: power is %s\n", __func__, on ? "on" : "off");
@@ -292,8 +300,10 @@ static void __init balloon3_init(void)
 	pxa_set_stuart_info(NULL);
 
 	pxa_set_i2c_info(NULL);
-	if (balloon3_has(BALLOON3_FEATURE_AUDIO))
+	if (balloon3_has(BALLOON3_FEATURE_AUDIO)) {
+		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_ac97_pin_config));
 		pxa_set_ac97_info(NULL);
+	}
 
 	if (balloon3_has(BALLOON3_FEATURE_TOPPOLY)) {
 		pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_lcd_pin_config));
diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
index 94b23a9..d578021 100644
--- a/arch/arm/mach-pxa/e740.c
+++ b/arch/arm/mach-pxa/e740.c
@@ -134,6 +134,12 @@ static unsigned long e740_pin_config[] __initdata = {
 	/* IrDA */
 	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
 
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	/* Audio power control */
 	GPIO16_GPIO,  /* AC97 codec AVDD2 supply (analogue power) */
 	GPIO40_GPIO,  /* Mic amp power */
diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index 5eccbce..af83caa 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -132,6 +132,12 @@ static unsigned long e750_pin_config[] __initdata = {
 	/* IrDA */
 	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
 
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	/* Audio power control */
 	GPIO4_GPIO,  /* Headphone amp power */
 	GPIO7_GPIO,  /* Speaker amp power */
diff --git a/arch/arm/mach-pxa/e800.c b/arch/arm/mach-pxa/e800.c
index aad129b..8ea97bf 100644
--- a/arch/arm/mach-pxa/e800.c
+++ b/arch/arm/mach-pxa/e800.c
@@ -35,6 +35,14 @@
 
 /* ------------------------ e800 LCD definitions ------------------------- */
 
+static unsigned long e800_pin_config[] __initdata = {
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+};
+
 static struct w100_gen_regs e800_lcd_regs = {
 	.lcd_format =            0x00008003,
 	.lcdd_cntl1 =            0x02a00000,
@@ -195,6 +203,7 @@ static struct platform_device *devices[] __initdata = {
 
 static void __init e800_init(void)
 {
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(e800_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index c87abc3..d279507 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -83,6 +83,10 @@ static unsigned long lpd270_pin_config[] __initdata = {
 	GPIO89_USBH1_PEN,
 
 	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
 	GPIO45_AC97_SYSCLK,
 
 	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 56ae54e..2f5e45e 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -66,6 +66,12 @@ static unsigned long lubbock_pin_config[] __initdata = {
 	GPIO25_SSP1_TXD,
 	GPIO26_SSP1_RXD,
 
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	/* LCD - 16bpp DSTN */
 	GPIOxx_LCD_DSTN_16BPP,
 
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 3637039..5543c64 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -88,6 +88,10 @@ static unsigned long mainstone_pin_config[] = {
 	GPIO57_nIOIS16,
 
 	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
 	GPIO45_AC97_SYSCLK,
 
 	/* Keypad */
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index ca47ee1..843fcca 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -137,6 +137,10 @@ static unsigned long mioa701_pin_config[] = {
 	GPIO41_FFUART_RTS,
 
 	/* Sound */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
 	GPIO89_AC97_SYSCLK,
 	MIO_CFG_IN(GPIO12_HPJACK_INSERT, AF0),
 
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index e74bdfc..9d0ecea 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -58,6 +58,12 @@ static unsigned long pcm990_pin_config[] __initdata = {
 	/* I2C */
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
 };
 
 /*
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 4416008..797f254 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -72,6 +72,12 @@ static unsigned long trizeps4_pin_config[] __initdata = {
 	GPIO79_nCS_3,		/* Logic CS */
 	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,	/* Logic irq */
 
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	/* LCD - 16bpp Active TFT */
 	GPIOxx_LCD_TFT_16BPP,
 
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 886b13a..8df96ad 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -711,6 +711,12 @@ static mfp_cfg_t viper_pin_config[] __initdata = {
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
 
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	/* FP Backlight */
 	GPIO9_GPIO, 				/* VIPER_BCKLIGHT_EN_GPIO */
 	GPIO10_GPIO,				/* VIPER_LCD_EN_GPIO */
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 5b986a8..9e16dea 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -686,6 +686,12 @@ static struct i2c_board_info __initdata zeus_i2c_devices[] = {
 };
 
 static mfp_cfg_t zeus_pin_config[] __initdata = {
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
 	GPIO15_nCS_1,
 	GPIO78_nCS_2,
 	GPIO80_nCS_4,
-- 
1.6.3.3
