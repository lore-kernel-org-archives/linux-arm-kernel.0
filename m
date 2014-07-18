From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Jul 2014 14:53:49 +0100
Subject: [PATCHv4 3/5] common: dma-mapping: Introduce common remapping
 functions
In-Reply-To: <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140718135349.GB4608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:03:36PM +0100, Laura Abbott wrote:
> +void *dma_common_pages_remap(struct page **pages, size_t size,
> +			unsigned long vm_flags, pgprot_t prot,
> +			const void *caller)
> +{
> +	struct vm_struct *area;
> +
> +	area = get_vm_area_caller(size, vm_flags, caller);
> +	if (!area)
> +		return NULL;
> +
> +	if (map_vm_area(area, prot, &pages)) {
> +		vunmap(area->addr);
> +		return NULL;
> +	}
> +
> +	return area->addr;
> +}

Why not just replace this function with vmap()? It is nearly identical.

-- 
Catalin
