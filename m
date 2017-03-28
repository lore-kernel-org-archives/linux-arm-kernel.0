From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 27 Mar 2017 17:40:55 -0700
Subject: [PATCH v6 38/39] media: imx-ic-prpencvf: add frame size enumeration
In-Reply-To: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1490661656-10318-39-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add frame size enumeration operation. The PRP ENC/VF subdevices
are scalers, so they can output a continuous range of widths/
heights on their source pads.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-ic-prpencvf.c | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 4123b03..860b406 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -875,6 +875,45 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 	return ret;
 }
 
+static int prp_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_pad_config *cfg,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct prp_priv *priv = sd_to_priv(sd);
+	struct v4l2_subdev_format format = {0};
+	const struct imx_media_pixfmt *cc;
+	int ret = 0;
+
+	if (fse->pad >= PRPENCVF_NUM_PADS || fse->index != 0)
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+
+	format.pad = fse->pad;
+	format.which = fse->which;
+	format.format.code = fse->code;
+	format.format.width = 1;
+	format.format.height = 1;
+	prp_try_fmt(priv, cfg, &format, &cc);
+	fse->min_width = format.format.width;
+	fse->min_height = format.format.height;
+
+	if (format.format.code != fse->code) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	format.format.code = fse->code;
+	format.format.width = -1;
+	format.format.height = -1;
+	prp_try_fmt(priv, cfg, &format, &cc);
+	fse->max_width = format.format.width;
+	fse->max_height = format.format.height;
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static int prp_link_setup(struct media_entity *entity,
 			  const struct media_pad *local,
 			  const struct media_pad *remote, u32 flags)
@@ -1125,6 +1164,7 @@ static void prp_unregistered(struct v4l2_subdev *sd)
 
 static struct v4l2_subdev_pad_ops prp_pad_ops = {
 	.enum_mbus_code = prp_enum_mbus_code,
+	.enum_frame_size = prp_enum_frame_size,
 	.get_fmt = prp_get_fmt,
 	.set_fmt = prp_set_fmt,
 	.link_validate = prp_link_validate,
-- 
2.7.4
