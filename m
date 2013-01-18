From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:31:54 +0100
Subject: [PATCH v2 6/8] ARM: OMAP: sdp3430: Audio support via the common
 omap-twl4030 machine driver
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519516-13165-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common omap-twl4030 ASoC machine driver for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 40c22a7..e7ef311 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/omap-twl4030.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -209,6 +210,19 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
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
 static int sdp3430_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -225,6 +239,9 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	/* gpio + 15 is "sub_lcd_nRST" (output) */
 	gpio_request_one(gpio + 15, GPIOF_OUT_INIT_LOW, "sub_lcd_nRST");
 
+	omap_twl4030_audio_data.jack_detect = gpio + 2;
+	omap_twl4030_audio_init("SDP3430", &omap_twl4030_audio_data);
+
 	return 0;
 }
 
-- 
1.8.1
