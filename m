From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter?= Ujfalusi)
Date: Fri, 04 Nov 2011 11:35:26 +0200
Subject: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source
	position
In-Reply-To: <20111103212756.GZ31337@atomide.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
	<1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com>
	<20111103212756.GZ31337@atomide.com>
Message-ID: <2603119.amz7RjSE3J@barack>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2011 14:27:56 Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [111031 06:46]:
> > If the DMA source position has been asked before the
> > first actual data transfer has been done, the CSAC
> > register does not contain valid information.
> > We can identify this situation by checking the CDAC
> > register:
> > CDAC != 0 indicates that the DMA transfer on the channel has
> > been started already.
> > When CDAC == 0 we can not trust the CSAC value since it has
> > not been updated, and can contain random number.
> > Return the start address in case the DMA has not jet started.
> > 
> > Note: The CDAC register has been initialized to 0 at dma_start
> > time.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > 
> >  arch/arm/plat-omap/dma.c |   15 +++++++++++++--
> >  1 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> > index c22217c..38b0d44 100644
> > --- a/arch/arm/plat-omap/dma.c
> > +++ b/arch/arm/plat-omap/dma.c
> > @@ -1024,12 +1024,23 @@ EXPORT_SYMBOL(omap_set_dma_callback);
> > 
> >   */
> >  
> >  dma_addr_t omap_get_dma_src_pos(int lch)
> >  {
> > 
> > +	u32 cdac;
> > 
> >  	dma_addr_t offset = 0;
> >  	
> >  	if (cpu_is_omap15xx())
> >  	
> >  		offset = p->dma_read(CPC, lch);
> > 
> > -	else
> > -		offset = p->dma_read(CSAC, lch);
> > +	else {
> > +		/*
> > +		 * CDAC == 0 indicates that the DMA transfer on the channel has
> > +		 * not been started (no data has been transferred so far).
> > +		 * Return the programmed source start address in this case.
> > +		 */
> > +		cdac = p->dma_read(CDAC, lch);
> > +		if (likely(cdac))
> > +			offset = p->dma_read(CSAC, lch);
> > +		else
> > +			offset = p->dma_read(CSSA, lch);
> > +	}
> > 
> >  	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
> >  	
> >  		offset = p->dma_read(CSAC, lch);
> 
> Should these tests be done only after the errata re-read for both
> src and dst patches? Otherwise the errata will not be handled?

Yes that might be a good idea.
I was trying to locate the original errata description for DMA_ERRATA_3_3, but 
it does not exist, or at least I can not find it. This only been mentioned in 
the kernel's comment.
I'm not sure when this DMA_ERRATA_3_3 would have been in force. My guess would 
be that if someone wants to read the src/dst position right after the channel 
is disabled, but what would we expect it to return when the channel has been 
disabled?
I mean what is the reasonable src/dst for a disabled channel? 0 is as good as 
any other number, probably the programmed start of the DMA transfer would be 
my best bet.
I think the errata description for DMA_ERRATA_3_3 is not correct, and it is in 
fact to handle the case I'm also handling: Before the first DMA request the 
CDAC is 0 (since we configured it to be), the CSAC contains _something_ (most 
of the time 0, but can be random number).
In some situation re-reading the src/dst position will give enough time to 
receive the first DMA request, which will update CDAC/CSAC registers.

What do you think?

--
P?ter
