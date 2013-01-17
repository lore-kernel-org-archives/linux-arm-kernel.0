From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jan 2013 23:41:17 -0500 (EST)
Subject: [PATCH 3/3] ARM: omap2: use get_auxcr for aux ctrl register read
In-Reply-To: <1358391205-23943-3-git-send-email-robherring2@gmail.com>
References: <1358391205-23943-1-git-send-email-robherring2@gmail.com>
 <1358391205-23943-3-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1301162340421.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jan 2013, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Use get_auxcr instead of inline assembly to read the CP15 aux ctrl
> register.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Looks trivial enough.

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7be3622..bef8ef6 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -33,6 +33,7 @@
>  
>  #include <trace/events/power.h>
>  
> +#include <asm/cp15.h>
>  #include <asm/fncpy.h>
>  #include <asm/suspend.h>
>  #include <asm/system_misc.h>
> @@ -216,9 +217,8 @@ static void omap34xx_save_context(u32 *save)
>  	u32 val;
>  
>  	/* Read Auxiliary Control Register */
> -	asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (val));
>  	*save++ = 1;
> -	*save++ = val;
> +	*save++ = get_auxcr();
>  
>  	/* Read L2 AUX ctrl register */
>  	asm("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
> -- 
> 1.7.10.4
> 
