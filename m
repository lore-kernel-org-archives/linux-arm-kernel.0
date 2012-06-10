From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jun 2012 11:03:53 +0100
Subject: [CFT 05/31] dmaengine: PL08x: clean up get_signal/put_signal
In-Reply-To: <E1ScaFP-0003kA-9Y@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
 <E1ScaFP-0003kA-9Y@rmk-PC.arm.linux.org.uk>
Message-ID: <20120610100353.GB11404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 11:47:23AM +0100, Russell King wrote:
> Try to avoid dereferencing the DMA engine's channel struct in these
> platform helpers; instead, pass a pointer to the channel data into
> get_signal(), and the returned signal number to put_signal().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The Spear stuff breaks as a result of this patch, so it needs the patch
below combined with this one to prevent that breakage occuring.

diff --git a/arch/arm/plat-spear/include/plat/pl080.h b/arch/arm/plat-spear/include/plat/pl080.h
index e14a3e4..1786eeb 100644
--- a/arch/arm/plat-spear/include/plat/pl080.h
+++ b/arch/arm/plat-spear/include/plat/pl080.h
@@ -14,8 +14,8 @@
 #ifndef __PLAT_PL080_H
 #define __PLAT_PL080_H
 
-struct pl08x_dma_chan;
-int pl080_get_signal(struct pl08x_dma_chan *ch);
-void pl080_put_signal(struct pl08x_dma_chan *ch);
+struct pl08x_channel_data;
+int pl080_get_signal(const struct pl08x_channel_data *cd);
+void pl080_put_signal(const struct pl08x_channel_data *cd, int signal);
 
 #endif /* __PLAT_PL080_H */
diff --git a/arch/arm/plat-spear/pl080.c b/arch/arm/plat-spear/pl080.c
index a56a067..08bec1a 100644
--- a/arch/arm/plat-spear/pl080.c
+++ b/arch/arm/plat-spear/pl080.c
@@ -27,9 +27,8 @@ struct {
 	unsigned char val;
 } signals[16] = {{0, 0}, };
 
-int pl080_get_signal(struct pl08x_dma_chan *ch)
+int pl080_get_signal(const struct pl08x_channel_data *cd)
 {
-	const struct pl08x_channel_data *cd = ch->cd;
 	unsigned int signal = cd->min_signal, val;
 	unsigned long flags;
 
@@ -63,18 +62,17 @@ int pl080_get_signal(struct pl08x_dma_chan *ch)
 	return signal;
 }
 
-void pl080_put_signal(struct pl08x_dma_chan *ch)
+void pl080_put_signal(const struct pl08x_channel_data *cd, int signal)
 {
-	const struct pl08x_channel_data *cd = ch->cd;
 	unsigned long flags;
 
 	spin_lock_irqsave(&lock, flags);
 
 	/* if signal is not used */
-	if (!signals[cd->min_signal].busy)
+	if (!signals[signal].busy)
 		BUG();
 
-	signals[cd->min_signal].busy--;
+	signals[signal].busy--;
 
 	spin_unlock_irqrestore(&lock, flags);
 }
