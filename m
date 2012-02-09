From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Feb 2012 22:12:32 -0800 (PST)
Subject: [PATCH v2 1/4] ARM: make arch_ret_to_user macro optional
In-Reply-To: <1328751219-2552-2-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
 <1328751219-2552-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1202082210540.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Feb 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Only 3 platforms need arch_ret_to_user macro, so add NEED_RET_TO_USER
> kconfig option and make iop13xx, iop32x and iop33x select it.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/Kconfig               |    6 ++++++
>  arch/arm/kernel/entry-common.S |    8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a48aecc..7d809b7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -186,6 +186,9 @@ config GENERIC_ISA_DMA
>  config FIQ
>  	bool
>  
> +config NEED_RET_TO_USER
> +	bool
> +
>  config ARCH_MTD_XIP
>  	bool
>  
> @@ -479,6 +482,7 @@ config ARCH_IOP13XX
>  	select ARCH_SUPPORTS_MSI
>  	select VMSPLIT_1G
>  	select NEED_MACH_MEMORY_H
> +	select NEED_RET_TO_USER
>  	help
>  	  Support for Intel's IOP13XX (XScale) family of processors.
>  
> @@ -486,6 +490,7 @@ config ARCH_IOP32X
>  	bool "IOP32x-based"
>  	depends on MMU
>  	select CPU_XSCALE
> +	select NEED_RET_TO_USER
>  	select PLAT_IOP
>  	select PCI
>  	select ARCH_REQUIRE_GPIOLIB
> @@ -497,6 +502,7 @@ config ARCH_IOP33X
>  	bool "IOP33x-based"
>  	depends on MMU
>  	select CPU_XSCALE
> +	select NEED_RET_TO_USER
>  	select PLAT_IOP
>  	select PCI
>  	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 9fd0ba9..54ee265 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -10,9 +10,15 @@
>  
>  #include <asm/unistd.h>
>  #include <asm/ftrace.h>
> -#include <mach/entry-macro.S>
>  #include <asm/unwind.h>
>  
> +#ifdef CONFIG_NEED_RET_TO_USER
> +#include <mach/entry-macro.S>
> +#else
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +#endif
> +
>  #include "entry-header.S"
>  
>  
> -- 
> 1.7.5.4
> 
