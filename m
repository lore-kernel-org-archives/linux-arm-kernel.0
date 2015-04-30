From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 15:03 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <20150430114614.GF32373@arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2204172.bmnN8Vg9Bj@wuerfel> <20150430114614.GF32373@arm.com>
Message-ID: <2597359.pR23oR6gM8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 12:46:15 Will Deacon wrote:
> On Thu, Apr 30, 2015 at 12:24:12PM +0100, Arnd Bergmann wrote:
> > On Thursday 30 April 2015 12:07:18 Will Deacon wrote:
> > > So for the CPU caches we'd do the usual clean to push dirty lines to the device
> > > and (clean+)invalidate before reading data from the device. For the "other
> > > caches in the system" we currently assume (for ARM64) that cache maintenance
> > > will be broadcast and therefore I wouldn't anticipate doing anything extra.
> > > 
> > > If people want to build system caches that don't respect broadcast cache
> > > maintenance and require explicit management (e.g outer_flush), then I
> > > consider that a broken system and we should try to disable the cache before
> > > entering the kernel. ARMv8 explicitly prohibits this type of cache in the
> > > architecture (type 1 below):
> > > 
> > >   `Conceptually, three classes of system cache can be envisaged:
> > > 
> > >    1. System caches which lie before the point of coherency and cannot
> > >       be managed by any cache maintenance instructions. Such systems
> > >       fundamentally undermine the concept of cache maintenance
> > >       instructions operating to the point of coherency, as they imply
> > >       the use of non-architecture mechanisms to manage coherency. The
> > >       use of such systems in the ARM architecture is explicitly
> > >       prohibited.
> > 
> > Hmm, I thought this was what GPUs typically have, with their own
> > internal caches that are managed by the GPU rather than the normal
> > cache maintenance instructions. Does this prohibit the use of most
> > GPU devices with ARMv8, or did I misunderstand what they do?
> 
> No, because it's the responsibility of the GPU/GPU driver to ensure
> that the internal caches are not visible to the CPU. I guess you can
> think of data in the GPU private cache like data sitting in a CPU's write
> buffer (i.e. non-snoopable).

Ok.

> > In particular, there are two common models that we support in Linux:
> > 
> > a) embedded ARM32 and others
> > 
> > dma_alloc_non_coherent() == dma_alloc_coherent() == alloc uncached
> > dma_cache_sync() == not supportable
> > dma_sync_{single,sg,page}_for_{device,cpu} == {flush, invalidate, ...}
> > 
> > b) NUMA servers (parisc, itanium) and others
> > 
> > dma_alloc_noncoherent() == alloc cached
> 
> This would lead to mismatched memory attributes on ARM/arm64.

How so? This is just what __dma_alloc() on arm64 does for
coherent devices:

        /* no need for non-cacheable mapping if coherent */
        if (coherent)
                return ptr;

> > dma_alloc_coherent() == alloc uncached
> > dma_sync_{single,sg,page}_for_{device,cpu} ==  dma_cache_sync() == cache sync
> 
> Cache sync doesn't exist in the ARM/arm64architecture, what are the
> semantics supposed to be? Maybe it's just DSB for us (complete all pending
> maintenance).

It ensures that a state of a buffer as observed by CPU and device is
identical. It's possible that we removed all platforms that did something
interesting here, so it's one of these:

a) On architectures that are mostly coherent, it's a barrier
   that is broadcast to all devices, like I assume DSB is. IA64
   currently does this for all machines, but IIRC it used to 
   access some cluster interconnect at some point to enforce a
   flush.
   The ARM32 based ArmadaXP also falls into this model if the cache
   coherency fabric is enabled, as that needs to be synchronized
b) On architectures where the device may not see the state of the cache,
   but the CPU is always aware of anything the device sends it,
   it flushes the cache. This seems to be the case on parisc,
   and in particular, there are some variants that do not support
   dma_alloc_coherent but only dma_alloc_noncoherent.
c) On architectures that need the synchronization both ways,
   it does (almost) the same invalidate/clean/flush thing as
   ARM, except it doesn't have to worry about cache lines from
   speculative prefetch which make it impossible to implement on
   ARM.

> > There are probably other models that could happen, but the patch
> > set seems to assume a) is the only possible model, while the
> > architecture description you cite seems to still allow both a) and
> > b), as well as some variations, and it's possible that we will 
> > see b) on arm64 servers but not a)
> 
> Well, we should be careful not to confuse the ACPI spec with the ARM
> architecture. The latter is more permissive, but does disallow system
> caches that do not respect broadcast maintenance.
> 
> It's also worth pointing out that the architecture doesn't distinguish
> between embedded and server machines using A-class processors.
> 
> > You could also have a system that requires cache invalidation for
> > sending data from the device to memory, but does not require anything
> > for memory-to-device data, or you could have the opposite.
> 
> You could theoretically build all sorts of strange devices, but that doesn't
> mean we have to support them. In the case you describe, they'd have to put
> up with the cost of redundant cache cleaning but it should at least function
> correctly.

Which case would a variant of ArmadaXP with a 64-bit core fall into then?
Do I understand it right that requiring to sync the coherency fabric
would make it noncompliant with ACPI but still architecturally compliant?

I guess we could handle that case as well, by requiring any ACPI based
firmware to turn off the coherency fabric on that system and just making
it dog slow.

	Arnd
