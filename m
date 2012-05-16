From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 May 2012 12:05:52 +0100
Subject: [PATCH 3/6] DMA: PL08x: get rid of device_fc in struct pl08x_dma_chan
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <E1SUc3E-0001ml-1F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we now store the dma_slave_config in pl08x_dma_chan, we don't need
to store this separately.  Use the one in dma_slave_config directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    4 +---
 include/linux/amba/pl08x.h |    4 ----
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 81f47cfa..c2e510a 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1198,8 +1198,6 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= burst << PL080_CONTROL_SB_SIZE_SHIFT;
 	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
-	plchan->device_fc = config->device_fc;
-
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
 		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
 			pl08x_select_bus(plchan->cd->periph_buses,
@@ -1429,7 +1427,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	if (plchan->device_fc)
+	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
 	else
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index b47b3c2..199ea4b 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -108,9 +108,6 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
- * channels. Fill with 'true' if peripheral should be flow controller. Direction
- * will be selected at Runtime.
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
  */
@@ -131,7 +128,6 @@ struct pl08x_dma_chan {
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
-	bool device_fc;
 	struct pl08x_txd *waiting;
 };
 
-- 
1.7.4.4
