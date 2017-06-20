From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 20 Jun 2017 15:24:21 +0100
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <20170620134932.GB31496@infradead.org>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
 <20170620134932.GB31496@infradead.org>
Message-ID: <3d5ea779-90a3-f0b5-b9aa-161d4c0855e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 14:49, Christoph Hellwig wrote:
> On Wed, May 24, 2017 at 11:24:29AM +0100, Vladimir Murzin wrote:
>> This patch introduces default coherent DMA pool similar to default CMA
>> area concept. To keep other users safe code kept under CONFIG_ARM.
> 
> I don't see a CONFIG_ARM in the code, although parts of it are added
> under CONFIG_OF_RESERVED_MEM.

It's in rmem_dma_setup() (line 325) currently enforcing no-map for ARM.

> But overall this code look a bit odd to me.  As far as I can tell
> the dma-coherent.c code is for the case where we have a special
> piece of coherent memory close to a device.

True, but the case here is where we need a special piece of coherent
memory for *all* devices, and it was more complicated *not* to reuse the
existing infrastructure. This would already be achievable by specifying
a separate rmem carveout per device, but the shared pool just makes life
easier, and mirrors the functionality dma-contiguous already supports.

> If you're allocating out of the global allocator the memory should
> come from the normal dma_ops ->alloc allocator - and also take
> the attrs into account (e.g. for DMA_ATTR_NON_CONSISTENT or
> DMA_ATTR_NO_KERNEL_MAPPING requests you don't need coherent memory)

The context here is noMMU but with caches - the problem being that the
normal allocator will give back kernel memory, and there's no way to
make that coherent with devices short of not enabling the caches in the
first place, which is obviously undesirable. The trick is that RAM is
aliased (in hardware) at two addresses, one of which makes CPU accesses
non-cacheable, so by only ever accessing the RAM set aside for the
coherent DMA pool using the non-cacheable alias (represented by the
dma_pfn_offset) we can achieve DMA coherency.

It perhaps seems a bit backwards, but we do actually end up honouring
DMA_ATTR_NON_CONSISTENT to a degree in patch #5, as such requests are
the only ones allowed to fall back to the normal dma_ops allocator.

Robin.
