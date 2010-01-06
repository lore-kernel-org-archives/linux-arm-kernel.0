From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 06 Jan 2010 16:23:47 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <20100105194328.GG14376@shareable.org>
References: <20100105194328.GG14376@shareable.org>
Message-ID: <1262795027.18401.28.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-05 at 19:43 +0000, Jamie Lokier wrote:
> Leif Lindholm wrote:
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 3a28521..cb85aeb 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -147,8 +147,10 @@ ENTRY(cpu_v7_set_pte_ext)
> > 
> >       tst     r1, #L_PTE_USER
> >       orrne   r3, r3, #PTE_EXT_AP1
> > +#ifndef CONFIG_SWP_EMULATE
> >       tstne   r3, #PTE_EXT_APX
> >       bicne   r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> > +#endif
> 
> Is this the part which changes kernel memory access to fault when
> writing to user-read-only pages?  (I don't know anything about the
> details of this, btw).
> 
> Is there any reason why this wasn't always like that?

On ARMv6 onwards (where this user RO, kernel RO is supported) we cannot
easily differentiate between the vectors page and a normal kernel page
unless we use another L_PTE_ bit. We need the vectors page to be
writable if there is no TLS register in hardware (I guess we could use
domain switching to override this though). But on ARMv7 we always have a
TLS register, so no need to write to the vectors page.

-- 
Catalin
