From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Feb 2011 10:44:09 +0800
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <201102161659.18475.arnd@arndb.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<20110215172948.GE10770@pengutronix.de>
	<20110216202818.GA11467@S2100-06.ap.freescale.net>
	<201102161659.18475.arnd@arndb.de>
Message-ID: <20110217024408.GA1273@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Feb 16, 2011 at 04:59:18PM +0100, Arnd Bergmann wrote:
> On Wednesday 16 February 2011, Shawn Guo wrote:
> > It's caused by spinlock recursion introduced by mxs-dma functions
> > mxs_dma_tx_submit and mxs_dma_tasklet.  We have mmc_request_done
> > invoked in the dma callback tasklet.  At the meantime,
> > mmc_request_done will issue retries in some case, which will call in
> > mxs_dma_tx_submit.
> > 
> > I added the lock by referring to other dma driver implementation, but
> > now I'm considering to remove the lock completely, as I do not see
> > any global data needs to be protected there.  Comments?
> 
> You need to be sure that the data accessed in the tasklet does not
> need to be locked against mxs_dma_tx_submit.
> 
The only thing we actually put in tasklet is just the callback
registered by client device driver, which should not have anything
that mxs_dma_tx_submit would concern.

> I haven't looked at the dmaengine code for this, but it's quite likely
> that you actually need it, because you need to serialize adding an
> element to the DMA device with removing it again.
> 
I'm not sure that I understand your comment. If the adding/removing
an element means what mxs_dma_alloc_chan_resources and 
mxs_dma_free_chan_resources do, I do not think it's a problem, as
client driver is calling them in probe/remove for once.

-- 
Regards,
Shawn
