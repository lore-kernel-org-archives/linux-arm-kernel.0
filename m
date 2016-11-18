From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2016 12:04:54 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20161117183541.8588-16-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
Message-ID: <20161118120453.GI13470@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 07:35:36PM +0100, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
> 
> smp_call_function_single() has been removed because the function is already
> invoked on the target CPU.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/kernel/hw_breakpoint.c | 44 ++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

[...]

>  static int __init arch_hw_breakpoint_init(void)
>  {
> +	int ret;
> +
>  	debug_arch = get_debug_arch();
>  
>  	if (!debug_arch_supported()) {
> @@ -1072,8 +1069,6 @@ static int __init arch_hw_breakpoint_init(void)
>  	core_num_brps = get_num_brps();
>  	core_num_wrps = get_num_wrps();
>  
> -	cpu_notifier_register_begin();
> -
>  	/*
>  	 * We need to tread carefully here because DBGSWENABLE may be
>  	 * driven low on this core and there isn't an architected way to
> @@ -1082,15 +1077,18 @@ static int __init arch_hw_breakpoint_init(void)
>  	register_undef_hook(&debug_reg_hook);
>  
>  	/*
> -	 * Reset the breakpoint resources. We assume that a halting
> -	 * debugger will leave the world in a nice state for us.
> +	 * Register CPU notifier which resets the breakpoint resources. We
> +	 * assume that a halting debugger will leave the world in a nice state
> +	 * for us.
>  	 */
> -	on_each_cpu(reset_ctrl_regs, NULL, 1);
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm/hw_breakpoint:online",
> +				dbg_reset_online, NULL);

I'm slightly unsure about this. The dbg_reset_online callback can execute
undefined instructions (unfortunately, there's no way to probe the presence
of some of the debug registers), so it absolutely has to run within the 
register_undef_hook/unregister_undef_hook calls that are in this function.

With this patch, I worry that the callback can be postponed to ONLINE time
for other CPUs, and then the kernel will panic.

Will
