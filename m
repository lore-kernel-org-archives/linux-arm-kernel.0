From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Thu, 24 Sep 2015 17:02:36 +0800
Subject: [PATCH v2] media: vb2: Fix vb2_dc_prepare do not correct sync data to
 device
In-Reply-To: <1443085356-1010-1-git-send-email-tiffany.lin@mediatek.com>
References: <1443085356-1010-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1443085356-1010-2-git-send-email-tiffany.lin@mediatek.com>
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
 drivers/media/v4l2-core/videobuf2-dma-sg.c     | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

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
diff --git a/drivers/media/v4l2-core/videobuf2-dma-sg.c b/drivers/media/v4l2-core/videobuf2-dma-sg.c
index be7bd65..a09f7fd 100644
--- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
@@ -1,4 +1,3 @@
-/*
  * videobuf2-dma-sg.c - dma scatter/gather memory allocator for videobuf2
  *
  * Copyright (C) 2010 Samsung Electronics
@@ -210,7 +209,7 @@ static void vb2_dma_sg_prepare(void *buf_priv)
 	if (buf->db_attach)
 		return;
 
-	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
 static void vb2_dma_sg_finish(void *buf_priv)
@@ -222,7 +221,7 @@ static void vb2_dma_sg_finish(void *buf_priv)
 	if (buf->db_attach)
 		return;
 
-	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir);
+	dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
 }
 
 static void *vb2_dma_sg_get_userptr(void *alloc_ctx, unsigned long vaddr,
-- 
1.8.1.1.dirty
