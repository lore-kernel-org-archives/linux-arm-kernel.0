From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 14:39:12 +0200
Subject: [PATCH] [media] ov2659: add v4l2_subdev dependency
Message-ID: <6092911.yr0lA5IaG4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added ov2659 driver uses the v4l2 subdev API, but
can be enabled even when that API is not part of the kernel,
resulting in this build error:

media/i2c/ov2659.c: In function 'ov2659_get_fmt':
media/i2c/ov2659.c:1054:8: error: implicit declaration of function 'v4l2_subdev_get_try_format' [-Werror=implicit-function-declaration]
media/i2c/ov2659.c:1054:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
media/i2c/ov2659.c: In function 'ov2659_set_fmt':
media/i2c/ov2659.c:1129:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
media/i2c/ov2659.c: In function 'ov2659_open':
media/i2c/ov2659.c:1264:38: error: 'struct v4l2_subdev_fh' has no member named 'pad'

This adds an explicit dependency, like all the other drivers have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c4c0283ab3c ("[media] media: i2c: add support for omnivision's ov2659 sensor")

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 6f30ea76151a..db01ed84918f 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -469,7 +469,7 @@ config VIDEO_SMIAPP_PLL
 config VIDEO_OV2659
 	tristate "OmniVision OV2659 sensor support"
 	depends on VIDEO_V4L2 && I2C
-	depends on MEDIA_CAMERA_SUPPORT
+	depends on MEDIA_CAMERA_SUPPORT && VIDEO_V4L2_SUBDEV_API
 	---help---
 	  This is a Video4Linux2 sensor-level driver for the OmniVision
 	  OV2659 camera.
