From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 19 Mar 2017 10:49:08 +0000
Subject: [PATCH 4/4] media: imx-media-capture: add frame sizes/interval
 enumeration
In-Reply-To: <20170319103801.GQ21222@n2100.armlinux.org.uk>
References: <20170319103801.GQ21222@n2100.armlinux.org.uk>
Message-ID: <E1cpYOa-0006Eu-CL@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for enumerating frame sizes and frame intervals from the
first subdev via the V4L2 interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/staging/media/imx/imx-media-capture.c | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index cdeb2cd8b1d7..bc99d9310e36 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -82,6 +82,65 @@ static int vidioc_querycap(struct file *file, void *fh,
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
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fsize->discrete.width = fse.min_width;
+	fsize->discrete.height = fse.max_height;
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
@@ -270,6 +329,9 @@ static int capture_s_parm(struct file *file, void *fh,
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
