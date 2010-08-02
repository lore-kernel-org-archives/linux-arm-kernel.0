From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Aug 2010 11:04:19 +0100
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100802181919J.fujita.tomonori@lab.ntt.co.jp>
References: <1280736182.1902.55.camel@pasglop>
	<20100802172941C.fujita.tomonori@lab.ntt.co.jp>
	<20100802090326.GA30670@n2100.arm.linux.org.uk>
	<20100802181919J.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100802100419.GC30670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 06:20:01PM +0900, FUJITA Tomonori wrote:
> On Mon, 2 Aug 2010 10:03:26 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Mon, Aug 02, 2010 at 05:30:26PM +0900, FUJITA Tomonori wrote:
> > > ARM's iommu code (arch/plat-omap/include/plat/iommu.h) is a library to
> > > simplify the IOMMU implementations. It could be useful for all the
> > > iommu implementations.
> > 
> > ITYM OMAP's iommu code.
> 
> Yeah, I meant that we could extend it to make it useful for other
> iommu implementations. At least, we could make something generic like
> struct iommu_functions, I think. Then we can embed a generic iommu
> structure into an iommu specific struct (like we do with inode).
> 
> The current iommu-api (include/linux/iommu.h) is just about domain and
> mapping concept. We can implement it on the top of the above
> infrastructure.
> 
> I'm still trying to figure out how the DMA-API can work well with
> them.

I'm not sure it can in totality.  The DMA-API solves the host CPU <->
device aspect of DMA support only.

However, there is another use case for IOMMUs, which is to allow two
separate peripheral devices to communicate with each other via system
memory.  As the streaming DMA-API involves the idea of buffer ownership
(of a singular agent), it is unsuitable for this use case.

The coherent allocation part of the DMA-API also only deals with the
idea of there being a singular DMA agent accessing the allocated buffer
(in conjunction with the host CPU).
