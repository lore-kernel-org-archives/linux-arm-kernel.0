From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:39:19 +0100
Subject: [RFC 12/34] dmaengine: PL08x: get rid of device_fc in struct
 pl08x_dma_chan
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZItb-0006zV-69@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now store the dma_slave_config in pl08x_dma_chan, we don't need
to store this separately.  Use the one in dma_slave_config directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f83db39..0f27c77 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -222,9 +222,6 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
- * channels. Fill with 'true' if peripheral should be flow controller. Direction
- * will be selected at Runtime.
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
  */
@@ -245,7 +242,6 @@ struct pl08x_dma_chan {
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
-	bool device_fc;
 	struct pl08x_txd *waiting;
 };
 
@@ -1257,8 +1253,6 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
 	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
-	plchan->device_fc = config->device_fc;
-
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
 		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
 			pl08x_select_bus(plchan->cd->periph_buses,
@@ -1488,7 +1482,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	if (plchan->device_fc)
+	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
 	else
-- 
1.7.4.4
