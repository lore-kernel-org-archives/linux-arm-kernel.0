From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 05 Feb 2014 10:15:10 +0000
Subject: [PATCH v2 4/5] ARM: init: add support for reserved memory defined
 by device tree
In-Reply-To: <1391515773-6112-5-git-send-email-m.szyprowski@samsung.com>
References: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com> <
 1391515773-6112-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20140205101510.59A95C40A89@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Feb 2014 13:09:32 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Enable reserved memory initialization from device tree.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/init.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 804d61566a53..ebafdb479410 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -17,6 +17,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/initrd.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/highmem.h>
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
> @@ -323,6 +324,8 @@ void __init arm_memblock_init(struct meminfo *mi,
>  	if (mdesc->reserve)
>  		mdesc->reserve();
>  
> +	early_init_dt_scan_reserved_mem();
> +

The new binding is being made fundamental. If the reserved-memory node
is present, then it needs to be honored, even if the kernel doesn't know
how to use the regions. Therefore, This needs to be unconditional for
all architectures. The hook should be called in early_init_dt_scan()
(drivers/of/fdt.c) immediately after the early_init_dt_scan_memory()
hook.

>  	/*
>  	 * reserve memory for DMA contigouos allocations,
>  	 * must come from DMA area inside low memory
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
