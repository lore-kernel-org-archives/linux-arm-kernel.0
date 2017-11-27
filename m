From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Nov 2017 14:19:56 +0100
Subject: [PATCH 4/8] [media] staging: bcm2835-camera use ktime_t for timestamps
In-Reply-To: <20171127132027.1734806-1-arnd@arndb.de>
References: <20171127132027.1734806-1-arnd@arndb.de>
Message-ID: <20171127132027.1734806-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct timeval is deprecated for in-kernel use, and converting
this function to use ktime_t makes it simpler as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 37 ++++++----------------
 .../vc04_services/bcm2835-camera/bcm2835-camera.h  |  2 +-
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index be936b8fe317..d8766b166675 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -343,37 +343,18 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 		if (dev->capture.frame_count) {
 			if (dev->capture.vc_start_timestamp != -1 &&
 			    pts != 0) {
-				struct timeval timestamp;
+				ktime_t timestamp;
 				s64 runtime_us = pts -
 				    dev->capture.vc_start_timestamp;
-				u32 div = 0;
-				u32 rem = 0;
-
-				div =
-				    div_u64_rem(runtime_us, USEC_PER_SEC, &rem);
-				timestamp.tv_sec =
-				    dev->capture.kernel_start_ts.tv_sec + div;
-				timestamp.tv_usec =
-				    dev->capture.kernel_start_ts.tv_usec + rem;
-
-				if (timestamp.tv_usec >=
-				    USEC_PER_SEC) {
-					timestamp.tv_sec++;
-					timestamp.tv_usec -=
-					    USEC_PER_SEC;
-				}
+				timestamp = ktime_add_us(dev->capture.kernel_start_ts,
+							 runtime_us);
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-					 "Convert start time %d.%06d and %llu "
-					 "with offset %llu to %d.%06d\n",
-					 (int)dev->capture.kernel_start_ts.
-					 tv_sec,
-					 (int)dev->capture.kernel_start_ts.
-					 tv_usec,
+					 "Convert start time %llu and %llu "
+					 "with offset %llu to %llu\n",
+					 ktime_to_ns(dev->capture.kernel_start_ts),
 					 dev->capture.vc_start_timestamp, pts,
-					 (int)timestamp.tv_sec,
-					 (int)timestamp.tv_usec);
-				buf->vb.vb2_buf.timestamp = timestamp.tv_sec * 1000000000ULL +
-					timestamp.tv_usec * 1000ULL;
+					 ktime_to_ns(timestamp));
+				buf->vb.vb2_buf.timestamp = ktime_to_ns(timestamp);
 			} else {
 				buf->vb.vb2_buf.timestamp = ktime_get_ns();
 			}
@@ -547,7 +528,7 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 			 "Start time %lld size %d\n",
 			 dev->capture.vc_start_timestamp, parameter_size);
 
-	v4l2_get_timestamp(&dev->capture.kernel_start_ts);
+	dev->capture.kernel_start_ts = ktime_get();
 
 	/* enable the camera port */
 	dev->capture.port->cb_ctx = dev;
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
index 404037476bc5..83920683a448 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h
@@ -92,7 +92,7 @@ struct bm2835_mmal_dev {
 		/* VC start timestamp for streaming */
 		s64         vc_start_timestamp;
 		/* Kernel start timestamp for streaming */
-		struct timeval kernel_start_ts;
+		ktime_t kernel_start_ts;
 
 		struct vchiq_mmal_port  *port; /* port being used for capture */
 		/* camera port being used for capture */
-- 
2.9.0
