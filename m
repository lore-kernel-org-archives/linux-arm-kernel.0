From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Dec 2017 10:22:35 +0000
Subject: [PATCH 01/10] arm64: add kconfig symbol to configure physical
 address size
In-Reply-To: <1513184845-8711-2-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-2-git-send-email-kristina.martsenko@arm.com>
Message-ID: <21d0fcaf-d454-6a75-f617-22b87de0b49f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 17:07, Kristina Martsenko wrote:
> ARMv8.2 introduces support for 52-bit physical addresses. To prepare for
> supporting this, add a new kconfig symbol to configure the physical
> address space size. The symbols will be used in subsequent patches.
> Currently the only choice is 48, a later patch will add the option of 52
> once the required code is in place.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm64/Kconfig | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a93339f5178f..8dc937823eeb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -646,6 +646,22 @@ config ARM64_VA_BITS
>   	default 47 if ARM64_VA_BITS_47
>   	default 48 if ARM64_VA_BITS_48
>   
> +choice
> +	prompt "Physical address space size"
> +	default ARM64_PA_BITS_48
> +	help
> +	  Choose the maximum physical address range that the kernel will
> +	  support.
> +
> +config ARM64_PA_BITS_48
> +	bool "48-bit"
> +
> +endchoice
> +
> +config ARM64_PA_BITS
> +	int
> +	default 48 if ARM64_PA_BITS_48
> +
>   config CPU_BIG_ENDIAN
>          bool "Build big-endian kernel"
>          help
> 

We could replace most of the hard coded "48" PA limit values to ARM64_PA_BITS,
now that we have a configurable entity. i.e, you could fold  patch 7 & 8 into
this one.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
