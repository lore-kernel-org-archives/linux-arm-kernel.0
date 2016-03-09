From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 9 Mar 2016 11:14:34 +0100
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160308025547.GI11154@localhost>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
Message-ID: <20160309111434.521c5ec2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Mar 2016 08:25:47 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Mon, Mar 07, 2016 at 09:30:24PM +0100, Maxime Ripard wrote:
> > On Mon, Mar 07, 2016 at 04:08:57PM +0100, Boris Brezillon wrote:
> > > Hi Vinod,
> > > 
> > > On Mon, 7 Mar 2016 20:24:29 +0530
> > > Vinod Koul <vinod.koul@intel.com> wrote:
> > > 
> > > > On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon wrote:
> > > > > +/* Dedicated DMA parameter register layout */
> > > > > +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) << 24)
> > > > > +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
> > > > > +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
> > > > > +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
> > > > > +
> > > > > +/**
> > > > > + * struct sun4i_dma_chan_config - DMA channel config
> > > > > + *
> > > > > + * @para: contains information about block size and time before checking
> > > > > + *	  DRQ line. This is device specific and only applicable to dedicated
> > > > > + *	  DMA channels
> > > > 
> > > > What information, can you elobrate.. And why can't you use existing
> > > > dma_slave_config for this?
> > > 
> > > Block size is related to the device FIFO size. I guess it allows the
> > > DMA channel to launch a transfer of X bytes without having to check the
> > > DRQ line (the line telling the DMA engine it can transfer more data
> > > to/from the device). The wait cycles information is apparently related
> > > to the number of clks the engine should wait before polling/checking
> > > the DRQ line status between each block transfer. I'm not sure what it
> > > saves to put WAIT_CYCLES() to something != 1, but in their BSP,
> > > Allwinner tweak that depending on the device.
> 
> we already have block size aka src/dst_maxburst, why not use that one.

Okay, but then remains the question "how should we choose the real burst
size?". The block size described in Allwinner datasheet is not the
number of words you will transmit without being preempted by other
master -> slave requests, it's the number of bytes that can be
transmitted without checking the DRQ line.
IOW, block_size = burst_size * X


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
