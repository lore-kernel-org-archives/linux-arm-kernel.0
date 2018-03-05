From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon,  5 Mar 2018 10:35:35 +0100
Subject: [PATCH 8/8] media: sun6i: Add g_parm/s_parm ioctl support
In-Reply-To: <20180305093535.11801-1-maxime.ripard@bootlin.com>
References: <1519697113-32202-1-git-send-email-yong.deng@magewell.com>
 <20180305093535.11801-1-maxime.ripard@bootlin.com>
Message-ID: <20180305093535.11801-9-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a g_parm and s_parm callback in order to be able to control the sensor
framerate of the sensor.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index bf7c0d1d1d47..bac867004fa0 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -478,6 +478,32 @@ static int vidioc_s_input(struct file *file, void *fh, unsigned int i)
 	return 0;
 }
 
+static int vidioc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct sun6i_video *video = video_drvdata(file);
+	struct v4l2_subdev *subdev;
+	u32 pad;
+
+	subdev = sun6i_video_remote_subdev(video, &pad);
+	if (subdev == NULL)
+		return -ENXIO;
+
+	return v4l2_g_parm_cap(video_devdata(file), subdev, a);
+}
+
+static int vidioc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
+{
+	struct sun6i_video *video = video_drvdata(file);
+	struct v4l2_subdev *subdev;
+	u32 pad;
+
+	subdev = sun6i_video_remote_subdev(video, &pad);
+	if (subdev == NULL)
+		return -ENXIO;
+
+	return v4l2_s_parm_cap(video_devdata(file), subdev, a);
+}
+
 static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 	.vidioc_querycap		= vidioc_querycap,
 	.vidioc_enum_fmt_vid_cap	= vidioc_enum_fmt_vid_cap,
@@ -489,6 +515,9 @@ static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 	.vidioc_s_input			= vidioc_s_input,
 	.vidioc_g_input			= vidioc_g_input,
 
+	.vidioc_g_parm			= vidioc_g_parm,
+	.vidioc_s_parm			= vidioc_s_parm,
+
 	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
 	.vidioc_querybuf		= vb2_ioctl_querybuf,
 	.vidioc_qbuf			= vb2_ioctl_qbuf,
-- 
2.14.3
