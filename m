From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Oct 2015 15:22:04 +0200
Subject: [PATCH 2/2] ARM: at91/pm: add ultra Low-power mode 1(ULP1) support
In-Reply-To: <1444880467-18598-3-git-send-email-wenyou.yang@atmel.com>
References: <1444880467-18598-1-git-send-email-wenyou.yang@atmel.com>
 <1444880467-18598-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20151015132204.GC3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On 15/10/2015 at 11:41:07 +0800, Wenyou Yang wrote :
> +#define ULP0_MODE      0x00
> +#define ULP1_MODE      0x11

Those are not used.

> +static void at91_config_ulp1_wkup_source(void)
> +{
> +	if (at91_pmc_read(AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION) {
> +		at91_pmc_write(AT91_PMC_FSMR, AT91_PMC_RTCAL |
> +					      AT91_PMC_FSTT9 |
> +					      AT91_PMC_FSTT8 |
> +					      AT91_PMC_FSTT7 |
> +					      AT91_PMC_FSTT6 |
> +					      AT91_PMC_FSTT5 |
> +					      AT91_PMC_FSTT4 |
> +					      AT91_PMC_FSTT3 |
> +					      AT91_PMC_FSTT2 |
> +					      AT91_PMC_FSTT0);
> +
> +		at91_pmc_write(AT91_PMC_FSPR, 0);

Shouldn't those be configured from irq_set_wake() in the aic driver
instead of activating all the wakeup sources?
I think you need to get the PMC syscon from the aic5 driver and
implement a new irq_set_wake function when you can find the sam5d2 pmc.

The PMC syscon is introduced with that series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376493.html

> @@ -140,6 +165,10 @@ static void at91_pm_suspend(suspend_state_t state)
>  	pm_data |= (state == PM_SUSPEND_MEM) ?
>  				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
>  
> +	pm_data |= ((state == PM_SUSPEND_MEM) &&
> +		    (at91_pmc_read(AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)) ?
> +		    AT91_PM_ULP(AT91_PM_ULP1_MODE) : 0;
> +

I would prefer not relying on the AT91_PMC_VERSION. Also, you probably
shouldn't read the register each time you go to suspend.
Finally, this could be better written by testing state only once.


>  	flush_cache_all();
>  	outer_disable();
>  
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
> index 825347b..543c430 100644
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
> @@ -99,6 +108,10 @@ ENTRY(at91_pm_suspend_in_sram)
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
> @@ -107,6 +120,14 @@ ENTRY(at91_pm_suspend_in_sram)
>  	tst	r0, #AT91_PM_SLOW_CLOCK
>  	beq	standby_mode
>  
> +	ldr	r0, .ulp_mode
> +	tst	r0, #AT91_PM_ULP1_MODE
> +	beq	ulp0_mode
> +
> +ulp1_mode:
> +	bl	at91_pm_ulp1_mode
> +	b	pm_exit
> +
>  ulp0_mode:
>  	bl	at91_pm_ulp0_mode
>  	b	pm_exit
> @@ -313,6 +334,94 @@ ENTRY(at91_pm_ulp0_mode)
>  	mov	pc, lr
>  ENDPROC(at91_pm_ulp0_mode)
>  
> +/*
> + * void at91_pm_ulp1_mode(void)
> + *
> + */
> +ENTRY(at91_pm_ulp1_mode)
> +	ldr	pmc, .pmc_base
> +
> +	/* Save PMC_MCKR config */
> +	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
> +	str	tmp1, .saved_mckr
> +
> +	/* Switch the master clock source to main clock */
> +	bic	tmp1, tmp1, #AT91_PMC_CSS
> +	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
> +	str	tmp1, [pmc, #AT91_PMC_MCKR]
> +
> +	wait_mckrdy
> +
> +	/* Save PLLA config, then and disable PLLA */
> +	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
> +	str	tmp1, .saved_pllar
> +
> +	bic	tmp1, tmp1, #AT91_PMC3_MUL
> +	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
> +
> +	/* Switch main clock to 12-MHz RC oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	bic	tmp1, tmp1, #(7 << 4)
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_moscsels
> +
> +	/* Disable the main oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	bic	tmp1, tmp1, #(7 << 4)
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	/* Enter the ULP1 mode by setting WAITMODE bit in CKGR_MOR */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_WAITMODE
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	bic	tmp1, tmp1, #(7 << 4)
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_mckrdy
> +
> +	/* Enable the main oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	bic	tmp1, tmp1, #(7 << 4)
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_moscrdy
> +
> +	/* Switch main clock to the main oscillator */
> +	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
> +	orr	tmp1, tmp1, #AT91_PMC_MOSCSEL
> +	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
> +	orr	tmp1, tmp1, #AT91_PMC_KEY
> +	bic	tmp1, tmp1, #(7 << 4)
> +	str	tmp1, [pmc, #AT91_CKGR_MOR]
> +
> +	wait_moscsels
> +
> +	/* Restore PLLA config */
> +	ldr	tmp1, .saved_pllar
> +	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
> +
> +	wait_pllalock
> +
> +	/* Restore PMC_MCKR config */
> +	ldr	tmp1, .saved_mckr
> +	str	tmp1, [pmc, #AT91_PMC_MCKR]
> +
> +	wait_mckrdy
> +
> +	mov	pc, lr
> +ENDPROC(at91_pm_ulp1_mode)
> +

This makes a lot of duplication anyway, why not having separate code for
ULP0 and ULP1 that would be copied in SRAM? This would avoid the test on .ulp_mode

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
