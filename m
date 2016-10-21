From: james.morse@arm.com (James Morse)
Date: Fri, 21 Oct 2016 15:50:34 +0100
Subject: [PATCH 10/10] arm64: split thread_info from task stack
In-Reply-To: <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
Message-ID: <580A2B3A.7000300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

This looks great, we should definitely do this.
There are a few things missing from entry.S below:

On 19/10/16 20:10, Mark Rutland wrote:
> This patch moves arm64's struct thread_info from the task stack into
> task_struct. This protects thread_info from corruption in the case of
> stack overflows, and makes its address harder to determine if stack
> addresses are leaked, making a number of attacks more difficult. Precise
> detection and handling of overflow is left for subsequent patches.
> 
> Largely, this involves changing code to store the task_struct in sp_el0,
> and acquire the thread_info from the task struct (which is the opposite
> way around to the current code). Both secondary entry and idle are
> updated to stash the sp and task pointer separately.
> 
> Userspace clobbers sp_el0, and we can no longer restore this from the
> stack. Instead, the current task is cached in a per-cpu variable that we
> can safely access from early assembly as interrupts are disabled (and we

>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/current.h     | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/smp.h         |  1 +
>  arch/arm64/include/asm/thread_info.h | 24 ------------------------
>  arch/arm64/kernel/asm-offsets.c      |  1 +

>  arch/arm64/kernel/entry.S            |  4 ++--

4? That was too easy...


>  arch/arm64/kernel/head.S             | 11 ++++++-----
>  arch/arm64/kernel/process.c          | 13 +++++++++++++
>  arch/arm64/kernel/smp.c              |  2 ++
>  10 files changed, 48 insertions(+), 32 deletions(-)


> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 2d4c83b..e781391 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -123,6 +123,7 @@
>  	 * Set sp_el0 to current thread_info.
>  	 */
>  	.if	\el == 0
> +	ldr_this_cpu	tsk, __entry_task, x21
>  	msr	sp_el0, tsk
>  	.endif
>  
> @@ -674,8 +675,7 @@ ENTRY(cpu_switch_to)
>  	ldp	x29, x9, [x8], #16
>  	ldr	lr, [x8]
>  	mov	sp, x9
> -	and	x9, x9, #~(THREAD_SIZE - 1)
> -	msr	sp_el0, x9
> +	msr	sp_el0, x1
>  	ret
>  ENDPROC(cpu_switch_to)
>  

So now tsk is current instead of current_thread_info(), but we still access it
with TI_* offsets:
entry.S:102
> 	/* Save the task's original addr_limit and set USER_DS (TASK_SIZE_64) */
> 	ldr	x20, [tsk, #TI_ADDR_LIMIT]
> 	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
> 	mov	x20, #TASK_SIZE_64
> 	str	x20, [tsk, #TI_ADDR_LIMIT]

entry.S:143
> 	/* Restore the task's original addr_limit. */
> 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
> 	str	x20, [tsk, #TI_ADDR_LIMIT]


The 're-entered irq stack' check is going to need re-thinking:
entry.S:195
> 	/*
> 	 * Compare sp with the current thread_info, if the top
> 	 * ~(THREAD_SIZE - 1) bits match, we are on a task stack, and
> 	 * should switch to the irq stack.
> 	 */
> 	and	x25, x19, #~(THREAD_SIZE - 1)
> 	cmp	x25, tsk
> 	b.ne	9998f

It was done like this as the irq stack isn't naturally aligned, so this check
implicitly assumes tsk is on the stack. I will try and come up with an alternative.


And there are a few other things like this:
entry.S:431
> 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
> 	cbnz	w24, 1f				// preempt count != 0
> 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
> 	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
> 	bl	el1_preempt


(It may be worth renaming the register alias 'tsk' as it isn't really a
 struct_task. This would catch any missed users at build time, including
 any patches in flight...)


> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 2f39036..ddce61b 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -45,6 +45,7 @@
>  #include <linux/personality.h>
>  #include <linux/notifier.h>
>  #include <trace/events/power.h>
> +#include <linux/percpu.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/compat.h>
> @@ -312,6 +313,17 @@ static void uao_thread_switch(struct task_struct *next)
>  }
>  
>  /*
> + * We store our current task in sp_el0, which is clobbered by userspace. Keep a
> + * shadow copy so that we can restore this upon entry from userspace.
> + */
> +DEFINE_PER_CPU(struct task_struct *, __entry_task) = &init_task;
> +
> +static void entry_task_switch(struct task_struct *next)
> +{
> +	__this_cpu_write(__entry_task, next);
> +}
> +
> +/*
>   * Thread switching.
>   */
>  struct task_struct *__switch_to(struct task_struct *prev,
> @@ -323,6 +335,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	tls_thread_switch(next);
>  	hw_breakpoint_thread_switch(next);
>  	contextidr_thread_switch(next);
> +	entry_task_switch(next);
>  	uao_thread_switch(next);
>  
>  	/*
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2679722..cde25f4 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -149,6 +149,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	 * We need to tell the secondary core where to find its stack and the
>  	 * page tables.
>  	 */
> +	secondary_data.task = idle;
>  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
>  	update_cpu_boot_status(CPU_MMU_OFF);
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
> @@ -173,6 +174,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> +	secondary_data.task = NULL;
>  	secondary_data.stack = NULL;
>  	status = READ_ONCE(secondary_data.status);
>  	if (ret && status) {
> 

Nit-territory: Something we should remember is that __entry_task isn't written
on secondary startup, so its stale (CPU0s idle task) until the first
__switch_to(). This isn't a problem as its only read on entry from EL0.


Thanks,

James
