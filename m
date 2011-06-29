From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Jun 2011 22:00:39 +0800
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC controller
	driver
In-Reply-To: <20110629122942.GH1992@pengutronix.de>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110629100658.GE1992@pengutronix.de>
	<20110629103337.GF1992@pengutronix.de>
	<4E0B0296.6060902@freescale.com>
	<20110629122942.GH1992@pengutronix.de>
Message-ID: <20110629140038.GB25931@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 02:29:42PM +0200, Wolfram Sang wrote:
> 
> > > Still, the problem exists: When a second channel GPMI channel is
> > > requested, dmaengine will return -EBUSY, because the DMAIRQ is already
> > > taken.
> > >
> > Yes, we should change the DMA code, it is a DMA bug.
> > I ever submitted a patch about the issue:
> > http://patchwork.ozlabs.org/patch/87145/
> 
> That approach was rejected because it would register the same handler
> n-times where one time would do. Your other approach puts too much
> mach-specific details into the driver IMO and probably won't scale very
> well. Maybe we should add something to the private dma_data (like flags
> indicating SHARED) and then do some refcounting?
> 
I would suggest leave this gpmi specific quirk to gpmi driver to sort
out.  With the following mxs-dma change, it should work if gpmi driver
can pass the valid gpmi irq number for only one gpmi channel, and -1
for all others.

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..ea27002 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -327,10 +327,12 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)

        memset(mxs_chan->ccw, 0, PAGE_SIZE);

-       ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
-                               0, "mxs-dma", mxs_dma);
-       if (ret)
-               goto err_irq;
+       if (mxs_chan->chan_irq >= 0) {
+               ret = request_irq(mxs_chan->chan_irq, mxs_dma_int_handler,
+                                       0, "mxs-dma", mxs_dma);
+               if (ret)
+                       goto err_irq;
+       }

        ret = clk_enable(mxs_dma->clk);
        if (ret)

-- 
Regards,
Shawn
