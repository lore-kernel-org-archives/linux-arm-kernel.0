From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 18 Sep 2015 12:04:26 +0100
Subject: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
In-Reply-To: <1442566550.8145.156.camel@mhfsdcap03>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
 <1442566550.8145.156.camel@mhfsdcap03>
Message-ID: <55FBEFBA.6000606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/15 09:55, Yong Wu wrote:
> On Thu, 2015-09-17 at 17:42 +0100, Robin Murphy wrote:
[...]
>> the appropriate course of action. Further care (and ugliness) is also
>> necessary in the comparison to avoid truncation if phys_addr_t and
>> dma_addr_t differ in size.
[...]
>>   		/*
>>   		 * We depend on the IOMMU being able to work with any physical
>> -		 * address directly, so if the DMA layer suggests it can't by
>> -		 * giving us back some translation, that bodes very badly...
>> +		 * address directly, so if the DMA layer suggests otherwise by
>> +		 * translating or truncating them, that bodes very badly...
>>   		 */
>> -		if (dma != __arm_lpae_dma_addr(dev, pages))
>> +		if (dma != virt_to_phys(pages))
>
> Could I ask why not use __arm_lpae_dma_addr(pages) here?
> dma is dma_addr_t.

Specifically, the problem case for that is when phys_addr_t is 64-bit 
but dma_addr_t is 32-bit. The cast in __arm_lpae_dma_addr is necessary 
to avoid a truncation warning when we make the DMA API calls, but we 
actually need the opposite in the comparison here - comparing the 
different types directly allows integer promotion to kick in 
appropriately so we don't lose the top half of the larger address. 
Otherwise, you'd never spot the difference between, say, your original 
page at 0x88c0000000 and a bounce-buffered copy that happened to end up 
mapped to 0xc0000000.

Robin.
