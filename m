From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 21 Aug 2014 11:32:51 +0200
Subject: CMA region and highmem
In-Reply-To: <CAD8Lp47W9UcA7CHSK9xia_b9opLv-5wi_9Omj2DThRo4wYkcNw@mail.gmail.com>
References: <20140813191811.GP30401@n2100.arm.linux.org.uk>
 <53F44858.2070906@samsung.com>
 <CAD8Lp47W9UcA7CHSK9xia_b9opLv-5wi_9Omj2DThRo4wYkcNw@mail.gmail.com>
Message-ID: <53F5BCC3.2060609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-08-21 11:22, Daniel Drake wrote:
> Thanks Russell for looking into this! I'm also working with a large
> CMA region and had also seen a couple of OOMs which are likely the
> same thing.
>
> This will also allow for larger CMA regions to be allocated as right
> now they were limited to the largest free contiguous chunk of lowmem
> available and that does suffer a small amount of fragmentation at boot
> time.
>
> On Wed, Aug 20, 2014 at 8:03 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> There is no direct dependecy on low-mem. It was rather a heritage of initial
>> CMA implementation, which by design worked only with lowmem (there was no
>> code to allocate kernel virtual mappings from vmalloc range). The only
>> requirement about CMA regions is to put them entirely either in lowmem or
>> in highmem. I will prepare a patch swtiching default CMA region to highmem
>> if such is available and defined region fits into it.
> Just curious, to complete my understanding here...
>
> If the CMA region is now moved into highmem, when memory is allocated
> with the DMA API, such memory will now use up vmalloc space. Is that
> right?

Yes, you are right.

> In the default 3G/1G split configuration, of the 1G, 240mb is vmalloc
> space by default (and 760mb is lowmem).
>
> So, lets say your patch moves CMA into highmem, and I build a kernel
> with a 512mb CMA allocation.
>
> Now whenever anyone uses the DMA API to allocate from CMA, it will
> only be able to allocate a maximum of 240mb, later allocations will
> then fail due to lack of vmalloc space. Right?
>
> Of course, vmalloc space can be increased, but only at the expenses of
> reducing lowmem.
>
> Thanks for any clarifications!

You are right, but frankly drivers doing large DMA allocations should take
advantage of DMA_ATTR_NO_KERNEL_MAPPING DMA attribute, because all they
usually do is just mapping those buffers to userspace. For a bit complex
example, see drivers/gpu/drm/exynos/exynos_drm_buf.c or
drivers/gpu/drm/msm/msm_drv.c.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
