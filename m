From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jun 2013 18:23:42 +0100
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130611172342.GJ3439@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> machine_shutdown() is a hook for kexec. Add a comment saying so, since
> it isn't obvious from the function name.

I'd go as far as saying that some of this commit log could be included in
the comment too, since this comes up time and time again and it's never
clear!

Anyway, a few comments inline.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 42d6ea2..d7b3d2e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2028,7 +2028,7 @@ config XIP_PHYS_ADDR
>  
>  config KEXEC
>  	bool "Kexec system call (EXPERIMENTAL)"
> -	depends on (!SMP || HOTPLUG_CPU)
> +	depends on (!SMP || (HOTPLUG_CPU && PM_SLEEP_SMP))

PM_SLEEP_SMP selects HOTPLUG_CPU.

>  	help
>  	  kexec is a system call that implements the ability to shutdown your
>  	  current kernel, and to start another kernel.  It is like a reboot
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 282de48..dbe1692 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
>  {
>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>  
> +	BUG_ON(num_online_cpus() > 1);

I think this is overkill, and we could actually scream and try to return an
error here (we've not yet switched stack, and the upper layers of kexec look
like they can do something with an error code).

>  	/* Disable interrupts first */
>  	local_irq_disable();
>  	local_fiq_disable();
>  
> -	/* Disable the L2 if we're the last man standing. */
> -	if (num_online_cpus() == 1)
> -		outer_disable();
> +	/* Disable the L2 */
> +	outer_disable();
>  
>  	/* Change to the new stack and continue with the reset. */
>  	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
> @@ -184,30 +185,41 @@ int __init reboot_setup(char *str)
>  
>  __setup("reboot=", reboot_setup);
>  
> +/* For kexec */
>  void machine_shutdown(void)
>  {
> -#ifdef CONFIG_SMP
> -	smp_send_stop();
> +#ifdef CONFIG_PM_SLEEP_SMP
> +	disable_nonboot_cpus();
>  #endif

You can lose the #ifdef here.

> +
> +	BUG_ON(num_online_cpus() > 1);

Maybe redefine machine_shutdown if !kexec and lose this BUG?

>  void machine_halt(void)
>  {
> -	machine_shutdown();
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif

Don't need the #ifdef.

> +
>  	local_irq_disable();
>  	while (1);
>  }
>  
>  void machine_power_off(void)
>  {
> -	machine_shutdown();
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif
> +
>  	if (pm_power_off)
>  		pm_power_off();
>  }
>  
>  void machine_restart(char *cmd)
>  {
> -	machine_shutdown();
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif

Similarly for these two (power_off and restart).

Will
