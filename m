From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Aug 2014 10:20:21 -0700
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <1407847365-10873-1-git-send-email-achandran@mvista.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
Message-ID: <1408123221.22761.38.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, 2014-08-12 at 18:12 +0530, Arun Chandran wrote:
> soft_restart() will fail on arm64 systems that does not
> quarantee the flushing of cache to PoC with flush_cache_all().
> 
> soft_restart(addr)
> {
> 	push_to_stack(addr);
> 
> 	Do mm setup for restart;
> 	Flush&turnoff D-cache;
> 
> 	pop_from_stack(addr); --> fails here as addr is not at PoC
> 	cpu_reset(addr) --> Jumps to invalid address
> }

For the cpu-ops shutdown I'm working on I need a call to move the
secondary processors to an identity mapped spin loop after the identity
map is enabled.  I want to do this in C code, so it needs to happen
after the identity map is enabled, and before the dcache is disabled.

I think to do this we can keep the existing soft_restart(addr) routine
with something like this:

void soft_restart(unsigned long addr)
{
	setup_mm_for_reboot();

#if defined(CONFIG_SMP)
	smp_secondary_shutdown();
#endif

	cpu_soft_restart(addr);

	/* Should never get here */
	BUG();
}


> 
> So convert the whole code to assembly to make sure that addr
> is not pushed to stack.
> 
> Signed-off-by: Arun Chandran <achandran@mvista.com>
> ---
>  arch/arm64/include/asm/proc-fns.h    |    1 +
>  arch/arm64/include/asm/system_misc.h |    1 -
>  arch/arm64/kernel/process.c          |   38 ++--------------------------------
>  arch/arm64/mm/proc.S                 |   34 ++++++++++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
> index 0c657bb..e18d5d0 100644
> --- a/arch/arm64/include/asm/proc-fns.h
> +++ b/arch/arm64/include/asm/proc-fns.h
> @@ -32,6 +32,7 @@ extern void cpu_cache_off(void);
>  extern void cpu_do_idle(void);
>  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
>  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> +extern void cpu_soft_restart(unsigned long addr) __attribute__((noreturn));

Function prototypes are never definitions, so remove this 'extern'
keyword.  checkpatch should have warned about this.  If it did not,
report it to the checkpatch maintainers.

>  extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
>  extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
>  
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index 7a18fab..659fbf5 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -41,7 +41,6 @@ struct mm_struct;
>  extern void show_pte(struct mm_struct *mm, unsigned long addr);
>  extern void __show_regs(struct pt_regs *);
>  
> -void soft_restart(unsigned long);
>  extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  
>  #define UDBG_UNDEFINED	(1 << 0)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1309d64..3ca1ade 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -57,40 +57,6 @@ unsigned long __stack_chk_guard __read_mostly;
>  EXPORT_SYMBOL(__stack_chk_guard);
>  #endif
>  
> -static void setup_restart(void)
> -{
> -	/*
> -	 * Tell the mm system that we are going to reboot -
> -	 * we may need it to insert some 1:1 mappings so that
> -	 * soft boot works.
> -	 */
> -	setup_mm_for_reboot();
> -
> -	/* Clean and invalidate caches */
> -	flush_cache_all();
> -
> -	/* Turn D-cache off */
> -	cpu_cache_off();
> -
> -	/* Push out any further dirty data, and ensure cache is empty */
> -	flush_cache_all();
> -}
> -
> -void soft_restart(unsigned long addr)
> -{
> -	typedef void (*phys_reset_t)(unsigned long);
> -	phys_reset_t phys_reset;
> -
> -	setup_restart();
> -
> -	/* Switch to the identity mapping */
> -	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> -	phys_reset(addr);
> -
> -	/* Should never get here */
> -	BUG();
> -}
> -
>  /*
>   * Function pointers to optional machine specific functions
>   */
> @@ -162,8 +128,8 @@ void machine_power_off(void)
>  
>  /*
>   * Restart requires that the secondary CPUs stop performing any activity
> - * while the primary CPU resets the system. Systems with a single CPU can
> - * use soft_restart() as their machine descriptor's .restart hook, since that
> + * while the primary CPU resets the system. Systems with a single CPU can use
> + * cpu_soft_restart() as their machine descriptor's .restart hook, since that
>   * will cause the only available CPU to reset. Systems with multiple CPUs must
>   * provide a HW restart implementation, to ensure that all CPUs reset at once.
>   * This is required so that any code running after reset on the primary CPU
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 7736779..a7c3fce 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -76,6 +76,40 @@ ENTRY(cpu_reset)
>  	ret	x0
>  ENDPROC(cpu_reset)
>  
> +	.align 3
> +1:	.quad	memstart_addr
> +
> +ENTRY(cpu_soft_restart)
> +	adr	x1, cpu_reset
> +	adr	x2, 1b
> +
> +	/* virt_to_phys(cpu_reset) */
> +	ldr	x3, [x2]
> +	ldr	x3, [x3]
> +	mov	x4, #1
> +	lsl	x4, x4, #(VA_BITS - 1)
> +	add	x1, x1, x4
> +	add	x1, x1, x3
> +
> +	/* Save it; We can't use stack as it is going to run with caches OFF */
> +	mov	x19, x0
> +	mov	x20, x1
> +
> +	bl	setup_mm_for_reboot
> +
> +	bl	flush_cache_all
> +	/* Turn D-cache off */
> +	bl	cpu_cache_off
> +	/* Push out any further dirty data, and ensure cache is empty */
> +	bl	flush_cache_all

It would be nice to have some blank lines above the comments.  Same
below.

> +	mov	x0, x19
> +
> +	br	x20
> +	/* It should never come back */
> +	bl	panic
> +ENDPROC(cpu_soft_restart)
> +
>  /*
>   *	cpu_do_idle()
>   *
