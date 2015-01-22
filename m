From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Jan 2015 12:03 +0100
Subject: [PATCH] ARM: use default ioremap alignment for SMP or LPAE
In-Reply-To: <20150122100441.GA19811@e104818-lin.cambridge.arm.com>
References: <1421911075-8814-1-git-send-email-s.dyasly@samsung.com>
 <20150122100441.GA19811@e104818-lin.cambridge.arm.com>
Message-ID: <3060178.HEZJjJCl1e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 January 2015 10:04:41 Catalin Marinas wrote:
> On Thu, Jan 22, 2015 at 07:17:55AM +0000, Sergey Dyasly wrote:
> > 16MB alignment for ioremap mappings was added by commit a069c896d0d6 ("[ARM]
> > 3705/1: add supersection support to ioremap()") in order to support supersection
> > mappings. But __arm_ioremap_pfn_caller uses section and supersection mappings
> > only in !SMP && !LPAE case. There is no need for such big alignment if either
> > SMP or LPAE is enabled.
> [...]
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index 184def0..c3ef139 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -78,10 +78,12 @@
> >   */
> >  #define XIP_VIRT_ADDR(physaddr)  (MODULES_VADDR + ((physaddr) & 0x000fffff))
> >  
> > +#if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
> >  /*
> >   * Allow 16MB-aligned ioremap pages
> >   */
> >  #define IOREMAP_MAX_ORDER    24
> > +#endif
> 
> Actually, I think we could make this depend only on CONFIG_IO_36. That's
> the only scenario where we get the supersections matter, and maybe make
> CONFIG_IO_36 dependent on !SMP or !ARM_LPAE.

Good point, I assumed this was just a performance optimization,
but it is in fact required for dynamic high mappings on XSC3.

> My assumption is that we
> don't support single zImage with CPU_XSC3 enabled (but I haven't
> followed the latest developments here).

I have said in the past that I do not expect any of the xscale or
strongarm based platforms to be used with a single zImage kernel.
This has changed slightly given the work that Robert Jarzmik and
others are doing on mach-pxa with DT conversion. I still don't
think it's likely that they will move on to multiplatform, but I
no longer think it's impossible.

Fortunately, PXA also does not have any high physical address mappings
that I can see. The only platform we have that has these (see
'git grep ioremap_pfn') is mach-iop13xx, and I am still seeing
this in the 'never going to be multiplatform' category.

Unrelated to this question however is whether we want to keep
supersection mappings as a performance optimization to save TLBs.
It seems useful to me, but not critical.

	Arnd
