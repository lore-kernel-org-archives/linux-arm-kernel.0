From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:59 +0200
Subject: [PATCH 10/20] net: irda: pxaficp_ir: switch to dmaengine
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-11-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was only compile-tested.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/net/irda/pxaficp_ir.c | 242 ++++++++++++++++++++++++++----------------
 1 file changed, 151 insertions(+), 91 deletions(-)

diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index 964b116..d77a342 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -21,13 +21,15 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/mmp-pdma.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irmod.h>
 #include <net/irda/wrapper.h>
 #include <net/irda/irda_device.h>
 
-#include <mach/dma.h>
 #include <linux/platform_data/irda-pxaficp.h>
 #include <mach/regs-ost.h>
 #include <mach/regs-uart.h>
@@ -99,6 +101,9 @@
                 IrSR_RCVEIR_UART_MODE | \
                 IrSR_XMITIR_IR_MODE)
 
+/* FIXME */
+extern void pxa2xx_transceiver_mode(struct device *dev, int mode);
+
 struct pxa_irda {
 	int			speed;
 	int			newspeed;
@@ -109,8 +114,10 @@ struct pxa_irda {
 	dma_addr_t		dma_rx_buff_phy;
 	dma_addr_t		dma_tx_buff_phy;
 	unsigned int		dma_tx_buff_len;
-	int			txdma;
-	int			rxdma;
+	struct dma_chan		*txdma;
+	struct dma_chan		*rxdma;
+	dma_cookie_t		dma_rx_cookie;
+	dma_cookie_t		dma_tx_cookie;
 
 	int			uart_irq;
 	int			icp_irq;
@@ -122,6 +129,7 @@ struct pxa_irda {
 	iobuff_t		rx_buff;
 
 	struct device		*dev;
+	struct net_device	*net_dev;
 	struct pxaficp_platform_data *pdata;
 	struct clk		*fir_clk;
 	struct clk		*sir_clk;
@@ -147,26 +155,121 @@ static inline void pxa_irda_enable_sirclk(struct pxa_irda *si)
 	clk_prepare_enable(si->sir_clk);
 }
 
-
 #define IS_FIR(si)		((si)->speed >= 4000000)
 #define IRDA_FRAME_SIZE_LIMIT	2047
 
 inline static void pxa_irda_fir_dma_rx_start(struct pxa_irda *si)
 {
-	DCSR(si->rxdma)  = DCSR_NODESC;
-	DSADR(si->rxdma) = __PREG(ICDR);
-	DTADR(si->rxdma) = si->dma_rx_buff_phy;
-	DCMD(si->rxdma) = DCMD_INCTRGADDR | DCMD_FLOWSRC |  DCMD_WIDTH1 | DCMD_BURST32 | IRDA_FRAME_SIZE_LIMIT;
-	DCSR(si->rxdma) |= DCSR_RUN;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config config;
+	struct dma_device *dma_dev;
+	int ret;
+
+	dma_dev = si->rxdma->device;
+
+	memset(&config, 0, sizeof(config));
+	config.src_maxburst = 32;
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.direction = DMA_DEV_TO_MEM;
+
+	ret = dmaengine_slave_config(si->rxdma, &config);
+	if (ret < 0) {
+		dev_err(si->dev, "dmaengine_slave_config() failed: %d\n", ret);
+		return;
+	}
+
+	tx = dma_dev->device_prep_dma_memcpy(si->rxdma, __PREG(ICDR),
+					     si->dma_rx_buff_phy,
+					     IRDA_FRAME_SIZE_LIMIT, 0);
+	if (!tx) {
+		dev_err(si->dev, "device_prep_dma_memcpy() failed: %d\n", ret);
+		return;
+	}
+
+	si->dma_rx_cookie = dmaengine_submit(tx);
+	dma_async_issue_pending(si->rxdma);
+}
+
+static int pxa_irda_set_speed(struct pxa_irda *si, int speed);
+
+/* FIR Transmit DMA interrupt handler */
+static void pxa_irda_fir_dma_tx_irq(void *param)
+{
+	struct net_device *dev = param;
+	struct pxa_irda *si = netdev_priv(dev);
+	struct dma_tx_state tx_state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(si->txdma, si->dma_tx_cookie, &tx_state);
+	if (status == DMA_ERROR) {
+		dev->stats.tx_errors++;
+	} else {
+		dev->stats.tx_packets++;
+		dev->stats.tx_bytes += si->dma_tx_buff_len;
+	}
+
+	while (ICSR1 & ICSR1_TBY)
+		cpu_relax();
+	si->last_oscr = readl_relaxed(OSCR);
+
+	/*
+	 * HACK: It looks like the TBY bit is dropped too soon.
+	 * Without this delay things break.
+	 */
+	udelay(120);
+
+	if (si->newspeed) {
+		pxa_irda_set_speed(si, si->newspeed);
+		si->newspeed = 0;
+	} else {
+		int i = 64;
+
+		ICCR0 = 0;
+		pxa_irda_fir_dma_rx_start(si);
+		while ((ICSR1 & ICSR1_RNE) && i--)
+			(void)ICDR;
+		ICCR0 = ICCR0_ITR | ICCR0_RXE;
+
+		if (i < 0)
+			printk(KERN_ERR "pxa_ir: cannot clear Rx FIFO!\n");
+	}
+	netif_wake_queue(dev);
 }
 
+
 inline static void pxa_irda_fir_dma_tx_start(struct pxa_irda *si)
 {
-	DCSR(si->txdma)  = DCSR_NODESC;
-	DSADR(si->txdma) = si->dma_tx_buff_phy;
-	DTADR(si->txdma) = __PREG(ICDR);
-	DCMD(si->txdma) = DCMD_INCSRCADDR | DCMD_FLOWTRG |  DCMD_ENDIRQEN | DCMD_WIDTH1 | DCMD_BURST32 | si->dma_tx_buff_len;
-	DCSR(si->txdma) |= DCSR_RUN;
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config config;
+	struct dma_device *dma_dev;
+	int ret;
+
+	dma_dev = si->txdma->device;
+
+	memset(&config, 0, sizeof(config));
+	config.dst_maxburst = 32;
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.direction = DMA_MEM_TO_DEV;
+
+	ret = dmaengine_slave_config(si->txdma, &config);
+	if (ret < 0) {
+		dev_err(si->dev, "dmaengine_slave_config() failed: %d\n", ret);
+		return;
+	}
+
+	tx = dma_dev->device_prep_dma_memcpy(si->txdma, __PREG(ICDR),
+					     si->dma_tx_buff_phy,
+					     si->dma_tx_buff_len, 0);
+	if (!tx) {
+		dev_err(si->dev, "device_prep_dma_memcpy() failed: %d\n", ret);
+		return;
+	}
+
+	tx->callback = pxa_irda_fir_dma_tx_irq;
+	tx->callback_param = si->net_dev;
+
+	si->dma_tx_cookie = dmaengine_submit(tx);
+	dma_async_issue_pending(si->txdma);
 }
 
 /*
@@ -205,7 +308,7 @@ static int pxa_irda_set_speed(struct pxa_irda *si, int speed)
 
 		if (IS_FIR(si)) {
 			/* stop RX DMA */
-			DCSR(si->rxdma) &= ~DCSR_RUN;
+			dmaengine_terminate_all(si->rxdma);
 			/* disable FICP */
 			ICCR0 = 0;
 			pxa_irda_disable_clk(si);
@@ -344,68 +447,18 @@ static irqreturn_t pxa_irda_sir_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* FIR Receive DMA interrupt handler */
-static void pxa_irda_fir_dma_rx_irq(int channel, void *data)
-{
-	int dcsr = DCSR(channel);
-
-	DCSR(channel) = dcsr & ~DCSR_RUN;
-
-	printk(KERN_DEBUG "pxa_ir: fir rx dma bus error %#x\n", dcsr);
-}
-
-/* FIR Transmit DMA interrupt handler */
-static void pxa_irda_fir_dma_tx_irq(int channel, void *data)
-{
-	struct net_device *dev = data;
-	struct pxa_irda *si = netdev_priv(dev);
-	int dcsr;
-
-	dcsr = DCSR(channel);
-	DCSR(channel) = dcsr & ~DCSR_RUN;
-
-	if (dcsr & DCSR_ENDINTR)  {
-		dev->stats.tx_packets++;
-		dev->stats.tx_bytes += si->dma_tx_buff_len;
-	} else {
-		dev->stats.tx_errors++;
-	}
-
-	while (ICSR1 & ICSR1_TBY)
-		cpu_relax();
-	si->last_oscr = readl_relaxed(OSCR);
-
-	/*
-	 * HACK: It looks like the TBY bit is dropped too soon.
-	 * Without this delay things break.
-	 */
-	udelay(120);
-
-	if (si->newspeed) {
-		pxa_irda_set_speed(si, si->newspeed);
-		si->newspeed = 0;
-	} else {
-		int i = 64;
-
-		ICCR0 = 0;
-		pxa_irda_fir_dma_rx_start(si);
-		while ((ICSR1 & ICSR1_RNE) && i--)
-			(void)ICDR;
-		ICCR0 = ICCR0_ITR | ICCR0_RXE;
-
-		if (i < 0)
-			printk(KERN_ERR "pxa_ir: cannot clear Rx FIFO!\n");
-	}
-	netif_wake_queue(dev);
-}
-
 /* EIF(Error in FIFO/End in Frame) handler for FIR */
 static void pxa_irda_fir_irq_eif(struct pxa_irda *si, struct net_device *dev, int icsr0)
 {
 	unsigned int len, stat, data;
+	struct dma_tx_state tx_state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(si->rxdma, si->dma_rx_cookie,
+				     &tx_state);
 
 	/* Get the current data position. */
-	len = DTADR(si->rxdma) - si->dma_rx_buff_phy;
+	len = IRDA_FRAME_SIZE_LIMIT - tx_state.residue;
 
 	do {
 		/* Read Status, and then Data. 	 */
@@ -472,7 +525,7 @@ static irqreturn_t pxa_irda_fir_irq(int irq, void *dev_id)
 	int icsr0, i = 64;
 
 	/* stop RX DMA */
-	DCSR(si->rxdma) &= ~DCSR_RUN;
+	dmaengine_terminate_all(si->rxdma);
 	si->last_oscr = readl_relaxed(OSCR);
 	icsr0 = ICSR0;
 
@@ -553,7 +606,7 @@ static int pxa_irda_hard_xmit(struct sk_buff *skb, struct net_device *dev)
 				cpu_relax();
 
 		/* stop RX DMA,  disable FICP */
-		DCSR(si->rxdma) &= ~DCSR_RUN;
+		dmaengine_terminate_all(si->rxdma);
 		ICCR0 = 0;
 
 		pxa_irda_fir_dma_tx_start(si);
@@ -626,10 +679,6 @@ static void pxa_irda_startup(struct pxa_irda *si)
 	/* configure FICP ICCR2 */
 	ICCR2 = ICCR2_TXP | ICCR2_TRIG_32;
 
-	/* configure DMAC */
-	DRCMR(17) = si->rxdma | DRCMR_MAPVLD;
-	DRCMR(18) = si->txdma | DRCMR_MAPVLD;
-
 	/* force SIR reinitialization */
 	si->speed = 4000000;
 	pxa_irda_set_speed(si, 9600);
@@ -649,17 +698,15 @@ static void pxa_irda_shutdown(struct pxa_irda *si)
 	STISR = 0;
 
 	/* disable DMA */
-	DCSR(si->txdma) &= ~DCSR_RUN;
-	DCSR(si->rxdma) &= ~DCSR_RUN;
+	dmaengine_terminate_all(si->rxdma);
+	dmaengine_terminate_all(si->txdma);
+
 	/* disable FICP */
 	ICCR0 = 0;
 
 	/* disable the STUART or FICP clocks */
 	pxa_irda_disable_clk(si);
 
-	DRCMR(17) = 0;
-	DRCMR(18) = 0;
-
 	local_irq_restore(flags);
 
 	/* power off board transceiver */
@@ -671,7 +718,8 @@ static void pxa_irda_shutdown(struct pxa_irda *si)
 static int pxa_irda_start(struct net_device *dev)
 {
 	struct pxa_irda *si = netdev_priv(dev);
-	int err;
+	dma_cap_mask_t mask;
+	int drcmr, err;
 
 	si->speed = 9600;
 
@@ -689,13 +737,21 @@ static int pxa_irda_start(struct net_device *dev)
 	disable_irq(si->uart_irq);
 	disable_irq(si->icp_irq);
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
 	err = -EBUSY;
-	si->rxdma = pxa_request_dma("FICP_RX",DMA_PRIO_LOW, pxa_irda_fir_dma_rx_irq, dev);
-	if (si->rxdma < 0)
+
+	drcmr = 17;
+	si->rxdma = dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
+						     &drcmr, si->dev, "rx");
+	if (si->rxdma == NULL)
 		goto err_rx_dma;
 
-	si->txdma = pxa_request_dma("FICP_TX",DMA_PRIO_LOW, pxa_irda_fir_dma_tx_irq, dev);
-	if (si->txdma < 0)
+	drcmr = 18;
+	si->rxdma = dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
+						     &drcmr, si->dev, "rx");
+	if (si->txdma == NULL)
 		goto err_tx_dma;
 
 	err = -ENOMEM;
@@ -737,9 +793,9 @@ err_irlap:
 err_dma_tx_buff:
 	dma_free_coherent(si->dev, IRDA_FRAME_SIZE_LIMIT, si->dma_rx_buff, si->dma_rx_buff_phy);
 err_dma_rx_buff:
-	pxa_free_dma(si->txdma);
+	dma_release_channel(si->txdma);
 err_tx_dma:
-	pxa_free_dma(si->rxdma);
+	dma_release_channel(si->rxdma);
 err_rx_dma:
 	free_irq(si->icp_irq, dev);
 err_irq2:
@@ -766,8 +822,11 @@ static int pxa_irda_stop(struct net_device *dev)
 	free_irq(si->uart_irq, dev);
 	free_irq(si->icp_irq, dev);
 
-	pxa_free_dma(si->rxdma);
-	pxa_free_dma(si->txdma);
+	dmaengine_terminate_all(si->rxdma);
+	dmaengine_terminate_all(si->txdma);
+
+	dma_release_channel(si->rxdma);
+	dma_release_channel(si->txdma);
 
 	if (si->dma_rx_buff)
 		dma_free_coherent(si->dev, IRDA_FRAME_SIZE_LIMIT, si->dma_tx_buff, si->dma_tx_buff_phy);
@@ -855,6 +914,7 @@ static int pxa_irda_probe(struct platform_device *pdev)
 	si = netdev_priv(dev);
 	si->dev = &pdev->dev;
 	si->pdata = pdev->dev.platform_data;
+	si->net_dev = dev;
 
 	si->uart_irq = platform_get_irq(pdev, 0);
 	si->icp_irq = platform_get_irq(pdev, 1);
-- 
1.8.3.1
