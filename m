From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 6 Jul 2013 00:58:34 +0200
Subject: [PATCH 6/9] clocksource: dw_apb_timer: quirk for inverted int mask
In-Reply-To: <201307060054.35996.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060054.35996.heiko@sntech.de>
Message-ID: <201307060058.34736.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch should have had a

From: Ulrich Prinz <ulrich.prinz@googlemail.com>

sorry for the mistake

Am Samstag, 6. Juli 2013, 00:54:35 schrieb Heiko St?bner:
> Some timer variants use an inverted setting to mask the timer interrupt.
> Therefore add a quirk to handle these variants.
> 
> Signed-off-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
> ---
>  drivers/clocksource/dw_apb_timer.c |   23 ++++++++++++++++++-----
>  include/linux/dw_apb_timer.h       |    6 ++++++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer.c
> b/drivers/clocksource/dw_apb_timer.c index 23cd7c6..7705d13 100644
> --- a/drivers/clocksource/dw_apb_timer.c
> +++ b/drivers/clocksource/dw_apb_timer.c
> @@ -84,7 +84,10 @@ static void apbt_disable_int(struct dw_apb_timer *timer)
>  {
>  	unsigned long ctrl = apbt_readl(timer, timer->reg_control);
> 
> -	ctrl |= APBTMR_CONTROL_INT;
> +	if (timer->quirks & APBTMR_QUIRK_INVERSE_INTMASK)
> +		ctrl &= ~APBTMR_CONTROL_INT;
> +	else
> +		ctrl |= APBTMR_CONTROL_INT;
>  	apbt_writel(timer, ctrl, timer->reg_control);
>  }
> 
> @@ -134,7 +137,10 @@ static void apbt_enable_int(struct
> dw_apb_clock_event_device *dw_ced) /* clear pending intr */
>  	if (dw_ced->eoi)
>  		dw_ced->eoi(timer);
> -	ctrl &= ~APBTMR_CONTROL_INT;
> +	if (timer->quirks & APBTMR_QUIRK_INVERSE_INTMASK)
> +		ctrl |= APBTMR_CONTROL_INT;
> +	else
> +		ctrl &= ~APBTMR_CONTROL_INT;
>  	apbt_writel(timer, ctrl, timer->reg_control);
>  }
> 
> @@ -195,7 +201,10 @@ static void apbt_set_mode(enum clock_event_mode mode,
>  		if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
>  			apbt_writel(timer, 0, timer->reg_load_count + 0x4);
> 
> -		ctrl &= ~APBTMR_CONTROL_INT;
> +		if (timer->quirks & APBTMR_QUIRK_INVERSE_INTMASK)
> +			ctrl |= APBTMR_CONTROL_INT;
> +		else
> +			ctrl &= ~APBTMR_CONTROL_INT;
>  		ctrl |= APBTMR_CONTROL_ENABLE;
>  		apbt_writel(timer, ctrl, timer->reg_control);
>  		break;
> @@ -363,9 +372,13 @@ void dw_apb_clocksource_start(struct
> dw_apb_clocksource *dw_cs) if (timer->quirks & APBTMR_QUIRK_64BIT_COUNTER)
>  		apbt_writel(timer, 0, timer->reg_load_count + 0x4);
> 
> -	/* enable, mask interrupt */
> +	/* set periodic, mask interrupt, enable timer */
>  	ctrl &= ~APBTMR_CONTROL_MODE_PERIODIC;
> -	ctrl |= (APBTMR_CONTROL_ENABLE | APBTMR_CONTROL_INT);
> +	if (timer->quirks & APBTMR_QUIRK_INVERSE_INTMASK)
> +		ctrl &= ~APBTMR_CONTROL_INT;
> +	else
> +		ctrl |= APBTMR_CONTROL_INT;
> +	ctrl |= APBTMR_CONTROL_ENABLE;
>  	apbt_writel(timer, ctrl, timer->reg_control);
>  	/* read it once to get cached counter value initialized */
>  	dw_apb_clocksource_read(dw_cs);
> diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
> index fbe4c6b..7d36d91 100644
> --- a/include/linux/dw_apb_timer.h
> +++ b/include/linux/dw_apb_timer.h
> @@ -30,6 +30,12 @@
>   */
>  #define APBTMR_QUIRK_NO_EOI		BIT(1)
> 
> +/* The IP uses an inverted interrupt-mask bit.
> + * Instead of activating interrupts clearing a maks bit, it needs an
> enable + * bit to be set 1.
> + */
> +#define APBTMR_QUIRK_INVERSE_INTMASK	BIT(2)
> +
>  struct dw_apb_timer {
>  	void __iomem				*base;
>  	unsigned long				freq;
