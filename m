From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Jun 2011 16:59:44 +0200
Subject: [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <4DFF59BB.100@gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<4DFF59BB.100@gmail.com>
Message-ID: <000001cc2f5a$b0f1a3d0$12d4eb70$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 4:31 PM Subash Patel wrote:

> In function:
> dma_alloc_coherent()->arm_iommu_alloc_attrs()->__iommu_alloc_buffer()
> 
> I have following questions:
> 
> a) Before we come to this point, we would have enabled SYSMMU in a call
> to arm_iommu_init(). Shouldnt the SYSMMU be enabled after call to
> __iommu_alloc_buffer(), but before __iommu_create_mapping()? If in case
> the __iommu_alloc_buffer() fails, we dont disable the SYSMMU.

I want to move enabling and disabling SYSMMU completely to the runtime_pm
framework. As You can notice, the updated SYSMMU driver automatically
becomes a parent of respective multimedia device and a child of the power
domain to which both belongs. This means that sysmmu will operate only
when multimedia device is enabled, what really makes sense. The sysmmu
driver will need to be updated not to poke into the registers if it is
disabled, but this should be really trivial change.

> b) For huge buffer sizes, the pressure on SYSMMU would be very high.
> Cant we have option to dictate the page size for the IOMMU from driver
> in such cases? Should it always be the size of system pages?

This was just a first version of dma-mapping and IOMMU integration, just
to show the development road and start the discussion. Of course in the
final version support for pages larger than 4KiB is highly expected. We
can even reuse the recently posted CMA to allocate large pages for IOMMU
to improve the performance and make sure that the framework will be able
to allocate such pages even if the device is running for long time and 
memory got fragmented by typically movable pages.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
