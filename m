From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 07 Jun 2012 11:47:23 +0100
Subject: [CFT 05/31] dmaengine: PL08x: clean up get_signal/put_signal
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Message-ID: <E1ScaFP-0003kA-9Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to avoid dereferencing the DMA engine's channel struct in these
platform helpers; instead, pass a pointer to the channel data into
get_signal(), and the returned signal number to put_signal().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    4 ++--
 include/linux/amba/pl08x.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 5821125..cc08c8c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -874,7 +874,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * Can the platform allow us to use this channel?
 	 */
 	if (plchan->slave && pl08x->pd->get_signal) {
-		ret = pl08x->pd->get_signal(plchan);
+		ret = pl08x->pd->get_signal(plchan->cd);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -909,7 +909,7 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 	struct pl08x_driver_data *pl08x = plchan->host;
 
 	if ((plchan->phychan->signal >= 0) && pl08x->pd->put_signal) {
-		pl08x->pd->put_signal(plchan);
+		pl08x->pd->put_signal(plchan->cd, plchan->phychan->signal);
 		plchan->phychan->signal = -1;
 	}
 	pl08x_put_phy_channel(pl08x, plchan->phychan);
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 0f5b34d..88765a6 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -225,8 +225,8 @@ struct pl08x_platform_data {
 	const struct pl08x_channel_data *slave_channels;
 	unsigned int num_slave_channels;
 	struct pl08x_channel_data memcpy_channel;
-	int (*get_signal)(struct pl08x_dma_chan *);
-	void (*put_signal)(struct pl08x_dma_chan *);
+	int (*get_signal)(const struct pl08x_channel_data *);
+	void (*put_signal)(const struct pl08x_channel_data *, int);
 	u8 lli_buses;
 	u8 mem_buses;
 };
-- 
1.7.4.4
