From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 10:14:36 +0100
Subject: [PATCH v3 26/40] Subject: ARM: mm: proc-feroceon: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-27-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-27-git-send-email-dave.martin@linaro.org>
Message-ID: <20110707091436.GK8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 06:50:34PM +0100, Dave Martin wrote:
> -ENTRY(feroceon_cache_fns)
> -	.long	feroceon_flush_icache_all
> -	.long	feroceon_flush_kern_cache_all
> -	.long	feroceon_flush_user_cache_all
> -	.long	feroceon_flush_user_cache_range
> -	.long	feroceon_coherent_kern_range
> -	.long	feroceon_coherent_user_range
> -	.long	feroceon_flush_kern_dcache_area
> -	.long	feroceon_dma_map_area
> -	.long	feroceon_dma_unmap_area
> -	.long	feroceon_dma_flush_range
> -
> -ENTRY(feroceon_range_cache_fns)
> -	.long	feroceon_flush_icache_all
> -	.long	feroceon_flush_kern_cache_all
> -	.long	feroceon_flush_user_cache_all
> -	.long	feroceon_flush_user_cache_range
> -	.long	feroceon_coherent_kern_range
> -	.long	feroceon_coherent_user_range
> -	.long	feroceon_range_flush_kern_dcache_area
> -	.long	feroceon_range_dma_map_area
> -	.long	feroceon_dma_unmap_area
> -	.long	feroceon_range_dma_flush_range
> +	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
> +	define_cache_functions feroceon, default=feroceon
> +	define_cache_functions feroceon_range, default=feroceon, \
> +		flush_kern_dcache_area=feroceon_range_flush_kern_dcache_area, \
> +		dma_map_area=feroceon_range_dma_map_area, \
> +		dma_flush_range=feroceon_range_dma_flush_range

That's unique enough that it can be left as-is I think, rather than
having to add that special knowledge into the macro.

A solution to this would be to alias (using .equ) the feroceon_xxx
functions to feroceon_range_xxx, and then use the standard
define_cache_functions macro, which would be more in keeping with
the way these things are supposed to work.
