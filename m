From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 08:56:27 +0200
Subject: [PATCH v3 02/13] ARM: append ARCH_MULTI_V7_LPAE
In-Reply-To: <1397801156-25682-3-git-send-email-haojian.zhuang@linaro.org>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5350CC9B.2090102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On 18/04/2014 08:05, Haojian Zhuang wrote:
> Add new ARCH_MULTI_V7_LPAE config. It will select ARM_LPAE only both
> ARCH_MULTI_V6 & ARCH_MULTI_V7 is disabled.
> 
> ARCH_MULTI_V7 means non-LPAE platform.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/Kconfig               | 9 ++++++++-
>  arch/arm/mach-berlin/Kconfig   | 2 +-
>  arch/arm/mach-highbank/Kconfig | 2 +-
>  arch/arm/mach-mvebu/Kconfig    | 6 +++---
>  arch/arm/mach-omap2/Kconfig    | 4 ++--
>  arch/arm/mach-qcom/Kconfig     | 2 +-
>  arch/arm/mach-shmobile/Kconfig | 2 +-
>  arch/arm/mach-tegra/Kconfig    | 2 +-
>  arch/arm/mach-vexpress/Kconfig | 2 +-
>  9 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ab438cb..9a2214e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -918,12 +918,19 @@ config ARCH_MULTI_V6
>  	select CPU_V6K
>  
>  config ARCH_MULTI_V7
> -	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
> +	bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, Scorpion)"
Actually some PJ4B are also non LPAE capable


>  	default y
>  	select ARCH_MULTI_V6_V7
>  	select CPU_V7
>  	select HAVE_SMP
>  
> +config ARCH_MULTI_V7_LPAE
> +	bool "ARMv7 LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B, Krait)"
Only Armada XP is LPAE capable, and and the CPU is not a "simple" PJ4B
but a PJ4B-MP

> +	select ARCH_MULTI_V6_V7
> +	select CPU_V7
> +	select HAVE_SMP
> +	select ARM_LPAE if !(ARCH_MULTI_V6 || ARCH_MULTI_V7)
> +
>  config ARCH_MULTI_V6_V7
>  	bool
>  	select MIGHT_HAVE_CACHE_L2X0
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index b0cb072..be0512d 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_BERLIN
> -	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
> +	bool "Marvell Berlin SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V7_LPAE)
>  	select ARM_GIC
>  	select GENERIC_IRQ_CHIP
>  	select DW_APB_ICTL
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index 830b76e..9b6b3f8 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_HIGHBANK
> -	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
> +	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7_LPAE
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 3f73eec..16f69ae 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -1,5 +1,5 @@
>  config ARCH_MVEBU
> -	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
> +	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V7_LPAE || ARCH_MULTI_V5)
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
> @@ -23,7 +23,7 @@ config MACH_MVEBU_V7
>  	select CACHE_L2X0
>  
>  config MACH_ARMADA_370
> -	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
> +	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7_LPAE
Armada 370 is not LPAE capable

>  	select ARMADA_370_CLK
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7
> @@ -59,7 +59,7 @@ config MACH_ARMADA_38X
>  	  on the Marvell Armada 380/385 SoC with device tree.
>  
>  config MACH_ARMADA_XP
> -	bool "Marvell Armada XP boards" if ARCH_MULTI_V7
> +	bool "Marvell Armada XP boards" if ARCH_MULTI_V7_LPAE
>  	select ARMADA_XP_CLK
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
