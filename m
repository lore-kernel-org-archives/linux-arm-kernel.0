From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 15:52:17 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <20150430131345.GG32373@arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2597359.pR23oR6gM8@wuerfel> <20150430131345.GG32373@arm.com>
Message-ID: <2797677.7Ghz879K9z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 14:13:45 Will Deacon wrote:
> On Thu, Apr 30, 2015 at 02:03:00PM +0100, Arnd Bergmann wrote:
> > On Thursday 30 April 2015 12:46:15 Will Deacon wrote:
> > > On Thu, Apr 30, 2015 at 12:24:12PM +0100, Arnd Bergmann wrote:
> > > > In particular, there are two common models that we support in Linux:
> > > > 
> > > > a) embedded ARM32 and others
> > > > 
> > > > dma_alloc_non_coherent() == dma_alloc_coherent() == alloc uncached
> > > > dma_cache_sync() == not supportable
> > > > dma_sync_{single,sg,page}_for_{device,cpu} == {flush, invalidate, ...}
> > > > 
> > > > b) NUMA servers (parisc, itanium) and others
> > > > 
> > > > dma_alloc_noncoherent() == alloc cached
> > > 
> > > This would lead to mismatched memory attributes on ARM/arm64.
> > 
> > How so? This is just what __dma_alloc() on arm64 does for
> > coherent devices:
> > 
> >         /* no need for non-cacheable mapping if coherent */
> >         if (coherent)
> >                 return ptr;
> 
> Ok, I thought that you were only describing the cases when the device is
> non-coherent (_CCA=0). Otherwise, your assertion above that
> dma_alloc_coherent == alloc uncached isn't true for coherent devices.
> 
> So now I'm confused...

What I was describing here is a device that is not fully coherent,
but instead requires some operation other than a cache flush/invalidate
to complete before the memory can be accessed.

> > > > dma_alloc_coherent() == alloc uncached
> > > > dma_sync_{single,sg,page}_for_{device,cpu} ==  dma_cache_sync() == cache sync
> > > 
> > > Cache sync doesn't exist in the ARM/arm64architecture, what are the
> > > semantics supposed to be? Maybe it's just DSB for us (complete all pending
> > > maintenance).
> > 
> > It ensures that a state of a buffer as observed by CPU and device is
> > identical. It's possible that we removed all platforms that did something
> > interesting here, so it's one of these:
> > 
> > a) On architectures that are mostly coherent, it's a barrier
> >    that is broadcast to all devices, like I assume DSB is. IA64
> >    currently does this for all machines, but IIRC it used to 
> >    access some cluster interconnect at some point to enforce a
> >    flush.
> >    The ARM32 based ArmadaXP also falls into this model if the cache
> >    coherency fabric is enabled, as that needs to be synchronized
> > b) On architectures where the device may not see the state of the cache,
> >    but the CPU is always aware of anything the device sends it,
> >    it flushes the cache. This seems to be the case on parisc,
> >    and in particular, there are some variants that do not support
> >    dma_alloc_coherent but only dma_alloc_noncoherent.
> > c) On architectures that need the synchronization both ways,
> >    it does (almost) the same invalidate/clean/flush thing as
> >    ARM, except it doesn't have to worry about cache lines from
> >    speculative prefetch which make it impossible to implement on
> >    ARM.
> 
> Okey doke, thanks for the explanation. It sounds like we can just build
> the primitive out of the existing cache maintenance routines if we need
> to implement it.

Cases a) and b) yes, but not c), otherwise we could simplify
the ARM dma-mapping implementation and just merge __dma_page_cpu_to_dev
and __dma_page_dev_to_cpu into one function.

And a) and b) are both for systems that are more coherent than what
our noncoherent dma_map_ops implement, but less coherent than what
the coherent dma_map_ops do, and that is specifically what the ACPI
binding cannot describe, unless you argue that either ACPI or ARMv8
forbids both of these models.

> > Which case would a variant of ArmadaXP with a 64-bit core fall into then?
> > Do I understand it right that requiring to sync the coherency fabric
> > would make it noncompliant with ACPI but still architecturally compliant?
> 
> I would say that the ArmadaXP coherency fabric is not compliant with ARMv8
> as it requires additional steps over those cache maintenance instructions
> described by the architecture (i.e. it falls into class (1) of the three
> classes of system cache in the architecture).
> 
> > I guess we could handle that case as well, by requiring any ACPI based
> > firmware to turn off the coherency fabric on that system and just making
> > it dog slow.
> 
> We already require something similar in Documentation/arm64/booting.txt:
> 
>   `System caches which do not respect architected cache maintenance by VA
>    operations (not recommended) must be configured and disabled.'

Hmm, does that rule really get violated here? I think it fully respects
the cache maintenance (flush/invalidate/clean) operations, but it does
not fully respect the dsb/dmb instructions, which is something else.

	Arnd
