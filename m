From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 24 Apr 2013 12:40:36 +0300
Subject: [PATCH 04/11] dmaengine: dw_dmac: simplify master selection
In-Reply-To: <1366796443-7083-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1366796443-7083-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <1366796443-7083-4-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The patch to add the common DMA binding added a dummy dw_dma_slave
structure into the dw_dma_chan structure in order to configure the
masters correctly. It turns out that this can be simplified if we
pick the DMA masters in the dwc_alloc_chan_resources function instead
and save them in the dw_dma_chan structure directly.

This could be simplified further once all users that today use
dw_dma_slave for configuration get converted to device tree based
setup instead.

(Upstream commit id: f776076b9fa82d630651c9af56359d80fce86d68)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/dw_dmac.c      |   76 +++++++++++++++++---------------------------
 drivers/dma/dw_dmac_regs.h |    5 ++-
 2 files changed, 33 insertions(+), 48 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 274fd7d..951ef5b 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -49,29 +49,22 @@ static inline unsigned int dwc_get_sms(struct dw_dma_slave *slave)
 	return slave ? slave->src_master : 1;
 }
 
-#define SRC_MASTER	0
-#define DST_MASTER	1
-
-static inline unsigned int dwc_get_master(struct dma_chan *chan, int master)
+static inline void dwc_set_masters(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(chan->device);
-	struct dw_dma_slave *dws = chan->private;
-	unsigned int m;
-
-	if (master == SRC_MASTER)
-		m = dwc_get_sms(dws);
-	else
-		m = dwc_get_dms(dws);
+	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma_slave *dws = dwc->chan.private;
+	unsigned char mmax = dw->nr_masters - 1;
 
-	return min_t(unsigned int, dw->nr_masters - 1, m);
+	if (dwc->request_line == ~0) {
+		dwc->src_master = min_t(unsigned char, mmax, dwc_get_sms(dws));
+		dwc->dst_master = min_t(unsigned char, mmax, dwc_get_dms(dws));
+	}
 }
 
 #define DWC_DEFAULT_CTLLO(_chan) ({				\
 		struct dw_dma_chan *_dwc = to_dw_dma_chan(_chan);	\
 		struct dma_slave_config	*_sconfig = &_dwc->dma_sconfig;	\
 		bool _is_slave = is_slave_direction(_dwc->direction);	\
-		int _dms = dwc_get_master(_chan, DST_MASTER);		\
-		int _sms = dwc_get_master(_chan, SRC_MASTER);		\
 		u8 _smsize = _is_slave ? _sconfig->src_maxburst :	\
 			DW_DMA_MSIZE_16;			\
 		u8 _dmsize = _is_slave ? _sconfig->dst_maxburst :	\
@@ -81,8 +74,8 @@ static inline unsigned int dwc_get_master(struct dma_chan *chan, int master)
 		 | DWC_CTLL_SRC_MSIZE(_smsize)			\
 		 | DWC_CTLL_LLP_D_EN				\
 		 | DWC_CTLL_LLP_S_EN				\
-		 | DWC_CTLL_DMS(_dms)				\
-		 | DWC_CTLL_SMS(_sms));				\
+		 | DWC_CTLL_DMS(_dwc->dst_master)		\
+		 | DWC_CTLL_SMS(_dwc->src_master));		\
 	})
 
 /*
@@ -92,13 +85,6 @@ static inline unsigned int dwc_get_master(struct dma_chan *chan, int master)
  */
 #define NR_DESCS_PER_CHANNEL	64
 
-static inline unsigned int dwc_get_data_width(struct dma_chan *chan, int master)
-{
-	struct dw_dma *dw = to_dw_dma(chan->device);
-
-	return dw->data_width[dwc_get_master(chan, master)];
-}
-
 /*----------------------------------------------------------------------*/
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -172,13 +158,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 	if (dwc->initialized == true)
 		return;
 
-	if (dws && dws->cfg_hi == ~0 && dws->cfg_lo == ~0) {
-		/* Autoconfigure based on request line from DT */
-		if (dwc->direction == DMA_MEM_TO_DEV)
-			cfghi = DWC_CFGH_DST_PER(dwc->request_line);
-		else if (dwc->direction == DMA_DEV_TO_MEM)
-			cfghi = DWC_CFGH_SRC_PER(dwc->request_line);
-	} else if (dws) {
+	if (dws) {
 		/*
 		 * We need controller-specific data to set up slave
 		 * transfers.
@@ -189,9 +169,9 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 		cfglo |= dws->cfg_lo & ~DWC_CFGL_CH_PRIOR_MASK;
 	} else {
 		if (dwc->direction == DMA_MEM_TO_DEV)
-			cfghi = DWC_CFGH_DST_PER(dwc->dma_sconfig.slave_id);
+			cfghi = DWC_CFGH_DST_PER(dwc->request_line);
 		else if (dwc->direction == DMA_DEV_TO_MEM)
-			cfghi = DWC_CFGH_SRC_PER(dwc->dma_sconfig.slave_id);
+			cfghi = DWC_CFGH_SRC_PER(dwc->request_line);
 	}
 
 	channel_writel(dwc, CFG_LO, cfglo);
@@ -745,6 +725,7 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		size_t len, unsigned long flags)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	struct dw_desc		*desc;
 	struct dw_desc		*first;
 	struct dw_desc		*prev;
@@ -767,8 +748,8 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 	dwc->direction = DMA_MEM_TO_MEM;
 
-	data_width = min_t(unsigned int, dwc_get_data_width(chan, SRC_MASTER),
-			   dwc_get_data_width(chan, DST_MASTER));
+	data_width = min_t(unsigned int, dw->data_width[dwc->src_master],
+			   dw->data_width[dwc->dst_master]);
 
 	src_width = dst_width = min_t(unsigned int, data_width,
 				      dwc_fast_fls(src | dest | len));
@@ -826,6 +807,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned long flags, void *context)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
 	struct dw_desc		*prev;
 	struct dw_desc		*first;
@@ -859,7 +841,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		ctllo |= sconfig->device_fc ? DWC_CTLL_FC(DW_DMA_FC_P_M2P) :
 			DWC_CTLL_FC(DW_DMA_FC_D_M2P);
 
-		data_width = dwc_get_data_width(chan, SRC_MASTER);
+		data_width = dw->data_width[dwc->src_master];
 
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
@@ -919,7 +901,7 @@ slave_sg_todev_fill_desc:
 		ctllo |= sconfig->device_fc ? DWC_CTLL_FC(DW_DMA_FC_P_P2M) :
 			DWC_CTLL_FC(DW_DMA_FC_D_P2M);
 
-		data_width = dwc_get_data_width(chan, DST_MASTER);
+		data_width = dw->data_width[dwc->dst_master];
 
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct dw_desc	*desc;
@@ -1020,6 +1002,10 @@ set_runtime_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
 	dwc->direction = sconfig->direction;
 
+	/* Take the request line from slave_id member */
+	if (dwc->request_line == ~0)
+		dwc->request_line = sconfig->slave_id;
+
 	convert_burst(&dwc->dma_sconfig.src_maxburst);
 	convert_burst(&dwc->dma_sconfig.dst_maxburst);
 	convert_slave_id(dwc);
@@ -1170,6 +1156,8 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 	 * doesn't mean what you think it means), and status writeback.
 	 */
 
+	dwc_set_masters(dwc);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	i = dwc->descs_allocated;
 	while (dwc->descs_allocated < NR_DESCS_PER_CHANNEL) {
@@ -1227,6 +1215,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	list_splice_init(&dwc->free_list, &list);
 	dwc->descs_allocated = 0;
 	dwc->initialized = false;
+	dwc->request_line = ~0;
 
 	/* Disable interrupts */
 	channel_clear_bit(dw, MASK.XFER, dwc->mask);
@@ -1254,23 +1243,15 @@ struct dw_dma_of_filter_args {
 static bool dw_dma_of_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
-	struct dw_dma *dw = to_dw_dma(chan->device);
 	struct dw_dma_of_filter_args *fargs = param;
-	struct dw_dma_slave *dws = &dwc->slave;
 
 	/* Ensure the device matches our channel */
         if (chan->device != &fargs->dw->dma)
                 return false;
 
-	dws->dma_dev	= dw->dma.dev;
-	dws->cfg_hi	= ~0;
-	dws->cfg_lo	= ~0;
-	dws->src_master	= fargs->src;
-	dws->dst_master	= fargs->dst;
-
 	dwc->request_line = fargs->req;
-
-	chan->private = dws;
+	dwc->src_master	= fargs->src;
+	dwc->dst_master	= fargs->dst;
 
 	return true;
 }
@@ -1784,6 +1765,7 @@ static int dw_probe(struct platform_device *pdev)
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 
 		dwc->direction = DMA_TRANS_NONE;
+		dwc->request_line = ~0;
 
 		/* Hardware configuration */
 		if (autocfg) {
diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 4d02c36..9b0e12e 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -212,8 +212,11 @@ struct dw_dma_chan {
 	/* hardware configuration */
 	unsigned int		block_size;
 	bool			nollp;
+
+	/* custom slave configuration */
 	unsigned int		request_line;
-	struct dw_dma_slave	slave;
+	unsigned char		src_master;
+	unsigned char		dst_master;
 
 	/* configuration passed via DMA_SLAVE_CONFIG */
 	struct dma_slave_config dma_sconfig;
-- 
1.7.10.4
