From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jun 2015 16:36:57 +0200
Subject: [PATCH v3 6/6] dmaengine: mv_xor: optimize performance by using a
 subset of the XOR channels
In-Reply-To: <1435675017-875-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1435675017-875-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1435675017-875-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to how async_tx behaves internally, having more XOR channels than
CPUs is actually hurting performance more than it improves it, because
memcpy requests get scheduled on a different channel than the XOR
requests, but async_tx will still wait for the completion of the
memcpy requests before scheduling the XOR requests.

It is in fact more efficient to have at most one channel per CPU,
which this patch implements by limiting the number of channels per
engine, and the number of engines registered depending on the number
of availables CPUs.

Marvell platforms are currently available in one CPU, two CPUs and
four CPUs configurations:

 - in the configurations with one CPU, only one channel from one
   engine is used.

 - in the configurations with two CPUs, only one channel from each
   engine is used (they are two XOR engines)

 - in the configurations with four CPUs, both channels of both engines
   are used.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 6e09d59..2cdfca7 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/cpumask.h>
 #include <linux/platform_data/dma-mv_xor.h>
 
 #include "dmaengine.h"
@@ -1137,12 +1138,15 @@ static const struct of_device_id mv_xor_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mv_xor_dt_ids);
 
+static unsigned int mv_xor_engine_count;
+
 static int mv_xor_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *res;
+	unsigned int max_engines, max_channels;
 	int i, ret;
 	int op_in_desc;
 
@@ -1186,6 +1190,21 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!IS_ERR(xordev->clk))
 		clk_prepare_enable(xordev->clk);
 
+	/*
+	 * We don't want to have more than one channel per CPU in
+	 * order for async_tx to perform well. So we limit the number
+	 * of engines and channels so that we take into account this
+	 * constraint. Note that we also want to use channels from
+	 * separate engines when possible.
+	 */
+	max_engines = num_present_cpus();
+	max_channels = min_t(unsigned int,
+			     MV_XOR_MAX_CHANNELS,
+			     DIV_ROUND_UP(num_present_cpus(), 2));
+
+	if (mv_xor_engine_count >= max_engines)
+		return 0;
+
 	if (pdev->dev.of_node) {
 		struct device_node *np;
 		int i = 0;
@@ -1199,6 +1218,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 			int irq;
 			op_in_desc = (int)of_id->data;
 
+			if (i >= max_channels)
+				continue;
+
 			dma_cap_zero(cap_mask);
 			dma_cap_set(DMA_MEMCPY, cap_mask);
 			dma_cap_set(DMA_XOR, cap_mask);
@@ -1222,7 +1244,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			i++;
 		}
 	} else if (pdata && pdata->channels) {
-		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
+		for (i = 0; i < max_channels; i++) {
 			struct mv_xor_channel_data *cd;
 			struct mv_xor_chan *chan;
 			int irq;
-- 
2.4.5
