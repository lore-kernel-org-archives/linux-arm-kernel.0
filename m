From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 21:05:55 +0800
Subject: [PATCH 3/3] video: mxsfb: Adapt to new videomode API
In-Reply-To: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
References: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368018355-26014-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 6cd2c7db4 (videomode: videomode_from_timing work) changed the name of
the function from videomode_from_timing() to videomode_from_timings().

commit 32ed6ef1 (videomode: create enum for videomode's display flags) changed
the 'data_flags' field in videomode structure to 'flags'

Adapt to these changes in order to fix the following errors:

drivers/video/mxsfb.c:761:3: error: too many arguments to function 'videomode_from_timing'
drivers/video/mxsfb.c:761:7: error: void value not ignored as it ought to be
drivers/video/mxsfb.c:768:9: error: 'struct videomode' has no member named 'data_flags'
drivers/video/mxsfb.c:770:9: error: 'struct videomode' has no member named 'data_flags'

Also, select VIDEOMODE_HELPER instead of OF_VIDEOMODE, as this one is
deprecated.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/Kconfig |    2 +-
 drivers/video/mxsfb.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c04ccdf..1687058 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2429,7 +2429,7 @@ config FB_MXS
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_MODE_HELPERS
-	select OF_VIDEOMODE
+	select VIDEOMODE_HELPERS
 	help
 	  Framebuffer support for the MXS SoC.
 
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 1b2c26d..21223d4 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -42,7 +42,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
-#include <video/of_display_timing.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -50,6 +49,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/fb.h>
 #include <linux/regulator/consumer.h>
+#include <video/of_display_timing.h>
 #include <video/videomode.h>
 
 #define REG_SET	4
@@ -777,16 +777,16 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
 		struct videomode vm;
 		struct fb_videomode fb_vm;
 
-		ret = videomode_from_timing(timings, &vm, i);
+		ret = videomode_from_timings(timings, &vm, i);
 		if (ret < 0)
 			goto put_timings_node;
 		ret = fb_videomode_from_videomode(&vm, &fb_vm);
 		if (ret < 0)
 			goto put_timings_node;
 
-		if (vm.data_flags & DISPLAY_FLAGS_DE_HIGH)
+		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
 			host->sync |= MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
-		if (vm.data_flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
 			host->sync |= MXSFB_SYNC_DOTCLK_FALLING_ACT;
 		fb_add_videomode(&fb_vm, &fb_info->modelist);
 	}
-- 
1.7.9.5
