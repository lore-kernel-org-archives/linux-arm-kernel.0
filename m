From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 9 Dec 2016 16:27:45 +0100
Subject: [PATCH] nommu: allow mmap when !CONFIG_MMU
In-Reply-To: <1480600080-30196-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1480600080-30196-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <CA+M3ks67a9H2Ro87mPZ1_3=ucnyWNMMKnr_EW=dLS1kBxuU3Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Vladimir

2016-12-01 14:48 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> commit ab6494f0c96f ("nommu: Add noMMU support to the DMA API") have
> add CONFIG_MMU compilation flag but that prohibit to use dma_mmap_wc()
> when the platform doesn't have MMU.
>
> This patch call vm_iomap_memory() in noMMU case to test if addresses
> are correct and set wma->vm_flags rather than all return an error.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: arnd at arndb.de
> ---
>  arch/arm/mm/dma-mapping.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ab4f745..230875e 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -868,6 +868,9 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>                                       vma->vm_end - vma->vm_start,
>                                       vma->vm_page_prot);
>         }
> +#else
> +       ret = vm_iomap_memory(vma, vma->vm_start,
> +                             (vma->vm_end - vma->vm_start));
>  #endif /* CONFIG_MMU */
>
>         return ret;
> --
> 1.9.1
>
