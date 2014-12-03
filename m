From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Dec 2014 17:31:56 +0100
Subject: [PATCH 5/8] ARM: at91/clocksource: remove !DT PIT initializations
In-Reply-To: <60ebb777ae686d2a8c6820f9c891d9a0dd0fd03d.1417541118.git.nicolas.ferre@atmel.com>
References: <e093d7cf37ec9ff24b0631b0a2e405a7cf7574db.1417541118.git.nicolas.ferre@atmel.com>
 <60ebb777ae686d2a8c6820f9c891d9a0dd0fd03d.1417541118.git.nicolas.ferre@atmel.com>
Message-ID: <547F3AFC.2050400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2014 18:27, Nicolas Ferre a ?crit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As AT91 !DT code is now removed, cleanup the PIT clocksource driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [nicolas.ferre at atmel.com: split patch]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

I plan to take this patch with me in a "cleanup" series and send it to
arm-soc soon. Do you think you can add your Acked-by tag?

I verified and there is no modification between Linus' tree and
linux-next: it should not conflict with anything queued on your side.

Bye,

> ---
>  arch/arm/mach-at91/generic.h          |  2 --
>  drivers/clocksource/timer-atmel-pit.c | 32 --------------------------------
>  2 files changed, 34 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index 8527e8bd675f..d53324210adf 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -31,8 +31,6 @@ extern void __init at91_sysirq_mask_rtt(u32 rtt_base);
>  
>   /* Timer */
>  extern void at91rm9200_timer_init(void);
> -extern void at91sam926x_ioremap_pit(u32 addr);
> -extern void at91sam926x_pit_init(int irq);
>  
>  /* idle */
>  extern void at91sam9_idle(void);
> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
> index d5289098b3df..b5b4d4585c9a 100644
> --- a/drivers/clocksource/timer-atmel-pit.c
> +++ b/drivers/clocksource/timer-atmel-pit.c
> @@ -262,35 +262,3 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
>  }
>  CLOCKSOURCE_OF_DECLARE(at91sam926x_pit, "atmel,at91sam9260-pit",
>  		       at91sam926x_pit_dt_init);
> -
> -static void __iomem *pit_base_addr;
> -
> -void __init at91sam926x_pit_init(int irq)
> -{
> -	struct pit_data *data;
> -
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		panic(pr_fmt("Unable to allocate memory\n"));
> -
> -	data->base = pit_base_addr;
> -
> -	data->mck = clk_get(NULL, "mck");
> -	if (IS_ERR(data->mck))
> -		panic(pr_fmt("Unable to get mck clk\n"));
> -
> -	data->irq = irq;
> -
> -	at91sam926x_pit_common_init(data);
> -}
> -
> -void __init at91sam926x_ioremap_pit(u32 addr)
> -{
> -	if (of_have_populated_dt())
> -		return;
> -
> -	pit_base_addr = ioremap(addr, 16);
> -
> -	if (!pit_base_addr)
> -		panic(pr_fmt("Impossible to ioremap PIT\n"));
> -}
> 


-- 
Nicolas Ferre
