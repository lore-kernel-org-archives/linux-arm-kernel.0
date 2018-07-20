From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jul 2018 07:23:15 +0100
Subject: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
In-Reply-To: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
References: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
Message-ID: <20180720062314.7qh23yfq2o5jciuh@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 03:18:46PM -0700, Venkata Narendra Kumar Gutta wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().
> 
> CPU0                      CPU1
> 
>  sys_reboot()
>  kernel_restart()
>  machine_restart()
>  machine_shutdown()
>  smp_send_stop()

>From a quick look arm64's machine_restart() disables IRQs, calls
smp_send_stop(), then calls one of:

* efi_reboot()
* arm_pm_restart()
* do_kernel_restart()

... and I can't see any of these calling machine_shutdown() directly.

How does machine_shutdown() get called? Is that somewhere in the restart_list
associated with do_kernel_restart?

>  ...                   ipi_cpu_stop()
> 		       set_cpu_online(1, false)
>                        local_irq_disable()
>                        while(1)
>         <PREEMPT>

Given IRQs are disabled in machine_restart(), I don't understand how this
preemption can occur. Where do they get re-enabled?

>  cpu_up()
>  _cpu_up()
>  if (!cpu_online(1))
>  __cpu_notify(CPU_UP_PREPARE...)
> 
>  cpu_stop_cpu_callback()
>  BUG_ON(stopper->thread)
> 
> This is easily reproducible by hotplugging in and out in a tight
> loop while also rebooting.

Is this reproducible with mainline? e.g. v4.18-rc5?

I've packed away my HW in preparation for an office move, but I might be able
to give this a go in a VM.

> Since the CPU is not really offline and hasn't gone through the
> proper steps to be marked as such, let's mark the CPU as inactive.
> This is just as easily testable as online and avoids any possibility
> of _cpu_up() trying to bring the CPU back online when it never was
> offline to begin with. Based on the similar patchset by for arm
> targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

Is this in mainline?

Looking at v4.18-rc5 I don't see arm's ipi_cpu_stop touching the active mask.

Thanks,
Mark.

> 
> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  arch/arm64/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2faa986..adee4d3 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -790,7 +790,7 @@ void arch_irq_work_raise(void)
>   */
>  static void ipi_cpu_stop(unsigned int cpu)
>  {
> -	set_cpu_online(cpu, false);
> +	set_cpu_active(cpu, false);
>  
>  	local_daif_mask();
>  	sdei_mask_local_cpu();
> @@ -925,10 +925,10 @@ void smp_send_stop(void)
>  
>  	/* Wait up to one second for other CPUs to stop */
>  	timeout = USEC_PER_SEC;
> -	while (num_online_cpus() > 1 && timeout--)
> +	while (num_active_cpus() > 1 && timeout--)
>  		udelay(1);
>  
> -	if (num_online_cpus() > 1)
> +	if (num_active_cpus() > 1)
>  		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>  			   cpumask_pr_args(cpu_online_mask));
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
