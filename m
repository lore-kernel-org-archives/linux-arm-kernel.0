From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Feb 2017 14:24:46 +0100
Subject: [PATCHv2 net-next 05/16] net: mvpp2: introduce PPv2.2 HW
 descriptors and adapt accessors
In-Reply-To: <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106142901.GC14217@n2100.armlinux.org.uk>
 <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
Message-ID: <20170203142446.2ee517a7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 6 Jan 2017 14:44:56 +0000, Robin Murphy wrote:

> >> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> >> +		dma_addr_t dma_addr =
> >> +			rx_desc->pp22.buf_phys_addr_key_hash & DMA_BIT_MASK(40);
> >> +		phys_addr_t phys_addr =
> >> +			dma_to_phys(port->dev->dev.parent, dma_addr);  
> 
> Ugh, this looks bogus. dma_to_phys(), in the arm64 case at least, is
> essentially a SWIOTLB internal helper function which has to be
> implemented in architecture code because reasons. Calling it from a
> driver is almost certainly wrong (it doesn't even exist on most
> architectures). Besides, if this is really a genuine dma_addr_t obtained
> from a DMA API call, you cannot infer it to be related to a CPU physical
> address, or convertible to one at all.

So do you have a better suggestion? The descriptors only have enough
space to store a 40-bit virtual address, which is not enough to fit the
virtual addresses used by Linux for SKBs. This is why I'm instead
relying on the fact that the descriptors can store the 40-bit physical
address, and convert it back to a virtual address, which should be fine
on ARM64 because the entire physical memory is part of the kernel linear
mapping.

> >> +		return (unsigned long)phys_to_virt(phys_addr);
> >> +#else
> >> +		return rx_desc->pp22.buf_cookie_misc & DMA_BIT_MASK(40);
> >> +#endif  
> > 
> > I'm not sure that's the best way of selecting the difference.  
> 
> Given that CONFIG_ARCH_DMA_ADDR_T_64BIT could be enabled on 32-bit LPAE
> systems, indeed it definitely isn't.

Russell proposal of testing the size of a virtual address
pointer instead would solve this I believe, correct?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
