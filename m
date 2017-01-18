From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Jan 2017 14:56:00 +0000
Subject: [RFC PATCH v5 1/7] dma: Take into account dma_pfn_offset
In-Reply-To: <20170118134447.GG9529@suse.de>
References: <1484738003-29892-1-git-send-email-vladimir.murzin@arm.com>
 <1484738003-29892-2-git-send-email-vladimir.murzin@arm.com>
 <20170118134447.GG9529@suse.de>
Message-ID: <490ac8b1-b5b6-1b64-50c2-6602e89f9b0d@arm.com>
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

Effectively, yes. The value of dev->dma_pfn_offset can be thought of as
the physical (CPU) PFN to which "bus PFN" 0 (for the given device)
corresponds. On the Keystone platform which begat this machinery, the
DRAM is at 0x08_000_0000-0x09_ffff_ffff, but there is an I/O-coherent
alias of the first 2GB which appears at 0x00_8000_0000-0x00_ffff_ffff to
devices - thus on that platform 32-bit devices get a dma_mask of
0x7fff_ffff and a dma_pfn_offset of 0x7_8000_0000 >> PAGE_SHIFT, and
everything works out.

The STM32 situation is a bit funkier, as it's actually the CPU which is
making use of a DRAM alias there, but we achieve the same effect by
giving all the DMA masters a (negative) offset to compensate, such that
subtracting the offset translates addresses from the alias region back
to the "real" physical address when handed off to a DMA master.

Robin.

> 
> 
> 	Joerg
> 
