From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 28 Jul 2017 12:05:01 +0200
Subject: [PATCH v1 4/5] [media] stm32-dcmi: set default format at open()
In-Reply-To: <1501236302-18097-1-git-send-email-hugues.fruchet@st.com>
References: <1501236302-18097-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1501236302-18097-5-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we start with default pixel format and resolution
when opening a new instance.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 49 ++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 4733d1f..2be56b6 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -890,6 +890,28 @@ static int dcmi_enum_frameintervals(struct file *file, void *fh,
 	return 0;
 }
 
+static int dcmi_set_default_fmt(struct stm32_dcmi *dcmi)
+{
+	struct v4l2_format f = {
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+		.fmt.pix = {
+			.width		= CIF_WIDTH,
+			.height		= CIF_HEIGHT,
+			.field		= V4L2_FIELD_NONE,
+			.pixelformat	= dcmi->sd_formats[0]->fourcc,
+		},
+	};
+	int ret;
+
+	ret = dcmi_try_fmt(dcmi, &f, NULL);
+	if (ret)
+		return ret;
+	dcmi->sd_format = dcmi->sd_formats[0];
+	dcmi->fmt = f;
+
+	return 0;
+}
+
 static const struct of_device_id stm32_dcmi_of_match[] = {
 	{ .compatible = "st,stm32-dcmi"},
 	{ /* end node */ },
@@ -916,7 +938,13 @@ static int dcmi_open(struct file *file)
 	if (ret < 0 && ret != -ENOIOCTLCMD)
 		goto fh_rel;
 
+	ret = dcmi_set_default_fmt(dcmi);
+	if (ret)
+		goto power_off;
+
 	ret = dcmi_set_fmt(dcmi, &dcmi->fmt);
+
+power_off:
 	if (ret)
 		v4l2_subdev_call(sd, core, s_power, 0);
 fh_rel:
@@ -991,27 +1019,6 @@ static int dcmi_release(struct file *file)
 	.read		= vb2_fop_read,
 };
 
-static int dcmi_set_default_fmt(struct stm32_dcmi *dcmi)
-{
-	struct v4l2_format f = {
-		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
-		.fmt.pix = {
-			.width		= CIF_WIDTH,
-			.height		= CIF_HEIGHT,
-			.field		= V4L2_FIELD_NONE,
-			.pixelformat	= dcmi->sd_formats[0]->fourcc,
-		},
-	};
-	int ret;
-
-	ret = dcmi_try_fmt(dcmi, &f, NULL);
-	if (ret)
-		return ret;
-	dcmi->sd_format = dcmi->sd_formats[0];
-	dcmi->fmt = f;
-	return 0;
-}
-
 static const struct dcmi_format dcmi_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_RGB565,
-- 
1.9.1
