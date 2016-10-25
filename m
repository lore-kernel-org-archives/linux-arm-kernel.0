From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 25 Oct 2016 16:55:35 -0700
Subject: [RFC PATCH 5/6] [media] davinci: vpif_capture: don't lock over
 s_stream
In-Reply-To: <20161025235536.7342-1-khilman@baylibre.com>
References: <20161025235536.7342-1-khilman@baylibre.com>
Message-ID: <20161025235536.7342-6-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Video capture subdevs may be over I2C and may sleep during xfer, so we
cannot do IRQ-disabled locking when calling the subdev.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 79cef74e164f..becc3e63b472 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -193,12 +193,16 @@ static int vpif_start_streaming(struct vb2_queue *vq, unsigned int count)
 		}
 	}
 
+	spin_unlock_irqrestore(&common->irqlock, flags);
+
 	ret = v4l2_subdev_call(ch->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD && ret != -ENODEV) {
 		vpif_dbg(1, debug, "stream on failed in subdev\n");
 		goto err;
 	}
 
+	spin_lock_irqsave(&common->irqlock, flags);
+
 	/* Call vpif_set_params function to set the parameters and addresses */
 	ret = vpif_set_video_params(vpif, ch->channel_id);
 	if (ret < 0) {
-- 
2.9.3
