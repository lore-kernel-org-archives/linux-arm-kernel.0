From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Mon, 21 Sep 2015 20:26:11 +0800
Subject: [RESEND PATCH] media: vb2: Fix vb2_dc_prepare do not correct sync
 data to device
Message-ID: <1442838371-21484-1-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vb2_dc_prepare use the number of SG entries dma_map_sg_attrs return.
But in dma_sync_sg_for_device, it use lengths of each SG entries
before dma_map_sg_attrs. dma_map_sg_attrs will concatenate
SGs until dma length > dma seg bundary. sgt->nents will less than
sgt->orig_nents. Using SG entries after dma_map_sg_attrs
in vb2_dc_prepare will make some SGs are not sync to device.
After add DMA_ATTR_SKIP_CPU_SYNC in vb2_dc_get_userptr to remove
sync data to device twice. Device randomly get incorrect data because
some SGs are not sync to device. Change to use number of SG entries
before dma_map_sg_attrs in vb2_dc_prepare to prevent this issue.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 drivers/media/v4l2-core/videobuf2-dma-contig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
index 2397ceb..c5d00bd 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
@@ -100,7 +100,7 @@ static void vb2_dc_prepare(void *buf_priv)
 	if (!sgt || buf->db_attach)
 		return;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
 static void vb2_dc_finish(void *buf_priv)
@@ -112,7 +112,7 @@ static void vb2_dc_finish(void *buf_priv)
 	if (!sgt || buf->db_attach)
 		return;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
 /*********************************************/
-- 
1.8.1.1.dirty
