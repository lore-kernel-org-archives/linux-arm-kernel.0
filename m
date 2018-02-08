From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Thu, 8 Feb 2018 12:00:45 +0100
Subject: [PATCH v2] media: stm32-dcmi: add g/s_parm framerate support
Message-ID: <1518087645-1394-1-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add g/s_parm framerate support by calling subdev
g/s_frame_interval ops.
This allows user to control sensor framerate by
calling ioctl G/S_PARM.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
version 2:
  - Rebase on Hans branch to use new helpers:
    See https://www.mail-archive.com/linux-media at vger.kernel.org/msg125769.html

 drivers/media/platform/stm32/stm32-dcmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 9460b30..60dd24c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1167,6 +1167,22 @@ static int dcmi_enum_framesizes(struct file *file, void *fh,
 	return 0;
 }
 
+static int dcmi_g_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *p)
+{
+	struct stm32_dcmi *dcmi = video_drvdata(file);
+
+	return v4l2_g_parm_cap(video_devdata(file), dcmi->entity.subdev, p);
+}
+
+static int dcmi_s_parm(struct file *file, void *priv,
+		       struct v4l2_streamparm *p)
+{
+	struct stm32_dcmi *dcmi = video_drvdata(file);
+
+	return v4l2_s_parm_cap(video_devdata(file), dcmi->entity.subdev, p);
+}
+
 static int dcmi_enum_frameintervals(struct file *file, void *fh,
 				    struct v4l2_frmivalenum *fival)
 {
@@ -1269,6 +1285,9 @@ static int dcmi_release(struct file *file)
 	.vidioc_g_input			= dcmi_g_input,
 	.vidioc_s_input			= dcmi_s_input,
 
+	.vidioc_g_parm			= dcmi_g_parm,
+	.vidioc_s_parm			= dcmi_s_parm,
+
 	.vidioc_enum_framesizes		= dcmi_enum_framesizes,
 	.vidioc_enum_frameintervals	= dcmi_enum_frameintervals,
 
-- 
1.9.1
