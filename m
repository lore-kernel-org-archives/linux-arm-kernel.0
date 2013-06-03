From: alior@marvell.com (Lior Amsalem)
Date: Mon, 3 Jun 2013 10:16:56 +0300
Subject: [PATCH 3/3] ARM PJ4B: Add support for errata 4611
In-Reply-To: <20130529112207.GG13095@mudshark.cambridge.arm.com>
References: <1369822618-26797-1-git-send-email-gregory.clement@free-electrons.com>
 <1369822618-26797-4-git-send-email-gregory.clement@free-electrons.com>
 <20130529112207.GG13095@mudshark.cambridge.arm.com>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56CF1A398@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Wednesday, May 29, 2013 2:22 PM
> 
> On Wed, May 29, 2013 at 11:16:58AM +0100, Gregory CLEMENT wrote:
> > From: Lior Amsalem <alior@marvell.com>
> >
> > A CP15 clean operation can result in a dead lock state if it is hit by
> > an incoming snoop event. the fiw to this issue is the following:
[Snip]
> > a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> > index e3a8064..112f778 100644
> > --- a/arch/arm/include/asm/tlbflush.h
> > +++ b/arch/arm/include/asm/tlbflush.h
> > @@ -475,11 +475,22 @@ static inline void flush_pmd_entry(void *pmd)  {
> >  	const unsigned int __tlb_flag = __cpu_tlb_flags;
> >
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	unsigned long flags;
> > +	raw_local_irq_save(flags);
> > +	dmb();
> > +#endif
> > +
> >  #ifdef CONFIG_PJ4B_ERRATA_6124
> >  	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);
> >  #else
> >  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
> >  #endif
> > +
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	raw_local_irq_restore(flags);
> > +#endif
> 
> Eeek. Why do you have to disable interrupts during this? Again, are there no
> chicken bits to save you?

It's there in order to avoid an exception that will cause the workaround (of adding a DMB) 
to be dismissed.
No chicken bit for it...

> 
> >  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
> >
> >  	if (tlb_flag(TLB_WB))
> > @@ -490,11 +501,22 @@ static inline void clean_pmd_entry(void *pmd)  {
> >  	const unsigned int __tlb_flag = __cpu_tlb_flags;
> >
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	unsigned long flags;
> > +	raw_local_irq_save(flags);
> > +	dmb();
> > +#endif
> > +
> >  #ifdef CONFIG_PJ4B_ERRATA_6124
> >  	tlb_op(TLB_DCLEAN, "c7, c14, 1	@ flush_pmd", pmd);
> >  #else
> >  	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
> >  #endif
> > +
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	raw_local_irq_restore(flags);
> > +#endif
> > +
> >  	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);  }
> >
> > diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> > index b9bcc9d..20b69ad 100644
> > --- a/arch/arm/mm/copypage-v6.c
> > +++ b/arch/arm/mm/copypage-v6.c
> > @@ -59,11 +59,22 @@ static void
> v6_clear_user_highpage_nonaliasing(struct page *page, unsigned long
> >   */
> >  static void discard_old_kernel_data(void *kto)  {
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +        unsigned long flags;
> > +
> > +        raw_local_irq_save(flags);
> > +        dmb();
> > +#endif
> > +
> >  	__asm__("mcrr	p15, 0, %1, %0, c6	@ 0xec401f06"
> >  	   :
> >  	   : "r" (kto),
> >  	     "r" ((unsigned long)kto + PAGE_SIZE - L1_CACHE_BYTES)
> >  	   : "cc");
> > +
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +        raw_local_irq_restore(flags); #endif
> 
> Do you actually have an aliasing vipt cache? If not, you don't care about this
> function.

No, It's a mistake, will be removed. 10x for pointing that out.

> 
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index f9a0aa7..ca81291 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -178,7 +178,20 @@
> >  #endif
> >
> >  	str	r3, [r0]
> > +
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	mrs     r2, cpsr
> > +	orr     r3, r2, #PSR_F_BIT | PSR_I_BIT
> > +	msr     cpsr_c, r3                      @ Disable interrupts
> > +	dmb                                     @ ensure ordering with previous memory
> accesses
> > +#endif
> > +
> >  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> > +
> > +#ifdef CONFIG_PJ4B_ERRATA_4611
> > +	msr     cpsr_c, r2                      @ Restore interrupts
> > +	mcr     p15, 0, r0, c7, c10, 4          @ drain write buffer
> > +#endif
> 
> This could be a dsb.

Yes it can.

> 
> Will

Regards,
Lior Amsalem
