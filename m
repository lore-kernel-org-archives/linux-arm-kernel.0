From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 23 Jan 2015 17:50:20 +0100
Subject: [PATCH 07/12] pm: at91: the standby mode uses the same sram
 function as the suspend to memory mode
In-Reply-To: <1421741825-18226-8-git-send-email-wenyou.yang@atmel.com>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
 <1421741825-18226-8-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150123165020.GA24210@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,


On Tue, Jan 20, 2015 at 04:17:00PM +0800, Wenyou Yang wrote:
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 691e6db..a1010f0 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c


> @@ -145,62 +145,51 @@ extern void at91_slow_clock(void __iomem *pmc, void __iomem *ramc0,
>  			    void __iomem *ramc1, int memctrl);
>  extern u32 at91_slow_clock_sz;
>  
> +static void at91_pm_suspend(suspend_state_t state)
> +{
      (...)
> +	slow_clock(at91_pmc_base, at91_ramc_base[0],
> +			at91_ramc_base[1], pm_data);
> +}


> -			if (slow_clock) {
> -				slow_clock(at91_pmc_base, at91_ramc_base[0],
> -					   at91_ramc_base[1],
> -					   at91_pm_data.memctrl);
      (...)
> +               at91_pm_suspend(state);


By doing that you removed the condition "if (slow_clock)".

But slow_clock can still be NULL, see commit d2e4679, there are multiple 
reasons which ends up with a NULL slow_clock.


Sylvain
