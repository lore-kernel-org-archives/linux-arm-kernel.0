From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Nov 2014 18:32:11 +0000
Subject: [PATCH v8 09/13] xen/arm/arm64: merge xen/mm32.c into xen/mm.c
In-Reply-To: <1415636045-24669-9-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
 <1415636045-24669-9-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20141110183211.GF25609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 04:14:01PM +0000, Stefano Stabellini wrote:
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -1,6 +1,10 @@
> +#include <linux/cpu.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/bootmem.h>
>  #include <linux/gfp.h>
> +#include <linux/highmem.h>
>  #include <linux/export.h>
> +#include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/dma-mapping.h>
> @@ -16,6 +20,88 @@
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/interface.h>
>  
> +enum dma_cache_op {
> +       DMA_UNMAP,
> +       DMA_MAP,
> +};
> +
> +/* functions called by SWIOTLB */
> +
> +static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
> +	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
> +{
> +	unsigned long pfn;
> +	size_t left = size;
> +
> +	pfn = (handle >> PAGE_SHIFT) + offset / PAGE_SIZE;
> +	offset %= PAGE_SIZE;
> +
> +	do {
> +		size_t len = left;
> +	
> +		BUG_ON(pfn_valid(pfn));

You probably don't need this in the loop.

> +
> +		/* TODO: cache flush */
> +
> +		offset = 0;
> +		pfn++;
> +		left -= len;
> +	} while (left);
> +}

That's smaller now ;). I have to finish reading the other patches to see
what ends up replacing TODO.

-- 
Catalin
