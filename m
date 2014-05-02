From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 18:12:47 +0100
Subject: [PATCH] arm64: Implement cache_line_size() based on CTR_EL0.CWG
In-Reply-To: <1399046132-5760-1-git-send-email-catalin.marinas@arm.com>
References: <1399046132-5760-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140502171247.GG20642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 04:55:32PM +0100, Catalin Marinas wrote:
> The hardware provides the maximum cache line size in the system via the
> CTR_EL0.CWG bits. This patch implements the cache_line_size() function
> to read such information, together with a sanity check if the statically
> defined L1_CACHE_BYTES is smaller than the hardware value.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig                 |  3 +++
>  arch/arm64/include/asm/cache.h     | 13 ++++++++++++-
>  arch/arm64/include/asm/cachetype.h | 11 +++++++++++
>  arch/arm64/kernel/setup.c          | 15 +++++++++++++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e759af5d7098..9a5b5fea86ba 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -242,6 +242,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
>  config HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	def_bool y
>  
> +config ARCH_HAS_CACHE_LINE_SIZE
> +	def_bool y
> +
>  source "mm/Kconfig"
>  
>  config XEN_DOM0
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 390308a67f0d..88cc05b5f3ac 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -16,6 +16,8 @@
>  #ifndef __ASM_CACHE_H
>  #define __ASM_CACHE_H
>  
> +#include <asm/cachetype.h>
> +
>  #define L1_CACHE_SHIFT		6
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  
> @@ -27,6 +29,15 @@
>   * the CPU.
>   */
>  #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> -#define ARCH_SLAB_MINALIGN	8
> +
> +#ifndef __ASSEMBLY__
> +
> +static inline int cache_line_size(void)
> +{
> +	u32 cwg = cache_type_cwg();
> +	return cwg ? 4 << cwg : L1_CACHE_BYTES;
> +}

Hmmm, but the CWG is not the same thing as the L1 cache line size, so
something is amiss here. If I have an L2 cache with bigger lines, then
reporting L1_CACHE_BYTES is wrong here.

Will
