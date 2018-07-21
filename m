From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sat, 21 Jul 2018 15:20:28 +0200
Subject: [PATCH] staging: bcm2835-camera: fix timeout handling in
 wait_for_completion_timeout
Message-ID: <1532179228-30347-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and should
be == 0 here indicating timeout which is the only error case so no additional
check needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
---

Patch found by experimental coccinell API conformance checker

Patch was compile tested with: bcm2835_defconfig + CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_CAMERA_SUPPORT=y, CONFIG_VIDEO_BCM2835=m

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index f5b5ead..51e5b04 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -630,6 +630,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
+	unsigned long timeout;
 
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -668,11 +669,11 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 		return ret;
 	}
 
-	ret = wait_for_completion_timeout(&msg_context->u.sync.cmplt, 3 * HZ);
-	if (ret <= 0) {
-		pr_err("error %d waiting for sync completion\n", ret);
-		if (ret == 0)
-			ret = -ETIME;
+	timeout = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
+					      3 * HZ);
+	if (timeout == 0) {
+		pr_err("timed out waiting for sync completion\n");
+		ret = -ETIME;
 		/* todo: what happens if the message arrives after aborting */
 		release_msg_context(msg_context);
 		return ret;
-- 
2.1.4
