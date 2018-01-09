From: tfiga@chromium.org (Tomasz Figa)
Date: Tue,  9 Jan 2018 17:42:47 +0900
Subject: [PATCH] media: mtk-vcodec: Always signal source change event on
 format change
Message-ID: <20180109084247.104601-1-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver signals the source change event only in case of
a midstream resolution change, however the initial format detection
is also defined as a source change by the V4L2 codec API specification.
Fix this by signaling the event after the initial header is parsed as
well.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 843510979ad8..86f0a7134365 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1224,6 +1224,8 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 	ctx->dpb_size = dpbsize;
 	ctx->state = MTK_STATE_HEADER;
 	mtk_v4l2_debug(1, "[%d] dpbsize=%d", ctx->id, ctx->dpb_size);
+
+	mtk_vdec_queue_res_chg_event(ctx);
 }
 
 static void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
-- 
2.16.0.rc0.223.g4a4ac83678-goog
