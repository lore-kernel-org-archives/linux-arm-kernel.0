From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 27 Jan 2011 13:40:37 -0500 (EST)
Subject: HIGHMEM is broken when working in SMP V6 mode
In-Reply-To: <20110127173716.GA605@n2100.arm.linux.org.uk>
References: <AANLkTikjcgRgPd7oLjf0ESxeyC2BHpaaRi8DiMz3b+JQ@mail.gmail.com>
	<20110123145639.GB30094@n2100.arm.linux.org.uk>
	<AANLkTi=HtLjnOLGVVqWvqToiXdQAm_+cDdZf51M+ABV4@mail.gmail.com>
	<20110123170830.GG30094@n2100.arm.linux.org.uk>
	<AANLkTim3VVYTrWZX+UJUtK73bUkmSufW_4awhgQcVeNZ@mail.gmail.com>
	<alpine.LFD.2.00.1101241010580.8580@xanadu.home>
	<20110127173716.GA605@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101271337410.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Jan 2011, Russell King - ARM Linux wrote:

> On Mon, Jan 24, 2011 at 02:58:07PM -0500, Nicolas Pitre wrote:
> >  /*
> > + * The reason for kmap_high_get() is to ensure that the currently kmap'd
> > + * page usage count does not decrease to zero while we're using its
> > + * existing virtual mapping in an atomic context.  With a VIVT cache this
> > + * is essential to do, but with a VIPT cache this is only an optimization
> > + * so not to pay the price of establishing a second mapping if an existing
> > + * one can be used.  However, on platforms without hardware TLB maintainence
> > + * broadcast, we simply cannot use ARCH_NEEDS_KMAP_HIGH_GET at all since
> > + * the locking involved must also disable IRQs which is incompatible with
> > + * the IPI mechanism used by global TLB operations.
> > + */
> > +#define ARCH_NEEDS_KMAP_HIGH_GET
> > +#if defined(CONFIG_SMP) && defined(CONFIG_CPU_TLB_V6)
> > +#undef ARCH_NEEDS_KMAP_HIGH_GET
> > +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_CPU_CACHE_VIVT)
> > +#error "The sum of feature in your kernel config cannot be supported together"
> > +#endif
> 
> This is wrong.  Take a moment to consider a kernel supporting an ARMv6
> VIPT aliasing cache CPU and ARMv7 SMP.  Don't we need kmap_high_get()
> for ARMv6 VIPT aliasing cache?

We don't support highmem on aliasing VIPT.  Highmem gets disabled at run 
time on aliasing VIPT platforms.


Nicolas
