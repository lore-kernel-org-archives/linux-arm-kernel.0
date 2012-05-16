From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2012 14:17:20 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <4FB3A5E7.7060505@antcom.de>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <4FB39C62.3030305@antcom.de> <20120516125253.GD9571@n2100.arm.linux.org.uk>
 <4FB3A5E7.7060505@antcom.de>
Message-ID: <20120516131720.GE9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:04:39PM +0200, Roland Stigge wrote:
> On 05/16/2012 02:52 PM, Russell King - ARM Linux wrote:
> >> * SLC driver says:
> >>
> >> lpc32xx-nand 20020000.flash: FIFO not empty!
> >> lpc32xx-nand 20020000.flash: FIFO held data too long
> >> lpc32xx-nand 20020000.flash: DMA FIFO failure
> >>
> >> Any hints, before I find the time to sort out all the details with
> >> amba-pl08x?
> > 
> > Nothing jumps out; it would be useful if you could bisect the small
> > series - I did the conversion in small steps so it should be easy to
> > track down.  And it shouldn't take too long to rebuild between each
> > iteration.  Whatever it is, it's probably going to be a stupid mistake
> > somewhere.
> 
> The problem first appears with patch #4.

I said it would be something silly...

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 940f762..e62dd87 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1415,7 +1415,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	cctl |= pl08x_select_bus(src_buses, dst_buses);
+	txd->cctl = cctl | pl08x_select_bus(src_buses, dst_buses);
 
 	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
@@ -1424,7 +1424,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER :
 			PL080_FLOW_PER2MEM;
 
-	txd->ccfg = cctl | (tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT);
+	txd->ccfg |= tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 
 	for_each_sg(sgl, sg, sg_len, tmp) {
 		dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
