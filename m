From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 14 Sep 2017 13:11:10 +0800
Subject: [PATCH v2 2/3] media: ov7670: Add the get_fmt callback
In-Reply-To: <20170914051111.18197-1-wenyou.yang@microchip.com>
References: <20170914051111.18197-1-wenyou.yang@microchip.com>
Message-ID: <20170914051111.18197-3-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the get_fmt callback, also enable V4L2_SUBDEV_FL_HAS_DEVNODE flag
to make this subdev has device node.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

Changes in v2: None

 drivers/media/i2c/ov7670.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 5c8460ee65c3..efc738112e2a 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -230,6 +230,7 @@ struct ov7670_info {
 		struct v4l2_ctrl *saturation;
 		struct v4l2_ctrl *hue;
 	};
+	struct v4l2_mbus_framefmt format;
 	struct ov7670_format_struct *fmt;  /* Current format */
 	struct clk *clk;
 	struct gpio_desc *resetb_gpio;
@@ -973,6 +974,29 @@ static int ov7670_try_fmt_internal(struct v4l2_subdev *sd,
 	fmt->width = wsize->width;
 	fmt->height = wsize->height;
 	fmt->colorspace = ov7670_formats[index].colorspace;
+
+	info->format.code = fmt->code;
+	info->format.width = fmt->width;
+	info->format.height = fmt->height;
+	info->format.colorspace = fmt->colorspace;
+
+	return 0;
+}
+
+static int ov7670_get_fmt(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *format)
+{
+	struct ov7670_info *info = to_state(sd);
+	struct v4l2_mbus_framefmt *fmt;
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		fmt = v4l2_subdev_get_try_format(sd, cfg, format->pad);
+	else
+		fmt = &info->format;
+
+	format->format = *fmt;
+
 	return 0;
 }
 
@@ -1526,6 +1550,7 @@ static const struct v4l2_subdev_pad_ops ov7670_pad_ops = {
 	.enum_frame_interval = ov7670_enum_frame_interval,
 	.enum_frame_size = ov7670_enum_frame_size,
 	.enum_mbus_code = ov7670_enum_mbus_code,
+	.get_fmt = ov7670_get_fmt,
 	.set_fmt = ov7670_set_fmt,
 };
 
@@ -1698,6 +1723,7 @@ static int ov7670_probe(struct i2c_client *client,
 
 	v4l2_ctrl_handler_setup(&info->hdl);
 
+	info->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ret = v4l2_async_register_subdev(&info->sd);
 	if (ret < 0)
 		goto entity_cleanup;
-- 
2.13.0
