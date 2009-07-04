From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sat, 4 Jul 2009 13:25:06 +0000
Subject: [PATCH 02/10] ov7670: Temporary soc-camera support
Message-ID: <mailman.99.1257097472.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/media/video/ov7670.c |   50 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/ov7670.c b/drivers/media/video/ov7670.c
index 0e2184e..910a499 100644
--- a/drivers/media/video/ov7670.c
+++ b/drivers/media/video/ov7670.c
@@ -19,6 +19,8 @@
 #include <media/v4l2-chip-ident.h>
 #include <media/v4l2-i2c-drv.h>
 
+#include <media/soc_camera.h>
+#include <linux/autoconf.h>
 
 MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
 MODULE_DESCRIPTION("A low-level driver for OmniVision ov7670 sensors");
@@ -745,6 +747,10 @@ static int ov7670_s_fmt(struct v4l2_subdev *sd, struct v4l2_format *fmt)
 	struct ov7670_info *info = to_state(sd);
 	unsigned char com7, clkrc = 0;
 
+	ret = ov7670_init(sd, 0);
+	if (ret)
+		return ret;
+
 	ret = ov7670_try_fmt_internal(sd, fmt, &ovfmt, &wsize);
 	if (ret)
 		return ret;
@@ -1239,6 +1245,41 @@ static const struct v4l2_subdev_ops ov7670_ops = {
 };
 
 /* ----------------------------------------------------------------------- */
+static unsigned long ov7670_soc_query_bus_param(struct soc_camera_device *icd)
+{
+	struct soc_camera_link *icl = to_soc_camera_link(icd);
+
+	unsigned long flags = SOCAM_PCLK_SAMPLE_RISING | SOCAM_MASTER |
+		SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_HSYNC_ACTIVE_HIGH |
+		SOCAM_DATAWIDTH_8 | SOCAM_DATA_ACTIVE_HIGH;
+
+	return soc_camera_apply_sensor_flags(icl, flags);
+}
+
+/* This device only supports one bus option */
+static int ov7670_soc_set_bus_param(struct soc_camera_device *icd,
+				    unsigned long flags)
+{
+	return 0;
+}
+
+static struct soc_camera_ops ov7670_soc_ops = {
+	.set_bus_param = ov7670_soc_set_bus_param,
+	.query_bus_param = ov7670_soc_query_bus_param,
+};
+
+#define SETFOURCC(type) .name = (#type), .fourcc = (V4L2_PIX_FMT_ ## type)
+static const struct soc_camera_data_format ov7670_soc_fmt_lists[] = {
+	{
+		SETFOURCC(YUYV),
+		.depth = 16,
+		.colorspace = V4L2_COLORSPACE_JPEG,
+	}, {
+		SETFOURCC(RGB565),
+		.depth = 16,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+	},
+};
 
 static int ov7670_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
@@ -1246,7 +1287,16 @@ static int ov7670_probe(struct i2c_client *client,
 	struct v4l2_subdev *sd;
 	struct ov7670_info *info;
 	int ret;
+	struct soc_camera_device *icd = client->dev.platform_data;
+
+	if (!icd) {
+		dev_err(&client->dev, "OV7670: missing soc-camera data!\n");
+		return -EINVAL;
+	}
 
+	icd->ops = &ov7670_soc_ops;
+	icd->formats = ov7670_soc_fmt_lists;
+	icd->num_formats = ARRAY_SIZE(ov7670_soc_fmt_lists);
 	info = kzalloc(sizeof(struct ov7670_info), GFP_KERNEL);
 	if (info == NULL)
 		return -ENOMEM;
-- 
1.6.3.3
