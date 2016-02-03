From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 17:01:15 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160203170114.GD1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K Poulose wrote:
> From: Suzuki K. Poulose <suzuki.poulose@arm.com>
> 
> A secondary CPU could fail to come online due to insufficient
> capabilities and could simply die or loop in the kernel.
> e.g, a CPU with no support for the selected kernel PAGE_SIZE
> loops in kernel with MMU turned off.
> or a hotplugged CPU which doesn't have one of the advertised
> system capability will die during the activation.
> 
> There is no way to synchronise the status of the failing CPU
> back to the master. This patch solves the issue by adding a
> field to the secondary_data which can be updated by the failing
> CPU. If the secondary CPU fails even before turning the MMU on,
> it updates the status in a special variable reserved in the head.txt
> section to make sure that the update can be cache invalidated safely
> without possible sharing of cache write back granule.
> 
> Here are the possible states :
> 
>  -1. CPU_MMU_OFF - Initial value set by the master CPU, this value
> indicates that the CPU could not turn the MMU on, hence the status
> could not be reliably updated in the secondary_data. Instead, the
> CPU has updated the status in __early_cpu_boot_status (reserved in
> head.txt section)
> 
>  0. CPU_BOOT_SUCCESS - CPU has booted successfully.
> 
>  1. CPU_KILL_ME - CPU has invoked cpu_ops->die, indicating the
> master CPU to synchronise by issuing a cpu_ops->cpu_kill.
> 
>  2. CPU_STUCK_IN_KERNEL - CPU couldn't invoke die(), instead is
> looping in the kernel. This information could be used by say,
> kexec to check if it is really safe to do a kexec reboot.
> 
>  3. CPU_PANIC_KERNEL - CPU detected some serious issues which
> requires kernel to crash immediately. The secondary CPU cannot
> call panic() until it has initialised the GIC. This flag can
> be used to instruct the master to do so.

When would we use this last case?

Perhaps a better option is to always throw any incompatible CPU into an
(MMU-off) pen, and assume that it's stuck in the kernel, even if we
could theoretically turn it off.

A system with incompatible CPUs is a broken system to begin with...

Otherwise, comments below.

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/smp.h    |   26 ++++++++++++++++++++++
>  arch/arm64/kernel/asm-offsets.c |    2 ++
>  arch/arm64/kernel/head.S        |   39 +++++++++++++++++++++++++++++---
>  arch/arm64/kernel/smp.c         |   47 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 3 deletions(-)

[...]

> @@ -650,6 +679,10 @@ __enable_mmu:
>  ENDPROC(__enable_mmu)
>  
>  __no_granule_support:
> +	/* Indicate that this CPU can't boot and is stuck in the kernel */
> +	update_early_cpu_boot_status x2, CPU_STUCK_IN_KERNEL
> +1:
>  	wfe
> -	b __no_granule_support
> +	wfi
> +	b 1b

The addition of wfi seems fine, but should be mentioned in the commit
message.

>  ENDPROC(__no_granule_support)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 59f032b..d2721ae 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -63,6 +63,8 @@
>   * where to place its SVC stack
>   */
>  struct secondary_data secondary_data;
> +/* Number of CPUs which aren't online, but looping in kernel text. */
> +u32 cpus_stuck_in_kernel;

Why u32 rather than int?

>  
>  enum ipi_msg_type {
>  	IPI_RESCHEDULE,
> @@ -72,6 +74,16 @@ enum ipi_msg_type {
>  	IPI_IRQ_WORK,
>  };
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int op_cpu_kill(unsigned int cpu);
> +#else
> +static inline int op_cpu_kill(unsigned int cpu)
> +{
> +	return -ENOSYS;
> +}
> +#endif

There is no !CONFIG_HOTPLUG_CPU configuration any more.

> +
> +
>  /*
>   * Boot a secondary CPU, and assign it the specified idle task.
>   * This also gives us the initial stack to use for this CPU.
> @@ -89,12 +101,14 @@ static DECLARE_COMPLETION(cpu_running);
>  int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  {
>  	int ret;
> +	int status;
>  
>  	/*
>  	 * We need to tell the secondary core where to find its stack and the
>  	 * page tables.
>  	 */
>  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> +	update_cpu_boot_status(CPU_MMU_OFF);
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>  
>  	/*

> @@ -117,7 +131,35 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> +	/* Make sure the update to status is visible */
> +	smp_rmb();
>  	secondary_data.stack = NULL;
> +	status = READ_ONCE(secondary_data.status);

What is the rmb intended to order here?

> +	if (ret && status) {
> +
> +		if (status == CPU_MMU_OFF)
> +			status = READ_ONCE(__early_cpu_boot_status);
> +
> +		switch (status) {
> +		default:
> +			pr_err("CPU%u: failed in unknown state : 0x%x\n",
> +					cpu, status);
> +			break;
> +		case CPU_KILL_ME:
> +			if (!op_cpu_kill(cpu)) {
> +				pr_crit("CPU%u: died during early boot\n", cpu);
> +				break;
> +			}
> +			/* Fall through */
> +			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> +		case CPU_STUCK_IN_KERNEL:
> +			pr_crit("CPU%u: is stuck in kernel\n", cpu);
> +			cpus_stuck_in_kernel++;
> +			break;
> +		case CPU_PANIC_KERNEL:
> +			panic("CPU%u detected unsupported configuration\n", cpu);
> +		}
> +	}
>  
>  	return ret;
>  }
> @@ -185,6 +227,9 @@ asmlinkage void secondary_start_kernel(void)
>  	 */
>  	pr_info("CPU%u: Booted secondary processor [%08x]\n",
>  					 cpu, read_cpuid_id());
> +	update_cpu_boot_status(CPU_BOOT_SUCCESS);
> +	/* Make sure the status update is visible before we complete */
> +	smp_wmb();

Surely complete() has appropriate barriers?

>  	set_cpu_online(cpu, true);
>  	complete(&cpu_running);
>  
> @@ -327,10 +372,12 @@ void cpu_die_early(void)
>  	set_cpu_present(cpu, 0);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +	update_cpu_boot_status(CPU_KILL_ME);
>  	/* Check if we can park ourselves */
>  	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
>  		cpu_ops[cpu]->cpu_die(cpu);

I think you need a barrier to ensure visibility of the store prior to
calling cpu_die (i.e. you want to order an access against execution). A
dsb is what you want -- smp_wmb() only expands to a dmb.

>  #endif
> +	update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
>  
>  	cpu_park_loop();

Likewise here.

Mark.
