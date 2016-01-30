From: ayaka@soulik.info (ayaka)
Date: Sun, 31 Jan 2016 02:53:36 +0800
Subject: [PATCH 3/4] [media] s5p-mfc: don't close instance after free OUTPUT
 buffers
In-Reply-To: <1454180017-29071-1-git-send-email-ayaka@soulik.info>
References: <1454180017-29071-1-git-send-email-ayaka@soulik.info>
Message-ID: <1454180017-29071-4-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free buffers in OUTPUT is quite normal to detect the driver's
buffer capacity, it doesn't mean the application want to close
that mfc instance.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index aebe4fd..609b17b 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -474,7 +474,6 @@ static int reqbufs_output(struct s5p_mfc_dev *dev, struct s5p_mfc_ctx *ctx,
 		ret = vb2_reqbufs(&ctx->vq_src, reqbufs);
 		if (ret)
 			goto out;
-		s5p_mfc_close_mfc_inst(dev, ctx);
 		ctx->src_bufs_cnt = 0;
 		ctx->output_state = QUEUE_FREE;
 	} else if (ctx->output_state == QUEUE_FREE) {
-- 
2.5.0
