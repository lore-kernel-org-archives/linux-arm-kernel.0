From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 04 Jul 2015 17:42:29 +0200
Subject: [PATCH 16/41] clocksource: pxa: Migrate to new 'set-state'
 interface
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <cover.1434622147.git.viresh.kumar@linaro.org>
 <3aa5c1a740911258698769cbbb8f60ee02178848.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <87h9pk9bfe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> @@ -88,26 +88,12 @@ pxa_osmr0_set_next_event(unsigned long delta, struct clock_event_device *dev)
>  	return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
>  }
>  
> -static void
> -pxa_osmr0_set_mode(enum clock_event_mode mode, struct clock_event_device *dev)
> +static int pxa_osmr0_shutdown(struct clock_event_device *evt)
>  {
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
> -		timer_writel(OSSR_M0, OSSR);
> -		break;
> -
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -		/* initializing, released, or preparing for suspend */
> -		timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
> -		timer_writel(OSSR_M0, OSSR);
> -		break;
> -
> -	case CLOCK_EVT_MODE_RESUME:
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		break;
> -	}
> +	/* initializing, released, or preparing for suspend */
> +	timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
> +	timer_writel(OSSR_M0, OSSR);
> +	return 0;
For consistency, please leave an empty line before that return statement.

> @@ -147,13 +133,14 @@ static void pxa_timer_resume(struct clock_event_device *cedev)
>  #endif
>  
>  static struct clock_event_device ckevt_pxa_osmr0 = {
> -	.name		= "osmr0",
> -	.features	= CLOCK_EVT_FEAT_ONESHOT,
> -	.rating		= 200,
> -	.set_next_event	= pxa_osmr0_set_next_event,
> -	.set_mode	= pxa_osmr0_set_mode,
> -	.suspend	= pxa_timer_suspend,
> -	.resume		= pxa_timer_resume,
> +	.name			= "osmr0",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.rating			= 200,
> +	.set_next_event		= pxa_osmr0_set_next_event,
> +	.set_state_shutdown	= pxa_osmr0_shutdown,
> +	.set_state_oneshot	= pxa_osmr0_shutdown,
A bit weird to have a "set_state_oneshot" function to point to a function called
"X_shutdown". As I don't have a clear idea on what's this new interface for,
I'll just hope it's the intended purpose. The code does look equivalent to me
anyway.

Apart from the cosmetic comment, once it is fixed :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
