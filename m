From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:42:50 -0700
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <3d5ea779-90a3-f0b5-b9aa-161d4c0855e7@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
 <20170620134932.GB31496@infradead.org>
 <3d5ea779-90a3-f0b5-b9aa-161d4c0855e7@arm.com>
Message-ID: <20170626094250.GB21570@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 03:24:21PM +0100, Robin Murphy wrote:
> True, but the case here is where we need a special piece of coherent
> memory for *all* devices, and it was more complicated *not* to reuse the
> existing infrastructure. This would already be achievable by specifying
> a separate rmem carveout per device, but the shared pool just makes life
> easier, and mirrors the functionality dma-contiguous already supports.

?'m really worried about the code in dma-coherent.c - the original
version clearly intends to have a coherent pool per device, declared
in the driver.  Then Marek added the reserved_mem interface, and
now we get another variant of it.  Conceptually the per-device
and global pool are very different, and to me it seems like the
reserved mem should be a different interface.

> > If you're allocating out of the global allocator the memory should
> > come from the normal dma_ops ->alloc allocator - and also take
> > the attrs into account (e.g. for DMA_ATTR_NON_CONSISTENT or
> > DMA_ATTR_NO_KERNEL_MAPPING requests you don't need coherent memory)
> 
> The context here is noMMU but with caches - the problem being that the
> normal allocator will give back kernel memory, and there's no way to
> make that coherent with devices short of not enabling the caches in the
> first place, which is obviously undesirable. The trick is that RAM is
> aliased (in hardware) at two addresses, one of which makes CPU accesses
> non-cacheable, so by only ever accessing the RAM set aside for the
> coherent DMA pool using the non-cacheable alias (represented by the
> dma_pfn_offset) we can achieve DMA coherency.

Yes, and I think this is something we already have to deal with
for example on mips.  A simple genalloc allocator from your pool
in the normal dma_ops implementation should do the work just fine.
