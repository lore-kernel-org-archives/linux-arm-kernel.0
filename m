From: thomas.lendacky@amd.com (Tom Lendacky)
Date: Tue, 8 Jul 2014 16:48:15 -0500
Subject: [PATCH] arm64/dma: Flush the coherent mapping in
 __dma_alloc_noncoherent
In-Reply-To: <20140708173916.GA14329@arm.com>
References: <20140707160303.30884.66565.stgit@tlendack-t1.amdoffice.net>
 <20140708173916.GA14329@arm.com>
Message-ID: <53BC671F.3020501@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 12:39 PM, Catalin Marinas wrote:
> On Mon, Jul 07, 2014 at 05:03:03PM +0100, Tom Lendacky wrote:
>> In 3.15 (-rc3) the default arm64 DMA operations changed from coherent
>> to non-coherent operations. This change broke some devices. The
>> associated devices were specifying AXI domain and cache coherency
>> signals equal to write-back, no-allocate. Given that the non-coherent
>> operations resulted in un-cached operations, the device should have
>> succeeded even with those cache coherency signals (the DMA should not
>> have found anything in cache and went to memory). But this was not the
>> case. Not until the coherent mapping range was flushed did the device
>> work properly.
>>
>> In __dma_alloc_noncoherent the allocated memory is flushed but
>> the coherent mapping is not.  If a device is performing DMA
>> with non-allocating caching hints (will look in cache, but if
>> not found will go to memory and not allocate a cache entry) this
>> could result in unpredictable results.  So flush the coherent
>> mapping as well.
>
> The __dma_alloc_noncoherent() function flushes the allocated memory.
> Since the CPU caches are PIPT, the CPU should no longer have any dirty
> cache lines (that's actually the only aim here). Flushing the coherent
> mapping as well does not bring us anything new, just double flushing of
> the same physical address.

That makes sense.  Doing a quick test by moving the original flush to
just before the return allowed the device to work properly also.

>
> Since we don't unmap the cacheable mapping (kernel linear address), the
> CPU could always allocate entries in the cache speculatively. The
> architecture says that the CPU would not hit in such caches, so it's
> fine from the CPU perspective.

I think that I've just been lucky in my testing of the late flush with
the device using the cacheable settings.  It's quite possible that
eventually that scenario would break also should a speculative cache
entry be allocated.

>
> In your case, it seems that the device will look into the CPU cache. In
> this case, the device should only use the coherent DMA ops (with
> cacheable mappings). I know we changed the default but you should be
> able to specify in the DT whether your device/bus in 'dma-coherent'. We
> are currently missing a notifier for PCIe to set up the dma ops (but
> mainline arm64 does not support PCIe yet).

I have since added the 'dma-coherent' property to the device tree node
to restore the old behavior.

The device I am working with allows me to set the AXI domain and cache
attributes so I also updated the driver code to specify AXI domain and
cache attributes based on whether or not the 'dma-coherent' property is
present in the device tree node.  I have verified (using the original
dma-mapping.c file) that I get correct behavior from the device in both
scenarios.

Thanks,
Tom

>
> (what we do with ACPI I have no idea. Probably always assuming I/O
> coherency)
>
