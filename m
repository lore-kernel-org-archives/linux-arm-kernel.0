From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 16:49:53 +0200
Subject: [PATCH 2/6] clocksource: arm_global_timer: Migrate to new
 'set-state' interface
In-Reply-To: <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <5579A011.8030900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:40 PM, Viresh Kumar wrote:
> Migrate arm_global_timer driver to the new 'set-state' interface
> provided by the clockevents core, the earlier 'set-mode' interface is
> marked obsolete now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/clocksource/arm_global_timer.c | 37 ++++++++++++++++------------------

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> -	clk->set_mode = gt_clockevent_set_mode;
> +	clk->set_state_shutdown = gt_clockevent_shutdown;
> +	clk->set_state_periodic = gt_clockevent_set_periodic;
> +	clk->set_state_oneshot = gt_clockevent_shutdown;

nit: it sounds weird to use the same function as the purpose of the 
patch is use the new API which is to ventilate those functions (anyway ...)

>   	clk->set_next_event = gt_clockevent_set_next_event;
>   	clk->cpumask = cpumask_of(cpu);
>   	clk->rating = 300;
> @@ -184,7 +181,7 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>
>   static void gt_clockevents_stop(struct clock_event_device *clk)
>   {
> -	gt_clockevent_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
> +	gt_clockevent_shutdown(clk);
>   	disable_percpu_irq(clk->irq);
>   }


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
