From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 15 Feb 2017 18:19:38 -0800
Subject: [PATCH v4 36/36] media: imx: propagate sink pad formats to source pads
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487211578-11360-37-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-ic-prp.c      | 11 ++++++++++-
 drivers/staging/media/imx/imx-ic-prpencvf.c | 22 ++++++++++++++--------
 drivers/staging/media/imx/imx-media-csi.c   | 26 +++++++++++++++++---------
 drivers/staging/media/imx/imx-media-vdic.c  | 15 ++++++++++++++-
 4 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prp.c b/drivers/staging/media/imx/imx-ic-prp.c
index b9ee8fb..5c57d2b 100644
--- a/drivers/staging/media/imx/imx-ic-prp.c
+++ b/drivers/staging/media/imx/imx-ic-prp.c
@@ -196,8 +196,17 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
 		cfg->try_fmt = sdformat->format;
 	} else {
-		priv->format_mbus[sdformat->pad] = sdformat->format;
+		struct v4l2_mbus_framefmt *f =
+			&priv->format_mbus[sdformat->pad];
+
+		*f = sdformat->format;
 		priv->cc[sdformat->pad] = cc;
+
+		/* propagate format to source pads */
+		if (sdformat->pad == PRP_SINK_PAD) {
+			priv->format_mbus[PRP_SRC_PAD_PRPENC] = *f;
+			priv->format_mbus[PRP_SRC_PAD_PRPVF] = *f;
+		}
 	}
 
 	return 0;
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index dd9d499..c43f85f 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -806,16 +806,22 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
 		cfg->try_fmt = sdformat->format;
 	} else {
-		priv->format_mbus[sdformat->pad] = sdformat->format;
+		struct v4l2_mbus_framefmt *f =
+			&priv->format_mbus[sdformat->pad];
+		struct v4l2_mbus_framefmt *outf =
+			&priv->format_mbus[PRPENCVF_SRC_PAD];
+
+		*f = sdformat->format;
 		priv->cc[sdformat->pad] = cc;
-		if (sdformat->pad == PRPENCVF_SRC_PAD) {
-			/*
-			 * update the capture device format if this is
-			 * the IDMAC output pad
-			 */
-			imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
-						      &sdformat->format, cc);
+
+		/* propagate format to source pad */
+		if (sdformat->pad == PRPENCVF_SINK_PAD) {
+			outf->width = f->width;
+			outf->height = f->height;
 		}
+
+		/* update the capture device format from output pad */
+		imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix, outf, cc);
 	}
 
 	return 0;
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 3e6b607..9d9ec03 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1161,19 +1161,27 @@ static int csi_set_fmt(struct v4l2_subdev *sd,
 	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
 		cfg->try_fmt = sdformat->format;
 	} else {
+		struct v4l2_mbus_framefmt *f_direct, *f_idmac;
+
 		priv->format_mbus[sdformat->pad] = sdformat->format;
 		priv->cc[sdformat->pad] = cc;
-		/* Reset the crop window if this is the input pad */
-		if (sdformat->pad == CSI_SINK_PAD)
+
+		f_direct = &priv->format_mbus[CSI_SRC_PAD_DIRECT];
+		f_idmac = &priv->format_mbus[CSI_SRC_PAD_IDMAC];
+
+		if (sdformat->pad == CSI_SINK_PAD) {
+			/* reset the crop window */
 			priv->crop = crop;
-		else if (sdformat->pad == CSI_SRC_PAD_IDMAC) {
-			/*
-			 * update the capture device format if this is
-			 * the IDMAC output pad
-			 */
-			imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
-						      &sdformat->format, cc);
+
+			/* propagate format to source pads */
+			f_direct->width = crop.width;
+			f_direct->height = crop.height;
+			f_idmac->width = crop.width;
+			f_idmac->height = crop.height;
 		}
+
+		/* update the capture device format from IDMAC output pad */
+		imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix, f_idmac, cc);
 	}
 
 	return 0;
diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 61e6017..55fb522 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -649,8 +649,21 @@ static int vdic_set_fmt(struct v4l2_subdev *sd,
 	if (sdformat->which == V4L2_SUBDEV_FORMAT_TRY) {
 		cfg->try_fmt = sdformat->format;
 	} else {
-		priv->format_mbus[sdformat->pad] = sdformat->format;
+		struct v4l2_mbus_framefmt *f =
+			&priv->format_mbus[sdformat->pad];
+		struct v4l2_mbus_framefmt *outf =
+			&priv->format_mbus[VDIC_SRC_PAD_DIRECT];
+
+		*f = sdformat->format;
 		priv->cc[sdformat->pad] = cc;
+
+		/* propagate format to source pad */
+		if (sdformat->pad == VDIC_SINK_PAD_DIRECT ||
+		    sdformat->pad == VDIC_SINK_PAD_IDMAC) {
+			outf->width = f->width;
+			outf->height = f->height;
+			outf->field = V4L2_FIELD_NONE;
+		}
 	}
 
 	return 0;
-- 
2.7.4
