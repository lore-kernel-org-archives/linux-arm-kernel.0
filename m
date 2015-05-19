From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 15:08:05 +0200
Subject: [PATCH] input: sur40: fix v4l dependency
Message-ID: <6880566.G7eZ6NqpSp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added support for the raw video stream in the SUR40
driver fails to link if the driver is built-in but v4l2 is not:

drivers/built-in.o: In function `sur40_disconnect':
:(.text+0xf2ed2): undefined reference to `video_unregister_device'
:(.text+0xf2eda): undefined reference to `v4l2_device_unregister'
:(.text+0xf2ee2): undefined reference to `vb2_dma_sg_cleanup_ctx'

This adds an explicit dependency, to avoid the broken build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e831cd251fb ("[media] add raw video stream support for Samsung SUR40")

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cee8ffe4ffd9..90935f3918db 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -980,6 +980,7 @@ config TOUCHSCREEN_SUN4I
 config TOUCHSCREEN_SUR40
 	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
 	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
+	depends on VIDEO_V4L2
 	select INPUT_POLLDEV
 	select VIDEOBUF2_DMA_SG
 	help
