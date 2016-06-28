From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 28 Jun 2016 13:17:17 -0600
Subject: [PATCH REBASE 2/3] media: s5p-mfc fix memory leak in s5p_mfc_remove()
In-Reply-To: <cover.1467140929.git.shuahkh@osg.samsung.com>
References: <cover.1467140929.git.shuahkh@osg.samsung.com>
Message-ID: <08a995ba777f7ee9f38d6ee886bbe1f2a9656781.1467140929.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_mfc_remove() fails to release encoder and decoder video devices.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
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
