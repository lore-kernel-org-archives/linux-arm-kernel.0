From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 14:23:18 +0200
Subject: [PATCH 1/6] clocksource: arm_arch_timer: Migrate to new
 'set-state' interface
In-Reply-To: <80bb7da364daf25660d130513d386353ac78a640.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <80bb7da364daf25660d130513d386353ac78a640.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <55797DB6.1040301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:40 PM, Viresh Kumar wrote:
> Migrate arm_arch_timer driver to the new 'set-state' interface provided
> by the clockevents core, the earlier 'set-mode' interface is marked
> obsolete now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/clocksource/arm_arch_timer.c | 61 ++++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 0aa135ddbf80..d0b0cf43b981 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -181,44 +181,44 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
>   	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
>   }
>
> -static __always_inline void timer_set_mode(const int access, int mode,
> -				  struct clock_event_device *clk)
> +static __always_inline void timer_shutdown(const int access,
> +					   struct clock_event_device *clk)
>   {

[ ... ]

Instead of returning zero in the functions 
'timer_shutdown_virt|phys|virt_mem|phys_mem', do it here directly.

>   }
>
> -static void arch_timer_set_mode_virt(enum clock_event_mode mode,
> -				     struct clock_event_device *clk)
> +static int arch_timer_shutdown_virt(struct clock_event_device *clk)
>   {
> -	timer_set_mode(ARCH_TIMER_VIRT_ACCESS, mode, clk);
> +	timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
> +	return 0;

As suggested above:

	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);

>   }
>

[ ... ]

> @@ -286,17 +286,18 @@ static void __arch_timer_setup(unsigned type,
>   		clk->rating = 400;
>   		clk->cpumask = cpu_all_mask;
>   		if (arch_timer_mem_use_virtual) {
> -			clk->set_mode = arch_timer_set_mode_virt_mem;
> +			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
>   			clk->set_next_event =
>   				arch_timer_set_next_event_virt_mem;
>   		} else {
> -			clk->set_mode = arch_timer_set_mode_phys_mem;
> +			clk->set_state_shutdown = arch_timer_shutdown_phys_mem;
>   			clk->set_next_event =
>   				arch_timer_set_next_event_phys_mem;
>   		}
>   	}
>
> -	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, clk);
> +	clk->set_state_oneshot = arch_timer_set_oneshot;
> +	clk->set_state_shutdown(clk);

Why don't you call clockevent_shutdown(clk) ?

There is some initialization there, no ?

>   	clockevents_config_and_register(clk, arch_timer_rate, 0xf, 0x7fffffff);
>   }
> @@ -506,7 +507,7 @@ static void arch_timer_stop(struct clock_event_device *clk)
>   			disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
>   	}
>
> -	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
> +	clk->set_state_shutdown(clk);
>   }

Ditto.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
