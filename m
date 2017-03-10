From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu,  9 Mar 2017 20:53:18 -0800
Subject: [PATCH v5 38/39] media: imx: csi: fix crop rectangle reset in sink
 set_fmt
In-Reply-To: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1489121599-23206-39-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The csi_try_crop call in set_fmt should compare the cropping rectangle
to the currently set input format, not to the previous input format.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index e5105ec..cf070be 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -989,13 +989,11 @@ __csi_get_fmt(struct csi_priv *priv, struct v4l2_subdev_pad_config *cfg,
 static int csi_try_crop(struct csi_priv *priv,
 			struct v4l2_rect *crop,
 			struct v4l2_subdev_pad_config *cfg,
-			enum v4l2_subdev_format_whence which,
+			struct v4l2_mbus_framefmt *infmt,
 			struct imx_media_subdev *sensor)
 {
 	struct v4l2_of_endpoint *sensor_ep;
-	struct v4l2_mbus_framefmt *infmt;
 
-	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, which);
 	sensor_ep = &sensor->sensor_ep;
 
 	crop->width = min_t(__u32, infmt->width, crop->width);
@@ -1178,8 +1176,7 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		crop.top = 0;
 		crop.width = sdformat->format.width;
 		crop.height = sdformat->format.height;
-		ret = csi_try_crop(priv, &crop, cfg,
-				   sdformat->which, sensor);
+		ret = csi_try_crop(priv, &crop, cfg, &sdformat->format, sensor);
 		if (ret)
 			goto out;
 
@@ -1263,6 +1260,7 @@ static int csi_set_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_selection *sel)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *infmt;
 	struct imx_media_subdev *sensor;
 	int ret = 0;
 
@@ -1296,7 +1294,8 @@ static int csi_set_selection(struct v4l2_subdev *sd,
 		goto out;
 	}
 
-	ret = csi_try_crop(priv, &sel->r, cfg, sel->which, sensor);
+	infmt = __csi_get_fmt(priv, cfg, CSI_SINK_PAD, sel->which);
+	ret = csi_try_crop(priv, &sel->r, cfg, infmt, sensor);
 	if (ret)
 		goto out;
 
-- 
2.7.4
