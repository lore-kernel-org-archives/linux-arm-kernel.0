From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed,  8 Jun 2016 19:35:15 -0600
Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
Message-ID: <1465436115-13880-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_mfc_remove() fails to release encoder and decoder video devices.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 274b4f1..af61f54 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1317,7 +1317,9 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 	destroy_workqueue(dev->watchdog_workqueue);
 
 	video_unregister_device(dev->vfd_enc);
+	video_device_release(dev->vfd_enc);
 	video_unregister_device(dev->vfd_dec);
+	video_device_release(dev->vfd_dec);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	s5p_mfc_release_firmware(dev);
 	vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[0]);
-- 
2.7.4
