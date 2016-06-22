From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 22 Jun 2016 07:04:28 +0000
Subject: [PATCH 2/4] dmaengine: vdma: Add support for mulit-channel dma
 mode
In-Reply-To: <20160621163340.GE16910@localhost>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
 <1465549954-30220-3-git-send-email-appanad@xilinx.com>
 <20160621155502.GB16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B8248@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160621163340.GE16910@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5B84A9@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> 
> On Tue, Jun 21, 2016 at 04:02:05PM +0000, Appana Durga Kedareswara Rao
> wrote:
> > Hi Vinod,
> >
> > 	Thanks for the review...
> >
> > >
> > > On Fri, Jun 10, 2016 at 02:42:32PM +0530, Kedareswara rao Appana wrote:
> > > > This patch adds support for AXI DMA multi-channel dma mode
> > > > Multichannel mode enables DMA to connect to multiple masters And
> > > > slaves on the streaming side.
> > > > In Multichannel mode AXI DMA supports 2D transfers.
> > >
> > > Funny formatting!
> >
> > Will fix in next version...
> >
> > >
> > > Can you elobrate what you meant by Multichannel mode? This patch
> > > seems to do two things, one is to add interleaved dma support and
> > > something else. Can you explain the latter part?
> >
> > AXI DMA has two Stream interfaces (Memory to Stream MM2S and Stream to
> > Memory S2MM)
> 
> what is a stream in this context?

Stream means I/O transfer (Memory to I/O and I/O to Memory).
Sorry if I confused you.

> 
> > In Multi-Channel dma mode each stream interface can be configured up to 16
> channels.
> > In Multi-channel DMA mode IP supports only interleaved transfers (2-D
> transfers).
> 
> 
> >
> > >
> > > >  /**
> > > > + * struct xilinx_mcdma_config - DMA Multi channel configuration
> > > > +structure
> > > > + * @tdest: Channel to operate on
> > > > + * @tid:   Channel configuration
> > > > + * @tuser: Tuser configuration
> > > > + * @ax_user: ax_user value
> > > > + * @ax_cache: ax_cache value
> > > > + */
> > > > +struct xilinx_mcdma_config {
> > > > +	u8 tdest;
> > > > +	u8 tid;
> > > > +	u8 tuser;
> > > > +	u8 ax_user;
> > > > +	u8 ax_cache;
> > >
> > > can you describe these in details, what do these do, what are the
> > > values to be programmed?
> >
> > As said above In Multi-Channel Mode each Stream interface can be
> > Configured up to 16 channels each channel is differentiated based on the tdest
> and tid values.
> 
> Then why are you not registering 16 channels for this? That should give you
> channel to operate on!

The number of channels are configurable.
We are registering number of Channels that h/w configured for.

Will fix in the next version. Will remove this config.
And based on the channel type will configure the h/w.

> 
> >
> > tdest:
> > TDEST provides routing information for the data stream.
> 
> pls elobrate

Need to configure this with the channel number that
We would like to transfer data.

> 
> > TDEST values are static for the entire packet.
> 
> what do these mean

We shouldn't modify this value when a transfer is going on...
Providing it in the config option user may not aware of all this possibilities.
Will remove this config and will handle this in the driver itself.

> 
> >
> > tid:
> > Provides a stream identifier. TID values are static for entire packet.
> > TID values provided in the TX descriptor field are presented on TID
> > signals of the streaming side.
> 
> what is this used for?

Currently I am not using this parameter will remove this config.
But usually it is used as a packet identifier.

> 
> >
> > tuser:
> > Sideband signals used for user-defined information.
> > TUSER values are static for entire packet. TUSER values provided in
> > the TX Descriptor field are presented on TUSER signals of streaming side.
> 
> what is this used for?

Used for user-defined information.
Currently I am not using it will remove this in the next version...

> 
> >
> > ax_user:
> > Sideband signals used for user-defined information ARUSER values and
> > their interpretations are user-defined
> 
> How is it used by client?

Currently I am not using it will remove this in the next version...

> 
> >
> > ax_cache:
> > Cache type this signal provides additional information about the
> > cacheable Characteristics of the transfer.
> 
> and what are those...

It is a 4-bit filed.
Bit 0: Bufferable
Bit 1: Modifiable
Bit 2: Non-cacheable
Bit 3: Normal

Currently I am not using it will remove this in the next version...

> 
> >
> > In the above parameters tdest and tid are mandatory to differentiate
> > b/w different channels Other parameters are optional please let me
> > know if you don't want me to Include other optional parameters will remove in
> the next version.
> 
> dmaengine provides channel as an argument so it is quite odd that you need to
> differentiate b/w different channels. This only makes me worry that things are
> not standard and fishy

Will fix in the next version will handle
Based on the channel type only.

Regards,
Kedar.

> 
> --
> ~Vinod
