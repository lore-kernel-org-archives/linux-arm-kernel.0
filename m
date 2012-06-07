From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 07 Jun 2012 11:51:08 +0100
Subject: [CFT 16/31] dmaengine: PL08x: track mux usage on a per-channel basis.
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Message-ID: <E1ScaJ2-0003lB-0A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep track of the number of descriptors currently using a MUX setting
on a per-channel basis.  This allows us to know when we have descriptors
queued somewhere which have been assigned a DMA request signal.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c203d2f..ac9fdcc 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -227,6 +227,7 @@ enum pl08x_dma_chan_state {
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
  * @signal: the physical DMA request signal which this channel is using
+ * @mux_use: count of descriptors using this DMA request signal setting
  */
 struct pl08x_dma_chan {
 	struct dma_chan chan;
@@ -244,6 +245,7 @@ struct pl08x_dma_chan {
 	bool slave;
 	struct pl08x_txd *waiting;
 	int signal;
+	unsigned mux_use;
 };
 
 /**
@@ -310,10 +312,12 @@ static int pl08x_request_mux(struct pl08x_dma_chan *plchan)
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 	int ret;
 
-	if (pd->get_signal) {
+	if (plchan->mux_use++ == 0 && pd->get_signal) {
 		ret = pd->get_signal(plchan->cd);
-		if (ret < 0)
+		if (ret < 0) {
+			plchan->mux_use = 0;
 			return ret;
+		}
 
 		plchan->signal = ret;
 	}
@@ -324,9 +328,13 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 
-	if (plchan->signal >= 0 && pd->put_signal) {
-		pd->put_signal(plchan->cd, plchan->signal);
-		plchan->signal = -1;
+	if (plchan->signal >= 0) {
+		WARN_ON(plchan->mux_use == 0);
+
+		if (--plchan->mux_use == 0 && pd->put_signal) {
+			pd->put_signal(plchan->cd, plchan->signal);
+			plchan->signal = -1;
+		}
 	}
 }
 
-- 
1.7.4.4
