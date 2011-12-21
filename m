From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Dec 2011 12:45:18 +0800
Subject: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
In-Reply-To: <1324440424.1641.10104.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1324373044.1641.10096.camel@vkoul-udesk3>
 <20111220125401.GA5129@S2101-09.ap.freescale.net>
 <1324440424.1641.10104.camel@vkoul-udesk3>
Message-ID: <20111221044517.GD5983@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 09:37:04AM +0530, Vinod Koul wrote:
> On Tue, 2011-12-20 at 20:54 +0800, Shawn Guo wrote:
> > On Tue, Dec 20, 2011 at 02:54:04PM +0530, Vinod Koul wrote:
> > > On Tue, 2011-12-13 at 23:48 +0800, Shawn Guo wrote:
> > > > I have been working on -rc recently, and have not noticed the failure
> > > > until I ran next tree today.  The mxs-mmc driver is broken on next
> > > > tree because the DMA_NONE was left over from the dma_transfer_direction
> > > > migration for mxs-dma and its client drivers.
> > > > 
> > > For DMA transfer, the NONE direction makes no sense?
> > > 
> > > In your conetext, what are you trying to achieve?
> > > 
> > The mxs-dma controller has a feature to program peripheral registers
> > with given values (mxs-dma PIO mode).  This is designed to pipeline
> > the operations.  For example, we can put mxs-mmc controller register
> > values into scatter list as one element together with actual data.
> > Triggering the mxs-dma, the dma will program the values into mxs-mmc
> > controller register to set up and enable mxs-mmc, and then dma
> > continue transfer data from/to mxs-mmc.  All these get done in one
> > dmaengine_submit().
> > 
> > And DMA_NONE was used to let mxs-dma know this is a PIO operation.
> Sorry am little lost here. Why would DMA driver bother with a PIO mode,
> that is something only peripheral driver would know about, mmc in your
> case.
> 
The term PIO here may not the one on your mind.  I call it 'mxs-dma
pio'.  In this mode, mxs-dma hardware can write values into mmc
controller register without cpu involved.

> So what you are saying is the your dma has the capability to program the
> peripheral registers in case of PIO mode, but why wouldn't the
> peripheral driver do that instead? 
> 
Yes, I'm saying mxs-dma has the capability to program the peripheral
registers, and that's called 'mxs-dma pio' mode.

-- 
Regards,
Shawn
