From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 3 Feb 2017 14:05:13 +0000
Subject: [PATCHv2 net-next 05/16] net: mvpp2: introduce PPv2.2 HW
 descriptors and adapt accessors
In-Reply-To: <20170203142446.2ee517a7@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106142901.GC14217@n2100.armlinux.org.uk>
 <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
 <20170203142446.2ee517a7@free-electrons.com>
Message-ID: <231514f4-2e35-8bde-4469-aada833635aa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/17 13:24, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 6 Jan 2017 14:44:56 +0000, Robin Murphy wrote:
> 
>>>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>> +		dma_addr_t dma_addr =
>>>> +			rx_desc->pp22.buf_phys_addr_key_hash & DMA_BIT_MASK(40);
>>>> +		phys_addr_t phys_addr =
>>>> +			dma_to_phys(port->dev->dev.parent, dma_addr);  
>>
>> Ugh, this looks bogus. dma_to_phys(), in the arm64 case at least, is
>> essentially a SWIOTLB internal helper function which has to be
>> implemented in architecture code because reasons. Calling it from a
>> driver is almost certainly wrong (it doesn't even exist on most
>> architectures). Besides, if this is really a genuine dma_addr_t obtained
>> from a DMA API call, you cannot infer it to be related to a CPU physical
>> address, or convertible to one at all.
> 
> So do you have a better suggestion? The descriptors only have enough
> space to store a 40-bit virtual address, which is not enough to fit the
> virtual addresses used by Linux for SKBs. This is why I'm instead
> relying on the fact that the descriptors can store the 40-bit physical
> address, and convert it back to a virtual address, which should be fine
> on ARM64 because the entire physical memory is part of the kernel linear
> mapping.

OK, that has nothing to do with DMA addresses then.

>>>> +		return (unsigned long)phys_to_virt(phys_addr);
>>>> +#else
>>>> +		return rx_desc->pp22.buf_cookie_misc & DMA_BIT_MASK(40);
>>>> +#endif  
>>>
>>> I'm not sure that's the best way of selecting the difference.  
>>
>> Given that CONFIG_ARCH_DMA_ADDR_T_64BIT could be enabled on 32-bit LPAE
>> systems, indeed it definitely isn't.
> 
> Russell proposal of testing the size of a virtual address
> pointer instead would solve this I believe, correct?

AFAICS, even that shouldn't really be necessary - for all VA/PA
combinations of 32/32, 32/40 and 64/40, storing virt_to_phys() of the
SKB VA won't overflow 40 bits, so a corresponding phys_to_virt() at the
other end can't go wrong either. If you really do want to special-case
things based on VA size, though, either CONFIG_64BIT or sizeof(void *)
would indeed be infinitely more useful than the unrelated DMA address
width - I know this driver's never going to run on SPARC64, but that's
one example of where the above logic would lead to precisely the
truncated VA it's trying to avoid.

Robin.

> 
> Thanks,
> 
> Thomas
> 
