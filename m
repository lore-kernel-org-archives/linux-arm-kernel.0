From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 17 Jun 2015 19:23:14 +0200 (CEST)
Subject: [PATCH 4/9] ARM: gemini: fix race in installing GPIO chained
 IRQ handler
In-Reply-To: <E1Z4z07-0002SO-Gv@rmk-PC.arm.linux.org.uk>
References: <E1Z4z07-0002SO-Gv@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LNX.2.00.1506171923010.27619@T520.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 16 Jun 2015, Russell King wrote:

> The gemini code was installing its chained interrupt handler (which
> enables the interrupt) before it was setting its data, which is bad if
> the IRQ was previously pending.  Avoid this problem by converting it to
> irq_set_chained_handler_and_data().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Depends on patch 1.
> 
>  arch/arm/mach-gemini/gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
> index f8cb5710d6ee..3292f2e6ed6f 100644
> --- a/arch/arm/mach-gemini/gpio.c
> +++ b/arch/arm/mach-gemini/gpio.c
> @@ -223,8 +223,8 @@ void __init gemini_gpio_init(void)
>  			set_irq_flags(j, IRQF_VALID);
>  		}
>  
> -		irq_set_chained_handler(IRQ_GPIO(i), gpio_irq_handler);
> -		irq_set_handler_data(IRQ_GPIO(i), (void *)i);
> +		irq_set_chained_handler_and_data(IRQ_GPIO(i), gpio_irq_handler,
> +						 (void *)i);
>  	}
>  
>  	BUG_ON(gpiochip_add(&gemini_gpio_chip));
> -- 
> 2.1.0
> 
> 
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
