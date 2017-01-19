From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 19 Jan 2017 15:21:22 +0000
Subject: [RFC PATCH v5 5/7] ARM: NOMMU: Introduce dma operations for noMMU
In-Reply-To: <7c1f73a9-47cb-851a-1374-4f8436a688f3@arm.com>
References: <1484738003-29892-1-git-send-email-vladimir.murzin@arm.com>
 <1484738003-29892-6-git-send-email-vladimir.murzin@arm.com>
 <7c1f73a9-47cb-851a-1374-4f8436a688f3@arm.com>
Message-ID: <ec3066ec-ddfe-739c-6dc7-531fa8247a96@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 15:11, Robin Murphy wrote:
> On 18/01/17 11:13, Vladimir Murzin wrote:
>> R/M classes of cpus can have memory covered by MPU which in turn might
>> configure RAM as Normal i.e. bufferable and cacheable. It breaks
>> dma_alloc_coherent() and friends, since data can stuck in caches now
>> or be buffered.
>>
>> This patch factors out DMA support for NOMMU configuration into
>> separate entity which provides dedicated dma_ops. We have to handle
>> there several cases:
>> - configurations with MMU/MPU setup
>> - configurations without MMU/MPU setup
>> - special case for M-class, since caches and MPU there are optional
>>
>> In general we rely on default DMA area for coherent allocations or/and
>> per-device memory reserves suitable for coherent DMA, so if such
>> regions are set coherent allocations go from there.
>>
>> In case MPU/MPU was not setup we fallback to normal page allocator for
>> DMA memory allocation.
>>
>> In case we run M-class cpus, for configuration without cache support
>> (like Cortex-M3/M4) dma operations are forced to be coherent and wired
>> with dma-noop (such decision is made based on cacheid global
>> variable); however, if caches are detected there and no DMA coherent
>> region is given (either default or per-device), dma is disallowed even
>> MPU is not set - it is because M-class implement system memory map
>> which defines part of address space as Normal memory.
>>
>> Reported-by: Alexandre Torgue <alexandre.torgue@st.com>
>> Reported-by: Andras Szemzo <sza@esh.hu>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/dma-mapping.h |   3 +-
>>  arch/arm/mm/Makefile               |   5 +-
>>  arch/arm/mm/dma-mapping-nommu.c    | 252 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 256 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/arm/mm/dma-mapping-nommu.c
>>
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index bf02dbd..559faad 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -20,7 +20,8 @@ static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
>>  {
>>  	if (dev && dev->archdata.dma_ops)
>>  		return dev->archdata.dma_ops;
>> -	return &arm_dma_ops;
>> +
>> +	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
>>  }
>>  
>>  static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
>> index 2ac7988..5796357 100644
>> --- a/arch/arm/mm/Makefile
>> +++ b/arch/arm/mm/Makefile
>> @@ -2,9 +2,8 @@
>>  # Makefile for the linux arm-specific parts of the memory manager.
>>  #
>>  
>> -obj-y				:= dma-mapping.o extable.o fault.o init.o \
>> -				   iomap.o
>> -
>> +obj-y				:= extable.o fault.o init.o iomap.o
>> +obj-y				+= dma-mapping$(MMUEXT).o
>>  obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
>>  				   mmap.o pgd.o mmu.o pageattr.o
>>  
>> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
>> new file mode 100644
>> index 0000000..76f00c9
>> --- /dev/null
>> +++ b/arch/arm/mm/dma-mapping-nommu.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + *  Based on linux/arch/arm/mm/dma-mapping.c
>> + *
>> + *  Copyright (C) 2000-2004 Russell King
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/export.h>
>> +#include <linux/mm.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/scatterlist.h>
>> +
>> +#include <asm/cachetype.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/outercache.h>
>> +#include <asm/cp15.h>
>> +
>> +#include "dma.h"
>> +
>> +/*
>> + *  dma_noop_ops is used if
>> + *   - MMU/MPU is off
>> + *   - cpu is v7m w/o cache support
>> + *   - device is coherent
>> + *  otherwise arm_nommu_dma_ops is used.
>> + *
>> + *  arm_nommu_dma_ops rely on consistent DMA memory (please, refer to
>> + *  [1] on how to declare such memory).
>> + *
>> + *  [1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>> + */
>> +
>> +static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>> +				 dma_addr_t *dma_handle, gfp_t gfp,
>> +				 unsigned long attrs)
>> +
>> +{
>> +	struct dma_map_ops *ops = &dma_noop_ops;
>> +
>> +	/*
>> +	 * We are here because:
>> +	 * - no consistent DMA region has been defined, so we can't
>> +	 *   continue.
>> +	 * - there is no space left in consistent DMA region, so we
>> +	 *   only can fallback to generic allocator if we are
>> +	 *   advertised that consistency is not required.
>> +	 */
>> +
>> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>> +		return ops->alloc(dev, size, dma_handle, gfp, attrs);
>> +
>> +	WARN_ON_ONCE(1);
>> +	return NULL;
>> +}
>> +
>> +static void arm_nommu_dma_free(struct device *dev, size_t size,
>> +			       void *cpu_addr, dma_addr_t dma_addr,
>> +			       unsigned long attrs)
>> +{
>> +	struct dma_map_ops *ops = &dma_noop_ops;
>> +
>> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>> +		ops->free(dev, size, cpu_addr, dma_addr, attrs);
> 
> +	else
> 
> Unlike in alloc, there's no early return...
> 
>> +	WARN_ON_ONCE(1);
> 
> ...so this would still fire for a legitimate non-consistent free.

Ahh, right, I'll fix this.

> 
> Otherwise, I think we're pretty much done - with the above fixed:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Much appreciated!

Cheers
Vladimir
