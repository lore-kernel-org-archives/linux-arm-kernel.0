From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Apr 2015 16:55:14 +0100
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <2797677.7Ghz879K9z@wuerfel>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2597359.pR23oR6gM8@wuerfel> <20150430131345.GG32373@arm.com>
 <2797677.7Ghz879K9z@wuerfel>
Message-ID: <20150430155513.GC27755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 03:52:17PM +0200, Arnd Bergmann wrote:
> On Thursday 30 April 2015 14:13:45 Will Deacon wrote:
> > On Thu, Apr 30, 2015 at 02:03:00PM +0100, Arnd Bergmann wrote:
> > > On Thursday 30 April 2015 12:46:15 Will Deacon wrote:
> > > > Cache sync doesn't exist in the ARM/arm64architecture, what are the
> > > > semantics supposed to be? Maybe it's just DSB for us (complete all pending
> > > > maintenance).
> > > 
> > > It ensures that a state of a buffer as observed by CPU and device is
> > > identical. It's possible that we removed all platforms that did something
> > > interesting here, so it's one of these:
> > > 
> > > a) On architectures that are mostly coherent, it's a barrier
> > >    that is broadcast to all devices, like I assume DSB is. IA64
> > >    currently does this for all machines, but IIRC it used to 
> > >    access some cluster interconnect at some point to enforce a
> > >    flush.
> > >    The ARM32 based ArmadaXP also falls into this model if the cache
> > >    coherency fabric is enabled, as that needs to be synchronized

I'm getting confused by the ArmadaXP case. IIRC, the point of the
arm,io-coherent property to the PL310 was precisely to make the
outer_sync a no-op when the coherency is enabled. So basically an mb()
would only issue a DSB on such platform without the PL310 cache sync.

On coherent systems, devices usually snoop the inner/CPU cache and not
the system cache, that's further down the line. So a DSB would ensure
the visibility at the coherent interconnect level before the system
cache. I don't think it needs to be broadcast all the way to devices.

> > > b) On architectures where the device may not see the state of the cache,
> > >    but the CPU is always aware of anything the device sends it,
> > >    it flushes the cache. This seems to be the case on parisc,
> > >    and in particular, there are some variants that do not support
> > >    dma_alloc_coherent but only dma_alloc_noncoherent.
> > > c) On architectures that need the synchronization both ways,
> > >    it does (almost) the same invalidate/clean/flush thing as
> > >    ARM, except it doesn't have to worry about cache lines from
> > >    speculative prefetch which make it impossible to implement on
> > >    ARM.
> > 
> > Okey doke, thanks for the explanation. It sounds like we can just build
> > the primitive out of the existing cache maintenance routines if we need
> > to implement it.
> 
> Cases a) and b) yes, but not c), otherwise we could simplify
> the ARM dma-mapping implementation and just merge __dma_page_cpu_to_dev
> and __dma_page_dev_to_cpu into one function.

I don't fully understand c) or b). Wouldn't the non-coherent ops cover
them both, though potentially not as efficient?

> And a) and b) are both for systems that are more coherent than what
> our noncoherent dma_map_ops implement, but less coherent than what
> the coherent dma_map_ops do, and that is specifically what the ACPI
> binding cannot describe, unless you argue that either ACPI or ARMv8
> forbids both of these models.

In general, a DSB should work as described in the ARM ARM without the
need to poke additional devices (PL310 is an example not to follow).

> > > I guess we could handle that case as well, by requiring any ACPI based
> > > firmware to turn off the coherency fabric on that system and just making
> > > it dog slow.
> > 
> > We already require something similar in Documentation/arm64/booting.txt:
> > 
> >   `System caches which do not respect architected cache maintenance by VA
> >    operations (not recommended) must be configured and disabled.'
> 
> Hmm, does that rule really get violated here? I think it fully respects
> the cache maintenance (flush/invalidate/clean) operations, but it does
> not fully respect the dsb/dmb instructions, which is something else.

If it fully respects the cache maintenance, it should also respect the
completion and ordering requirements of the cache maintenance
operations. That means that a DSB guarantees completion of such
operations.

-- 
Catalin
