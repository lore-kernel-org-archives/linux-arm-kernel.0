From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:41:39 +0100
Subject: [RFC 19/34] dmaengine: PL08x: track mux usage on a per-channel basis.
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIvr-0006zy-Uk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep track of the number of descriptors currently using a MUX setting
on a per-channel basis.  This allows us to know when we have descriptors
queued somewhere which have been assigned a DMA request signal.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e5b13e6..3532833 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -220,6 +220,7 @@ enum pl08x_dma_chan_state {
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
  * @signal: the physical DMA request signal which this channel is using
+ * @mux_use: count of descriptors using this DMA request signal setting
  */
 struct pl08x_dma_chan {
 	struct dma_chan chan;
@@ -237,6 +238,7 @@ struct pl08x_dma_chan {
 	bool slave;
 	struct pl08x_txd *waiting;
 	int signal;
+	unsigned mux_use;
 };
 
 /**
@@ -303,10 +305,12 @@ static int pl08x_request_mux(struct pl08x_dma_chan *plchan)
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
@@ -317,9 +321,13 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
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
