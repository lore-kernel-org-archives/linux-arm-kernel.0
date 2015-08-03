From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Aug 2015 13:00:08 +0100
Subject: [PATCH] arm64: dma-mapping: Simplify pgprot handling
In-Reply-To: <a82d2ce0db8d1511ea91bb37ef8432ce33b4719e.1438363644.git.robin.murphy@arm.com>
References: <a82d2ce0db8d1511ea91bb37ef8432ce33b4719e.1438363644.git.robin.murphy@arm.com>
Message-ID: <20150803120007.GD4033@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:28:34PM +0100, Robin Murphy wrote:
> Since __get_dma_pgprot() does The Right Thing(TM) in the non-coherent
> case, and the non-cacheable alias for DMA buffers is private to the
> kernel anyway, we can simplify things slightly and make the code more
> readable by just using PAGE_KERNEL as the base pgprot.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e5d74cd..0bcc4bc 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -144,6 +144,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  	struct page *page;
>  	void *ptr, *coherent_ptr;
>  	bool coherent = is_device_dma_coherent(dev);
> +	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
>  
>  	size = PAGE_ALIGN(size);
>  
> @@ -171,9 +172,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  	/* create a coherent mapping */
>  	page = virt_to_page(ptr);
>  	coherent_ptr = dma_common_contiguous_remap(page, size, VM_USERMAP,
> -				__get_dma_pgprot(attrs,
> -					__pgprot(PROT_NORMAL_NC), false),
> -					NULL);
> +						   prot, NULL);
>  	if (!coherent_ptr)
>  		goto no_map;

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
