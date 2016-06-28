From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 28 Jun 2016 10:04:59 +0530
Subject: [PATCH 2/4] dmaengine: vdma: Add support for mulit-channel dma
 mode
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5B84A9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
 <1465549954-30220-3-git-send-email-appanad@xilinx.com>
 <20160621155502.GB16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B8248@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160621163340.GE16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B84A9@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160628043459.GR22564@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 07:04:28AM +0000, Appana Durga Kedareswara Rao wrote:
> > > >
> > > > Can you elobrate what you meant by Multichannel mode? This patch
> > > > seems to do two things, one is to add interleaved dma support and
> > > > something else. Can you explain the latter part?
> > >
> > > AXI DMA has two Stream interfaces (Memory to Stream MM2S and Stream to
> > > Memory S2MM)
> > 
> > what is a stream in this context?
> 
> Stream means I/O transfer (Memory to I/O and I/O to Memory).
> Sorry if I confused you.
> 
> > 
> > > In Multi-Channel dma mode each stream interface can be configured up to 16
> > channels.
> > > In Multi-channel DMA mode IP supports only interleaved transfers (2-D
> > transfers).
> > 
> > 
> > >
> > > >
> > > > >  /**
> > > > > + * struct xilinx_mcdma_config - DMA Multi channel configuration
> > > > > +structure
> > > > > + * @tdest: Channel to operate on
> > > > > + * @tid:   Channel configuration
> > > > > + * @tuser: Tuser configuration
> > > > > + * @ax_user: ax_user value
> > > > > + * @ax_cache: ax_cache value
> > > > > + */
> > > > > +struct xilinx_mcdma_config {
> > > > > +	u8 tdest;
> > > > > +	u8 tid;
> > > > > +	u8 tuser;
> > > > > +	u8 ax_user;
> > > > > +	u8 ax_cache;
> > > >
> > > > can you describe these in details, what do these do, what are the
> > > > values to be programmed?
> > >
> > > As said above In Multi-Channel Mode each Stream interface can be
> > > Configured up to 16 channels each channel is differentiated based on the tdest
> > and tid values.
> > 
> > Then why are you not registering 16 channels for this? That should give you
> > channel to operate on!
> 
> The number of channels are configurable.
> We are registering number of Channels that h/w configured for.
> 
> Will fix in the next version. Will remove this config.
> And based on the channel type will configure the h/w.

Looking at this you should redesign!

The vchan was designed to operate on 'virtual' channels. The hardware
channels can be independent of that.

Your IP seems to be a good fit for that approach. Do not link the two and
separate them. User can have a virtual channel. In your driver, you can
manage hardware channels...

> 
> > 
> > >
> > > tdest:
> > > TDEST provides routing information for the data stream.
> > 
> > pls elobrate
> 
> Need to configure this with the channel number that
> We would like to transfer data.

This should be internal to driver...

-- 
~Vinod
