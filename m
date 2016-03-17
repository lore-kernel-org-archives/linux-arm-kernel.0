From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Mar 2016 17:14:06 +0100
Subject: [PATCH v5 1/5] ARM: at91: pm: create a separate procedure for
 the ULP0 mode
In-Reply-To: <1458111489-23774-2-git-send-email-wenyou.yang@atmel.com>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
 <1458111489-23774-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160317161406.GB2831@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2016 at 14:58:05 +0800, Wenyou Yang wrote :
> To make the code more legible and prepare to add the ULP1 mode
> support in the future, create a separate procedure for the ULP0 mode.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/mach-at91/pm_suspend.S |   65 ++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index a25defd..5fcffdc 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -107,7 +107,7 @@ ENTRY(at91_pm_suspend_in_sram)
>  
>  	ldr	r0, .pm_mode
>  	tst	r0, #AT91_PM_SLOW_CLOCK
> -	beq	skip_disable_main_clock
> +	beq	standby_mode
>  
>  	ldr	pmc, .pmc_base
>  
> @@ -131,32 +131,13 @@ ENTRY(at91_pm_suspend_in_sram)
>  	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
>  	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
>  
> -	/* Turn off the main oscillator */
> -	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> -	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
> -	orr	tmp1, tmp1, #AT91_PMC_KEY
> -	str	tmp1, [pmc, #AT91_CKGR_MOR]
> -
> -skip_disable_main_clock:
> -	ldr	pmc, .pmc_base
> -
> -	/* Wait for interrupt */
> -	at91_cpu_idle
> -
> -	ldr	r0, .pm_mode
> -	tst	r0, #AT91_PM_SLOW_CLOCK
> -	beq	skip_enable_main_clock
> +ulp0_mode:
> +	bl	at91_pm_ulp0_mode
> +	b	ulp_exit
>  
> +ulp_exit:
>  	ldr	pmc, .pmc_base
>  
> -	/* Turn on the main oscillator */
> -	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> -	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
> -	orr	tmp1, tmp1, #AT91_PMC_KEY
> -	str	tmp1, [pmc, #AT91_CKGR_MOR]
> -
> -	wait_moscrdy
> -
>  	/* Restore PLLA setting */
>  	ldr	tmp1, .saved_pllar
>  	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
> @@ -177,7 +158,15 @@ skip_disable_main_clock:
>  
>  	wait_mckrdy
>  
> -skip_enable_main_clock:
> +	b	pm_exit
> +
> +standby_mode:
> +	ldr	pmc, .pmc_base
> +
> +	/* Wait for interrupt */
> +	at91_cpu_idle
> +
> +pm_exit:
>  	/* Exit the self-refresh mode */
>  	mov	r0, #SRAMC_SELF_FRESH_EXIT
>  	bl	at91_sramc_self_refresh
> @@ -311,6 +300,32 @@ exit_sramc_sf:
>  	mov	pc, lr
>  ENDPROC(at91_sramc_self_refresh)
>  
> +/*
> + * void at91_pm_ulp0_mode(void)
> + */
> +ENTRY(at91_pm_ulp0_mode)
> +	ldr	pmc, .pmc_base
> +
> +	/* Turn off the crystal oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	/* Wait for interrupt */
> +	at91_cpu_idle
> +
> +	/* Turn on the crystal oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_moscrdy
> +
> +	mov	pc, lr
> +ENDPROC(at91_pm_ulp0_mode)
> +
>  .pmc_base:
>  	.word 0
>  .sramc_base:
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
