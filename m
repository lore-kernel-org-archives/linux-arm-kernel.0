From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Feb 2015 11:25:59 +0100
Subject: [PATCH 3/3] pm: at91: flush data cache and clean, invalidate and
 disable the L2 cache
In-Reply-To: <1423709578-8475-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
 <1423709578-8475-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150217102559.GD11529@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2015 at 10:52:58 +0800, Wenyou Yang wrote :
> Flush data cache, and clean, invalidate and disable the L2 cache before going to suspend.
> Restore the L2 cache configuration and re-enable the L2 cache after waking up.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/mach-at91/pm.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 9075b41..2574bad 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -30,6 +30,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/mach/irq.h>
>  #include <asm/fncpy.h>
> +#include <asm/cacheflush.h>
>  
>  #include <mach/cpu.h>
>  #include <mach/hardware.h>
> @@ -145,8 +146,13 @@ static void at91_pm_suspend(suspend_state_t state)
>  	pm_data |= (state == PM_SUSPEND_MEM) ?
>  				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
>  
> +	flush_cache_all();
> +	outer_disable();
> +
>  	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
>  				at91_ramc_base[1], pm_data);
> +
> +	outer_resume();
>  }
>  
>  static int at91_pm_enter(suspend_state_t state)
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
