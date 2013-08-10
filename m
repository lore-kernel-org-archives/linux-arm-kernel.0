From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:19 +0200
Subject: [PATCH v2 05/11] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-6-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the mmp_pdma controller able to provide DMA resources
in DT environments by providing an dma xlate function.

of_dma_simple_xlate() isn't used here, because if fails to handle
multiple different DMA engines or several instances of the same
controller. Instead, a private implementation is provided that makes use
of the newly introduced dma_get_slave_channel() call.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 9dda27e..0ec5c21 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -18,6 +18,7 @@
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 #include <linux/of.h>
 #include <linux/dma/mmp-pdma.h>
 
@@ -784,6 +785,39 @@ static struct of_device_id mmp_pdma_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
 
+static struct dma_chan *mmp_pdma_dma_xlate(struct of_phandle_args *dma_spec,
+					   struct of_dma *ofdma)
+{
+	struct mmp_pdma_device *d = ofdma->of_dma_data;
+	struct dma_chan *chan, *candidate;
+
+retry:
+	candidate = NULL;
+
+	/* walk the list of channels registered with the current instance and
+	 * find one that is currently unused */
+	list_for_each_entry(chan, &d->device.channels, device_node)
+		if (chan->client_count == 0) {
+			candidate = chan;
+			break;
+		}
+
+	if (!candidate)
+		return NULL;
+
+	/* dma_get_slave_channel will return NULL if we lost a race between
+	 * the lookup and the reservation */
+	chan = dma_get_slave_channel(candidate);
+
+	if (chan) {
+		struct mmp_pdma_chan *c = to_mmp_pdma_chan(chan);
+		c->drcmr = dma_spec->args[0];
+		return chan;
+	}
+
+	goto retry;
+}
+
 static int mmp_pdma_probe(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev;
@@ -870,6 +904,16 @@ static int mmp_pdma_probe(struct platform_device *op)
 		return ret;
 	}
 
+	if (op->dev.of_node) {
+		/* Device-tree DMA controller registration */
+		ret = of_dma_controller_register(op->dev.of_node,
+						 mmp_pdma_dma_xlate, pdev);
+		if (ret < 0) {
+			dev_err(&op->dev, "of_dma_controller_register failed\n");
+			return ret;
+		}
+	}
+
 	dev_info(pdev->device.dev, "initialized\n");
 	return 0;
 }
-- 
1.8.3.1
