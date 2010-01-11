From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:11 +0800
Subject: [PATCH 03/16] [ARM] pxa: simplify the LCD pin configuration for
	pxa25x platforms
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-4-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are only limited possible LCD pin configurations for pxa25x
platforms, simplify this by macro.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/cm-x255.c                 |   21 +----------------
 arch/arm/mach-pxa/idp.c                     |   20 +----------------
 arch/arm/mach-pxa/include/mach/mfp-pxa25x.h |   32 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/lubbock.c                 |   20 +----------------
 arch/arm/mach-pxa/palmtc.c                  |   21 +----------------
 arch/arm/mach-pxa/palmte2.c                 |   21 +----------------
 arch/arm/mach-pxa/poodle.c                  |   21 +----------------
 7 files changed, 38 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index 253fd76..f1a7703 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -50,26 +50,7 @@ static unsigned long cmx255_pin_config[] = {
 	GPIO47_STUART_TXD,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* SSP1 */
 	GPIO23_SSP1_SCLK,
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 5c9e11d..bc78c4d 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -47,25 +47,7 @@
 
 static unsigned long idp_pin_config[] __initdata = {
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_DSTN_16BPP,
 
 	/* BTUART */
 	GPIO42_BTUART_RXD,
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
index b13dc02..8910a3b 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa25x.h
@@ -188,4 +188,36 @@
 #define GPIO31_ASSP_SFRM_OUT	MFP_CFG_OUT(GPIO31, AF3, DRIVE_LOW)
 #endif
 
+/* commonly used pin configurations */
+#define GPIOxx_LCD_16BPP	\
+	GPIO58_LCD_LDD_0,	\
+	GPIO59_LCD_LDD_1,	\
+	GPIO60_LCD_LDD_2,	\
+	GPIO61_LCD_LDD_3,	\
+	GPIO62_LCD_LDD_4,	\
+	GPIO63_LCD_LDD_5,	\
+	GPIO64_LCD_LDD_6,	\
+	GPIO65_LCD_LDD_7,	\
+	GPIO66_LCD_LDD_8,	\
+	GPIO67_LCD_LDD_9,	\
+	GPIO68_LCD_LDD_10,	\
+	GPIO69_LCD_LDD_11,	\
+	GPIO70_LCD_LDD_12,	\
+	GPIO71_LCD_LDD_13,	\
+	GPIO72_LCD_LDD_14,	\
+	GPIO73_LCD_LDD_15
+
+#define GPIOxx_LCD_DSTN_16BPP	\
+	GPIOxx_LCD_16BPP,	\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK
+
+#define GPIOxx_LCD_TFT_16BPP	\
+	GPIOxx_LCD_16BPP,	\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK,	\
+	GPIO77_LCD_BIAS
+
 #endif /* __ASM_ARCH_MFP_PXA25X_H */
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index d9982b1..56ae54e 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -67,25 +67,7 @@ static unsigned long lubbock_pin_config[] __initdata = {
 	GPIO26_SSP1_RXD,
 
 	/* LCD - 16bpp DSTN */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_DSTN_16BPP,
 
 	/* BTUART */
 	GPIO42_BTUART_RXD,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 3084175..baff2cc 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -84,26 +84,7 @@ static unsigned long palmtc_pin_config[] __initdata = {
 	GPIO36_GPIO,	/* pullup */
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* MATRIX KEYPAD */
 	GPIO0_GPIO | WAKEUP_ON_EDGE_BOTH,	/* in 0 */
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 265d62b..634cbcd 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -73,26 +73,7 @@ static unsigned long palmte2_pin_config[] __initdata = {
 	GPIO47_FICP_TXD,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* GPIO KEYS */
 	GPIO5_GPIO,	/* notes */
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index e5eeb3a..336f663 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -91,26 +91,7 @@ static unsigned long poodle_pin_config[] __initdata = {
 	GPIO35_FFUART_CTS,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* PC Card */
 	GPIO48_nPOE,
-- 
1.6.3.3
