From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 07 Feb 2017 17:18:39 +0100
Subject: [PATCH] media: imx: csi: fix crop rectangle reset in sink set_fmt
In-Reply-To: <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1486484319.2277.78.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The csi_try_crop call in set_fmt should compare the cropping rectangle
to the currently set input format, not to the previous input format.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
This is a patch against the current imx-media-staging-md-wip branch.
S_FMT wouldn't update the cropping rectangle during the first time it is
called, since the csi_try_crop call would compare to the input frame
format returned by __csi_get_fmt, which still contains the old value.
---
 drivers/staging/media/imx/imx-media-csi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c
b/drivers/staging/media/imx/imx-media-csi.c
index 637d0f137938a..7c590bf94fad5 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -820,15 +820,13 @@ __csi_get_fmt(struct csi_priv *priv, struct
v4l2_subdev_pad_config *cfg,
 static int csi_try_crop(struct csi_priv *priv,
 			struct v4l2_rect *crop,
 			struct v4l2_subdev_pad_config *cfg,
-			enum v4l2_subdev_format_whence which,
+			struct v4l2_mbus_framefmt *infmt,
 			struct imx_media_subdev *sensor)
 {
 	struct v4l2_of_endpoint *sensor_ep;
-	struct v4l2_mbus_framefmt *infmt;
 	v4l2_std_id std;
 	int ret;
 
-	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, which);
 	sensor_ep = &sensor->sensor_ep;
 
 	crop->width = min_t(__u32, infmt->width, crop->width);
@@ -1023,8 +1021,7 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		crop.top = 0;
 		crop.width = sdformat->format.width;
 		crop.height = sdformat->format.height;
-		ret = csi_try_crop(priv, &crop, cfg,
-				   sdformat->which, sensor);
+		ret = csi_try_crop(priv, &crop, cfg, &sdformat->format, sensor);
 		if (ret)
 			return ret;
 
@@ -1104,6 +1101,7 @@ static int csi_set_selection(struct v4l2_subdev
*sd,
 			     struct v4l2_subdev_selection *sel)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *infmt;
 	struct imx_media_subdev *sensor;
 	int ret;
 
@@ -1133,7 +1131,8 @@ static int csi_set_selection(struct v4l2_subdev
*sd,
 		return 0;
 	}
 
-	ret = csi_try_crop(priv, &sel->r, cfg, sel->which, sensor);
+	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sel->which);
+	ret = csi_try_crop(priv, &sel->r, cfg, infmt, sensor);
 	if (ret)
 		return ret;
 
-- 
2.11.0
