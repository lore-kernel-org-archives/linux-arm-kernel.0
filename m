From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sat, 21 Jul 2018 13:31:24 +0200
Subject: [PATCH] staging: bcm2835-camera: handle wait_for_completion_timeout
 return properly
Message-ID: <1532172684-26138-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and
should be == 0 here indicating timeout.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
---

Patch found by experimental coccinell API conformance checker

Printing the return value was dropped as there is no additional information
by including it (not an errno). 

Patch was compile tested with: bcm2835_defconfig + CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_CAMERA_SUPPORT=y, CONFIG_VIDEO_BCM2835=m
(with some sparse warnings - not related to the proposed change thogh)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 6dd0c83..c04bdf0 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -580,6 +580,7 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 static void stop_streaming(struct vb2_queue *vq)
 {
 	int ret;
+	unsigned long timeout;
 	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
@@ -605,10 +606,10 @@ static void stop_streaming(struct vb2_queue *vq)
 				      sizeof(dev->capture.frame_count));
 
 	/* wait for last frame to complete */
-	ret = wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
-	if (ret <= 0)
+	timeout = wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
+	if (timeout == 0)
 		v4l2_err(&dev->v4l2_dev,
-			 "error %d waiting for frame completion\n", ret);
+			 "timed out waiting for frame completion\n");
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "disabling connection\n");
-- 
2.1.4
