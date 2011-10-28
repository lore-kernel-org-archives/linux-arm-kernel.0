From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 29 Oct 2011 00:12:08 +0200
Subject: [PATCH 34/51] ARM: mach-pxa: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-35-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-35-git-send-email-will.deacon@arm.com>
Message-ID: <201110290012.08558.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch updates mach-pxa to use arm_arch_reset instead of
> arch_reset.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mach-pxa/include/mach/system.h |    6 +++---
>  arch/arm/mach-pxa/reset.c               |    8 +++++++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/include/mach/system.h
> b/arch/arm/mach-pxa/include/mach/system.h index d1fce8b..0687110 100644
> --- a/arch/arm/mach-pxa/include/mach/system.h
> +++ b/arch/arm/mach-pxa/include/mach/system.h
> @@ -11,8 +11,6 @@
>   */
> 
>  #include <asm/proc-fns.h>
> -#include "hardware.h"
> -#include "pxa2xx-regs.h"
> 
>  static inline void arch_idle(void)
>  {
> @@ -20,4 +18,6 @@ static inline void arch_idle(void)
>  }
> 
> 
> -void arch_reset(char mode, const char *cmd);
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
> diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
> index 01e9d64..075598a 100644
> --- a/arch/arm/mach-pxa/reset.c
> +++ b/arch/arm/mach-pxa/reset.c
> @@ -81,7 +81,7 @@ static void do_hw_reset(void)
>  	OSMR3 = OSCR + 368640;	/* ... in 100 ms */
>  }
> 
> -void arch_reset(char mode, const char *cmd)
> +static void pxa_arch_reset(char mode, const char *cmd)
>  {
>  	clear_reset_status(RESET_STATUS_ALL);
> 
> @@ -100,3 +100,9 @@ void arch_reset(char mode, const char *cmd)
>  	}
>  }
> 
> +static int __init pxa_arch_reset_init(void)
> +{
> +	arm_arch_reset = pxa_arch_reset;
> +	return 0;
> +}
> +arch_initcall(pxa_arch_reset_init);

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
