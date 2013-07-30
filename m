From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jul 2013 22:15:01 +0100
Subject: [PATCH v2 3/9] ARM: msm: Move debug-macro.S to include/debug
In-Reply-To: <1374699274-18388-4-git-send-email-sboyd@codeaurora.org>
References: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
 <1374699274-18388-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130730211501.GT24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 01:54:28PM -0700, Stephen Boyd wrote:
> One more step to allowing MSM to participate in the
> multi-platform defconfig.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig.debug                             |  9 +++-
>  .../mach/debug-macro.S => include/debug/msm.S}     | 32 ++++++++++-
>  arch/arm/mach-msm/include/mach/msm_iomap-8960.h    |  5 --
>  arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |  5 --
>  arch/arm/mach-msm/include/mach/msm_iomap.h         | 12 -----
>  arch/arm/mach-msm/include/mach/uncompress.h        | 63 ----------------------
>  arch/arm/mach-msm/io.c                             | 40 +++++++-------
>  7 files changed, 58 insertions(+), 108 deletions(-)
>  rename arch/arm/{mach-msm/include/mach/debug-macro.S => include/debug/msm.S} (61%)
>  delete mode 100644 arch/arm/mach-msm/include/mach/uncompress.h
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e401a76..4a62a8d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -777,6 +777,11 @@ config DEBUG_LL_INCLUDE
>  				 DEBUG_IMX6SL_UART
>  	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
>  				      DEBUG_KEYSTONE_UART1
> +	default "debug/msm.S" if DEBUG_MSM_UART1 || \
> +				 DEBUG_MSM_UART2 || \
> +				 DEBUG_MSM_UART3 || \
> +				 DEBUG_MSM8660_UART || \
> +				 DEBUG_MSM8960_UART
>  	default "debug/mvebu.S" if DEBUG_MVEBU_UART || \
>  				   DEBUG_MVEBU_UART_ALTERNATE
>  	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
> @@ -804,13 +809,13 @@ config DEBUG_LL_INCLUDE
>  
>  config DEBUG_UNCOMPRESS
>  	bool
> -	default y if ARCH_MULTIPLATFORM && DEBUG_LL && \
> +	default y if (ARCH_MULTIPLATFORM || ARCH_MSM) && DEBUG_LL && \
>  		     !DEBUG_OMAP2PLUS_UART && \
>  		     !DEBUG_TEGRA_UART
>  
>  config UNCOMPRESS_INCLUDE
>  	string
> -	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
> +	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM
>  	default "mach/uncompress.h"

I hope the above two aren't going to grow.

>  	{
>  		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
>  		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
>  		.length =   MSM_SHARED_RAM_SIZE,
>  		.type =     MT_DEVICE,
>  	},

A comment here mentioning that the below must be the last entry would
probably be a good idea as you overwrite the virtual/pfn members of this
last entry.

> +#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
> +		defined(CONFIG_DEBUG_MSM_UART3)
> +	{
> +		/* virtual and pfn filled in by debug_ll_addr() */
> +		.length = SZ_4K,
> +		.type = MT_DEVICE_NONSHARED,
> +	}
> +#endif

Other than that, this seems to be fine.
