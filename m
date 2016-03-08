From: plaes@plaes.org (Priit Laes)
Date: Tue, 08 Mar 2016 11:10:50 +0200
Subject: [linux-sunxi] Re: [PATCH] dma: sun4i: expose block size and
 wait cycle configuration to DMA users
In-Reply-To: <20160308094625.539646f8@bbrezillon>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost> <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160308075131.GE8418@lukather> <20160308094625.539646f8@bbrezillon>
Message-ID: <1457428250.29321.7.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-08 at 09:46 +0100, Boris Brezillon wrote:
> On Tue, 8 Mar 2016 08:51:31 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Tue, Mar 08, 2016 at 08:25:47AM +0530, Vinod Koul wrote:
> > > On Mon, Mar 07, 2016 at 09:30:24PM +0100, Maxime Ripard wrote:
> > > > On Mon, Mar 07, 2016 at 04:08:57PM +0100, Boris Brezillon
> > > > wrote:
> > > > > Hi Vinod,
> > > > > 
> > > > > On Mon, 7 Mar 2016 20:24:29 +0530
> > > > > Vinod Koul <vinod.koul@intel.com> wrote:
> > > > > 
> > > > > > On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon
> > > > > > wrote:
> > > > > > > +/* Dedicated DMA parameter register layout */
> > > > > > > +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n
> > > > > > > ) - 1) << 24)
> > > > > > > +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) 
> > > > > > > - 1) << 16)
> > > > > > > +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n
> > > > > > > ) - 1) << 8)
> > > > > > > +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) 
> > > > > > > - 1) << 0)
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct sun4i_dma_chan_config - DMA channel config
> > > > > > > + *
> > > > > > > + * @para: contains information about block size and time
> > > > > > > before checking
> > > > > > > + *	  DRQ line. This is device specific and only
> > > > > > > applicable to dedicated
> > > > > > > + *	  DMA channels
> > > > > > 
> > > > > > What information, can you elobrate.. And why can't you use
> > > > > > existing
> > > > > > dma_slave_config for this?
> > > > > 
> > > > > Block size is related to the device FIFO size. I guess it
> > > > > allows the
> > > > > DMA channel to launch a transfer of X bytes without having to
> > > > > check the
> > > > > DRQ line (the line telling the DMA engine it can transfer
> > > > > more data
> > > > > to/from the device). The wait cycles information is
> > > > > apparently related
> > > > > to the number of clks the engine should wait before
> > > > > polling/checking
> > > > > the DRQ line status between each block transfer. I'm not sure
> > > > > what it
> > > > > saves to put WAIT_CYCLES() to something != 1, but in their
> > > > > BSP,
> > > > > Allwinner tweak that depending on the device.
> > > 
> > > we already have block size aka src/dst_maxburst, why not use that
> > > one.
> > 
> > I'm not sure it's really the same thing. The DMA controller also
> > has a
> > burst parameter, that is either 1 byte or 8 bytes, and ends up
> > being
> > different from this one.
> 
> Well, that's what I understood to, but when reading more carefully
> the
> src/dst_maxburst description, it seems to match the block_size
> concept
> exposed by the sun4i dmaengine. But how should we choose the real
> burst
> size then.
> IIRC, in most documentation/datasheets, burst size is referred as the
> maximum number of words (word size depends on the selected width) a
> master is allowed to transfer to a slave through the bus without
> being interrupted by other master requests.
> Am I correct?
> 
> > 
> > > Why does dmaengine need to wait? Can you explain that
> > 
> > We have no idea, we thought you might have one :)
> 
> Yes, it's really unclear to us why this is needed. There might be
> some
> kind of contention, or maybe the slave device takes some time to put
> DRQ line to low state, and without these wait_cycles the dmaengine
> would assume some data are still available in the FIFO while there's
> actually no more data to retrieve.
> 
> > 
> > It doesn't really makes sense to us, but it does have a significant
> > impact on the throughput.
> 
> I wouldn't say significant impact, but tweaking those parameters has
> some impact on the performances, and since it's not that complicated
> to
> implement, I thought it was worth a try, but maybe I'm wrong.

Somewhat offtopic, but there was also another patchset a while ago for
sun4i SPI that removed the 64 byte limit for SPI transfers (although
this was DMA-less case) back then.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241392
.html

(This patchset made it possible to use SPI-based small TFT displays via
fbtft, when I tested it some time ago).

As it currently stands, sun4i SPI is not using DMA and transfers are
limited to 64 bytes.

P?ikest,
Priit ;)
