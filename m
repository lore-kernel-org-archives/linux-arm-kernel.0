From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 02 Jul 2015 22:11:59 +0200
Subject: [PATCH 41/41] clocksource: zevio: Migrate to new 'set-state'
 interface
In-Reply-To: <2492473d6bb8f057af389d6db24af77462af2468.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <2492473d6bb8f057af389d6db24af77462af2468.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <55959B0F.5000306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> Migrate zevio driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Daniel Tang <dt.tangr@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

[ ... ]

>   static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
> @@ -162,7 +158,9 @@ static int __init zevio_timer_add(struct device_node *node)
>   	if (timer->interrupt_regs && irqnr) {
>   		timer->clkevt.name		= timer->clockevent_name;
>   		timer->clkevt.set_next_event	= zevio_timer_set_event;
> -		timer->clkevt.set_mode		= zevio_timer_set_mode;
> +		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
> +		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
> +		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;

Why is tick_resume added here ?

>   		timer->clkevt.rating		= 200;
>   		timer->clkevt.cpumask		= cpu_all_mask;
>   		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
