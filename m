From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 11 Jan 2010 20:48:37 +0530
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
In-Reply-To: <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	<1263220628.6305.44.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for cooments !!
> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Monday, January 11, 2010 8:07 PM
> To: Shilimkar, Santosh
> Cc: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> tony at atomide.com; Woodruff, Richard
> Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> 
> On Mon, 2009-12-21 at 10:09 +0000, Santosh Shilimkar wrote:
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index cb8fc65..5443c0d 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -28,6 +28,24 @@
> >  static void __iomem *l2x0_base;
> >  static DEFINE_SPINLOCK(l2x0_lock);
> >
> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +static void debug_writel(unsigned long val)
> > +{
> > +       register unsigned long r0 asm("r0") = val;
> > +       /*
> > +        * Texas Instrument secure monitor api to modify the PL310
> > +        * Debug Control Register.
> > +        */
> > +       __asm__ __volatile__(
> > +               __asmeq("%0", "r0")
> > +               "ldr r12, =0x100\n"
> > +               "dsb\n"
> > +               "smc\n"
> > +               : : "r" (r0)
> > +               : "r4", "r5", "r6", "r7", "r8");
> 
> Does your secure monitor corrupt r4-r8? Maybe you could add a comment
> with a few words on this API.
Yes they are corrupted. I will add some comments on the API.
> Do you need to specify "r12" as well? What about "cc", are they
> preserved by the secure monitor?
r12 and reset of the registers are preserved. Lr needs to be saved but
because of function call, the compiler saves/restores it.
I didn't get your this comment "What about "cc", are they preserved
by the secure monitor ?  Do you mean rest of the register. If yes then
the secure monitor don't tamper those registers.
 
> > @@ -139,7 +184,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
> >                         spin_lock_irqsave(&l2x0_lock, flags);
> >                 }
> >         }
> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +       cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> > +       cache_wait(base + L2X0_INV_LINE_PA, 1);
> > +#else
> >         cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> > +#endif
> 
> I don't think we need to way on two separate registers here. AFAICT, bit
> 1 of those registers is shared for all the operations.
> 
> As a general comment, maybe an inline function called something like
> wait_writel(before/after) would be better than a lot of ifdefs in the
> code, especially if one has a different workaround other than using TI's
> secure monitor.
I agree. As suggested by Russell, we don't need above #ifdef and can 
be removed 

Regards,
Santosh
