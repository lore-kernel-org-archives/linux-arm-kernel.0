From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 15:09:59 +0100
Subject: [PATCH 5/7] [media] em28xx: only use mt9v011 if camera support is
 enabled
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
References: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <1453817424-3080054-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In randconfig builds that select VIDEO_EM28XX_V4L2 and
MEDIA_SUBDRV_AUTOSELECT, but not MEDIA_CAMERA_SUPPORT, we get
a Kconfig warning:

 warning: (VIDEO_EM28XX_V4L2) selects VIDEO_MT9V011 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This avoids the warning by making that 'select' conditional on
MEDIA_CAMERA_SUPPORT. Alternatively we could mark EM28XX as
'depends on MEDIA_CAMERA_SUPPORT', but it does not seem to
have any real dependency on that itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/em28xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
index e382210c4ada..75323f5efd0f 100644
--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_EM28XX_V4L2
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 
 	---help---
 	  This is a video4linux driver for Empia 28xx based TV cards.
-- 
2.7.0
