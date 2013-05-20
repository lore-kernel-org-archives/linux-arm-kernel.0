From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 May 2013 14:53:21 +0100
Subject: [RFC PATCH 2/6] ARM: imx: use the core cpu hotplug functions
In-Reply-To: <1369031608-27347-3-git-send-email-sanjay.rawat@linaro.org>
References: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
 <1369031608-27347-3-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <20130520135321.GW18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please read back on this list for my comments about such moves of this
very code.  You're not the first.

On Mon, May 20, 2013 at 12:03:24PM +0530, Sanjay Singh Rawat wrote:
> Generic arm cpu hotplug related functions are moved to core hotplug code,
> remove the functions from the platform code.
> 
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>  arch/arm/mach-imx/hotplug.c |   22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
> index 3daf1ed..280c6f3 100644
> --- a/arch/arm/mach-imx/hotplug.c
> +++ b/arch/arm/mach-imx/hotplug.c
> @@ -14,30 +14,10 @@
>  #include <linux/jiffies.h>
>  #include <asm/cp15.h>
>  #include <asm/proc-fns.h>
> +#include <asm/hotplug.h>
>  
>  #include "common.h"
>  
> -static inline void cpu_enter_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -		"mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> -	/*
> -	 * Turn off coherency
> -	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, %3\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> -	  : "cc");
> -}
> -
>  /*
>   * platform-specific code to shutdown a CPU
>   *
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
