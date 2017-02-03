From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Feb 2017 16:02:27 +0100
Subject: [PATCHv2 net-next 05/16] net: mvpp2: introduce PPv2.2 HW
 descriptors and adapt accessors
In-Reply-To: <231514f4-2e35-8bde-4469-aada833635aa@arm.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106142901.GC14217@n2100.armlinux.org.uk>
 <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
 <20170203142446.2ee517a7@free-electrons.com>
 <231514f4-2e35-8bde-4469-aada833635aa@arm.com>
Message-ID: <20170203160227.08b40c58@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 3 Feb 2017 14:05:13 +0000, Robin Murphy wrote:

> > So do you have a better suggestion? The descriptors only have enough
> > space to store a 40-bit virtual address, which is not enough to fit the
> > virtual addresses used by Linux for SKBs. This is why I'm instead
> > relying on the fact that the descriptors can store the 40-bit physical
> > address, and convert it back to a virtual address, which should be fine
> > on ARM64 because the entire physical memory is part of the kernel linear
> > mapping.  
> 
> OK, that has nothing to do with DMA addresses then.

Well, it has to do with DMA in the sense that those buffers are
mapped with dma_map_single(). So the address that is given to us by the
hardware as the "physical address of the RX buffer" is the one that we
have initially given to the hardware and was the result of 
dma_map_single().

> > Russell proposal of testing the size of a virtual address
> > pointer instead would solve this I believe, correct?  
> 
> AFAICS, even that shouldn't really be necessary - for all VA/PA
> combinations of 32/32, 32/40 and 64/40, storing virt_to_phys() of the
> SKB VA won't overflow 40 bits,

I'm already lost here. Why are you talking about virt_to_phys() ? See
above: we have the dma_addr_t returned from dma_map_single(), and we
need to find back the corresponding virtual address, because there is
not enough room in the HW descriptors to store a full 64-bit VA.

> so a corresponding phys_to_virt() at the other end can't go wrong
> either. If you really do want to special-case things based on VA
> size, though, either CONFIG_64BIT or sizeof(void *) would indeed be
> infinitely more useful than the unrelated DMA address width - I know
> this driver's never going to run on SPARC64, but that's one example
> of where the above logic would lead to precisely the truncated VA
> it's trying to avoid.

What is different on SPARC64 here?

The situation we have is the following:

 - On systems where VAs are 32-bit wide, we have enough room to store
   the VA in the HW descriptor. So when we receive a packet, the HW
   descriptor provides us directly with the VA of the network packet,
   and the DMA address of the packet. We can dma_unmap_single() the
   packet, and do its processing.

 - On systems where VAs are 64-bit wide, we don't have enough room to
   store the VA in the HW descriptor. However, on 64-bit systems, the
   entire physical memory is mapped in the kernel linear mapping, so
   phys_to_virt() is valid on any physical address. And we use this
   property to retrieve the full 64-bit VA using the DMA address that
   we get from the HW descriptor.

   Since what we get from the HW descriptor is a DMA address, that's
   why we're using phys_to_virt(dma_to_phys(...)).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
