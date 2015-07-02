From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 02 Jul 2015 21:41:39 +0200
Subject: [PATCH 25/41] clocksource: tegra20: Migrate to new 'set-state'
 interface
In-Reply-To: <1888421925acbfbcc453488d254faa154cd0fc2b.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <1888421925acbfbcc453488d254faa154cd0fc2b.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <559593F3.5030802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> Migrate tegra20 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

[ ... ]

> +static int tegra_timer_shutdown(struct clock_event_device *evt)
>   {
> -	u32 reg;
> -
>   	timer_writel(0, TIMER3_BASE + TIMER_PTV);
> +	return 0;
> +}
>
> -	switch (mode) {
> -	case CLOCK_EVT_MODE_PERIODIC:
> -		reg = 0xC0000000 | ((1000000/HZ)-1);
> -		timer_writel(reg, TIMER3_BASE + TIMER_PTV);
> -		break;
> -	case CLOCK_EVT_MODE_ONESHOT:
> -		break;
> -	case CLOCK_EVT_MODE_UNUSED:
> -	case CLOCK_EVT_MODE_SHUTDOWN:
> -	case CLOCK_EVT_MODE_RESUME:
> -		break;
> -	}
> +static int tegra_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
> +
> +	timer_writel(0, TIMER3_BASE + TIMER_PTV);

Replace with 'tegra_timer_shutdown'

> +	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
> +	return 0;
>   }



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
