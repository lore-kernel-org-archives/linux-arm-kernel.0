From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Wed, 7 Feb 2018 18:43:09 +0100
Subject: [PATCH] media: stm32-dcmi: add g/s_parm framerate support
Message-ID: <1518025389-3677-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add g/s_parm framerate support by calling subdev
g/s_frame_interval ops.
This allows user to control sensor framerate by
calling ioctl G/S_PARM.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index ab555d4..8197554 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1151,6 +1151,52 @@ static int dcmi_enum_framesizes(struct file *file, void *fh,
 	return 0;
 }
 
+static int dcmi_g_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *p)
+{
+	struct stm32_dcmi *dcmi = video_drvdata(file);
+	struct v4l2_subdev_frame_interval ival = { 0 };
+	int ret;
+
+	if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	p->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	ret = v4l2_subdev_call(dcmi->entity.subdev, video,
+			       g_frame_interval, &ival);
+	if (ret)
+		return ret;
+
+	p->parm.capture.timeperframe = ival.interval;
+
+	return ret;
+}
+
+static int dcmi_s_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *p)
+{
+	struct stm32_dcmi *dcmi = video_drvdata(file);
+	struct v4l2_subdev_frame_interval ival = {
+		0,
+		p->parm.capture.timeperframe
+	};
+	int ret;
+
+	if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	memset(&p->parm, 0, sizeof(p->parm));
+	p->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	ret = v4l2_subdev_call(dcmi->entity.subdev, video,
+			       s_frame_interval, &ival);
+	if (ret)
+		return ret;
+
+	p->parm.capture.timeperframe = ival.interval;
+
+	return ret;
+}
+
 static int dcmi_enum_frameintervals(struct file *file, void *fh,
 				    struct v4l2_frmivalenum *fival)
 {
@@ -1253,6 +1299,9 @@ static int dcmi_release(struct file *file)
 	.vidioc_g_input			= dcmi_g_input,
 	.vidioc_s_input			= dcmi_s_input,
 
+	.vidioc_g_parm			= dcmi_g_parm,
+	.vidioc_s_parm			= dcmi_s_parm,
+
 	.vidioc_enum_framesizes		= dcmi_enum_framesizes,
 	.vidioc_enum_frameintervals	= dcmi_enum_frameintervals,
 
-- 
1.9.1
