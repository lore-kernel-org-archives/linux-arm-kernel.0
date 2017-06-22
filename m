From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 22 Jun 2017 14:18:48 +0100
Subject: [PATCH v5 4/7] drivers: dma-coherent: Introduce default DMA pool
In-Reply-To: <20170620134932.GB31496@infradead.org>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <1495621472-9323-5-git-send-email-vladimir.murzin@arm.com>
 <20170620134932.GB31496@infradead.org>
Message-ID: <94e57caa-e7b9-d740-bca3-89950c10033e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/17 14:49, Christoph Hellwig wrote:
> On Wed, May 24, 2017 at 11:24:29AM +0100, Vladimir Murzin wrote:
>> This patch introduces default coherent DMA pool similar to default CMA
>> area concept. To keep other users safe code kept under CONFIG_ARM.
> 
> I don't see a CONFIG_ARM in the code, although parts of it are added
> under CONFIG_OF_RESERVED_MEM.

It should look like that:

#ifdef CONFIG_ARM
	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
		pr_err("Reserved memory: regions without no-map are not yet supported\n");
		return -EINVAL;
	}
+
+	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
+		WARN(dma_reserved_default_memory,
+		     "Reserved memory: region for default DMA coherent area is redefined\n");
+		dma_reserved_default_memory = rmem;
+	}
#endif


> 
> But overall this code look a bit odd to me.  As far as I can tell
> the dma-coherent.c code is for the case where we have a special
> piece of coherent memory close to a device.
> 
> If you're allocating out of the global allocator the memory should
> come from the normal dma_ops ->alloc allocator - and also take
> the attrs into account (e.g. for DMA_ATTR_NON_CONSISTENT or
> DMA_ATTR_NO_KERNEL_MAPPING requests you don't need coherent memory)
> 

It is how it has been started [1] - defining memory which is not cacheable
(i.e. suitable for coherent allocations) and building custom allocator on top
of it, like it was done for c6x and blackfin. The annoying thing was that we
needed to advertise such memory via command line parameter plus some "mem="
adjustment to hide coherent memory from buddy allocator. So it was suggested
to use reserved memory and this makes things look much better, but on the
other hand require changes on dts side to "bind" devices with reserved memory
- default DMA pool removes such drawback.

[1] https://marc.info/?l=linux-arm-kernel&m=148163694824475&w=2

Cheers
Vladimir
