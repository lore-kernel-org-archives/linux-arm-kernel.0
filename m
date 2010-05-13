From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 May 2010 12:42:08 +0100
Subject: [RFC PATCH 1/3] ARM: Use lazy cache flushing on ARMv7 SMPsystems
In-Reply-To: <20100513113215.GA13001@n2100.arm.linux.org.uk>
References: <20100513110609.21178.39630.stgit@e102109-lin.cambridge.arm.com>
	<20100513111555.21178.63776.stgit@e102109-lin.cambridge.arm.com>
	<20100513113215.GA13001@n2100.arm.linux.org.uk>
Message-ID: <1273750928.30713.46.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 12:32 +0100, Russell King - ARM Linux wrote:
> On Thu, May 13, 2010 at 12:15:55PM +0100, Catalin Marinas wrote:
> > diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> > index c6844cb..5ad8711 100644
> > --- a/arch/arm/mm/flush.c
> > +++ b/arch/arm/mm/flush.c
> > @@ -17,6 +17,7 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/system.h>
> >  #include <asm/tlbflush.h>
> > +#include <asm/smp_plat.h>
> > 
> >  #include "mm.h"
> > 
> > @@ -93,12 +94,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
> >  #define flush_pfn_alias(pfn,vaddr)   do { } while (0)
> >  #endif
> > 
> > -#ifdef CONFIG_SMP
> >  static void flush_ptrace_access_other(void *args)
> >  {
> >       __flush_icache_all();
> >  }
> > -#endif
> > 
> >  static
> >  void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> > @@ -122,11 +121,9 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
> >       if (vma->vm_flags & VM_EXEC) {
> >               unsigned long addr = (unsigned long)kaddr;
> >               __cpuc_coherent_kern_range(addr, addr + len);
> > -#ifdef CONFIG_SMP
> >               if (cache_ops_need_broadcast())
> >                       smp_call_function(flush_ptrace_access_other,
> >                                         NULL, 1);
> > -#endif
> 
> Err.  __cpuc_coherent_kern_range() makes the cache lines coherent between
> the data and instruction threads.  So what you're doing is:
> 
> 1. flush the D and I caches for the affected cache lines on the local
>    processor
> 2. flush the entire I cache on the local processor

This should be "flush the entire I cache on the other processors".

> Why?

I don't think my patch changes the current flush_ptrace_access()
behaviour. It just removes the #ifdef CONFIG_SMP since
cache_ops_need_broadcast() is 0 anyway on !SMP and the code compiled
out.

The current behaviour is needed on ARM11MPCore (and I now realised that
my 4th patch for ARM11MPCore is slightly wrong) since the I-cache
maintenance isn't visible to the other CPUs (and you miss breakpoints
when gdb and the debugged app are on different processors).

-- 
Catalin
