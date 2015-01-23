From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Jan 2015 08:26:52 +0100
Subject: CMA region and highmem
In-Reply-To: <CAD8Lp46rqXwQR5L=-Tt_iL0CPDsKt+hVYU7-viS0uHvmVXLqng@mail.gmail.com>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
 <53F44858.2070906@samsung.com>
 <CAD8Lp47W9UcA7CHSK9xia_b9opLv-5wi_9Omj2DThRo4wYkcNw@mail.gmail.com>
 <53F5BCC3.2060609@samsung.com>
 <CAD8Lp46rqXwQR5L=-Tt_iL0CPDsKt+hVYU7-viS0uHvmVXLqng@mail.gmail.com>
Message-ID: <54C1F7BC.20604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-22 21:55, Daniel Drake wrote:
> On Thu, Aug 21, 2014 at 3:32 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> You are right, but frankly drivers doing large DMA allocations should take
>> advantage of DMA_ATTR_NO_KERNEL_MAPPING DMA attribute, because all they
>> usually do is just mapping those buffers to userspace. For a bit complex
>> example, see drivers/gpu/drm/exynos/exynos_drm_buf.c or
>> drivers/gpu/drm/msm/msm_drv.c.
> Thanks again for the insight here. Revisiting this topic now:
>
> Looking at DMA_ATTR_NO_KERNEL_MAPPING in latest linus git, this only
> seems to be implemented for IOMMU setups.
> On other setups this flag seems to be ignored, so on such setups, your
> change that tends to place the CMA region in high memory now puts
> pressure on the vmalloc area even when the driver asked for
> NO_KERNEL_MAPPING.
>
> Is there a good reason why the non-IOMMU codepath doesn't obey
> DMA_ATTR_NO_KERNEL_MAPPING?

No, it simply has not been implemented yet. Mainly because initially CMA
regions were allocated in low memory and all my development boards that time
didn't have enough memory to experiment with high mem...

> We ran a quick experiment here
> implementing this (i.e. just bailing out of __alloc_from_contiguous
> before mapping the memory into kernel space) and it seems to work.

Right. This should be enough. Feel free to submit a patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
