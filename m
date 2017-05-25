From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 24 May 2017 17:29:47 -0700
Subject: [PATCH v7 32/34] media: imx: capture: add frame sizes/interval
 enumeration
In-Reply-To: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1495672189-29164-33-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Add support for enumerating frame sizes and frame intervals from the
first subdev via the V4L2 interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-capture.c | 73 +++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 76c17d9..8b28dbc 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -81,6 +81,76 @@ static int vidioc_querycap(struct file *file, void *fh,
 	return 0;
 }
 
+static int capture_enum_framesizes(struct file *file, void *fh,
+				   struct v4l2_frmsizeenum *fsize)
+{
+	struct capture_priv *priv = video_drvdata(file);
+	const struct imx_media_pixfmt *cc;
+	struct v4l2_subdev_frame_size_enum fse = {
+		.index = fsize->index,
+		.pad = priv->src_sd_pad,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	cc = imx_media_find_format(fsize->pixel_format, CS_SEL_ANY, true);
+	if (!cc)
+		return -EINVAL;
+
+	fse.code = cc->codes[0];
+
+	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_size, NULL, &fse);
+	if (ret)
+		return ret;
+
+	if (fse.min_width == fse.max_width &&
+	    fse.min_height == fse.max_height) {
+		fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+		fsize->discrete.width = fse.min_width;
+		fsize->discrete.height = fse.min_height;
+	} else {
+		fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
+		fsize->stepwise.min_width = fse.min_width;
+		fsize->stepwise.max_width = fse.max_width;
+		fsize->stepwise.min_height = fse.min_height;
+		fsize->stepwise.max_height = fse.max_height;
+		fsize->stepwise.step_width = 1;
+		fsize->stepwise.step_height = 1;
+	}
+
+	return 0;
+}
+
+static int capture_enum_frameintervals(struct file *file, void *fh,
+				       struct v4l2_frmivalenum *fival)
+{
+	struct capture_priv *priv = video_drvdata(file);
+	const struct imx_media_pixfmt *cc;
+	struct v4l2_subdev_frame_interval_enum fie = {
+		.index = fival->index,
+		.pad = priv->src_sd_pad,
+		.width = fival->width,
+		.height = fival->height,
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	cc = imx_media_find_format(fival->pixel_format, CS_SEL_ANY, true);
+	if (!cc)
+		return -EINVAL;
+
+	fie.code = cc->codes[0];
+
+	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval, NULL, &fie);
+	if (ret)
+		return ret;
+
+	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
+	fival->discrete = fie.interval;
+
+	return 0;
+}
+
 static int capture_enum_fmt_vid_cap(struct file *file, void *fh,
 				    struct v4l2_fmtdesc *f)
 {
@@ -269,6 +339,9 @@ static int capture_s_parm(struct file *file, void *fh,
 static const struct v4l2_ioctl_ops capture_ioctl_ops = {
 	.vidioc_querycap	= vidioc_querycap,
 
+	.vidioc_enum_framesizes = capture_enum_framesizes,
+	.vidioc_enum_frameintervals = capture_enum_frameintervals,
+
 	.vidioc_enum_fmt_vid_cap        = capture_enum_fmt_vid_cap,
 	.vidioc_g_fmt_vid_cap           = capture_g_fmt_vid_cap,
 	.vidioc_try_fmt_vid_cap         = capture_try_fmt_vid_cap,
-- 
2.7.4
