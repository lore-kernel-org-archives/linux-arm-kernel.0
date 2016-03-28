From: konrad@kernel.org (Konrad Rzeszutek Wilk)
Date: Mon, 28 Mar 2016 14:29:29 -0400
Subject: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
In-Reply-To: <56EC1805.5060207@codeaurora.org>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-2-git-send-email-okaya@codeaurora.org>
 <56EBF09A.1060503@arm.com> <56EC1805.5060207@codeaurora.org>
Message-ID: <CACJDEmrzKOExg-Rchjy2hfVzkzbCZ=WNn4Bu3EVgim748VvRig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 11:00 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/18/2016 8:12 AM, Robin Murphy wrote:
>> Since we know for sure that swiotlb_to_phys is a no-op on arm64, it might be cleaner to simply not reference it at all. I suppose we could have some private local wrappers, e.g.:
>>
>> #define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
>>
>> to keep the intent of the code clear (and just in case anyone ever builds a system mad enough to warrant switching out that definition, but I'd hope that never happens).
>>
>> Otherwise, looks good - thanks for doing this!
>
> OK. I added this. Reviewed-by?
>
> I'm not happy to submit such a big patch for all different ARCHs. I couldn't
> find a cleaner solution. I'm willing to split this patch into multiple if there
> is a better way.
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index ada00c3..8c0f66b 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -29,6 +29,14 @@
>
>  #include <asm/cacheflush.h>
>
> +/*
> + * If you are building a system without IOMMU, then you are using SWIOTLB
> + * library. The ARM64 adaptation of this library does not support address
> + * translation and it assumes that physical address = dma address for such
> + * a use case. Please don't build a platform that violates this.
> + */

Why not just expand the ARM64 part to support address translation?

> +#define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
> +

Adding Stefano here.

>  static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
>                                  bool coherent)
>  {
> @@ -188,7 +196,7 @@ static void __dma_free(struct device *dev, size_t size,
>                        void *vaddr, dma_addr_t dma_handle,
>                        struct dma_attrs *attrs)
>  {
> -       void *swiotlb_addr = phys_to_virt(swiotlb_dma_to_phys(dev, dma_handle));
> +       void *swiotlb_addr = swiotlb_to_virt(dma_handle);
>
>         size = PAGE_ALIGN(size);
>
> @@ -209,8 +217,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
>
>         dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
>         if (!is_device_dma_coherent(dev))
> -               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
> -                              size, dir);
> +               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
>
>         return dev_addr;
>  }
> @@ -283,8 +290,7 @@ static void __swiotlb_sync_single_for_device(struct device *dev,
>  {
>         swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
>         if (!is_device_dma_coherent(dev))
> -               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
> -                              size, dir);
> +               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
>  }
>
>
>
>
> --
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
