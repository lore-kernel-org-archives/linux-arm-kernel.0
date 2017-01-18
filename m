From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 18 Jan 2017 14:24:35 +0000
Subject: [RFC PATCH v5 1/7] dma: Take into account dma_pfn_offset
In-Reply-To: <20170118134447.GG9529@suse.de>
References: <1484738003-29892-1-git-send-email-vladimir.murzin@arm.com>
 <1484738003-29892-2-git-send-email-vladimir.murzin@arm.com>
 <20170118134447.GG9529@suse.de>
Message-ID: <e4fedef2-4f07-669f-605b-39c599bca598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/17 13:47, Joerg Roedel wrote:
> On Wed, Jan 18, 2017 at 11:13:17AM +0000, Vladimir Murzin wrote:
>> Even though dma-noop-ops assumes 1:1 memory mapping DMA memory range
>> can be different to RAM. For example, ARM STM32F4 MCU offers the
>> possibility to remap SDRAM from 0xc000_0000 to 0x0 to get CPU
>> performance boost, but DMA continue to see SDRAM at 0xc000_0000. This
>> difference in mapping is handled via device-tree "dma-range" property
>> which leads to dev->dma_pfn_offset is set nonzero. To handle such
>> cases take dma_pfn_offset into account.
>>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reported-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  lib/dma-noop.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/dma-noop.c b/lib/dma-noop.c
>> index 3d766e7..a14eee5 100644
>> --- a/lib/dma-noop.c
>> +++ b/lib/dma-noop.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/scatterlist.h>
>> +#include <linux/pfn.h>
>>  
>>  static void *dma_noop_alloc(struct device *dev, size_t size,
>>  			    dma_addr_t *dma_handle, gfp_t gfp,
>> @@ -16,7 +17,8 @@ static void *dma_noop_alloc(struct device *dev, size_t size,
>>  
>>  	ret = (void *)__get_free_pages(gfp, get_order(size));
>>  	if (ret)
>> -		*dma_handle = virt_to_phys(ret);
>> +		*dma_handle = virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
>> +
> 
> If you need to do a '-' operation here, the offset is basically a
> cpu_pfn_offset for the device. Is that correct?
> 

dma_pfn_offset is calculated as PFN_DOWN(paddr - dma_addr) in
of_dma_configure(), it is why '-' is used here.

Cheers
Vladimir

> 
> 	Joerg
> 
> 
