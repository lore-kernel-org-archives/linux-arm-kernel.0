From: thibault.saunier@osg.samsung.com (Thibault Saunier)
Date: Thu,  9 Feb 2017 16:43:13 -0300
Subject: [PATCH 3/4] [media] s5p-mfc: Set colorspace in VIDIO_{G,TRY}_FMT
In-Reply-To: <20170209194314.5908-1-thibault.saunier@osg.samsung.com>
References: <20170209194314.5908-1-thibault.saunier@osg.samsung.com>
Message-ID: <20170209194314.5908-4-thibault.saunier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The media documentation says that the V4L2_COLORSPACE_SMPTE170M colorspace
should be used for SDTV and V4L2_COLORSPACE_REC709 for HDTV but the driver
didn't set the colorimetry, also respect usespace setting.

Use 576p display resolution as a threshold to set this.

Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 367ef8e8dbf0..960d6c7052bd 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -354,6 +354,15 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		pix_mp->plane_fmt[0].sizeimage = ctx->luma_size;
 		pix_mp->plane_fmt[1].bytesperline = ctx->buf_width;
 		pix_mp->plane_fmt[1].sizeimage = ctx->chroma_size;
+
+		if (pix_mp->colorspace != V4L2_COLORSPACE_REC709 &&
+			pix_mp->colorspace != V4L2_COLORSPACE_SMPTE170M &&
+			pix_mp->colorspace != V4L2_COLORSPACE_DEFAULT) {
+		  if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
+			pix_mp->colorspace = V4L2_COLORSPACE_REC709;
+		  else /* SD */
+			pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
+		}
 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		/* This is run on OUTPUT
 		   The buffer contains compressed image
@@ -378,6 +387,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct s5p_mfc_dev *dev = video_drvdata(file);
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct s5p_mfc_fmt *fmt;
 
 	mfc_debug(2, "Type is %d\n", f->type);
@@ -405,6 +415,15 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
 		}
+
+		if (pix_mp->colorspace != V4L2_COLORSPACE_REC709 &&
+			pix_mp->colorspace != V4L2_COLORSPACE_SMPTE170M &&
+			pix_mp->colorspace != V4L2_COLORSPACE_DEFAULT) {
+		  if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
+			pix_mp->colorspace = V4L2_COLORSPACE_REC709;
+		  else /* SD */
+			pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
+		}
 	}
 
 	return 0;
-- 
2.11.1
