From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Nov 2013 15:34:41 +0100
Subject: [PATCH] clocksource: armada-370-xp: Enable timer divider only
 when needed
In-Reply-To: <1385562701-18976-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385562701-18976-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52960301.8050202@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 27/11/2013 15:31, Ezequiel Garcia wrote:
> The current code sets the timer divider bits always. However, when
> the 25 MHz timer is enabled, this is not needed and has no effect.
> As this causes some confusion, rework the code so the divider is
> set only when needed, i.e. when the 25 MHz timer is not in use.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  drivers/clocksource/time-armada-370-xp.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 4e7f680..ee8691b 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -76,6 +76,7 @@
>  static void __iomem *timer_base, *local_base;
>  static unsigned int timer_clk;
>  static bool timer25Mhz = true;
> +static u32 enable_mask;
>  
>  /*
>   * Number of timer ticks per jiffy.
> @@ -121,8 +122,7 @@ armada_370_xp_clkevt_next_event(unsigned long delta,
>  	/*
>  	 * Enable the timer.
>  	 */
> -	local_timer_ctrl_clrset(TIMER0_RELOAD_EN,
> -				TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT));
> +	local_timer_ctrl_clrset(TIMER0_RELOAD_EN, enable_mask);
>  	return 0;
>  }
>  
> @@ -141,9 +141,7 @@ armada_370_xp_clkevt_mode(enum clock_event_mode mode,
>  		/*
>  		 * Enable timer.
>  		 */
> -		local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN |
> -					   TIMER0_EN |
> -					   TIMER0_DIV(TIMER_DIVIDER_SHIFT));
> +		local_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
>  	} else {
>  		/*
>  		 * Disable timer.
> @@ -240,10 +238,13 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
>  	WARN_ON(!timer_base);
>  	local_base = of_iomap(np, 1);
>  
> -	if (timer25Mhz)
> +	if (timer25Mhz) {
>  		set = TIMER0_25MHZ;		
> -	else
> +		enable_mask = TIMER0_EN;
> +	} else {
>  		clr = TIMER0_25MHZ;
> +		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
> +	}
>  	timer_ctrl_clrset(clr, set);
>  	local_timer_ctrl_clrset(clr, set);
>  
> @@ -262,8 +263,7 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
>  	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
>  	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
>  
> -	timer_ctrl_clrset(0, TIMER0_EN | TIMER0_RELOAD_EN |
> -			     TIMER0_DIV(TIMER_DIVIDER_SHIFT));
> +	timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
>  
>  	/*
>  	 * Set scale and timer for sched_clock.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
