From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Oct 2010 11:07:50 -0700
Subject: [PATCH] OMAP: UART: fix wakeup registers for OMAP24xx UART2
In-Reply-To: <1287616743-23434-1-git-send-email-khilman@deeprootsystems.com>
References: <1287616743-23434-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20101022180750.GE17595@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101020 16:10]:
> On OMAP24xx, UART2 WKEN and WKST registers are in PM_WKEN2_CORE and
> PM_WKST2_CORE respecitvely.  Fix the OMAP2 register init to use the
> correct registers on OMAP24xx.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Tony, this should probably squeeze in for 2.6.37 as well.

OK, adding into omap-for-linus.

Regards,

Tony
 
>  arch/arm/mach-omap2/serial.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index ba8a5cc..becf0e3 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -515,14 +515,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  		uart->padconf = padconf;
>  	} else if (cpu_is_omap24xx()) {
>  		u32 wk_mask = 0;
> +		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
>  
> -		if (cpu_is_omap2430()) {
> -			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
> -			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
> -		} else if (cpu_is_omap2420()) {
> -			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
> -			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
> -		}
>  		switch (uart->num) {
>  		case 0:
>  			wk_mask = OMAP24XX_ST_UART1_MASK;
> @@ -531,10 +525,19 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  			wk_mask = OMAP24XX_ST_UART2_MASK;
>  			break;
>  		case 2:
> +			wk_en = OMAP24XX_PM_WKEN2;
> +			wk_st = OMAP24XX_PM_WKST2;
>  			wk_mask = OMAP24XX_ST_UART3_MASK;
>  			break;
>  		}
>  		uart->wk_mask = wk_mask;
> +		if (cpu_is_omap2430()) {
> +			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, wk_en);
> +			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, wk_st);
> +		} else if (cpu_is_omap2420()) {
> +			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, wk_en);
> +			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, wk_st);
> +		}
>  	} else {
>  		uart->wk_en = NULL;
>  		uart->wk_st = NULL;
> -- 
> 1.7.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
