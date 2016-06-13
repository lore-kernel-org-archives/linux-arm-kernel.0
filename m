From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 13 Jun 2016 13:45:14 -0600
Subject: [PATCH] media: s5p-mfc fix memory leak in s5p_mfc_remove()
Message-ID: <1465847114-7427-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_mfc_remove() fails to release encoder and decoder video devices.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes since v1:
- Addressed comments from Javier Martinez Canillas and added
  his reviewed by:

 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 274b4f1..f537b74 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1318,6 +1318,8 @@ static int s5p_mfc_remove(struct platform_device *pdev)
 
 	video_unregister_device(dev->vfd_enc);
 	video_unregister_device(dev->vfd_dec);
+	video_device_release(dev->vfd_enc);
+	video_device_release(dev->vfd_dec);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	s5p_mfc_release_firmware(dev);
 	vb2_dma_contig_cleanup_ctx(dev->alloc_ctx[0]);
-- 
2.7.4
