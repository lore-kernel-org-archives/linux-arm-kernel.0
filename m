From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Nov 2010 14:41:29 +0000
Subject: [PATCH 1/5] ARM: pgtable: switch order of Linux vs hardware
	page tables
In-Reply-To: <20101126113825.GK9310@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
	<AANLkTik043UX-cXyriVAwzFTNNTtCTcxYd6VN_gYqCFe@mail.gmail.com>
	<20101126113825.GK9310@n2100.arm.linux.org.uk>
Message-ID: <1290782489.15771.53.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-26 at 11:38 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 19, 2010 at 11:48:31AM +0000, Catalin Marinas wrote:
> > On 17 November 2010 17:28, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > --- a/arch/arm/mm/proc-v7.S
> > > +++ b/arch/arm/mm/proc-v7.S
> > > @@ -158,7 +156,7 @@ ENTRY(cpu_v7_set_pte_ext)
> > >        tstne   r1, #L_PTE_PRESENT
> > >        moveq   r3, #0
> > >
> > > -       str     r3, [r0]
> > > +       str     r3, [r0, #2048]!
> >
> > Thumb-2 build gives "offset out of range".  We need to do a separate
> > ADD for this case.
> 
> Do we have any clues about the typical timing of:
> 
>         str     r3, [r0, #2048]!
>         mcr     p15, 0, r0, c7, c10, 1
> 
> vs:
>         add     r0, r0, #2048
>         str     r3, [r0]
>         mcr     p15, 0, r0, c7, c10, 1
> 
> or
>         str     r3, [r0, #2048]
>         add     r0, r0, #2048
>         mcr     p15, 0, r0, c7, c10, 1
> 
> on ARMv7?

Since there is an address (r0) dependency in the last mcr, all three may
take the same number of cycles.

For T2, the last one could be better, generally, since the str has a bit
more time available before the cache flushing.

For ARM, the advantage of the first one (writeback) is that we don't use
another instruction and have more room in the prefetch buffer, though
not sure this would be noticeable. You could use some ARM/THUMB macros.

-- 
Catalin
