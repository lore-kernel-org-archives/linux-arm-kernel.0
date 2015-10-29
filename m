From: wenyou.yang@atmel.com (Yang, Wenyou)
Date: Thu, 29 Oct 2015 09:50:15 +0800
Subject: [PATCH v2 10/14] ARM: at91: pm: find and remap the pmc
In-Reply-To: <1444660131-14954-11-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1444660131-14954-11-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <56317B57.5040703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

Trivial comments.

On 2015/10/12 22:28, Alexandre Belloni wrote:
> To avoid relying on at91_pmc_read(), find the pmc node and remap it
> locally.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/mach-at91/pm.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 5c2b60c5a2a1..1dee29b33ff9 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -35,6 +35,8 @@
>   #include "generic.h"
>   #include "pm.h"
>   
> +void __iomem *pmc;
> +
>   /*
>    * FIXME: this is needed to communicate between the pinctrl driver and
>    * the PM implementation in the machine. Possibly part of the PM
> @@ -85,7 +87,7 @@ static int at91_pm_verify_clocks(void)
>   	unsigned long scsr;
>   	int i;
>   
> -	scsr = at91_pmc_read(AT91_PMC_SCSR);
> +	scsr = readl(pmc + AT91_PMC_SCSR);
>   
>   	/* USB must not be using PLLB */
>   	if ((scsr & at91_pm_data.uhp_udp_mask) != 0) {
> @@ -99,8 +101,7 @@ static int at91_pm_verify_clocks(void)
>   
>   		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
>   			continue;
> -
> -		css = at91_pmc_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
> +		css = readl(pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
>   		if (css != AT91_PMC_CSS_SLOW) {
>   			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
>   			return 0;
> @@ -143,8 +144,8 @@ static void at91_pm_suspend(suspend_state_t state)
>   	flush_cache_all();
>   	outer_disable();
>   
> -	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
> -				at91_ramc_base[1], pm_data);
> +	at91_suspend_sram_fn(pmc, at91_ramc_base[0],
> +			     at91_ramc_base[1], pm_data);
>   
>   	outer_resume();
>   }
> @@ -394,13 +395,32 @@ static void __init at91_pm_sram_init(void)
>   			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
>   }
>   
> +static const struct of_device_id atmel_pmc_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-pmc"  },
> +	{ .compatible = "atmel,at91sam9260-pmc" },
> +	{ .compatible = "atmel,at91sam9g45-pmc" },
> +	{ .compatible = "atmel,at91sam9n12-pmc" },
> +	{ .compatible = "atmel,at91sam9x5-pmc" },
> +	{ .compatible = "atmel,sama5d3-pmc" },
> +	{ /* sentinel */ },
Do we need  compatible for sama5d2 pmc used in sama5d2.dtsi?
{ .compatible = "atmel,sama5d2-pmc" },

> +};
> +
>   static void __init at91_pm_init(void)
>   {
> -	at91_pm_sram_init();
> +	struct device_node *pmc_np;
>   
>   	if (at91_cpuidle_device.dev.platform_data)
>   		platform_device_register(&at91_cpuidle_device);
>   
> +	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
> +	pmc = of_iomap(pmc_np, 0);
> +	if (!pmc) {
> +		pr_info("AT91: PM not supported, PMC not found");
Should need "\n" before end of printout.

> +		return;
> +	}
> +
> +	at91_pm_sram_init();
> +
>   	if (at91_suspend_sram_fn)
>   		suspend_set_ops(&at91_pm_ops);
>   	else

Best Regards,
Wenyou Yang
