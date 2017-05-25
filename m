From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 24 May 2017 17:29:46 -0700
Subject: [PATCH v7 31/34] media: imx: csi: add frame size/interval enumeration
In-Reply-To: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1495672189-29164-32-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Add frame size and frame interval enumeration to CSI.

CSI can downscale the image independently horizontally and vertically by a
factor of two, which enumerates to four different frame sizes at the
output pads. The input pad supports a range of frame sizes.

CSI can also drop frames, resulting in frame rate reduction, so
enumerate the resulting possible output frame rates.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 9766dee..b8b3630 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1163,6 +1163,74 @@ static int csi_enum_mbus_code(struct v4l2_subdev *sd,
 	return ret;
 }
 
+static int csi_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_pad_config *cfg,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct csi_priv *priv = v4l2_get_subdevdata(sd);
+	struct v4l2_rect *crop;
+	int ret = 0;
+
+	if (fse->pad >= CSI_NUM_PADS ||
+	    fse->index > (fse->pad == CSI_SINK_PAD ? 0 : 3))
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+
+	if (fse->pad == CSI_SINK_PAD) {
+		fse->min_width = MIN_W;
+		fse->max_width = MAX_W;
+		fse->min_height = MIN_H;
+		fse->max_height = MAX_H;
+	} else {
+		crop = __csi_get_crop(priv, cfg, fse->which);
+
+		fse->min_width = fse->max_width = fse->index & 1 ?
+			crop->width / 2 : crop->width;
+		fse->min_height = fse->max_height = fse->index & 2 ?
+			crop->height / 2 : crop->height;
+	}
+
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+static int csi_enum_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_pad_config *cfg,
+				   struct v4l2_subdev_frame_interval_enum *fie)
+{
+	struct csi_priv *priv = v4l2_get_subdevdata(sd);
+	struct v4l2_fract *input_fi;
+	struct v4l2_rect *crop;
+	int ret = 0;
+
+	if (fie->pad >= CSI_NUM_PADS ||
+	    fie->index >= (fie->pad != CSI_SRC_PAD_IDMAC ?
+			   1 : ARRAY_SIZE(csi_skip)))
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+
+	input_fi = &priv->frame_interval[CSI_SINK_PAD];
+	crop = __csi_get_crop(priv, cfg, fie->which);
+
+	if ((fie->width != crop->width && fie->width != crop->width / 2) ||
+	    (fie->height != crop->height && fie->height != crop->height / 2)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fie->interval = *input_fi;
+
+	if (fie->pad == CSI_SRC_PAD_IDMAC)
+		csi_apply_skip_interval(&csi_skip[fie->index],
+					&fie->interval);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static int csi_get_fmt(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_pad_config *cfg,
 		       struct v4l2_subdev_format *sdformat)
@@ -1631,6 +1699,8 @@ static const struct v4l2_subdev_video_ops csi_video_ops = {
 
 static const struct v4l2_subdev_pad_ops csi_pad_ops = {
 	.enum_mbus_code = csi_enum_mbus_code,
+	.enum_frame_size = csi_enum_frame_size,
+	.enum_frame_interval = csi_enum_frame_interval,
 	.get_fmt = csi_get_fmt,
 	.set_fmt = csi_set_fmt,
 	.get_selection = csi_get_selection,
-- 
2.7.4
