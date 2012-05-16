From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2012 12:17:44 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120516110451.GA9571@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
Message-ID: <20120516111744.GB9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 12:04:51PM +0100, Russell King - ARM Linux wrote:
> This series removes the dependence on the dma_slave_config direction
> argument for the PL08x DMA engine driver, and in doing so, we end up
> with less code in the driver.
> 
> We now compute the cctl values for both directions, and continue to
> select the appropriate one at prepare time.  If this is found to be
> invalid, the prepare function will return NULL.
> 
> However, we still use the direction argument in the slave configuration
> call to determine whether we should report and fail an invalid
> configuration.  Eventually this will be removed.

This is the final patch, which is not part of this RFC, which illustrates
where we should be with this driver.  Note that this will require all
slave users to issue a DMA slave configuration call before they use the
channel; the "defaults" are no longer used.  I think this is the case
today anyway.  Note - even more code reduction...

 drivers/dma/amba-pl08x.c   |   36 +++++++++---------------------------
 include/linux/amba/pl08x.h |    5 ++---
 2 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 7d92510..d662c22 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1180,30 +1180,10 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
-	struct pl08x_driver_data *pl08x = plchan->host;
-	u32 src_cctl, dst_cctl;
 
 	if (!plchan->slave)
 		return -EINVAL;
 
-	dst_cctl = pl08x_get_cctl(plchan, config->dst_addr_width,
-				  config->dst_maxburst);
-	if (dst_cctl == ~0 && config->direction == DMA_MEM_TO_DEV) {
-		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width (M2D)\n");
-		return -EINVAL;
-	}
-
-	src_cctl = pl08x_get_cctl(plchan, config->src_addr_width,
-				  config->src_maxburst);
-	if (src_cctl == ~0 && config->direction == DMA_DEV_TO_MEM) {
-		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width (D2M)\n");
-		return -EINVAL;
-	}
-
-	plchan->dst_cctl = dst_cctl;
-	plchan->src_cctl = src_cctl;
 	plchan->cfg = *config;
 
 	return 0;
@@ -1379,10 +1359,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct pl08x_txd *txd;
 	struct pl08x_sg *dsg;
 	struct scatterlist *sg;
+	enum dma_slave_buswidth addr_width;
 	dma_addr_t slave_addr;
 	int ret, tmp;
 	u8 src_buses, dst_buses;
-	u32 cctl;
+	u32 maxburst, cctl;
 
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sgl->length, plchan->name);
@@ -1401,13 +1382,17 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	txd->direction = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
-		cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
+		cctl = PL080_CONTROL_SRC_INCR;
 		slave_addr = plchan->cfg.dst_addr;
+		addr_width = plchan->cfg.dst_addr_width;
+		maxburst = plchan->cfg.dst_maxburst;
 		src_buses = pl08x->mem_buses;
 		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_DEV_TO_MEM) {
-		cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
+		cctl = PL080_CONTROL_DST_INCR;
 		slave_addr = plchan->cfg.src_addr;
+		addr_width = plchan->cfg.src_addr_width;
+		maxburst = plchan->cfg.src_maxburst;
 		src_buses = plchan->cd->periph_buses;
 		dst_buses = pl08x->mem_buses;
 	} else {
@@ -1417,6 +1402,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	cctl |= pl08x_get_cctl(plchan, addr_width, maxburst);
 	if (cctl == ~0) {
 		pl08x_free_txd(pl08x, txd);
 		dev_err(&pl08x->adev->dev,
@@ -1723,14 +1709,10 @@ static void pl08x_timer(unsigned long data)
 
 static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
 {
-	u32 cctl = pl08x_cctl(chan->cd->cctl);
-
 	chan->slave = true;
 	chan->name = chan->cd->bus_id;
 	chan->cfg.src_addr = chan->cd->addr;
 	chan->cfg.dst_addr = chan->cd->addr;
-	chan->src_cctl = cctl;
-	chan->dst_cctl = cctl;
 }
 
 /*
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 5f8e6d7..5d0ad6b 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -47,7 +47,8 @@ enum {
  * devices with static assignments
  * @muxval: a number usually used to poke into some mux regiser to
  * mux in the signal to this channel
- * @cctl_opt: default options for the channel control register
+ * @cctl: default options for the channel control register
+ *  *** not used for slave channels ***
  * @addr: source/target address in physical memory for this DMA channel,
  * can be the address of a FIFO register for burst requests for example.
  * This can be left undefined if the PrimeCell API is used for configuring
@@ -117,8 +118,6 @@ struct pl08x_dma_chan {
 	char *name;
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
-	u32 src_cctl;
-	u32 dst_cctl;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
