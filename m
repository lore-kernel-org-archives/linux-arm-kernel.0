From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 13:24:12 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <20150430110718.GE32373@arm.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2575874.Qzlb7P3t1y@wuerfel> <20150430110718.GE32373@arm.com>
Message-ID: <2204172.bmnN8Vg9Bj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 12:07:18 Will Deacon wrote:
> On Thu, Apr 30, 2015 at 11:47:46AM +0100, Arnd Bergmann wrote:
> > On Thursday 30 April 2015 11:41:02 Will Deacon wrote:
> > >    - 0x0: The device is not coherent. Therefore:
> > >      * Cache maintenance is required for memory shared with the
> > >        device that is mapped on CPUs as IWB-OWB-ISH.
> > 
> > This still seems insufficient. I guess this excludes having to
> > synchronize external bridges or write buffers, but it does not specify
> > what cache maintenance is required. Should there be an "outer-flush"?
> > Should the CPU cache be invalidated or flushed (or both), and do
> > we need to care about caches inside of the device or just inside of
> > the CPU?
> 
> See the note below:
> 
> > > [1] Note: Caching operations described in this document apply to the CPU
> > >     caches and any other caches in the system where device memory accesses
> > >     can hit.'
> 
> So for the CPU caches we'd do the usual clean to push dirty lines to the device
> and (clean+)invalidate before reading data from the device. For the "other
> caches in the system" we currently assume (for ARM64) that cache maintenance
> will be broadcast and therefore I wouldn't anticipate doing anything extra.
> 
> If people want to build system caches that don't respect broadcast cache
> maintenance and require explicit management (e.g outer_flush), then I
> consider that a broken system and we should try to disable the cache before
> entering the kernel. ARMv8 explicitly prohibits this type of cache in the
> architecture (type 1 below):
> 
>   `Conceptually, three classes of system cache can be envisaged:
> 
>    1. System caches which lie before the point of coherency and cannot
>       be managed by any cache maintenance instructions. Such systems
>       fundamentally undermine the concept of cache maintenance
>       instructions operating to the point of coherency, as they imply
>       the use of non-architecture mechanisms to manage coherency. The
>       use of such systems in the ARM architecture is explicitly
>       prohibited.

Hmm, I thought this was what GPUs typically have, with their own
internal caches that are managed by the GPU rather than the normal
cache maintenance instructions. Does this prohibit the use of most
GPU devices with ARMv8, or did I misunderstand what they do?

>    2. System caches which lie before the point of coherency and can be
>       managed by cache maintenance by address instructions that apply to
>       the point of coherency, but cannot be managed by cache maintenance
>       by set/way instructions. Where maintenance of the entirety of such
>       a cache must be performed, as in the case for power management, it
>       must be performed using non-architectural mechanisms.

That still doesn't define which cache maintenance instructions are
required for a device that is marked as not coherent using the _CCA
property.

Here, I know that I have a cache that I can flush or invalidate or sync
using architected instructions, but should I?

In particular, there are two common models that we support in Linux:

a) embedded ARM32 and others

dma_alloc_non_coherent() == dma_alloc_coherent() == alloc uncached
dma_cache_sync() == not supportable
dma_sync_{single,sg,page}_for_{device,cpu} == {flush, invalidate, ...}

b) NUMA servers (parisc, itanium) and others

dma_alloc_noncoherent() == alloc cached
dma_alloc_coherent() == alloc uncached
dma_sync_{single,sg,page}_for_{device,cpu} ==  dma_cache_sync() == cache sync

There are probably other models that could happen, but the patch
set seems to assume a) is the only possible model, while the
architecture description you cite seems to still allow both a) and
b), as well as some variations, and it's possible that we will 
see b) on arm64 servers but not a).

You could also have a system that requires cache invalidation for
sending data from the device to memory, but does not require anything
for memory-to-device data, or you could have the opposite.

>    3. System caches which lie beyond the point of coherency and so are
>       invisible to the software. The management of such caches is
>       outside the scope of the architecture.'
> 
> (sorry to keep throwing the book at you!)

That's fine, at least I don't have to read it cover-to-cover then ;-)

	Arnd
