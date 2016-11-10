From: wuchengli@chromium.org (Wu-Cheng Li)
Date: Thu, 10 Nov 2016 13:24:05 +0800
Subject: [PATCH v1] mtk-vcodec: add index check in decoder vidioc_qbuf.
In-Reply-To: <1478755445-23494-1-git-send-email-wuchengli@chromium.org>
References: <1478755445-23494-1-git-send-email-wuchengli@chromium.org>
Message-ID: <1478755445-23494-2-git-send-email-wuchengli@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wu-Cheng Li <wuchengli@google.com>

vb2_qbuf will check the buffer index. If a driver overrides
vidioc_qbuf and use the buffer index, the driver needs to check
the index.

Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 0520919..0746592 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -533,6 +533,10 @@ static int vidioc_vdec_qbuf(struct file *file, void *priv,
 	}
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, buf->type);
+	if (buf->index >= vq->num_buffers) {
+		mtk_v4l2_debug(1, "buffer index %d out of range", buf->index);
+		return -EINVAL;
+	}
 	vb = vq->bufs[buf->index];
 	vb2_v4l2 = container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
 	mtkbuf = container_of(vb2_v4l2, struct mtk_video_dec_buf, vb);
-- 
2.8.0.rc3.226.g39d4020
