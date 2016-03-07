From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 7 Mar 2016 16:08:57 +0100
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160307145429.GG11154@localhost>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
Message-ID: <20160307160857.577bb04d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, 7 Mar 2016 20:24:29 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Mon, Mar 07, 2016 at 10:59:31AM +0100, Boris Brezillon wrote:
> > +/* Dedicated DMA parameter register layout */
> > +#define SUN4I_DDMA_PARA_DST_DATA_BLK_SIZE(n)	(((n) - 1) << 24)
> > +#define SUN4I_DDMA_PARA_DST_WAIT_CYCLES(n)	(((n) - 1) << 16)
> > +#define SUN4I_DDMA_PARA_SRC_DATA_BLK_SIZE(n)	(((n) - 1) << 8)
> > +#define SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(n)	(((n) - 1) << 0)
> > +
> > +/**
> > + * struct sun4i_dma_chan_config - DMA channel config
> > + *
> > + * @para: contains information about block size and time before checking
> > + *	  DRQ line. This is device specific and only applicable to dedicated
> > + *	  DMA channels
> 
> What information, can you elobrate.. And why can't you use existing
> dma_slave_config for this?

Block size is related to the device FIFO size. I guess it allows the
DMA channel to launch a transfer of X bytes without having to check the
DRQ line (the line telling the DMA engine it can transfer more data
to/from the device). The wait cycles information is apparently related
to the number of clks the engine should wait before polling/checking
the DRQ line status between each block transfer. I'm not sure what it
saves to put WAIT_CYCLES() to something != 1, but in their BSP,
Allwinner tweak that depending on the device.

Note that I'd be happy if the above configuration could go into the
generic dma_slave_config struct. This way we could avoid per-engine
specific APIs.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
