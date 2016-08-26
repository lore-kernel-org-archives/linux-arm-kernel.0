From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 26 Aug 2016 13:28:06 +0200
Subject: [RFC PATCH 1/2] arm64: hw_breakpoint: convert CPU hotplug
 notifier to new infrastructure
In-Reply-To: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
References: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160826112806.rr3apxva73frag5x@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-26 11:35:57 [+0100], Will Deacon wrote:
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 26a6bf77d272..948b73148d56 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -857,7 +857,7 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
?
> -static int hw_breakpoint_reset_notify(struct notifier_block *self,
> -						unsigned long action,
> -						void *hcpu)
> -{
> -	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE) {
> -		local_irq_disable();
> -		hw_breakpoint_reset(NULL);

so the old one was invoked at CPU_ONLINE time.

> -		local_irq_enable();
> -	}
> -	return NOTIFY_OK;
> +	return 0;
>  }
?
> @@ -919,36 +905,34 @@ static inline void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
?
> +	/*
> +	 * Reset the breakpoint resources. We assume that a halting
> +	 * debugger will leave the world in a nice state for us.
> +	 */
> +	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
> +			  "CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING",
> +			  hw_breakpoint_reset, NULL);

But this will move it to CPU_STARTING. May I ask why?

Sebastian
