From: mzoran@crowfest.net (Michael Zoran)
Date: Mon, 31 Oct 2016 12:57:32 -0700
Subject: [PATCH] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <1477943593.30971.3.camel@crowfest.net>
References: <20161028171159.23973-1-mzoran@crowfest.net>
 <87twbsqsb4.fsf@eliezer.anholt.net> <1477939258.30971.1.camel@crowfest.net>
 <1477943593.30971.3.camel@crowfest.net>
Message-ID: <1477943852.30971.5.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-31 at 12:53 -0700, Michael Zoran wrote:
> On Mon, 2016-10-31 at 11:40 -0700, Michael Zoran wrote:
> > On Mon, 2016-10-31 at 11:36 -0700, Eric Anholt wrote:
> > > Michael Zoran <mzoran@crowfest.net> writes:
> > > 
> > > > Setting the DMA mask is optional on 32 bit but
> > > > is mandatory on 64 bit.??Set the DMA mask and coherent
> > > > to force all DMA to be in the 32 bit address space.
> > > > 
> > > > This is considered a "good practice" and most drivers
> > > > already do this.
> > > > 
> > > > Signed-off-by: Michael Zoran <mzoran@crowfest.net>
> > > > ---
> > > > ?.../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> > > > |
> > > > 10 ++++++++++
> > > > ?1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git
> > > > a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_
> > > > ar
> > > > m.
> > > > c
> > > > b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_
> > > > ar
> > > > m.
> > > > c
> > > > index a5afcc5..6fa2b5a 100644
> > > > ---
> > > > a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_
> > > > ar
> > > > m.
> > > > c
> > > > +++
> > > > b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_
> > > > ar
> > > > m.
> > > > c
> > > > @@ -97,6 +97,16 @@ int vchiq_platform_init(struct
> > > > platform_device
> > > > *pdev, VCHIQ_STATE_T *state)
> > > > ?	int slot_mem_size, frag_mem_size;
> > > > ?	int err, irq, i;
> > > > ?
> > > > +	/*
> > > > +	?* Setting the DMA mask is necessary in the 64 bit
> > > > environment.
> > > > +	?* It isn't necessary in a 32 bit environment but is
> > > > considered
> > > > +	?* a good practice.
> > > > +	?*/
> > > > +	err = dma_set_mask_and_coherent(dev,
> > > > DMA_BIT_MASK(32));
> > > 
> > > I think a better comment here would be simply:
> > > 
> > > /* VCHI messages between the CPU and firmware use 32-bit bus
> > > addresses. */
> > > 
> > > explaining why the value is chosen (once you know that the 32 bit
> > > restriction exists, reporting it is obviously needed).??I'm
> > > curious,
> > > though: what failed when you didn't set it?
> > > 
> > 
> > The comment is easy to change.
> > 
> > I don't have the log available ATM, but if I remember the DMA API's
> > bugcheck the first time that are used.??
> > 
> > I think this was a policy decision or something because the
> > information
> > should be available in the dma-ranges.
> > 
> > If it's important, I can setup a test again without the change and
> > e-
> > mail the logs.
> > 
> > If you look at the DWC2 driver you will see that it also sets this
> > mask.
> 
> OK, I'm begging to understand this.??It appears the architecture
> specific paths are very different.
> 
> In arm the mask and coherent is set to DMA_BIT_MASK(32) in mm/dma-
> mapping.c the first time the dma APIs are used.??On arm64, it appears
> this variable is uninitialized and will contain random crude.
> 
> Like I said, I don't know if this is a policy decision or if it just
> slipped through the cracks.
> 
Actually, I'm getting confused here.   If I need to prove this is
needed, is their anybody I can send e-mail to that has a deep
understanding of the two different architecture paths.   Perhaps they
can explain exactly why arm64 is not defaulting to 32 bit DMA.
