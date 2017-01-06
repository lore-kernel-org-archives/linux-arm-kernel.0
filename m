From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 6 Jan 2017 14:44:56 +0000
Subject: [PATCHv2 net-next 05/16] net: mvpp2: introduce PPv2.2 HW
 descriptors and adapt accessors
In-Reply-To: <20170106142901.GC14217@n2100.armlinux.org.uk>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106142901.GC14217@n2100.armlinux.org.uk>
Message-ID: <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 14:29, Russell King - ARM Linux wrote:
> On Wed, Dec 28, 2016 at 05:46:21PM +0100, Thomas Petazzoni wrote:
>> This commit adds the definition of the PPv2.2 HW descriptors, adjusts
>> the mvpp2_tx_desc and mvpp2_rx_desc structures accordingly, and adapts
>> the accessors to work on both PPv2.1 and PPv2.2.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ...
>> +		/* On PPv2.2, the situation is more complicated,
>> +		 * because there is only 40 bits to store the virtual
>> +		 * address, which is not sufficient. So on 64 bits
>> +		 * systems, we use phys_to_virt() to get the virtual
>> +		 * address from the physical address, which is fine
>> +		 * because the kernel linear mapping includes the
>> +		 * entire 40 bits physical address space. On 32 bits
>> +		 * systems however, we can't use phys_to_virt(), but
>> +		 * since virtual addresses are 32 bits only, there is
>> +		 * enough space in the RX descriptor for the full
>> +		 * virtual address.
>> +		 */
>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +		dma_addr_t dma_addr =
>> +			rx_desc->pp22.buf_phys_addr_key_hash & DMA_BIT_MASK(40);
>> +		phys_addr_t phys_addr =
>> +			dma_to_phys(port->dev->dev.parent, dma_addr);

Ugh, this looks bogus. dma_to_phys(), in the arm64 case at least, is
essentially a SWIOTLB internal helper function which has to be
implemented in architecture code because reasons. Calling it from a
driver is almost certainly wrong (it doesn't even exist on most
architectures). Besides, if this is really a genuine dma_addr_t obtained
from a DMA API call, you cannot infer it to be related to a CPU physical
address, or convertible to one at all.

>> +
>> +		return (unsigned long)phys_to_virt(phys_addr);
>> +#else
>> +		return rx_desc->pp22.buf_cookie_misc & DMA_BIT_MASK(40);
>> +#endif
> 
> I'm not sure that's the best way of selecting the difference.

Given that CONFIG_ARCH_DMA_ADDR_T_64BIT could be enabled on 32-bit LPAE
systems, indeed it definitely isn't.

Robin.

>  It seems
> that the issue here is the size of the virtual address, so why not test
> the size of a virtual address pointer?
> 
> 		if (8 * sizeof(rx_desc) > 40) {
> 			/* do phys addr dance */
> 		} else {
> 			return rx_desc->pp22.buf_cookie_misc & DMA_BIT_MASK(40);
> 		}
> 
> It also means that we get compile coverage over both sides of the
> conditional.
> 
