From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 18 Nov 2013 18:11:08 -0500
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to set_cntfreq
In-Reply-To: <20131118215855.GW10317@atomide.com>
References: <20131118215855.GW10317@atomide.com>
Message-ID: <528A9E8C.9040903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013 04:58 PM, Tony Lindgren wrote:
> If CONFIG_SOC_HAS_REALTIME_COUNTER is not selected for omap5
> or dra7xx, we can get the following error:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_init':
> :(.text+0x7ab0): undefined reference to `set_cntfreq'
> 
> Fix the issue by not trying to initalize the realtime counter
> unles CONFIG_SOC_HAS_REALTIME_COUNTER is selected.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
How about a dummy inline function of set_cntfreq() ?
Having #ifdef in middle of the code looks pretty ugly.

> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -65,12 +65,14 @@ static void omap4_secondary_init(unsigned int cpu)
>  		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
>  							4, 0, 0, 0, 0, 0);
>  
> +#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
>  	/*
>  	 * Configure the CNTFRQ register for the secondary cpu's which
>  	 * indicates the frequency of the cpu local timers.
>  	 */
>  	if (soc_is_omap54xx() || soc_is_dra7xx())
>  		set_cntfreq();
> +#endif
>  
>  	/*
>  	 * Synchronise with the boot thread.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
