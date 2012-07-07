From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Jul 2012 08:55:15 +0000
Subject: [PATCH 2/2] irda/pxa:
In-Reply-To: <201207070848.30706.arnd@arndb.de>
References: <201207070848.30706.arnd@arndb.de>
Message-ID: <201207070855.15431.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After c00184f9ab4 "ARM: sa11x0/pxa: convert OS timer registers to IOMEM",
magician_defconfig and a few others fail to build because the OSCR
register is accessed by the drivers/net/irda/pxaficp_ir.c but has turned
into a pointer that needs to be read using readl.

There are other registers in the same driver that eventually should
be converted, and it's unclear whether we would want a better interface
to access the OSCR from a device driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This patch should be applied to Russell's ARM tree which contains the
patch that broke it, Cc to netdev for information and Acks.

diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index ff16daf..8d54767 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -289,7 +289,7 @@ static irqreturn_t pxa_irda_sir_irq(int irq, void *dev_id)
 			}
 			lsr = STLSR;
 		}
-		si->last_oscr = OSCR;
+		si->last_oscr = readl_relaxed(OSCR);
 		break;
 
 	case 0x04: /* Received Data Available */
@@ -300,7 +300,7 @@ static irqreturn_t pxa_irda_sir_irq(int irq, void *dev_id)
 		    dev->stats.rx_bytes++;
 	            async_unwrap_char(dev, &dev->stats, &si->rx_buff, STRBR);
 	  	} while (STLSR & LSR_DR);
-		si->last_oscr = OSCR;
+		si->last_oscr = readl_relaxed(OSCR);
 	  	break;
 
 	case 0x02: /* Transmit FIFO Data Request */
@@ -316,7 +316,7 @@ static irqreturn_t pxa_irda_sir_irq(int irq, void *dev_id)
                         /* We need to ensure that the transmitter has finished. */
 			while ((STLSR & LSR_TEMT) == 0)
 				cpu_relax();
-			si->last_oscr = OSCR;
+			si->last_oscr = readl_relaxed(OSCR);
 
 			/*
 		 	* Ok, we've finished transmitting.  Now enable
@@ -370,7 +370,7 @@ static void pxa_irda_fir_dma_tx_irq(int channel, void *data)
 
 	while (ICSR1 & ICSR1_TBY)
 		cpu_relax();
-	si->last_oscr = OSCR;
+	si->last_oscr = readl_relaxed(OSCR);
 
 	/*
 	 * HACK: It looks like the TBY bit is dropped too soon.
@@ -470,7 +470,7 @@ static irqreturn_t pxa_irda_fir_irq(int irq, void *dev_id)
 
 	/* stop RX DMA */
 	DCSR(si->rxdma) &= ~DCSR_RUN;
-	si->last_oscr = OSCR;
+	si->last_oscr = readl_relaxed(OSCR);
 	icsr0 = ICSR0;
 
 	if (icsr0 & (ICSR0_FRE | ICSR0_RAB)) {
@@ -546,7 +546,7 @@ static int pxa_irda_hard_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_copy_from_linear_data(skb, si->dma_tx_buff, skb->len);
 
 		if (mtt)
-			while ((unsigned)(OSCR - si->last_oscr)/4 < mtt)
+			while ((unsigned)(readl_relaxed(OSCR) - si->last_oscr)/4 < mtt)
 				cpu_relax();
 
 		/* stop RX DMA,  disable FICP */
