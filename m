From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Mar 2016 08:25:47 +0530
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160307203024.GD8418@lukather>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather>
Message-ID: <20160308025547.GI11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 09:30:24PM +0100, Maxime Ripard wrote:
> On Mon, Mar 07, 2016 at 04:08:57PM +0100, Boris Brezillon wrote:
> > Hi Vinod,
> > 
> > On Mon, 7 Mar 2016 20:24:29 +0530
> > Vinod Koul <vinod.koul@intel.com> wrote:
> > 
> > > On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon wrote:
> > > > +/* Dedicated DMA parameter register layout */
> > > > +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) << 24)
> > > > +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
> > > > +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
> > > > +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
> > > > +
> > > > +/**
> > > > + * struct sun4i_dma_chan_config - DMA channel config
> > > > + *
> > > > + * @para: contains information about block size and time before checking
> > > > + *	  DRQ line. This is device specific and only applicable to dedicated
> > > > + *	  DMA channels
> > > 
> > > What information, can you elobrate.. And why can't you use existing
> > > dma_slave_config for this?
> > 
> > Block size is related to the device FIFO size. I guess it allows the
> > DMA channel to launch a transfer of X bytes without having to check the
> > DRQ line (the line telling the DMA engine it can transfer more data
> > to/from the device). The wait cycles information is apparently related
> > to the number of clks the engine should wait before polling/checking
> > the DRQ line status between each block transfer. I'm not sure what it
> > saves to put WAIT_CYCLES() to something != 1, but in their BSP,
> > Allwinner tweak that depending on the device.

we already have block size aka src/dst_maxburst, why not use that one.

Why does dmaengine need to wait? Can you explain that

> > Note that I'd be happy if the above configuration could go into the
> > generic dma_slave_config struct. This way we could avoid per-engine
> > specific APIs.
> 
> And I'd really like to avoid that too. That will avoid to cripple the
> consumer drivers that might be using any of the two.

If it is fairly genric property we should add, otherwise yes we don't want
that

-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/de257100/attachment-0001.sig>
