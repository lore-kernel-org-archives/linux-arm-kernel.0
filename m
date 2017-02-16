From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 15 Feb 2017 18:19:33 -0800
Subject: [PATCH v4 31/36] media: imx: csi: add __csi_get_fmt
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487211578-11360-32-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add __csi_get_fmt() and use it to return the correct mbus format
(active or try) in get_fmt. Use it in other places as well.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Suggested-by: Russell King <linux@armlinux.org.uk>
---
 drivers/staging/media/imx/imx-media-csi.c | 52 ++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 63555dc..b0aac82 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -788,7 +788,20 @@ static int csi_eof_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
 	return 0;
 }
 
-static int csi_try_crop(struct csi_priv *priv, struct v4l2_rect *crop,
+static struct v4l2_mbus_framefmt *
+__csi_get_fmt(struct csi_priv *priv, struct v4l2_subdev_pad_config *cfg,
+	      unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&priv->sd, cfg, pad);
+	else
+		return &priv->format_mbus[pad];
+}
+
+static int csi_try_crop(struct csi_priv *priv,
+			struct v4l2_rect *crop,
+			struct v4l2_subdev_pad_config *cfg,
+			enum v4l2_subdev_format_whence which,
 			struct imx_media_subdev *sensor)
 {
 	struct v4l2_of_endpoint *sensor_ep;
@@ -796,7 +809,7 @@ static int csi_try_crop(struct csi_priv *priv, struct v4l2_rect *crop,
 	v4l2_std_id std;
 	int ret;
 
-	infmt = &priv->format_mbus[CSI_SINK_PAD];
+	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, which);
 	sensor_ep = &sensor->sensor_ep;
 
 	crop->width = min_t(__u32, infmt->width, crop->width);
@@ -852,11 +865,16 @@ static int csi_get_fmt(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_format *sdformat)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *fmt;
 
 	if (sdformat->pad >= CSI_NUM_PADS)
 		return -EINVAL;
 
-	sdformat->format = priv->format_mbus[sdformat->pad];
+	fmt = __csi_get_fmt(priv, cfg, sdformat->pad, sdformat->which);
+	if (!fmt)
+		return -EINVAL;
+
+	sdformat->format = *fmt;
 
 	return 0;
 }
@@ -880,8 +898,6 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	if (priv->stream_on)
 		return -EBUSY;
 
-	infmt = &priv->format_mbus[CSI_SINK_PAD];
-
 	sensor = imx_media_find_sensor(priv->md, &priv->sd.entity);
 	if (IS_ERR(sensor)) {
 		v4l2_err(&priv->sd, "no sensor attached\n");
@@ -895,6 +911,8 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	switch (sdformat->pad) {
 	case CSI_SRC_PAD_DIRECT:
 	case CSI_SRC_PAD_IDMAC:
+		infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sdformat->which);
+
 		if (sdformat->format.width < priv->crop.width * 3 / 4)
 			sdformat->format.width = priv->crop.width / 2;
 		else
@@ -957,7 +975,8 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		crop.top = 0;
 		crop.width = sdformat->format.width;
 		crop.height = sdformat->format.height;
-		ret = csi_try_crop(priv, &crop, sensor);
+		ret = csi_try_crop(priv, &crop, cfg,
+				   sdformat->which, sensor);
 		if (ret)
 			return ret;
 
@@ -1004,7 +1023,9 @@ static int csi_get_selection(struct v4l2_subdev *sd,
 	if (sel->pad >= CSI_NUM_PADS || sel->pad == CSI_SINK_PAD)
 		return -EINVAL;
 
-	infmt = &priv->format_mbus[CSI_SINK_PAD];
+	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sel->which);
+	if (!infmt)
+		return -EINVAL;
 
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP_BOUNDS:
@@ -1014,7 +1035,14 @@ static int csi_get_selection(struct v4l2_subdev *sd,
 		sel->r.height = infmt->height;
 		break;
 	case V4L2_SEL_TGT_CROP:
-		sel->r = priv->crop;
+		if (sel->which == V4L2_SUBDEV_FORMAT_TRY) {
+			struct v4l2_rect *try_crop =
+				v4l2_subdev_get_try_crop(&priv->sd,
+							 cfg, sel->pad);
+			sel->r = *try_crop;
+		} else {
+			sel->r = priv->crop;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -1028,7 +1056,6 @@ static int csi_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_selection *sel)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *outfmt;
 	struct imx_media_subdev *sensor;
 	int ret;
 
@@ -1058,15 +1085,16 @@ static int csi_set_selection(struct v4l2_subdev *sd,
 		return 0;
 	}
 
-	outfmt = &priv->format_mbus[sel->pad];
-
-	ret = csi_try_crop(priv, &sel->r, sensor);
+	ret = csi_try_crop(priv, &sel->r, cfg, sel->which, sensor);
 	if (ret)
 		return ret;
 
 	if (sel->which == V4L2_SUBDEV_FORMAT_TRY) {
 		cfg->try_crop = sel->r;
 	} else {
+		struct v4l2_mbus_framefmt *outfmt =
+			&priv->format_mbus[sel->pad];
+
 		priv->crop = sel->r;
 		/* Update the source format */
 		outfmt->width = sel->r.width;
-- 
2.7.4
