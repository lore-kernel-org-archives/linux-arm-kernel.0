From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 06 Mar 2012 22:35:47 +0000
Subject: [PATCH 7/9] dmaengine: consolidate initialization of cookies
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <E1S52yx-0002N5-Bc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a common function to initialize a channels cookie values.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c    |    3 +--
 drivers/dma/at_hdmac.c      |    4 ++--
 drivers/dma/coh901318.c     |    2 +-
 drivers/dma/dmaengine.h     |   10 ++++++++++
 drivers/dma/dw_dmac.c       |    4 ++--
 drivers/dma/ep93xx_dma.c    |    3 +--
 drivers/dma/intel_mid_dma.c |    4 ++--
 drivers/dma/ipu/ipu_idmac.c |    6 ++----
 drivers/dma/mpc512x_dma.c   |    3 +--
 drivers/dma/pch_dma.c       |    4 ++--
 drivers/dma/pl330.c         |    2 +-
 drivers/dma/sirf-dma.c      |    3 +--
 drivers/dma/ste_dma40.c     |    2 +-
 drivers/dma/timb_dma.c      |    5 ++---
 drivers/dma/txx9dmac.c      |    4 ++--
 15 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 2781a2b..13c4d08 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1707,8 +1707,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 chan->name);
 
 		chan->chan.device = dmadev;
-		chan->chan.cookie = 0;
-		chan->chan.completed_cookie = 0;
+		dma_cookie_init(&chan->chan);
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 8a32974..5d225dd 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1103,7 +1103,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irqsave(&atchan->lock, flags);
 	atchan->descs_allocated = i;
 	list_splice(&tmp_list, &atchan->free_list);
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	/* channel parameters */
@@ -1303,7 +1303,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		struct at_dma_chan	*atchan = &atdma->chan[i];
 
 		atchan->chan_common.device = &atdma->dma_common;
-		atchan->chan_common.cookie = atchan->chan_common.completed_cookie = 1;
+		dma_cookie_init(&atchan->chan_common);
 		list_add_tail(&atchan->chan_common.device_node,
 				&atdma->dma_common.channels);
 
diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index f350517..187bb9e 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -915,7 +915,7 @@ static int coh901318_alloc_chan_resources(struct dma_chan *chan)
 	coh901318_config(cohc, NULL);
 
 	cohc->allocated = 1;
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 1ca5e0e..17f983a 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -9,6 +9,16 @@
 #include <linux/dmaengine.h>
 
 /**
+ * dma_cookie_init - initialize the cookies for a DMA channel
+ * @chan: dma channel to initialize
+ */
+static inline void dma_cookie_init(struct dma_chan *chan)
+{
+	chan->cookie = DMA_MIN_COOKIE;
+	chan->completed_cookie = DMA_MIN_COOKIE;
+}
+
+/**
  * dma_cookie_assign - assign a DMA engine cookie to the descriptor
  * @tx: descriptor needing cookie
  *
diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index acc3bc0..8b4be42 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -979,7 +979,7 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 		return -EIO;
 	}
 
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 
 	/*
 	 * NOTE: some controllers may have additional features that we
@@ -1398,7 +1398,7 @@ static int __init dw_probe(struct platform_device *pdev)
 		struct dw_dma_chan	*dwc = &dw->chan[i];
 
 		dwc->chan.device = &dw->dma;
-		dwc->chan.cookie = dwc->chan.completed_cookie = 1;
+		dma_cookie_init(&dwc->chan);
 		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
 			list_add_tail(&dwc->chan.device_node,
 					&dw->dma.channels);
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 142ebf0..f25e83b 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -854,8 +854,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 		goto fail_clk_disable;
 
 	spin_lock_irq(&edmac->lock);
-	edmac->chan.completed_cookie = 1;
-	edmac->chan.cookie = 1;
+	dma_cookie_init(&edmac->chan);
 	ret = edmac->edma->hw_setup(edmac);
 	spin_unlock_irq(&edmac->lock);
 
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index 69ed1e6..9d82a84 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -867,7 +867,7 @@ static int intel_mid_dma_alloc_chan_resources(struct dma_chan *chan)
 		pm_runtime_put(&mid->pdev->dev);
 		return -EIO;
 	}
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 
 	spin_lock_bh(&midc->lock);
 	while (midc->descs_allocated < DESCS_PER_CHANNEL) {
@@ -1099,7 +1099,7 @@ static int mid_setup_dma(struct pci_dev *pdev)
 		struct intel_mid_dma_chan *midch = &dma->ch[i];
 
 		midch->chan.device = &dma->common;
-		midch->chan.cookie =  1;
+		dma_cookie_init(&midch->chan);
 		midch->ch_id = dma->chan_base + i;
 		pr_debug("MDMA:Init CH %d, ID %d\n", i, midch->ch_id);
 
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index bff9250..1880274 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1504,8 +1504,7 @@ static int idmac_alloc_chan_resources(struct dma_chan *chan)
 	BUG_ON(chan->client_count > 1);
 	WARN_ON(ichan->status != IPU_CHANNEL_FREE);
 
-	chan->cookie		= 1;
-	chan->completed_cookie	= -ENXIO;
+	dma_cookie_init(chan);
 
 	ret = ipu_irq_map(chan->chan_id);
 	if (ret < 0)
@@ -1633,8 +1632,7 @@ static int __init ipu_idmac_init(struct ipu *ipu)
 		snprintf(ichan->eof_name, sizeof(ichan->eof_name), "IDMAC EOF %d", i);
 
 		dma_chan->device	= &idmac->dma;
-		dma_chan->cookie	= 1;
-		dma_chan->completed_cookie	= -ENXIO;
+		dma_cookie_init(dma_chan);
 		dma_chan->chan_id	= i;
 		list_add_tail(&dma_chan->device_node, &dma->channels);
 	}
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 1382715..2ab0a3d 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -733,8 +733,7 @@ static int __devinit mpc_dma_probe(struct platform_device *op)
 		mchan = &mdma->channels[i];
 
 		mchan->chan.device = dma;
-		mchan->chan.cookie = 1;
-		mchan->chan.completed_cookie = mchan->chan.cookie;
+		dma_cookie_init(&mchan->chan);
 
 		INIT_LIST_HEAD(&mchan->free);
 		INIT_LIST_HEAD(&mchan->prepared);
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c30f63e..c93bb045 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -531,7 +531,7 @@ static int pd_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irq(&pd_chan->lock);
 	list_splice(&tmp_list, &pd_chan->free_list);
 	pd_chan->descs_allocated = i;
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 	spin_unlock_irq(&pd_chan->lock);
 
 	pdc_enable_irq(chan, 1);
@@ -912,7 +912,7 @@ static int __devinit pch_dma_probe(struct pci_dev *pdev,
 		struct pch_dma_chan *pd_chan = &pd->channels[i];
 
 		pd_chan->chan.device = &pd->dma;
-		pd_chan->chan.cookie = 1;
+		dma_cookie_init(&pd_chan->chan);
 
 		pd_chan->membase = &regs->desc[i];
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 1993286..49c123f 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -304,7 +304,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 
 	spin_lock_irqsave(&pch->lock, flags);
 
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 	pch->cyclic = false;
 
 	pch->pl330_chid = pl330_request_channel(&pdmac->pif);
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index a760d98..a2cde85 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -625,8 +625,7 @@ static int __devinit sirfsoc_dma_probe(struct platform_device *op)
 		schan = &sdma->channels[i];
 
 		schan->chan.device = dma;
-		schan->chan.cookie = 1;
-		schan->chan.completed_cookie = schan->chan.cookie;
+		dma_cookie_init(&schan->chan);
 
 		INIT_LIST_HEAD(&schan->free);
 		INIT_LIST_HEAD(&schan->prepared);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 07b82e3..1ea6d02 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2172,7 +2172,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	bool is_free_phy;
 	spin_lock_irqsave(&d40c->lock, flags);
 
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 
 	/* If no dma configuration is set use default configuration (memcpy) */
 	if (!d40c->configured) {
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 6383abb..7805996 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -477,8 +477,7 @@ static int td_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	spin_lock_bh(&td_chan->lock);
-	chan->completed_cookie = 1;
-	chan->cookie = 1;
+	dma_cookie_init(chan);
 	spin_unlock_bh(&td_chan->lock);
 
 	return 0;
@@ -755,7 +754,7 @@ static int __devinit td_probe(struct platform_device *pdev)
 		}
 
 		td_chan->chan.device = &td->dma;
-		td_chan->chan.cookie = 1;
+		dma_cookie_init(&td_chan->chan);
 		spin_lock_init(&td_chan->lock);
 		INIT_LIST_HEAD(&td_chan->active_list);
 		INIT_LIST_HEAD(&td_chan->queue);
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index bb7b3d9..40440f9 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1034,7 +1034,7 @@ static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
 		return -EIO;
 	}
 
-	chan->completed_cookie = chan->cookie = 1;
+	dma_cookie_init(chan);
 
 	dc->ccr = TXX9_DMA_CCR_IMMCHN | TXX9_DMA_CCR_INTENE | CCR_LE;
 	txx9dmac_chan_set_SMPCHN(dc);
@@ -1163,7 +1163,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 	dc->ddev->chan[ch] = dc;
 	dc->chan.device = &dc->dma;
 	list_add_tail(&dc->chan.device_node, &dc->chan.device->channels);
-	dc->chan.cookie = dc->chan.completed_cookie = 1;
+	dma_cookie_init(&dc->chan);
 
 	if (is_dmac64(dc))
 		dc->ch_regs = &__txx9dmac_regs(dc->ddev)->CHAN[ch];
-- 
1.7.4.4
