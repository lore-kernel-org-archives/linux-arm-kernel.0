From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 27 Mar 2017 17:40:50 -0700
Subject: [PATCH v6 33/39] media: imx: csi: Avoid faulty sensor frames at
 stream start
In-Reply-To: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1490661656-10318-34-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the attached sensor reports faulty frames at stream start via
g_skip_frames callback, add a delay to avoid them before enabling
the CSI hardware. Especially for sensors with a bt.656 interface,
any shifts in the SAV/EAV sync codes will cause the CSI to lose
vert/horiz sync.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-csi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index d9c3a3b..8597d7e 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -9,6 +9,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/delay.h>
 #include <linux/gcd.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -591,6 +592,7 @@ static int csi_setup(struct csi_priv *priv)
 
 static int csi_start(struct csi_priv *priv)
 {
+	u32 bad_frames = 0;
 	int ret;
 
 	if (!priv->sensor) {
@@ -598,6 +600,25 @@ static int csi_start(struct csi_priv *priv)
 		return -EINVAL;
 	}
 
+	ret = v4l2_subdev_call(priv->sensor->sd, sensor,
+			       g_skip_frames, &bad_frames);
+	if (!ret && bad_frames) {
+		struct v4l2_fract *fi = &priv->frame_interval;
+		u32 delay_usec;
+
+		/*
+		 * This sensor has bad frames when it is turned on,
+		 * add a delay to avoid them before enabling the CSI
+		 * hardware. Especially for sensors with a bt.656 interface,
+		 * any shifts in the SAV/EAV sync codes will cause the CSI
+		 * to lose vert/horiz sync.
+		 */
+		delay_usec = DIV_ROUND_UP_ULL(
+			(u64)USEC_PER_SEC * fi->numerator * bad_frames,
+			fi->denominator);
+		usleep_range(delay_usec, delay_usec + 1000);
+	}
+
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
 		ret = csi_idmac_start(priv);
 		if (ret)
-- 
2.7.4
