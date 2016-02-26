From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 12:53:22 +0100
Subject: [PATCH] [media] em28xx: restore lost #ifdef
Message-ID: <1456487606-3912264-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cleanup that changed the em28xx driver to use v4l2_mc_create_media_graph
instead of its own implementation causes a build error when CONFIG_MEDIA_CONTROLLER
is disabled:

drivers/media/usb/em28xx/em28xx-video.c: In function 'em28xx_v4l2_init':
drivers/media/usb/em28xx/em28xx-video.c:2717:38: error: 'struct em28xx' has no member named 'media_dev'

This puts the new code inside the same #ifdef that controls the presence
of the 'media_dev' member, and that the old code was in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: de39078779cb ("[media] em2xx: use v4l2_mc_create_media_graph()")
---
 drivers/media/usb/em28xx/em28xx-video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index f772e2612608..44834b2eff55 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2714,12 +2714,14 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 	/* Init entities at the Media Controller */
 	em28xx_v4l2_create_entities(dev);
 
+#ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_mc_create_media_graph(dev->media_dev);
 	if (ret) {
 		em28xx_errdev("failed to create media graph\n");
 		em28xx_v4l2_media_release(dev);
 		goto unregister_dev;
 	}
+#endif
 
 	em28xx_info("V4L2 video device registered as %s\n",
 		    video_device_node_name(&v4l2->vdev));
-- 
2.7.0
