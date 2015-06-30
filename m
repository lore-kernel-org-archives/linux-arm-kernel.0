From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Jun 2015 10:25:12 +0200
Subject: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
In-Reply-To: <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <55925268.4050109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> Migrate asm9260 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

Could you add in the changelog the subtle change with set_mode(RESUME) 
and this code. As a default the timer was stopped when entering in the 
set_mode function, now with the new API, this is done explicitly.

> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

[ ... ]

> +static int asm9260_timer_shutdown(struct clock_event_device *evt)
>   {
>   	/* stop timer0 */
>   	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);
> +	return 0;
> +}
> +
> +static int asm9260_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +	/* stop timer0 */
> +	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);

Can you replace this line with a call to asm9260_timer_shutdown ?

> +	/* enable reset and stop on match */
> +	writel_relaxed(BM_MCR_RES_EN(0) | BM_MCR_STOP_EN(0),
> +		       priv.base + HW_MCR + SET_REG);
> +	return 0;
> +}

[ ... ]

> +static int asm9260_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	/* stop timer0 */
> +	writel_relaxed(BM_C0_EN, priv.base + HW_TCR + CLR_REG);

idem.

Thanks

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
