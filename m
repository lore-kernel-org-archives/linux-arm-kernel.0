From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:34:01 +0200
Subject: [PATCH 12/20] net: smc911x.c: switch to dmaengine API
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-13-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop all PXA-DMA specific implementation details and switch over to
generic dmaengine usage.

This patch is only compile-tested.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/net/ethernet/smsc/smc911x.c | 80 ++++++++++++++++++++++-------------
 drivers/net/ethernet/smsc/smc911x.h | 83 ++++++++++++++++++++-----------------
 2 files changed, 98 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 345558f..19cdf8f 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -1178,9 +1178,9 @@ static irqreturn_t smc911x_interrupt(int irq, void *dev_id)
 
 #ifdef SMC_USE_DMA
 static void
-smc911x_tx_dma_irq(int dma, void *data)
+smc911x_tx_dma_irq(void *param)
 {
-	struct net_device *dev = (struct net_device *)data;
+	struct net_device *dev = (struct net_device *) param;
 	struct smc911x_local *lp = netdev_priv(dev);
 	struct sk_buff *skb = lp->current_tx_skb;
 	unsigned long flags;
@@ -1189,7 +1189,6 @@ smc911x_tx_dma_irq(int dma, void *data)
 
 	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, "%s: TX DMA irq handler\n", dev->name);
 	/* Clear the DMA interrupt sources */
-	SMC_DMA_ACK_IRQ(dev, dma);
 	BUG_ON(skb == NULL);
 	dma_unmap_single(NULL, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
 	dev->trans_start = jiffies;
@@ -1212,10 +1211,9 @@ smc911x_tx_dma_irq(int dma, void *data)
 		"%s: TX DMA irq completed\n", dev->name);
 }
 static void
-smc911x_rx_dma_irq(int dma, void *data)
+smc911x_rx_dma_irq(void *param)
 {
-	struct net_device *dev = (struct net_device *)data;
-	unsigned long ioaddr = dev->base_addr;
+	struct net_device *dev = (struct net_device *) param;
 	struct smc911x_local *lp = netdev_priv(dev);
 	struct sk_buff *skb = lp->current_rx_skb;
 	unsigned long flags;
@@ -1224,7 +1222,6 @@ smc911x_rx_dma_irq(int dma, void *data)
 	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __func__);
 	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, "%s: RX DMA irq handler\n", dev->name);
 	/* Clear the DMA interrupt sources */
-	SMC_DMA_ACK_IRQ(dev, dma);
 	dma_unmap_single(NULL, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
 	BUG_ON(skb == NULL);
 	lp->current_rx_skb = NULL;
@@ -1754,6 +1751,37 @@ static int smc911x_findirq(struct net_device *dev)
 	return probe_irq_off(cookie);
 }
 
+#ifdef SMC_USE_DMA
+static void smc_alloc_dma(struct net_device *dev,
+			  struct smc911x_local *lp)
+{
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	lp->rxdma = dma_request_channel(mask, NULL, NULL);
+	if (!lp->rxdma) {
+		printk("%s(): unable to allocate RX channel\n", __func__);
+		return;
+	}
+
+	lp->txdma = dma_request_channel(mask, NULL, NULL);
+	if (!lp->txdma) {
+		printk("%s(): unable to allocate TX channel\n", __func__);
+		return;
+	}
+
+	lp->rxdma_active = 0;
+	lp->txdma_active = 0;
+}
+#else
+static inline void smc_alloc_dma(struct net_device *dev,
+				 struct smc911x_local *lp)
+{
+}
+#endif
+
 static const struct net_device_ops smc911x_netdev_ops = {
 	.ndo_open		= smc911x_open,
 	.ndo_stop		= smc911x_close,
@@ -1969,13 +1997,7 @@ static int smc911x_probe(struct net_device *dev)
 	if (retval)
 		goto err_out;
 
-#ifdef SMC_USE_DMA
-	lp->rxdma = SMC_DMA_REQUEST(dev, smc911x_rx_dma_irq);
-	lp->txdma = SMC_DMA_REQUEST(dev, smc911x_tx_dma_irq);
-	lp->rxdma_active = 0;
-	lp->txdma_active = 0;
-	dev->dma = lp->rxdma;
-#endif
+	smc_alloc_dma(dev, lp);
 
 	retval = register_netdev(dev);
 	if (retval == 0) {
@@ -1985,11 +2007,11 @@ static int smc911x_probe(struct net_device *dev)
 			dev->base_addr, dev->irq);
 
 #ifdef SMC_USE_DMA
-		if (lp->rxdma != -1)
-			printk(" RXDMA %d ", lp->rxdma);
+		if (lp->rxdma)
+			printk(" RXDMA %p", lp->rxdma);
 
-		if (lp->txdma != -1)
-			printk("TXDMA %d", lp->txdma);
+		if (lp->txdma)
+			printk("TXDMA %p", lp->txdma);
 #endif
 		printk("\n");
 		if (!is_valid_ether_addr(dev->dev_addr)) {
@@ -2013,11 +2035,14 @@ static int smc911x_probe(struct net_device *dev)
 err_out:
 #ifdef SMC_USE_DMA
 	if (retval) {
-		if (lp->rxdma != -1) {
-			SMC_DMA_FREE(dev, lp->rxdma);
+		if (lp->rxdma) {
+			dmaengine_terminate_all(lp->rxdma);
+			dma_release_channel(lp->rxdma);
 		}
-		if (lp->txdma != -1) {
-			SMC_DMA_FREE(dev, lp->txdma);
+
+		if (lp->txdma) {
+			dmaengine_terminate_all(lp->txdma);
+			dma_release_channel(lp->txdma);
 		}
 	}
 #endif
@@ -2119,12 +2144,11 @@ static int smc911x_drv_remove(struct platform_device *pdev)
 
 #ifdef SMC_USE_DMA
 	{
-		if (lp->rxdma != -1) {
-			SMC_DMA_FREE(dev, lp->rxdma);
-		}
-		if (lp->txdma != -1) {
-			SMC_DMA_FREE(dev, lp->txdma);
-		}
+		if (lp->rxdma)
+			dma_release_channel(lp->rxdma);
+
+		if (lp->txdma)
+			dma_release_channel(lp->txdma);
 	}
 #endif
 	iounmap(lp->base);
diff --git a/drivers/net/ethernet/smsc/smc911x.h b/drivers/net/ethernet/smsc/smc911x.h
index d51261b..9323f1d 100644
--- a/drivers/net/ethernet/smsc/smc911x.h
+++ b/drivers/net/ethernet/smsc/smc911x.h
@@ -29,6 +29,7 @@
 #ifndef _SMC911X_H_
 #define _SMC911X_H_
 
+#include <linux/dmaengine.h>
 #include <linux/smc911x.h>
 /*
  * Use the DMA feature on PXA chips
@@ -102,8 +103,8 @@ struct smc911x_local {
 #ifdef SMC_USE_DMA
 	/* DMA needs the physical address of the chip */
 	u_long physaddr;
-	int rxdma;
-	int txdma;
+	struct dma_chan	*rxdma;
+	struct dma_chan *txdma;
 	int rxdma_active;
 	int txdma_active;
 	struct sk_buff *current_rx_skb;
@@ -211,27 +212,6 @@ static inline void SMC_outsl(struct smc911x_local *lp, int reg,
 
 #ifdef SMC_USE_PXA_DMA
 
-#include <mach/dma.h>
-
-/*
- * Define the request and free functions
- * These are unfortunately architecture specific as no generic allocation
- * mechanism exits
- */
-#define SMC_DMA_REQUEST(dev, handler) \
-	 pxa_request_dma(dev->name, DMA_PRIO_LOW, handler, dev)
-
-#define SMC_DMA_FREE(dev, dma) \
-	 pxa_free_dma(dma)
-
-#define SMC_DMA_ACK_IRQ(dev, dma)					\
-{									\
-	if (DCSR(dma) & DCSR_BUSERR) {					\
-		printk("%s: DMA %d bus error!\n", dev->name, dma);	\
-	}								\
-	DCSR(dma) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;		\
-}
-
 /*
  * Use a DMA for RX and TX packets.
  */
@@ -240,6 +220,9 @@ static inline void SMC_outsl(struct smc911x_local *lp, int reg,
 static dma_addr_t rx_dmabuf, tx_dmabuf;
 static int rx_dmalen, tx_dmalen;
 
+static void smc911x_tx_dma_irq(void *param);
+static void smc911x_rx_dma_irq(void *param);
+
 #ifdef SMC_insl
 #undef SMC_insl
 #define SMC_insl(lp, r, p, l) \
@@ -247,8 +230,17 @@ static int rx_dmalen, tx_dmalen;
 
 static inline void
 smc_pxa_dma_insl(struct smc911x_local *lp, u_long physaddr,
-		int reg, int dma, u_char *buf, int len)
+		int reg, struct dma_chan *chan, u_char *buf, int len)
 {
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config conf;
+
+	memset(&conf, 0, sizeof(conf));
+
+	conf.direction = DMA_DEV_TO_MEM;
+	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	conf.src_maxburst = 32;
+
 	/* 64 bit alignment is required for memory to memory DMA */
 	if ((long)buf & 4) {
 		*((u32 *)buf) = SMC_inl(lp, reg);
@@ -259,12 +251,16 @@ smc_pxa_dma_insl(struct smc911x_local *lp, u_long physaddr,
 	len *= 4;
 	rx_dmabuf = dma_map_single(lp->dev, buf, len, DMA_FROM_DEVICE);
 	rx_dmalen = len;
-	DCSR(dma) = DCSR_NODESC;
-	DTADR(dma) = rx_dmabuf;
-	DSADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
-		DCMD_WIDTH4 | DCMD_ENDIRQEN | (DCMD_LENGTH & rx_dmalen));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+
+	dmaengine_slave_config(chan, &conf);
+	tx = chan->device->device_prep_dma_memcpy(chan, rx_dmabuf,
+						  physaddr + reg, len, 0);
+
+	tx->callback = smc911x_rx_dma_irq;
+	tx->callback_param = lp->netdev;
+
+	dmaengine_submit(tx);
+	dma_async_issue_pending(chan);
 }
 #endif
 
@@ -275,8 +271,17 @@ smc_pxa_dma_insl(struct smc911x_local *lp, u_long physaddr,
 
 static inline void
 smc_pxa_dma_outsl(struct smc911x_local *lp, u_long physaddr,
-		int reg, int dma, u_char *buf, int len)
+		int reg, struct dma_chan *chan, u_char *buf, int len)
 {
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config conf;
+
+	memset(&conf, 0, sizeof(conf));
+
+	conf.direction = DMA_MEM_TO_DEV;
+	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	conf.dst_maxburst = 32;
+
 	/* 64 bit alignment is required for memory to memory DMA */
 	if ((long)buf & 4) {
 		SMC_outl(*((u32 *)buf), lp, reg);
@@ -287,12 +292,16 @@ smc_pxa_dma_outsl(struct smc911x_local *lp, u_long physaddr,
 	len *= 4;
 	tx_dmabuf = dma_map_single(lp->dev, buf, len, DMA_TO_DEVICE);
 	tx_dmalen = len;
-	DCSR(dma) = DCSR_NODESC;
-	DSADR(dma) = tx_dmabuf;
-	DTADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCSRCADDR | DCMD_BURST32 |
-		DCMD_WIDTH4 | DCMD_ENDIRQEN | (DCMD_LENGTH & tx_dmalen));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+
+	dmaengine_slave_config(chan, &conf);
+	tx = chan->device->device_prep_dma_memcpy(chan, physaddr + reg,
+						  tx_dmabuf, len, 0);
+
+	tx->callback = smc911x_tx_dma_irq;
+	tx->callback_param = lp->netdev;
+
+	dmaengine_submit(tx);
+	dma_async_issue_pending(chan);
 }
 #endif
 #endif	 /* SMC_USE_PXA_DMA */
-- 
1.8.3.1
