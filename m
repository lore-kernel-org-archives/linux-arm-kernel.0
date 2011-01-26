From: agust@denx.de (Anatolij Gustschin)
Date: Wed, 26 Jan 2011 09:49:48 +0100
Subject: [PATCH 1/2] v4l: soc-camera: start stream after queueing the buffers
In-Reply-To: <1296031789-1721-1-git-send-email-agust@denx.de>
References: <1296031789-1721-1-git-send-email-agust@denx.de>
Message-ID: <1296031789-1721-2-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some camera systems have strong requirement for capturing
an exact number of frames after starting the stream and do
not tolerate losing captured frames. By starting the stream
after the videobuf has queued the buffers, we ensure that
no frame will be lost.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/media/video/soc_camera.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/soc_camera.c b/drivers/media/video/soc_camera.c
index a66811b..7299de0 100644
--- a/drivers/media/video/soc_camera.c
+++ b/drivers/media/video/soc_camera.c
@@ -646,11 +646,11 @@ static int soc_camera_streamon(struct file *file, void *priv,
 	if (icd->streamer != file)
 		return -EBUSY;
 
-	v4l2_subdev_call(sd, video, s_stream, 1);
-
 	/* This calls buf_queue from host driver's videobuf_queue_ops */
 	ret = videobuf_streamon(&icd->vb_vidq);
 
+	v4l2_subdev_call(sd, video, s_stream, 1);
+
 	return ret;
 }
 
-- 
1.7.1
