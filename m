From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 8 Nov 2009 03:06:00 +0100
Subject: [PATCH 2/2] Colibri/PXA320: Add UCB1400 touchscreen support
Message-ID: <200911080306.00426.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 0a31bd0b502ebf7761562467711c68134521d8fc Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 8 Nov 2009 02:27:04 +0100
Subject: [PATCH 2/2] Colibri/PXA320: Add UCB1400 touchscreen support

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa320.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-
pxa320.c
index ec0e14b..3b349e9 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -146,6 +146,21 @@ static void __init colibri_pxa320_init_lcd(void)
 static inline void colibri_pxa320_init_lcd(void) {}
 #endif
 
+#if	defined(CONFIG_TOUCHSCREEN_UCB1400) || \
+	defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
+static struct platform_device colibri_pxa320_ts_device = {
+	.name		= "ucb1400_core",
+	.id		= -1,
+};
+
+static void __init colibri_pxa320_init_touchscreen(void)
+{
+	platform_device_register(&colibri_pxa320_ts_device);
+}
+#else
+static inline void colibri_pxa320_init_touchscreen(void) {}
+#endif
+
 #if	defined(CONFIG_SND_AC97_CODEC) || \
 	defined(CONFIG_SND_AC97_CODEC_MODULE)
 static mfp_cfg_t colibri_pxa320_ac97_pin_config[] __initdata = {
@@ -205,6 +220,7 @@ void __init colibri_pxa320_init(void)
 	colibri_pxa320_init_lcd();
 	colibri_pxa3xx_init_lcd(mfp_to_gpio(GPIO49_GPIO));
 	colibri_pxa320_init_ac97();
+	colibri_pxa320_init_touchscreen();
 	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa320_mmc_pin_config),
 				mfp_to_gpio(MFP_PIN_GPIO28));
 	colibri_pxa320_init_uart();
-- 
1.6.5
