From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Mar 2016 17:54:42 +0100
Subject: [PATCH v5 2/5] ARM: at91: pm: add ULP1 mode support
In-Reply-To: <1458111489-23774-3-git-send-email-wenyou.yang@atmel.com>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
 <1458111489-23774-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160317165442.GC2831@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2016 at 14:58:06 +0800, Wenyou Yang wrote :
> @@ -497,4 +506,7 @@ void __init sama5_pm_init(void)
>  	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
>  	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
>  	at91_pm_init(NULL);
> +
> +	if (readl(pmc + AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)

I would not use that. Instead, I would create a new function,
sama5d2_pm_init() and call it from sama5.c with a new
sama5d2_dt_device_init and a new DT_MACHINE.

> +		at91_pm_data.ulp_mode = ULP1_MODE;
>  }
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index 3fcf881..2e76745 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -39,4 +39,11 @@ extern void __iomem *at91_ramc_base[];
>  
>  #define	AT91_PM_SLOW_CLOCK	0x01
>  
> +#define AT91_PM_ULP_OFFSET	5
> +#define AT91_PM_ULP_MASK	0x03
> +#define AT91_PM_ULP(x)		(((x) & AT91_PM_ULP_MASK) << AT91_PM_ULP_OFFSET)
> +
> +#define AT91_PM_ULP0_MODE	0x00
> +#define AT91_PM_ULP1_MODE	0x01
> +
>  #endif
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 5fcffdc..f2a5c4b 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -41,6 +41,15 @@ tmp2	.req	r5
>  	.endm
>  
>  /*
> + * Wait for main oscillator selection is done
> + */
> +	.macro wait_moscsels
> +1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
> +	tst	tmp1, #AT91_PMC_MOSCSELS
> +	beq	1b
> +	.endm
> +
> +/*
>   * Wait until PLLA has locked.
>   */
>  	.macro wait_pllalock
> @@ -101,6 +110,10 @@ ENTRY(at91_pm_suspend_in_sram)
>  	and	r0, r0, #AT91_PM_MODE_MASK
>  	str	r0, .pm_mode
>  
> +	lsr	r0, r3, #AT91_PM_ULP_OFFSET
> +	and	r0, r0, #AT91_PM_ULP_MASK
> +	str	r0, .ulp_mode
> +
>  	/* Active the self-refresh mode */
>  	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
>  	bl	at91_sramc_self_refresh
> @@ -131,6 +144,13 @@ ENTRY(at91_pm_suspend_in_sram)
>  	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
>  	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
>  
> +	ldr	r0, .ulp_mode
> +	tst	r0, #AT91_PM_ULP1_MODE
> +	beq	ulp0_mode
> +
> +	bl	at91_pm_ulp1_mode
> +	b	ulp_exit
> +
>  ulp0_mode:
>  	bl	at91_pm_ulp0_mode
>  	b	ulp_exit
> @@ -326,6 +346,81 @@ ENTRY(at91_pm_ulp0_mode)
>  	mov	pc, lr
>  ENDPROC(at91_pm_ulp0_mode)
>  
> +/*
> + * void at91_pm_ulp1_mode(void)
> + */
> +ENTRY(at91_pm_ulp1_mode)
> +	ldr	pmc, .pmc_base
> +
> +	/* Switch the main clock source to 12-MHz RC oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_moscsels
> +
> +	/* Disable the crystal oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	/* Switch the master clock source to main clock */
> +	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
> +	bic	tmp1, tmp1, #AT91_PMC_CSS
> +	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
> +	str	tmp1, [pmc, #AT91_PMC_MCKR]
> +
> +	wait_mckrdy
> +
> +	/* Enter the ULP1 mode by set WAITMODE bit in CKGR_MOR */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_WAITMODE
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_mckrdy
> +
> +	/* Enable the crystal oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +

This will badly fail on the platforms that don't populate a crystal for
the main clock or use the bypass. I think wee need to have at least a
comment or save the previous state and restore it.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
