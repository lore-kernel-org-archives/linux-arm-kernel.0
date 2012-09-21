From: mporter@ti.com (Matt Porter)
Date: Fri, 21 Sep 2012 14:54:05 -0400
Subject: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the EDMA
 DMAC
In-Reply-To: <20120921171840.GB10409@arwen.pp.htv.fi>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-9-git-send-email-mporter@ti.com>
 <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
 <CANfBPZ-h7MD4X_NRYfwOmMnEyOKy0bTNNLNRmdbef2pe=2aHyg@mail.gmail.com>
 <20120921171840.GB10409@arwen.pp.htv.fi>
Message-ID: <20120921185405.GK16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 08:18:41PM +0300, Felipe Balbi wrote:
> On Fri, Sep 21, 2012 at 10:47:30PM +0530, S, Venkatraman wrote:
> > On Fri, Sep 21, 2012 at 10:45 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> > > On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter@ti.com> wrote:
> > >> The EDMA DMAC has a hardware limitation that prevents supporting
> > >> scatter gather lists with any number of segments. Since the EDMA
> > >> DMA Engine driver sets the maximum segments to 16, we do the
> > >> same.
> > >>
> > >> Note: this can be removed once the DMA Engine API supports an
> > >> API to query the DMAC's segment limitations.
> > >>
> > >
> > > I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
> > > suggests. Why don't we have a max_segs property, which when explicitly specified
> > > in DT, will override the default ?
> > 
> > If you are adventurous, this can be a generic mmc DT binding instead
> > of restricting it to OMAP.
> 
> I say if it's a limitation in the DMAC, then DMAC's driver should handle
> it, no ? Meaning that in this case you would copy from one multi-segment
> sg into a one-segment sg and when transfer is complete, before calling
> user's callback, copy data the other way around (?)

With this DMAC, we would have to do a CPU-based copy or a series of
smaller DMA-based 16 segment copies with completion interrupts in between.

The reason the EDMA DMA Engine driver sets this limit is that we have
a hardware limitation preventing setting up a large multi-segment
transfer. The limitation is set by how many EDMA PaRaM slots are
available (varies based on how the hwmod is instantiated) but on AM335x
it's 256. You can't use all of those for just one slave device and so
the EDMA dmaengine driver arbitrarily hardcodes (atm) 16 as the max
any one channel can claim.  Even if you could use all of them, it's
common for an unrestricted scatter gather transfer to exceed even our
best case hardware limitation.

This is a case where asking the DMA Engine driver to handle any length
SG is going to result in a big peformance hit, since the MMC subsystem
provides this hook for a reason, we just need the proper DMA Engine API
to find out how to set it.

So I guess I'm going to need to write up an API proposal unless Vinod
has already been thinking about this...

-Matt
