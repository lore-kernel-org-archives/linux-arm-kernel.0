From: robherring2@gmail.com (Rob Herring)
Date: Sun, 10 Jul 2011 09:29:49 -0500
Subject: [PATCH 2/6] ARM: move ARCH_HAS_DMA_SET_COHERENT_MASK into memory.h
In-Reply-To: <20110709145856.GM4812@n2100.arm.linux.org.uk>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<1309366019-24379-3-git-send-email-robherring2@gmail.com>
	<4E1866A2.9040407@gmail.com>
	<20110709145856.GM4812@n2100.arm.linux.org.uk>
Message-ID: <4E19B75D.2080109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2011 09:58 AM, Russell King - ARM Linux wrote:
> On Sat, Jul 09, 2011 at 09:33:06AM -0500, Rob Herring wrote:
>> I noticed this is going to have conflicts with your ARM_DMA_ZONE_SIZE
>> series. Can you add this into your series? This still presents another
>> issue to solve for single kernel binary, but hopefully the dma mapping
>> work will help.
> 
> That's a different problem - its about limiting the maximum DMA mask
> which can be set, so that memory is sourced from the right place
> even for drivers which use 32-bit masks.

Yes, I know that they are different.

> It's needed to ensure that dma_set_coherent_mask() can be overridden.
> One solution to it would be to ensure that we always define
> ARCH_HAS_DMA_SET_COHERENT_MASK, and handle the differences internally,
> which is something I've been thinking about adding to my DMA bounce
> series of patches.

asm/dma-mapping.h only includes asm/memory.h. We are getting lucky that
linux/dma-mapping.h is picking up ARCH_HAS_DMA_SET_COHERENT_MASK because
the include path looks like this for ixp4xx and pxa: linux/dma-mapping.h
-> linux/scatterlist.h -> asm/io.h -> mach/io.h -> mach/hardware.h.

I was previously thinking the define was getting picked up thru
asm/pci.h somehow. So I can just drop this from my series. It does need
to get fixed though or other header re-working could silently break this.

Rob
