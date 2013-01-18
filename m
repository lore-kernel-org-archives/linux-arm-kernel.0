From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:31:53 +0100
Subject: [PATCH v2 5/8] ARM: OMAP: zoom: Audio support via the common
 omap-twl4030 machine driver
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519516-13165-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common omap-twl4030 ASoC machine driver for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 03ec6b2..f4ea926 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -20,6 +20,7 @@
 #include <linux/wl12xx.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/omap-twl4030.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -226,6 +227,19 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}      /* Terminator */
 };
 
+static struct omap_tw4030_pdata omap_twl4030_audio_data = {
+	.voice_connected = true,
+	.custom_routing	= true,
+
+	.has_hs		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+	.has_hf		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+
+	.has_mainmic	= true,
+	.has_submic	= true,
+	.has_hsmic	= true,
+	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+};
+
 static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -241,6 +255,10 @@ static int zoom_twl_gpio_setup(struct device *dev,
 		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
 				LCD_PANEL_ENABLE_GPIO);
 
+	/* Audio setup */
+	omap_twl4030_audio_data.jack_detect = gpio + 2;
+	omap_twl4030_audio_init("Zoom2", &omap_twl4030_audio_data);
+
 	return ret;
 }
 
-- 
1.8.1
