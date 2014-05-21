From: murzin.v@gmail.com (Vladimir Murzin)
Date: Wed, 21 May 2014 07:50:52 +0100
Subject: + arm-move-arm_dma_limit-to-setup_dma_zone.patch added to -mm tree
In-Reply-To: <CAKv+Gu_QCJn5UGyM4zEPLvkTPMnfwTM2qKYnBU42vEPwwt6-Dg@mail.gmail.com>
References: <CAKv+Gu_QCJn5UGyM4zEPLvkTPMnfwTM2qKYnBU42vEPwwt6-Dg@mail.gmail.com>
Message-ID: <CABV+yWt8vJK-ahGFhtoVbGLhkOOxy3-SLZQdaE5V1Oy+oQsh4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard

On 5/19/14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Gents,
>
> I noticed this patch turning up in -next:
> http://ozlabs.org/~akpm/mmots/broken-out/arm-move-arm_dma_limit-to-setup_dma_zone.patch
>
> which I think is incorrect. More specifically, it replaces a reference
> to arm_dma_limit, which is defined as either
>
> arch/arm/mm/init.c:177:         arm_dma_limit = PHYS_OFFSET +
> arm_dma_zone_size - 1;
>
> or
>
> arch/arm/mm/init.c:179:         arm_dma_limit = 0xffffffff;
>
> with 'arm_dma_pfn_limit << PAGE_SHIFT', which means the bottom
> PAGE_SHIFT '1' bytes are lost.
>

Do not we lost even more with
dma_contiguous_reserve
     dma_contiguous_reserve_area
...
        /* Sanitise input arguments */
        alignment = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
        base = ALIGN(base, alignment);
        size = ALIGN(size, alignment);
        limit &= ~(alignment - 1);

Vladimir

> Relevant part of patch quoted below.
>
> Regards,
> Ard.
>
>
>
>
> diff -puN arch/arm/mm/init.c~arm-move-arm_dma_limit-to-setup_dma_zone
> arch/arm/mm/init.c
> --- a/arch/arm/mm/init.c~arm-move-arm_dma_limit-to-setup_dma_zone
> +++ a/arch/arm/mm/init.c
> @@ -328,7 +329,8 @@ void __init arm_memblock_init(struct mem
>   * reserve memory for DMA contigouos allocations,
>   * must come from DMA area inside low memory
>   */
> - dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
> +
(min((phys_addr_t)arm_dma_pfn_limit << PAGE_SHIFT,
> +   arm_lowmem_limit));
>
>   arm_memblock_steal_permitted = false;
>   memblock_dump_all();
>
