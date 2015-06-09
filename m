From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 9 Jun 2015 11:54:58 +0200
Subject: Moan: usage of __iormb() and __iowmb() outside of asm/io.h
In-Reply-To: <20150608184701.GA7557@n2100.arm.linux.org.uk>
References: <20150608184701.GA7557@n2100.arm.linux.org.uk>
Message-ID: <20150609095458.GA972@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux | 2015-06-08 19:47:01 [+0100]:

>These are not official kernel barriers - the only reason they exist in
>asm/io.h is purely to provide a barrier implementation _for_ creating
>the accessors _in_ asm/io.h, which are macros, and therefore these
>macros need to stay around for the same scope as those accessors.

I'm sorry for that. Are those _relaxed() accessors okay? They don't show
up in Documentation/ so I ask here before I do it wrong again?

On the other hand if Tony or someone else things that this is not worth
it at all I could stick with readl/writel and drop the barries. It is
just that musb and releated code used those __raw accessors and I ended
up with them, too (I'm not looking for an excuse just saying that I do
not have any numbers to show which say that this is good in terms of
performance and worth keeping).

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -257,12 +257,12 @@ static struct cppi41_channel *desc_to_chan(struct cppi41_dd *cdd, u32 desc)
 
 static void cppi_writel(u32 val, void *__iomem *mem)
 {
-	__raw_writel(val, mem);
+	writel_relaxed(val, mem);
 }
 
 static u32 cppi_readl(void *__iomem *mem)
 {
-	return __raw_readl(mem);
+	return readl_relaxed(mem);
 }
 
 static u32 pd_trans_len(u32 val)
@@ -308,7 +308,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 		}
 
 		if (val)
-			__iormb();
+			rmb();
 
 		while (val) {
 			u32 desc, len;
@@ -410,14 +410,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		reg |= c->q_comp_num;
 	}
 
-	cppi_writel(reg, c->gcr_reg);
-
-	/*
-	 * We don't use writel() but __raw_writel() so we have to make sure
-	 * that the DMA descriptor in coherent memory made to the main memory
-	 * before starting the dma engine.
-	 */
-	__iowmb();
+	writel(reg, c->gcr_reg);
 	push_desc_queue(c);
 }
 
@@ -546,7 +539,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 
 	if (!c->td_queued) {
 		cppi41_compute_td_desc(td);
-		__iowmb();
+		wmb();
 
 		reg = (sizeof(struct cppi41_desc) - 24) / 4;
 		reg |= td_desc_phys;
@@ -577,7 +570,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 		} else if (desc_phys == td_desc_phys) {
 			u32 pd0;
 
-			__iormb();
+			rmb();
 			pd0 = td->pd0;
 			WARN_ON((pd0 >> DESC_TYPE) != DESC_TYPE_TEARD);
 			WARN_ON(!c->is_tx && !(pd0 & TD_DESC_IS_RX));
