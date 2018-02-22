From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 16:58:39 +0000
Subject: [PATCH] arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache
 line size)
In-Reply-To: <20180222160638.16162-1-catalin.marinas@arm.com>
References: <20180222160638.16162-1-catalin.marinas@arm.com>
Message-ID: <20180222165839.GD18421@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 04:06:38PM +0000, Catalin Marinas wrote:
> Commit 97303480753e ("arm64: Increase the max granular size") increased
> the cache line size to 128 to match Cavium ThunderX, apparently for some
> performance benefit which could not be confirmed. This change, however,
> has an impact on the network packets allocation in certain
> circumstances, requiring slightly over a 4K page with a significant
> performance degradation.
> 
> This patch reverts L1_CACHE_SHIFT back to 6 (64-byte cache line) while
> keeping ARCH_DMA_MINALIGN at 128. The cache_line_size() function was
> changed to default to ARCH_DMA_MINALIGN in the absence of a meaningful
> CTR_EL0.CWG bit field.
> 
> In addition, if a system with ARCH_DMA_MINALIGN < CTR_EL0.CWG is
> detected, the kernel will force swiotlb bounce buffering for all
> non-coherent devices since DMA cache maintenance on sub-CWG ranges is
> not safe, leading to data corruption.
> 
> Cc: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Cc: Timur Tabi <timur@codeaurora.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/cache.h      |  6 +++---
>  arch/arm64/include/asm/dma-direct.h | 43 +++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpufeature.c      |  9 ++------
>  arch/arm64/mm/dma-mapping.c         | 15 +++++++++++++
>  arch/arm64/mm/init.c                |  3 ++-
>  6 files changed, 66 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/include/asm/dma-direct.h

[...]

> +static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> +{
> +	if (!dev->dma_mask)
> +		return false;
> +
> +	/*
> +	 * Force swiotlb buffer bouncing when ARCH_DMA_MINALIGN < CWG. The
> +	 * swiotlb bounce buffers are aligned to (1 << IO_TLB_SHIFT).
> +	 */
> +	if (static_branch_unlikely(&swiotlb_noncoherent_bounce) &&
> +	    !is_device_dma_coherent(dev) &&
> +	    !is_swiotlb_buffer(dma_to_phys(dev, addr)))
> +		return false;
> +
> +	return addr + size - 1 <= *dev->dma_mask;

I can't think of a better way to do this and hopefully this won't actually
trigger in practice, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
