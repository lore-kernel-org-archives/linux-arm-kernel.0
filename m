From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Thu,  9 Feb 2017 16:43:14 -0300
Subject: [PATCH 4/4] [media] s5p-mfc: Always check and set
 'v4l2_pix_format:field' field
In-Reply-To: <20170209194314.5908-1-thibault.saunier@osg.samsung.com>
References: <20170209194314.5908-1-thibault.saunier@osg.samsung.com>
Message-ID: <20170209194314.5908-5-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is required by the standard that the field order is set by the
driver.

Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 960d6c7052bd..dfb21b4aee10 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -345,7 +345,6 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		   rectangle. */
 		pix_mp->width = ctx->buf_width;
 		pix_mp->height = ctx->buf_height;
-		pix_mp->field = V4L2_FIELD_NONE;
 		pix_mp->num_planes = 2;
 		/* Set pixelformat to the format in which MFC
 		   outputs the decoded frame */
@@ -369,7 +368,6 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		   so width and height have no meaning */
 		pix_mp->width = 0;
 		pix_mp->height = 0;
-		pix_mp->field = V4L2_FIELD_NONE;
 		pix_mp->plane_fmt[0].bytesperline = ctx->dec_src_buf_size;
 		pix_mp->plane_fmt[0].sizeimage = ctx->dec_src_buf_size;
 		pix_mp->pixelformat = ctx->src_fmt->fourcc;
@@ -379,6 +377,14 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		mfc_debug(2, "%s-- with error\n", __func__);
 		return -EINVAL;
 	}
+
+	if (pix_mp->field == V4L2_FIELD_ANY) {
+		pix_mp->field = V4L2_FIELD_NONE;
+	} else if (pix_mp->field != V4L2_FIELD_NONE) {
+		mfc_err("Not supported field order(%d)\n", pix_mp->field);
+		return -EINVAL;
+	}
+
 	mfc_debug_leave();
 	return 0;
 }
@@ -389,6 +395,19 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	struct s5p_mfc_dev *dev = video_drvdata(file);
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct s5p_mfc_fmt *fmt;
+	enum v4l2_field field;
+
+	field = f->fmt.pix.field;
+	if (field == V4L2_FIELD_ANY) {
+		field = V4L2_FIELD_NONE;
+	} else if (V4L2_FIELD_NONE != field) {
+		mfc_debug("Not supported field order(%d)\n", pix_mp->field);
+		return -EINVAL;
+	}
+
+	/* V4L2 specification suggests the driver corrects the format struct
+	 * if any of the dimensions is unsupported */
+	f->fmt.pix.field = field;
 
 	mfc_debug(2, "Type is %d\n", f->type);
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-- 
2.11.1
