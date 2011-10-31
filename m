From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 10:36:10 +0000
Subject: [RFC PATCH] arm: dma: Drop GFP_COMP for DMA memory allocations
In-Reply-To: <1319836732-31687-1-git-send-email-swarren@nvidia.com>
References: <1319836732-31687-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111031103610.GG19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 03:18:52PM -0600, Stephen Warren wrote:
> I believe the patch below was once posted to solve this for ARM, but never
> got picked up. Evidently, AVR32 did pick it up. I'm wondering if we should
> pick this up for ARM now, or if there's some other solution?

Well, Nick did talk about a solution using GFP_USERMAP in one of those
threads, which doesn't seem to have gone anywhere.  So I guess we need
this patch.

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 82a093c..93b86e6 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -308,6 +308,13 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
>  	struct page *page;
>  	void *addr;
>  
> +	/* Following is a work-around (a.k.a. hack) to prevent pages
> +	 * with __GFP_COMP being passed to split_page() which cannot
> +	 * handle them.  The real problem is that this flag probably
> +	 * should be 0 on ARM as it is not supported on this
> +	 * platform--see CONFIG_HUGETLB_PAGE. */

I don't think this comment makes sense anymore - HUGETLB_PAGE doesn't
have any help text.

> +	gfp &= ~(__GFP_COMP);
> +
>  	*handle = ~0;
>  	size = PAGE_ALIGN(size);
>  
> -- 
> 1.7.0.4
> 
> 
