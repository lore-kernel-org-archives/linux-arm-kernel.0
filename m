From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Mar 2015 20:17:53 +0000
Subject: ARM: OMPA4+: is it expected dma_coerce_mask_and_coherent(dev,
 DMA_BIT_MASK(64)); to fail?
In-Reply-To: <54F8A68B.3080709@linaro.org>
References: <54F8A68B.3080709@linaro.org>
Message-ID: <20150305201753.GG29584@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 08:55:07PM +0200, Grygorii.Strashko at linaro.org wrote:
> Now I can see very interesting behavior related to dma_coerce_mask_and_coherent()
> and friends which I'd like to explain and clarify.
> 
> Below is set of questions I have (why - I explained below):
> - Is expected dma_coerce_mask_and_coherent(DMA_BIT_MASK(64)) and friends to fail on 32 bits HW?

Not really.

> - What is expected value for max_pfn: max_phys_pfn or max_phys_pfn + 1?

mm/page_owner.c:
        /* Find an allocated page */
        for (; pfn < max_pfn; pfn++) {

drivers/base/platform.c:    u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
drivers/base/platform.c:    u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));

So, there's ample evidence that max_pfn is one more than the greatest pfn
which may be used in the system.

> - What is expected value for struct memblock_region->size: mem_range_size or mem_range_size - 1?

A size is a size - it's a number of bytes contained within the region.
If it is value 1, then there is exactly one byte in the region.  If
there are 0x7fffffff, then there are 2G-1 bytes in the region, not 2G.

> - What is expected value to be returned by memblock_end_of_DRAM():
>   @base + @size(max_phys_addr + 1) or @base + @size - 1(max_phys_addr)?

The last address plus one in the system.  However, there's a problem here.
On a 32-bit system, phys_addr_t may be 32-bit.  If it is 32-bit, then
"last address plus one" could be zero, which makes no sense.  Hence, it
is artificially reduced to 0xfffff000, thereby omitting the final page.

> Example 3 CONFIG_ARM_LPAE=y (but system really works with 32 bit address space):
> 	memory {
> 		device_type = "memory";
> 		reg = <0x80000000 0x80000000>;
> 	};
> 
>   memblock will be configured as:
> 	memory.cnt  = 0x1
> 	memory[0x0]     [0x00000080000000-0x000000ffffffff], 0x80000000 bytes flags: 0x0
> 							     ^^^^^^^^^^
>   max_pfn = 0x00100000
> 
> The dma_coerce_mask_and_coherent() will fail in case 'Example 3' and succeed in cases 1,2.
> dma-mapping.c --> __dma_supported()
> 	if (sizeof(mask) != sizeof(dma_addr_t) && <== true for all OMAP4+
> 	    mask > (dma_addr_t)~0 &&		<== true for DMA_BIT_MASK(64)
> 	    dma_to_pfn(dev, ~0) < max_pfn) {  <== true only for Example 3

Hmm, I think this may make more sense to be "< max_pfn - 1" here, as
that would be better suited to our intention.

The result of dma_to_pfn(dev, ~0) is the maximum PFN which we could
address via DMA, but we're comparing it with the maximum PFN in the
system plus 1 - so we need to subtract one from it.

Please think about this and test this out; I'm not back to normal yet
(post-op) so I could very well not be thinking straight yet.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
