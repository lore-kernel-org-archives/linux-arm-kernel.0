From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 27 Mar 2017 17:40:45 -0700
Subject: [PATCH v6 28/39] media: imx: csi: fix crop rectangle changes in
 set_fmt
In-Reply-To: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1490661656-10318-29-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The cropping rectangle was being modified by the output pad's
set_fmt, which is the wrong pad to do this. The crop rectangle
should not be modified by the output pad set_fmt. It instead
should be reset to the full input frame when the input pad format
is set.

The output pad set_fmt should set width/height to the current
crop dimensions, or 1/2 the crop width/height to enable
downscaling.

So the other part of this patch is to enable downscaling if
the output pad dimension(s) are 1/2 the crop dimension(s) at
csi_setup() time.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 35 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 37c68d8..730966b 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -555,6 +555,10 @@ static int csi_setup(struct csi_priv *priv)
 
 	ipu_csi_set_window(priv->csi, &priv->crop);
 
+	ipu_csi_set_downsize(priv->csi,
+			     priv->crop.width == 2 * outfmt->width,
+			     priv->crop.height == 2 * outfmt->height);
+
 	ipu_csi_init_interface(priv->csi, &sensor_mbus_cfg, &if_fmt);
 
 	ipu_csi_set_dest(priv->csi, priv->dest);
@@ -945,15 +949,15 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	switch (sdformat->pad) {
 	case CSI_SRC_PAD_DIRECT:
 	case CSI_SRC_PAD_IDMAC:
-		crop.left = priv->crop.left;
-		crop.top = priv->crop.top;
-		crop.width = sdformat->format.width;
-		crop.height = sdformat->format.height;
-		ret = csi_try_crop(priv, &crop, sensor);
-		if (ret)
-			goto out;
-		sdformat->format.width = crop.width;
-		sdformat->format.height = crop.height;
+		if (sdformat->format.width < priv->crop.width * 3 / 4)
+			sdformat->format.width = priv->crop.width / 2;
+		else
+			sdformat->format.width = priv->crop.width;
+
+		if (sdformat->format.height < priv->crop.height * 3 / 4)
+			sdformat->format.height = priv->crop.height / 2;
+		else
+			sdformat->format.height = priv->crop.height;
 
 		if (sdformat->pad == CSI_SRC_PAD_IDMAC) {
 			cc = imx_media_find_format(0, sdformat->format.code,
@@ -999,6 +1003,14 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 		}
 		break;
 	case CSI_SINK_PAD:
+		crop.left = 0;
+		crop.top = 0;
+		crop.width = sdformat->format.width;
+		crop.height = sdformat->format.height;
+		ret = csi_try_crop(priv, &crop, sensor);
+		if (ret)
+			goto out;
+
 		cc = imx_media_find_format(0, sdformat->format.code,
 					   true, false);
 		if (!cc) {
@@ -1017,9 +1029,8 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	} else {
 		priv->format_mbus[sdformat->pad] = sdformat->format;
 		priv->cc[sdformat->pad] = cc;
-		/* Update the crop window if this is an output pad  */
-		if (sdformat->pad == CSI_SRC_PAD_DIRECT ||
-		    sdformat->pad == CSI_SRC_PAD_IDMAC)
+		/* Reset the crop window if this is the input pad */
+		if (sdformat->pad == CSI_SINK_PAD)
 			priv->crop = crop;
 	}
 
-- 
2.7.4
