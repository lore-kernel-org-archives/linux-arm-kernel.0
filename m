From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:34:00 +0200
Subject: [PATCH 11/20] net: smc91x.c: switch to generic buf-to-buf DMA offload
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-12-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop all PXA-DMA specific implementation details and rely on
dma_async_memcpy_buf_to_buf().

This patch is only compile-tested.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/net/ethernet/smsc/smc91x.c | 40 +++++++--------------
 drivers/net/ethernet/smsc/smc91x.h | 71 ++++++++++++++------------------------
 2 files changed, 38 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index cde13be..2d1e073 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2015,17 +2015,17 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
       	if (retval)
       		goto err_out;
 
-#ifdef CONFIG_ARCH_PXA
-#  ifdef SMC_USE_PXA_DMA
-	lp->cfg.flags |= SMC91X_USE_DMA;
-#  endif
 	if (lp->cfg.flags & SMC91X_USE_DMA) {
-		int dma = pxa_request_dma(dev->name, DMA_PRIO_LOW,
-					  smc_pxa_dma_irq, NULL);
-		if (dma >= 0)
-			dev->dma = dma;
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_MEMCPY, mask);
+		lp->dma_channel = dma_request_channel(mask, NULL, NULL);
+
+		if (!lp->dma_channel)
+			printk("%s(): request of DMA channel failed\n",
+				__func__);
 	}
-#endif
 
 	retval = register_netdev(dev);
 	if (retval == 0) {
@@ -2034,9 +2034,6 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 			dev->name, version_string, revision_register & 0x0f,
 			lp->base, dev->irq);
 
-		if (dev->dma != (unsigned char)-1)
-			printk(" DMA %d", dev->dma);
-
 		printk("%s%s\n",
 			lp->cfg.flags & SMC91X_NOWAIT ? " [nowait]" : "",
 			THROTTLE_TX_PKTS ? " [throttle_tx]" : "");
@@ -2060,10 +2057,6 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	}
 
 err_out:
-#ifdef CONFIG_ARCH_PXA
-	if (retval && dev->dma != (unsigned char)-1)
-		pxa_free_dma(dev->dma);
-#endif
 	return retval;
 }
 
@@ -2282,14 +2275,6 @@ static int smc_drv_probe(struct platform_device *pdev)
 		goto out_release_attrib;
 	}
 
-#ifdef CONFIG_ARCH_PXA
-	{
-		struct smc_local *lp = netdev_priv(ndev);
-		lp->device = &pdev->dev;
-		lp->physaddr = res->start;
-	}
-#endif
-
 	ret = smc_probe(ndev, addr, irq_flags);
 	if (ret != 0)
 		goto out_iounmap;
@@ -2320,12 +2305,11 @@ static int smc_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
+	if (lp->dma_channel)
+		dma_release_channel(lp->dma_channel);
+
 	free_irq(ndev->irq, ndev);
 
-#ifdef CONFIG_ARCH_PXA
-	if (ndev->dma != (unsigned char)-1)
-		pxa_free_dma(ndev->dma);
-#endif
 	iounmap(lp->base);
 
 	smc_release_datacs(pdev,ndev);
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 370e13d..cf51366 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -34,6 +34,7 @@
 #ifndef _SMC91X_H_
 #define _SMC91X_H_
 
+#include <linux/dmaengine.h>
 #include <linux/smc91x.h>
 
 /*
@@ -338,11 +339,8 @@ struct smc_local {
 
 	spinlock_t lock;
 
-#ifdef CONFIG_ARCH_PXA
-	/* DMA needs the physical address of the chip */
-	u_long physaddr;
-	struct device *device;
-#endif
+	struct dma_chan	*dma_channel;
+
 	void __iomem *base;
 	void __iomem *datacs;
 
@@ -358,13 +356,29 @@ struct smc_local {
 
 #ifdef CONFIG_ARCH_PXA
 /*
- * Let's use the DMA engine on the XScale PXA2xx for RX packets. This is
+ * Let's use the generic DMA buffer-to-buffer offload mechanism. This is
  * always happening in irq context so no need to worry about races.  TX is
  * different and probably not worth it for that reason, and not as critical
  * as RX which can overrun memory and lose packets.
  */
-#include <linux/dma-mapping.h>
-#include <mach/dma.h>
+
+static void smc_dma_copy(struct smc_local *lp, void *dest, void *src,
+			 unsigned int len)
+{
+	dma_cookie_t cookie;
+	cookie = dma_async_memcpy_buf_to_buf(lp->dma_channel, dest, src, len);
+
+	while (1) {
+		struct dma_tx_state state;
+		enum dma_status status;
+
+		status = dmaengine_tx_status(lp->dma_channel, cookie, &state);
+		if (status != DMA_IN_PROGRESS)
+			break;
+
+		cpu_relax();
+	}
+}
 
 #ifdef SMC_insl
 #undef SMC_insl
@@ -374,11 +388,8 @@ static inline void
 smc_pxa_dma_insl(void __iomem *ioaddr, struct smc_local *lp, int reg, int dma,
 		 u_char *buf, int len)
 {
-	u_long physaddr = lp->physaddr;
-	dma_addr_t dmabuf;
-
 	/* fallback if no DMA available */
-	if (dma == (unsigned char)-1) {
+	if (lp->dma_channel == NULL) {
 		readsl(ioaddr + reg, buf, len);
 		return;
 	}
@@ -390,18 +401,7 @@ smc_pxa_dma_insl(void __iomem *ioaddr, struct smc_local *lp, int reg, int dma,
 		len--;
 	}
 
-	len *= 4;
-	dmabuf = dma_map_single(lp->device, buf, len, DMA_FROM_DEVICE);
-	DCSR(dma) = DCSR_NODESC;
-	DTADR(dma) = dmabuf;
-	DSADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
-		     DCMD_WIDTH4 | (DCMD_LENGTH & len));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
-	while (!(DCSR(dma) & DCSR_STOPSTATE))
-		cpu_relax();
-	DCSR(dma) = 0;
-	dma_unmap_single(lp->device, dmabuf, len, DMA_FROM_DEVICE);
+	smc_dma_copy(lp, buf, (__u32 *) ioaddr + reg, len * 4);
 }
 #endif
 
@@ -413,11 +413,8 @@ static inline void
 smc_pxa_dma_insw(void __iomem *ioaddr, struct smc_local *lp, int reg, int dma,
 		 u_char *buf, int len)
 {
-	u_long physaddr = lp->physaddr;
-	dma_addr_t dmabuf;
-
 	/* fallback if no DMA available */
-	if (dma == (unsigned char)-1) {
+	if (lp->dma_channel == NULL) {
 		readsw(ioaddr + reg, buf, len);
 		return;
 	}
@@ -429,26 +426,10 @@ smc_pxa_dma_insw(void __iomem *ioaddr, struct smc_local *lp, int reg, int dma,
 		len--;
 	}
 
-	len *= 2;
-	dmabuf = dma_map_single(lp->device, buf, len, DMA_FROM_DEVICE);
-	DCSR(dma) = DCSR_NODESC;
-	DTADR(dma) = dmabuf;
-	DSADR(dma) = physaddr + reg;
-	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
-		     DCMD_WIDTH2 | (DCMD_LENGTH & len));
-	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
-	while (!(DCSR(dma) & DCSR_STOPSTATE))
-		cpu_relax();
-	DCSR(dma) = 0;
-	dma_unmap_single(lp->device, dmabuf, len, DMA_FROM_DEVICE);
+	smc_dma_copy(lp, buf, (__u32 *) ioaddr + reg, len * 2);
 }
 #endif
 
-static void
-smc_pxa_dma_irq(int dma, void *dummy)
-{
-	DCSR(dma) = 0;
-}
 #endif  /* CONFIG_ARCH_PXA */
 
 
-- 
1.8.3.1
