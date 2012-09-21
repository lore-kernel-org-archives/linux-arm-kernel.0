From: mporter@ti.com (Matt Porter)
Date: Fri, 21 Sep 2012 14:42:56 -0400
Subject: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the EDMA
 DMAC
In-Reply-To: <CANfBPZ-h7MD4X_NRYfwOmMnEyOKy0bTNNLNRmdbef2pe=2aHyg@mail.gmail.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-9-git-send-email-mporter@ti.com>
 <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
 <CANfBPZ-h7MD4X_NRYfwOmMnEyOKy0bTNNLNRmdbef2pe=2aHyg@mail.gmail.com>
Message-ID: <20120921184256.GJ16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:47:30PM +0530, S, Venkatraman wrote:
> On Fri, Sep 21, 2012 at 10:45 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> > On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter@ti.com> wrote:
> >> The EDMA DMAC has a hardware limitation that prevents supporting
> >> scatter gather lists with any number of segments. Since the EDMA
> >> DMA Engine driver sets the maximum segments to 16, we do the
> >> same.
> >>
> >> Note: this can be removed once the DMA Engine API supports an
> >> API to query the DMAC's segment limitations.
> >>
> >
> > I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
> > suggests. Why don't we have a max_segs property, which when explicitly specified
> > in DT, will override the default ?
> 
> If you are adventurous, this can be a generic mmc DT binding instead
> of restricting it to OMAP.

I think it's bad practice to add something to a binding that is not part
of the hardware definition for the device. In this case, the limitations
comes strictly from the DMAC. As I noted, the proper fix for this is to
have the DMA Engine API extended to allow querying the DMAC SG
capabilities before setting up a DMA transfer. I brought this up
previously in the thread where the actual EDMA dmaengine wrapper driver
was discussed and Vinod indicated that he was open to dmaengine
providing this information.

It makes sense as DMA Engine should tell the slave driver everything it
needs to know to set up a transfer...this is just a missing piece right
now. FWIW, we have this issue in davinci_mmc.c as well...it just was
already hardcoded with a value to satisfy the EDMA DMAC. However, I'd
like to see that go away as well.

-Matt
