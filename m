From: frank.rowand@am.sony.com (Frank Rowand)
Date: Mon, 19 Dec 2011 17:36:13 -0800
Subject: [RFC PATCH v2 6/6] ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW
 on pre-ARMv6 CPUs
In-Reply-To: <1324306673-4282-7-git-send-email-catalin.marinas@arm.com>
References: <1324306673-4282-1-git-send-email-catalin.marinas@arm.com>
 <1324306673-4282-7-git-send-email-catalin.marinas@arm.com>
Message-ID: <4EEFE68D.6040601@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/11 06:57, Catalin Marinas wrote:
> This patch removes the __ARCH_WANT_INTERRUPTS_ON_CTXSW definition for
> ARMv5 and earlier processors. On such processors, the context switch
> requires a full cache flush. To avoid high interrupt latencies, this
> patch defers the mm switching to the post-lock switch hook if the
> interrupts are disabled.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  arch/arm/include/asm/mmu_context.h |   30 +++++++++++++++++++++++++-----
>  arch/arm/include/asm/system.h      |    9 ---------
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
> index fd6eeba..4ac7809 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -104,19 +104,39 @@ static inline void finish_arch_post_lock_switch(void)
>  
>  #else	/* !CONFIG_CPU_HAS_ASID */
>  
> +#ifdef CONFIG_MMU
> +
>  static inline void check_and_switch_context(struct mm_struct *mm,
>  					    struct task_struct *tsk)
>  {
> -#ifdef CONFIG_MMU
>  	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
>  		__check_kvm_seq(mm);
> -	cpu_switch_mm(mm->pgd, mm);
> -#endif
> +
> +	if (irqs_disabled())
> +		/*
> +		 * Defer the cpu_switch_mm() call and continue running with
> +		 * the old mm. Since we only support UP systems on non-ASID
> +		 * CPUs, the old mm will remain valid until the
> +		 * finish_arch_post_lock_switch() call.

It would be good to include in this comment the info from the patch header
that deferring the cpu_switch_mm() is to avoid high interrupt latencies.

I had applied all six patches so I could see what the end result looked
like, and reading the end result was asking myself why cpu_switch_mm() was
deferred for !CONFIG_CPU_HAS_ASID (since I was instead focusing on the
problem of calling __new_context() with IRQs disabled).  Then when I looked
at this patch in isolation, the patch header clearly answered the question for me.

> +		 */
> +		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
> +	else
> +		cpu_switch_mm(mm->pgd, mm);
>  }
>  
> -#define init_new_context(tsk,mm)	0
> +#define finish_arch_post_lock_switch \
> +	finish_arch_post_lock_switch
> +static inline void finish_arch_post_lock_switch(void)
> +{
> +	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
> +		struct mm_struct *mm = current->mm;
> +		cpu_switch_mm(mm->pgd, mm);
> +	}
> +}
>  
> -#define finish_arch_post_lock_switch()	do { } while (0)
> +#endif	/* CONFIG_MMU */
> +
> +#define init_new_context(tsk,mm)	0
>  
>  #endif	/* CONFIG_CPU_HAS_ASID */
>  
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 3daebde..ac7fade 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -218,15 +218,6 @@ static inline void set_copro_access(unsigned int val)
>  }
>  
>  /*
> - * switch_mm() may do a full cache flush over the context switch,
> - * so enable interrupts over the context switch to avoid high
> - * latency.
> - */
> -#ifndef CONFIG_CPU_HAS_ASID
> -#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
> -#endif
> -
> -/*
>   * switch_to(prev, next) should switch from task `prev' to `next'
>   * `prev' will never be the same as `next'.  schedule() itself
>   * contains the memory barrier to tell GCC not to cache `current'.
> 
> 
> .
> 
