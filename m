From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:46:40 +0000
Subject: PL011 DMA patches
In-Reply-To: <20101222231451.GA29368@n2100.arm.linux.org.uk>
References: <20101222231451.GA29368@n2100.arm.linux.org.uk>
Message-ID: <20101222234640.GD29368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 11:14:51PM +0000, Russell King - ARM Linux wrote:
> ... should be winging their way out.  This just supports the TX side
> without the RX DMA code, which is something needing some more work.
> 
> The PL08x issues are still to be sorted too - one of which is that
> having the PL08x unmap the buffer itself (under control of the
> DMA_COMPL_* flags) would avoid a few races with this driver doing
> that - otherwise we have to move the unmap inside the spinlock for
> safety.

Here's my dirty changes which I have for PL08x at the moment - the
most noisy in here is changing all those %08x to prefix them with
0x - a driver which prints some values as decimal and others as hex
is confusing.

It also changes the hard-coding of which AHB bus is used as per one
of my previous emails (this needs resolving properly.)  So more work
is needed on this driver.

It probably also breaks the circular buffer support too by moving that
callback...

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b605cc9..7a2b623 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -58,6 +58,8 @@
  * Global TODO:
  * - Break out common code from arch/arm/mach-s3c64xx and share
  */
+#define DEBUG
+#define VERBOSE_DEBUG
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -79,6 +81,8 @@
 #include <asm/cacheflush.h>
 
 #define DRIVER_NAME	"pl08xdmac"
+//#undef KERN_DEBUG
+//#define KERN_DEBUG KERN_INFO
 
 /**
  * struct vendor_data - vendor-specific config parameters
@@ -188,8 +192,8 @@ static void pl08x_set_cregs(struct pl08x_driver_data *pl08x,
 		;
 
 	dev_vdbg(&pl08x->adev->dev,
-		"WRITE channel %d: csrc=%08x, cdst=%08x, "
-		 "cctl=%08x, clli=%08x, ccfg=%08x\n",
+		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
+		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
 		ch->id,
 		ch->csrc,
 		ch->cdst,
@@ -350,7 +354,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	if (ch && txd) {
 		struct lli *llis_va = txd->llis_va;
 		struct lli *llis_bus = (struct lli *) txd->llis_bus;
-		u32 clli = readl(ch->base + PL080_CH_LLI);
+		u32 clli = readl(ch->base + PL080_CH_LLI) & ~PL080_LLI_LM_AHB2;
 
 		/* First get the bytes in the current active LLI */
 		bytes = get_bytes_in_cctl(readl(ch->base + PL080_CH_CONTROL));
@@ -573,6 +577,9 @@ int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 
 	llis_va[num_llis].next =
 		(dma_addr_t)((u32) &(llis_bus[num_llis + 1]));
+#if 1
+	llis_va[num_llis].next |= PL080_LLI_LM_AHB2;
+#endif
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
 		txd->srcbus.addr += len;
@@ -653,6 +660,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 */
 	cctl &= ~(PL080_CONTROL_DST_AHB2 | PL080_CONTROL_SRC_AHB2);
 	if (pl08x->vd->dualmaster) {
+#if 0
 		if (cctl & PL080_CONTROL_SRC_INCR)
 			/* Source increments, use AHB2 for destination */
 			cctl |= PL080_CONTROL_DST_AHB2;
@@ -662,6 +670,17 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		else
 			/* Just pick something, source AHB1 dest AHB2 */
 			cctl |= PL080_CONTROL_DST_AHB2;
+#else
+		if (cctl & PL080_CONTROL_SRC_INCR)
+			/* Source increments, use AHB2 for destination */
+			cctl |= PL080_CONTROL_SRC_AHB2;
+		else if (cctl & PL080_CONTROL_DST_INCR)
+			/* Destination increments, use AHB2 for source */
+			cctl |= PL080_CONTROL_DST_AHB2;
+		else
+			/* Just pick something, source AHB1 dest AHB2 */
+			cctl |= PL080_CONTROL_DST_AHB2;
+#endif
 	}
 
 	/* Find maximum width of the source bus */
@@ -721,7 +740,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		while (remainder) {
 			dev_vdbg(&pl08x->adev->dev,
 				 "%s single byte LLIs for a transfer of "
-				 "less than a bus width (remain %08x)\n",
+				 "less than a bus width (remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			num_llis =
@@ -737,7 +756,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		while ((mbus->addr) % (mbus->buswidth)) {
 			dev_vdbg(&pl08x->adev->dev,
 				"%s adjustment lli for less than bus width "
-				 "(remain %08x)\n",
+				 "(remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			num_llis = pl08x_fill_lli_for_desc
@@ -855,7 +874,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 				if (target_len != lli_len) {
 					dev_vdbg(&pl08x->adev->dev,
-					"%s can't send what we want. Desired %08x, lli of %08x bytes in txd of %08x\n",
+					"%s can't send what we want. Desired 0x%08x, lli of 0x%08x bytes in txd of 0x%08x\n",
 					__func__, target_len, lli_len, txd->len);
 				}
 
@@ -865,7 +884,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						       tsize);
 
 				dev_vdbg(&pl08x->adev->dev,
-					"%s fill lli with single lli chunk of size %08x (remainder %08x)\n",
+					"%s fill lli with single lli chunk of size 0x%08x (remainder 0x%08x)\n",
 					__func__, lli_len, remainder);
 				num_llis = pl08x_fill_lli_for_desc(pl08x, txd,
 						num_llis, lli_len, cctl,
@@ -884,7 +903,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						&& (remainder); j++) {
 					cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 					dev_vdbg(&pl08x->adev->dev,
-						"%s align with boundardy, single byte (remain %08x)\n",
+						"%s align with boundardy, single byte (remain 0x%08x)\n",
 						__func__, remainder);
 					num_llis =
 						pl08x_fill_lli_for_desc(pl08x,
@@ -969,7 +988,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 		for (i = 0; i < num_llis; i++) {
 			dev_vdbg(&pl08x->adev->dev,
-				 "lli %d @%p: csrc=%08x, cdst=%08x, cctl=%08x, clli=%08x\n",
+				 "lli %d @%p: csrc=0x%08x, cdst=0x%08x, cctl=0x%08x, clli=0x%08x\n",
 				 i,
 				 &llis_va[i],
 				 llis_va[i].src,
@@ -1278,7 +1297,7 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 
 	dev_dbg(&pl08x->adev->dev,
 		"configured channel %s (%s) for %s, data width %d, "
-		"maxburst %d words, LE, CCTL=%08x, CCFG=%08x\n",
+		"maxburst %d words, LE, CCTL=0x%08x, CCFG=0x%08x\n",
 		dma_chan_name(chan), plchan->name,
 		(config->direction == DMA_FROM_DEVICE) ? "RX" : "TX",
 		addr_width,
@@ -1630,17 +1649,19 @@ static void pl08x_tasklet(unsigned long data)
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
 	struct pl08x_driver_data *pl08x = plchan->host;
+	dma_async_tx_callback callback = NULL;
+	void *callback_param = NULL;
+	unsigned long flags;
+
 
 	if (!plchan)
 		BUG();
 
-	spin_lock(&plchan->lock);
+	spin_lock_irqsave(&plchan->lock, flags);
 
 	if (plchan->at) {
-		dma_async_tx_callback callback =
-			plchan->at->tx.callback;
-		void *callback_param =
-			plchan->at->tx.callback_param;
+		callback = plchan->at->tx.callback;
+		callback_param = plchan->at->tx.callback_param;
 
 		/*
 		 * Update last completed
@@ -1649,12 +1670,6 @@ static void pl08x_tasklet(unsigned long data)
 			(plchan->at->tx.cookie);
 
 		/*
-		 * Callback to signal completion
-		 */
-		if (callback)
-			callback(callback_param);
-
-		/*
 		 * Device callbacks should NOT clear
 		 * the current transaction on the channel
 		 * Linus: sometimes they should?
@@ -1732,7 +1747,13 @@ static void pl08x_tasklet(unsigned long data)
 		}
 	}
 
-	spin_unlock(&plchan->lock);
+	spin_unlock_irqrestore(&plchan->lock, flags);
+
+	/*
+	 * Callback to signal completion
+	 */
+	if (callback)
+		callback(callback_param);
 }
 
 static irqreturn_t pl08x_irq(int irq, void *dev)
@@ -1891,6 +1912,15 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 		seq_printf(s, "%d\t\t%s\n",
 			   ch->id, virt_chan ? virt_chan->name : "(none)");
 
+		if (virt_chan) {
+			seq_printf(s, "\t\t[%08x %08x %08x %08x %08x]\n",
+				readl(ch->base + PL080_CH_SRC_ADDR),
+				readl(ch->base + PL080_CH_DST_ADDR),
+				readl(ch->base + PL080_CH_LLI),
+				readl(ch->base + PL080_CH_CONTROL),
+				readl(ch->base + PL080_CH_CONFIG));
+		}
+
 		spin_unlock_irqrestore(&ch->lock, flags);
 	}
 
@@ -2087,7 +2117,7 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 
 	amba_set_drvdata(adev, pl08x);
 	init_pl08x_debugfs(pl08x);
-	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @%08x\n",
+	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @0x%08x\n",
 		vd->name, adev->res.start);
 	return 0;
 
