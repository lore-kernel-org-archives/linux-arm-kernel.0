From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jan 2013 15:57:17 +0000
Subject: [PATCH] ARM: tlb: perform branch predictor maintenance for whole
 invalidation
In-Reply-To: <20130130145243.GA2014@linaro.org>
References: <1359555125-27495-1-git-send-email-will.deacon@arm.com>
 <20130130145243.GA2014@linaro.org>
Message-ID: <20130130155717.GG7484@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 02:52:43PM +0000, Dave Martin wrote:
> On Wed, Jan 30, 2013 at 02:12:05PM +0000, Will Deacon wrote:
> > The ARM architecture requires explicit branch predictor maintenance
> > when updating an instruction stream for a given virtual address. In
> > reality, this isn't so much of a burden because the branch predictor
> > is flushed during the cache maintenance required to make the new
> > instructions visible to the I-side of the processor.
> > 
> > One exception to this rule is when we flush the entire TLB for a CPU in
> > response to something other than writing new instructions (for example,
> > ASID rollover or switching to an identity mapping before disabling the
> > MMU).
> > 
> > This patch ensures that we flush the branch predictor as part of
> > invalidating the entire TLB.
> 
> What about v6 implementations?  Is the branch predictor flush implicit?

No, they're also handled by the patch. There's no -UIS versions of iciall
and bpiall prior to v7, so the operations are broadcast via IPI, hence the
use of bpiall in the else case below.

Will

> Cheers
> ---Dave
> 
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/include/asm/tlbflush.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> > index 6e924d3..713ff32 100644
> > --- a/arch/arm/include/asm/tlbflush.h
> > +++ b/arch/arm/include/asm/tlbflush.h
> > @@ -38,6 +38,7 @@
> >  #define TLB_V7_UIS_PAGE	(1 << 19)
> >  #define TLB_V7_UIS_FULL (1 << 20)
> >  #define TLB_V7_UIS_ASID (1 << 21)
> > +#define TLB_V7_UIS_BP	(1 << 22)
> >  
> >  #define TLB_BARRIER	(1 << 28)
> >  #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
> > @@ -166,9 +167,11 @@
> >  #endif
> >  
> >  #define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
> > -			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
> > +				 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | \
> > +				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
> >  #define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
> > -			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
> > +				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
> > +				 TLB_V6_U_ASID)
> >  
> >  #ifdef CONFIG_CPU_TLB_V7
> >  
> > @@ -330,6 +333,11 @@ static inline void local_flush_tlb_all(void)
> >  	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
> >  	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
> >  
> > +	if (tlb_flag(TLB_V7_UIS_BP))
> > +		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
> > +	else
> > +		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
> > +
> >  	if (tlb_flag(TLB_BARRIER)) {
> >  		dsb();
> >  		isb();
> > -- 
> > 1.8.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
