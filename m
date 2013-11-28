From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 28 Nov 2013 11:38:16 +0530
Subject: [PATCH v6 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E852497D5@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1379498279-16096-1-git-send-email-b35083@freescale.com>
 <20131114104620.GB16396@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E852409CE@039-SN1MPN1-003.039d.mgd.msft.net>
 <20131118111451.GA30853@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E852497D5@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20131128060816.GQ8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 09:38:02AM +0000, Jingchang Lu wrote:
> > > > > +* DMAMUX
> > > > > +Required properties:
> > > >
> > > > No compatible?
> > > >
> > > > Where are DMAMUX nodes expected to live?
> > > >
> > > > How to they relate to the eDMA controller in HW? Are they a
> > > > subcomponent, or a logically separate unit that happens to be
> > connected?
> > > [Lu Jingchang-b35083]
> > > DMAMUX is a multiplexer between dma controller channels and peripheral
> > deivces,
> > > each DMAMUX provides 16 independently selectable DMA channel routers,
> > and each
> > > channel router can be assigned to one of the possible peripheral DMA
> > slots.
> > > So it's not a standalone device, it's just required by the DMA
> > controller to
> > > connect the channels and slaves, So it's got by DMA controller's
> > "fsl,dma-mux" property.
> > > Thanks!
> > 
> > Ok.
> > 
> > I'm not so sure on the way this is described, from the point of view of
> > the device, its DMA channel is wired to the MUX, not to the DMA engine
> > directly:
> > 
> >                        +-------+
> >              /---------|DEVICE0|
> >              |         +-------+
> > +-----+   +------+
> > | DMA |===|DMAMUX|
> > +-----+   +------+
> >              |         +-------+
> >              \---------|DEVICE1|
> >                        +-------+
> > 
> > If that's the case, I'd expect the DMAMUX to have a #dma-cells and
> > describe each device as being wired to the mux, and then the mux as
> > being wired to the DMA. If the MUXes are sub-blocks of the DMA, then I'm
> > not sure why they need to be described at all.
> > 
> > Currently, the DMA code is handling information that's specific to the
> > MUX (i.e. the channel ID that's specific to the MUX), and that feels odd
> > unless the MUX is a component of the DMA (which if true I'd expect it to
> > be described differently).
> > 
> Yes, the connection is as your imagination, except for each DMA has two MUX. 
> The DMA helper looks the registered DMA engineer for DMA channel binding,
> and the registered DMA engineer is the eDMA node, if binding to DMAMUX,
> the helper will not find out the dma engineer.
> The only DMAMUX configuration is programming the slave id into its
> corresponding register, so its code is handled by the eDMA driver,
> the DMAMUX is not optional.
This is fairly common representation of how DMA engines interact with slave
clients via a programmable mux. Now the slave id value in this case (which we
program to mux) needs to be for the client and _not_ for the dmanegine. DMA
engine would have a register to configure the mux value required for the
transaction.

The dma engine API provides a way to program the slave id (ie mux value) and IMO
this should be a property of slave device (perhaps part of its dma resource) and
used while programming channel. Making it dma driver property makes no sense
here

--
~Vinod
