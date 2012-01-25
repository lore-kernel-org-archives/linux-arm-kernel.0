From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Jan 2012 13:37:34 -0500 (EST)
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
Message-ID: <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2012, Pawel Moll wrote:

> Since commit 576d2f2525612ecb5af029a76f21f22a3b82563d "ARM: add
> generic ioremap optimization by reusing static mappings" ioremap()
> is trying to reuse existing, static mapping when possible.
> 
> The condition checking boundaries of the requested and existing
> mappings didn't take in-page offset into consideration though,
> which lead to obscure and hard to debug problems when.

... when what?

Good catch nevertheless.

> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mm/ioremap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 80632e8..ba15937 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -225,7 +225,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>  		if ((area->flags & VM_ARM_MTYPE_MASK) != VM_ARM_MTYPE(mtype))
>  			continue;
>  		if (__phys_to_pfn(area->phys_addr) > pfn ||
> -		    __pfn_to_phys(pfn) + size-1 > area->phys_addr + area->size-1)
> +		    __pfn_to_phys(pfn) + offset + size-1 >
> +		    area->phys_addr + area->size-1)
>  			continue;
>  		/* we can drop the lock here as we know *area is static */
>  		read_unlock(&vmlist_lock);
> -- 
> 1.7.5.4
> 
> 
