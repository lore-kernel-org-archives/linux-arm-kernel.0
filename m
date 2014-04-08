From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Apr 2014 18:24:25 +0100
Subject: [PATCH 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140408172424.GE16373@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 04:17:51PM +0000, Thomas Petazzoni wrote:
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -968,7 +968,7 @@ static const struct of_device_id l2x0_ids[] __initconst = {
>  	{}
>  };
>  
> -int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
> +int __init l2x0_of_init_common(u32 aux_val, u32 aux_mask, bool is_coherent)
>  {
>  	struct device_node *np;
>  	const struct l2x0_of_data *data;
> @@ -1005,8 +1005,28 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>  
>  	of_init = true;
>  	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
> +
> +	/*
> +	 * PL310 doesn't need an outer cache sync operation when the
> +	 * system is operating with hardware coherency enabled, as it
> +	 * is done directly in hardware.
> +	 */
> +	if (of_device_is_compatible(np, "arm,pl310-cache") && is_coherent)
> +		outer_cache.sync = NULL;
> +

For this particular case, you can add a specific l2x0_of_data structure
with the right compatible string for your platform where
outer_cache.sync is NULL, assuming that dma_alloc_coherent() returns
Cacheable memory (e.g. your platform uses arm_coherent_dma_ops). The
only use of outer_sync() is for non-SMP barriers in relation to Normal
NonCacheable buffers.

Even if the platform has coherent I/O, you still need the range L2 cache
ops to be available for secondary CPU booting. Unless this platform can
be configured in a way similar to the "marvell,aurora-system-cache" case
and you can make all the outer_cache ops NULL.

>  	l2x0_init(l2x0_base, aux_val, aux_mask);
>  
>  	return 0;
>  }
> +
> +int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
> +{
> +	return l2x0_of_init_common(aux_val, aux_mask, false);
> +}
> +
> +int __init l2x0_of_init_coherent(u32 aux_val, u32 aux_mask)
> +{
> +	return l2x0_of_init_common(aux_val, aux_mask, true);
> +}

This could be a bit misleading. I would rather have a generic
pl310_data_dma_coherent structure (though even on coherent systems you
could still have drivers that prefer writecombine/NormalNC memory to
avoid thrashing the cache).

-- 
Catalin
