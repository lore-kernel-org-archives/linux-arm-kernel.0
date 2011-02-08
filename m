From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 16:38:13 +0000
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110208225635.GA6748@S2100-06.ap.freescale.net>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<20110204181749.GB8732@n2100.arm.linux.org.uk>
	<20110208225635.GA6748@S2100-06.ap.freescale.net>
Message-ID: <20110208163813.GC27521@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 06:56:36AM +0800, Shawn Guo wrote:
> Hi Russell,
> 
> Thanks for the review and comments.
> 
> Hi Sascha,
> 
> Some of the comments here also apply on imx-sdma, as mxs-dma closely
> followed imx-sdma implementation.  It's appreciated if you can give 
> some responses to the comments.
> 
> On Fri, Feb 04, 2011 at 06:17:49PM +0000, Russell King - ARM Linux wrote:
> > Callbacks are supposed to happen from tasklet context, not irq context.
> > 
> 
> Here is callback copied from mxs-mmc driver.  I expect other mxs-dma
> client driver's callbacks are as simple as this one.
> 
> static void mxs_mmc_dma_irq_callback(void *param)
> {
> 	struct mxs_mmc_host *host = param;
> 
> 	host->status = __raw_readl(host->base + HW_SSP_STATUS);
> 	complete(&host->done);
> }
> 
> Is a simple callback also required be in tasklet context anyhow?

It is part of the DMA engine API specification.  It may not matter
for stuff which currently exists, but how do you know that in the
future you won't be re-using existing drivers which do other stuff
in callbacks and do assume that they're correctly called as per the
DMA engine API?

If you're not going to implement your driver to the DMA engine API
specification, there's no point implementing something which looks
like a DMA engine API but isn't.
