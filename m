From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Jul 2014 18:39:16 +0100
Subject: [PATCH] arm64/dma: Flush the coherent mapping in
 __dma_alloc_noncoherent
In-Reply-To: <20140707160303.30884.66565.stgit@tlendack-t1.amdoffice.net>
References: <20140707160303.30884.66565.stgit@tlendack-t1.amdoffice.net>
Message-ID: <20140708173916.GA14329@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 05:03:03PM +0100, Tom Lendacky wrote:
> In 3.15 (-rc3) the default arm64 DMA operations changed from coherent
> to non-coherent operations. This change broke some devices. The
> associated devices were specifying AXI domain and cache coherency
> signals equal to write-back, no-allocate. Given that the non-coherent
> operations resulted in un-cached operations, the device should have
> succeeded even with those cache coherency signals (the DMA should not
> have found anything in cache and went to memory). But this was not the
> case. Not until the coherent mapping range was flushed did the device
> work properly.
> 
> In __dma_alloc_noncoherent the allocated memory is flushed but
> the coherent mapping is not.  If a device is performing DMA
> with non-allocating caching hints (will look in cache, but if
> not found will go to memory and not allocate a cache entry) this
> could result in unpredictable results.  So flush the coherent
> mapping as well.

The __dma_alloc_noncoherent() function flushes the allocated memory.
Since the CPU caches are PIPT, the CPU should no longer have any dirty
cache lines (that's actually the only aim here). Flushing the coherent
mapping as well does not bring us anything new, just double flushing of
the same physical address.

Since we don't unmap the cacheable mapping (kernel linear address), the
CPU could always allocate entries in the cache speculatively. The
architecture says that the CPU would not hit in such caches, so it's
fine from the CPU perspective.

In your case, it seems that the device will look into the CPU cache. In
this case, the device should only use the coherent DMA ops (with
cacheable mappings). I know we changed the default but you should be
able to specify in the DT whether your device/bus in 'dma-coherent'. We
are currently missing a notifier for PCIe to set up the dma ops (but
mainline arm64 does not support PCIe yet).

(what we do with ACPI I have no idea. Probably always assuming I/O
coherency)

-- 
Catalin
