From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 29 Nov 2016 15:57:09 -0800
Subject: [PATCH v4 1/4] [media] davinci: vpif_capture: don't lock over s_stream
In-Reply-To: <20161129235712.29846-1-khilman@baylibre.com>
References: <20161129235712.29846-1-khilman@baylibre.com>
Message-ID: <20161129235712.29846-2-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Video capture subdevs may be over I2C and may sleep during xfer, so we
cannot do IRQ-disabled locking when calling the subdev.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 5104cc0ee40e..9f8f41c0f251 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -193,7 +193,10 @@ static int vpif_start_streaming(struct vb2_queue *vq, unsigned int count)
 		}
 	}
 
+	spin_unlock_irqrestore(&common->irqlock, flags);
 	ret = v4l2_subdev_call(ch->sd, video, s_stream, 1);
+	spin_lock_irqsave(&common->irqlock, flags);
+
 	if (ret && ret != -ENOIOCTLCMD && ret != -ENODEV) {
 		vpif_dbg(1, debug, "stream on failed in subdev\n");
 		goto err;
-- 
2.9.3
