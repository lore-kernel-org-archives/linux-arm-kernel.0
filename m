From: panpan1.liu@samsung.com (panpan liu)
Date: Wed, 16 Jul 2014 09:46:34 +0800
Subject: [PATCH] s5p-mfc: limit the size of the CPB
Message-ID: <1405475194-3116-1-git-send-email-panpan1.liu@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPB size is limited by the hardware. Add this limit to the s_fmt.
 space required before the open parenthesis '('
Signed-off-by: panpan liu <panpan1.liu@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 0bae907..0621ed8 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -413,6 +413,7 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	int ret = 0;
 	struct s5p_mfc_fmt *fmt;
 	struct v4l2_pix_format_mplane *pix_mp;
+	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;

 	mfc_debug_enter();
 	ret = vidioc_try_fmt(file, priv, f);
@@ -466,11 +467,13 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	mfc_debug(2, "The codec number is: %d\n", ctx->codec_mode);
 	pix_mp->height = 0;
 	pix_mp->width = 0;
-	if (pix_mp->plane_fmt[0].sizeimage)
-		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
-	else
+	if (pix_mp->plane_fmt[0].sizeimage == 0)
 		pix_mp->plane_fmt[0].sizeimage = ctx->dec_src_buf_size =
 								DEF_CPB_SIZE;
+	else if (pix_mp->plane_fmt[0].sizeimage > buf_size->cpb)
+		ctx->dec_src_buf_size = buf_size->cpb;
+	else
+		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
 	pix_mp->plane_fmt[0].bytesperline = 0;
 	ctx->state = MFCINST_INIT;
 out:
--
1.7.9.5
