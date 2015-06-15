From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:18:58 -0700
Subject: [PATCH 03/10] dma: imx-sdma: use a container_of function
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-4-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than including a struct sdma_engine pointer in
each sdma_channel, introduce to_sdma_engine() to get
the parent struct.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c255664..7c8703f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -246,7 +246,6 @@ struct sdma_engine;
  * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
-	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
 	enum sdma_peripheral_type	peripheral_type;
@@ -467,6 +466,11 @@ static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned int event)
 	return chnenbl0 + event * 4;
 }
 
+static struct sdma_engine *to_sdma_engine(struct sdma_channel *sdmac)
+{
+	return container_of(sdmac, struct sdma_engine, channel[sdmac->channel]);
+}
+
 static int sdma_config_ownership(struct sdma_engine *sdma, int channel,
 		bool event_override, bool mcu_override, bool dsp_override)
 {
@@ -687,7 +691,7 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 static void sdma_get_pc(struct sdma_channel *sdmac,
 		enum sdma_peripheral_type peripheral_type)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int per_2_emi = 0, emi_2_per = 0;
 	/*
 	 * These are needed once we start to support transfers between
@@ -776,7 +780,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 
 static int sdma_load_context(struct sdma_channel *sdmac)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
@@ -836,7 +840,7 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 {
 	int ret;
 	int channel = sdmac->channel;
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 
 	sdma_disable_channel(sdma, channel);
 
@@ -906,7 +910,7 @@ static int sdma_set_channel_priority(struct sdma_engine *sdma, int channel,
 
 static int sdma_request_channel(struct sdma_channel *sdmac)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int channel = sdmac->channel;
 	int ret = -EBUSY;
 
@@ -950,7 +954,7 @@ static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	struct imx_dma_data *data = chan->private;
 	int prio, ret;
 
@@ -995,7 +999,7 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int channel = sdmac->channel;
 
 	sdma_disable_channel(sdma, channel);
@@ -1022,7 +1026,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		unsigned long flags, void *context)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
@@ -1123,7 +1127,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		unsigned long flags)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
@@ -1201,7 +1205,7 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		unsigned long arg)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 	struct dma_slave_config *dmaengine_cfg = (void *)arg;
 
 	switch (cmd) {
@@ -1250,7 +1254,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_engine *sdma = to_sdma_engine(sdmac);
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		sdma_enable_channel(sdma, sdmac->channel);
@@ -1539,7 +1543,6 @@ static int sdma_probe(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
 		sdmac->chan.device = &sdma->dma_device;
-- 
2.1.4
