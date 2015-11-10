From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Nov 2015 14:43:05 +0100
Subject: [PATCH 1/1] drivers: of: of_reserved_mem: fixup the alignment with
 CMA setup
In-Reply-To: <1447158626-7773-1-git-send-email-r64343@freescale.com>
References: <1447158626-7773-1-git-send-email-r64343@freescale.com>
Message-ID: <5641F469.2030503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-11-10 13:30, Jason Liu wrote:
> There is an alignment mismatch issue between the of_reserved_mem and
> the CMA setup requirement. The of_reserved_mem will try to get the
> alignment value from the DTS and pass it to __memblock_alloc_base to
> do the memory block base allocation, but the alignment value specified
> in the DTS may not satisfy the CAM setup requirement since CMA setup
> required the alignment as the following in the code:
>
> align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
>
> The sanity check in the function of rmem_cma_setup will fail if the
> alignment does not setup correctly and thus CMA will fail to setup.
>
> This patch is to fixup the alignment to meet the CMA setup required.
>
> Mailing-list-thread: https://lkml.org/lkml/2015/11/9/138
> Signed-off-by: Jason Liu <r64343@freescale.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/of/of_reserved_mem.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 62f467b..9394311 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -124,6 +124,10 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>   		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
>   	}
>   
> +	/* Need adjust the alignment to satisfy the CMA requirement */
> +	if (IS_ENABLED(CONFIG_CMA) && of_flat_dt_is_compatible(node, "shared-dma-pool"))
> +		align = max(align, (phys_addr_t)PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order));
> +
>   	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
>   	if (prop) {
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
