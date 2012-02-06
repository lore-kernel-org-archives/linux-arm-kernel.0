From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 06 Feb 2012 14:21:38 -0800 (PST)
Subject: [PATCH 1/3] ARM: make arch_ret_to_user macro optional
In-Reply-To: <1328562200-8810-2-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1202061417210.1656@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Feb 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Only 3 platforms need arch_ret_to_user macro, so add ARCH_HAS_RET_TO_USER
> kconfig option and make iop13xx, iop32x and iop33x select it.

Please make it CONFIG_NEED_RET_TO_USER instead to more clearly indicate 
why it is there.  See NEED_MACH_MEMORY_H for example.

> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig               |    6 ++++++
>  arch/arm/kernel/entry-common.S |    8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a48aecc..322f2ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -43,6 +43,9 @@ config ARM
>  config ARM_HAS_SG_CHAIN
>  	bool
>  
> +config ARCH_HAS_RET_TO_USER
> +	bool
> +
>  config HAVE_PWM
>  	bool
>  
> @@ -473,6 +476,7 @@ config ARCH_H720X
>  config ARCH_IOP13XX
>  	bool "IOP13xx-based"
>  	depends on MMU
> +	select ARCH_HAS_RET_TO_USER
>  	select CPU_XSC3
>  	select PLAT_IOP
>  	select PCI
> @@ -485,6 +489,7 @@ config ARCH_IOP13XX
>  config ARCH_IOP32X
>  	bool "IOP32x-based"
>  	depends on MMU
> +	select ARCH_HAS_RET_TO_USER
>  	select CPU_XSCALE
>  	select PLAT_IOP
>  	select PCI
> @@ -496,6 +501,7 @@ config ARCH_IOP32X
>  config ARCH_IOP33X
>  	bool "IOP33x-based"
>  	depends on MMU
> +	select ARCH_HAS_RET_TO_USER
>  	select CPU_XSCALE
>  	select PLAT_IOP
>  	select PCI
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 9fd0ba9..5fe6ea8 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -10,9 +10,15 @@
>  
>  #include <asm/unistd.h>
>  #include <asm/ftrace.h>
> -#include <mach/entry-macro.S>
>  #include <asm/unwind.h>
>  
> +#ifdef CONFIG_ARCH_HAS_RET_TO_USER
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
