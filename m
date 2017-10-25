From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Oct 2017 10:37:21 +0200
Subject: [PATCH v7 1/6] timer: add timer_of_exit function
In-Reply-To: <1508752722-4489-2-git-send-email-benjamin.gaignard@linaro.org>
References: <1508752722-4489-1-git-send-email-benjamin.gaignard@linaro.org>
 <1508752722-4489-2-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <b3234794-0a72-02d9-9d29-f58effbb7356@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/2017 11:58, Benjamin Gaignard wrote:
> Add this exit function to be able to undo what have been done
> in timer_of_init().
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

I will take this one for 4.15

Thanks

  -- Daniel

> ---
>  drivers/clocksource/timer-of.c | 12 ++++++++++++
>  drivers/clocksource/timer-of.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index c79122d..7c64a5c1 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -176,3 +176,15 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
>  		timer_base_exit(&to->of_base);
>  	return ret;
>  }
> +
> +void timer_of_exit(struct timer_of *to)
> +{
> +	if (to->flags & TIMER_OF_IRQ)
> +		timer_irq_exit(&to->of_irq);
> +
> +	if (to->flags & TIMER_OF_CLOCK)
> +		timer_clk_exit(&to->of_clk);
> +
> +	if (to->flags & TIMER_OF_BASE)
> +		timer_base_exit(&to->of_base);
> +}
> diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
> index e0d7272..44f57e0 100644
> --- a/drivers/clocksource/timer-of.h
> +++ b/drivers/clocksource/timer-of.h
> @@ -66,4 +66,7 @@ static inline unsigned long timer_of_period(struct timer_of *to)
>  
>  extern int __init timer_of_init(struct device_node *np,
>  				struct timer_of *to);
> +
> +extern void timer_of_exit(struct timer_of *to);
> +
>  #endif
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
