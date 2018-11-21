From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 21 Nov 2018 15:37:59 +0900
Subject: [PATCH] media: mtk-vcodec: Remove VA from encoder frame buffers
Message-ID: <20181121063759.26374-1-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The encoder driver has no need to do any CPU access to the source frame
buffers. Use a separate structure for holding DMA addresses and sizes
for those and remove, so we do not end up introducing any erroneous
dereferences of those VAs.

This fixes DMA-buf import from exporters that do not provide contiguous
kernel mappings, which includes the MTK DRM driver.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c  | 6 +-----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 5 +++++
 drivers/media/platform/mtk-vcodec/venc_drv_if.h     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 54631ad1c71e..d1f12257bf66 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1087,7 +1087,6 @@ static void mtk_venc_worker(struct work_struct *work)
 	src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 	memset(&frm_buf, 0, sizeof(frm_buf));
 	for (i = 0; i < src_buf->num_planes ; i++) {
-		frm_buf.fb_addr[i].va = vb2_plane_vaddr(src_buf, i);
 		frm_buf.fb_addr[i].dma_addr =
 				vb2_dma_contig_plane_dma_addr(src_buf, i);
 		frm_buf.fb_addr[i].size =
@@ -1098,14 +1097,11 @@ static void mtk_venc_worker(struct work_struct *work)
 	bs_buf.size = (size_t)dst_buf->planes[0].length;
 
 	mtk_v4l2_debug(2,
-			"Framebuf VA=%p PA=%llx Size=0x%zx;VA=%p PA=0x%llx Size=0x%zx;VA=%p PA=0x%llx Size=%zu",
-			frm_buf.fb_addr[0].va,
+			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
 			(u64)frm_buf.fb_addr[0].dma_addr,
 			frm_buf.fb_addr[0].size,
-			frm_buf.fb_addr[1].va,
 			(u64)frm_buf.fb_addr[1].dma_addr,
 			frm_buf.fb_addr[1].size,
-			frm_buf.fb_addr[2].va,
 			(u64)frm_buf.fb_addr[2].dma_addr,
 			frm_buf.fb_addr[2].size);
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 06c254f5c171..9bf6e8d1b9c9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -25,6 +25,11 @@ struct mtk_vcodec_mem {
 	dma_addr_t dma_addr;
 };
 
+struct mtk_vcodec_fb {
+	size_t size;
+	dma_addr_t dma_addr;
+};
+
 struct mtk_vcodec_ctx;
 struct mtk_vcodec_dev;
 
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
index a6e7d32e55cb..55ecda844894 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
@@ -106,7 +106,7 @@ struct venc_enc_param {
  * @fb_addr: plane frame buffer addresses
  */
 struct venc_frm_buf {
-	struct mtk_vcodec_mem fb_addr[MTK_VCODEC_MAX_PLANES];
+	struct mtk_vcodec_fb fb_addr[MTK_VCODEC_MAX_PLANES];
 };
 
 /*
-- 
2.19.1.1215.g8438c0b245-goog
