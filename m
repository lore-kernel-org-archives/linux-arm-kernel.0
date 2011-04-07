From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  7 Apr 2011 10:50:43 +0200
Subject: [PATCH] V4L: mx3_camera: select VIDEOBUF2_DMA_CONTIG instead of
	VIDEOBUF_DMA_CONTIG
Message-ID: <1302166243-650-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit

	379fa5d ([media] V4L: mx3_camera: convert to videobuf2)

mx3_camera uses videobuf2, but that commit didn't upgrade the select
resulting in the following build failure:

	drivers/built-in.o: In function `mx3_camera_init_videobuf':
	clkdev.c:(.text+0x86580): undefined reference to `vb2_dma_contig_memops'
	drivers/built-in.o: In function `mx3_camera_probe':
	clkdev.c:(.devinit.text+0x3548): undefined reference to `vb2_dma_contig_init_ctx'
	clkdev.c:(.devinit.text+0x3578): undefined reference to `vb2_dma_contig_cleanup_ctx'
	drivers/built-in.o: In function `mx3_camera_remove':
	clkdev.c:(.devexit.text+0x674): undefined reference to `vb2_dma_contig_cleanup_ctx'
	make[2]: *** [.tmp_vmlinux1] Error 1
	make[1]: *** [sub-make] Error 2
	make: *** [all] Error 2

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

does someone has a hint how to fix gcc not to believe the undefined
references to be in clkdev.c?

Best regards
Uwe

 drivers/media/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 4498b94..00f51dd 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -875,7 +875,7 @@ config MX3_VIDEO
 config VIDEO_MX3
 	tristate "i.MX3x Camera Sensor Interface driver"
 	depends on VIDEO_DEV && MX3_IPU && SOC_CAMERA
-	select VIDEOBUF_DMA_CONTIG
+	select VIDEOBUF2_DMA_CONTIG
 	select MX3_VIDEO
 	---help---
 	  This is a v4l2 driver for the i.MX3x Camera Sensor Interface
-- 
1.7.2.3
