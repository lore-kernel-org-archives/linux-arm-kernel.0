From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Aug 2014 15:05:08 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <1407847365-10873-1-git-send-email-achandran@mvista.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
Message-ID: <20140812140508.GB4159@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, Aug 12, 2014 at 01:42:45PM +0100, Arun Chandran wrote:
> soft_restart() will fail on arm64 systems that does not
> quarantee the flushing of cache to PoC with flush_cache_all().

The flush_cache_all function is never guaranteed to flush data to the
PoC, so I wouldn't say that this is only broken on some systems. We just
happen to have been lucky so far.

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

This doesn't match this organisation on soft_restart, which makes it a
little confusing.

>
> So convert the whole code to assembly to make sure that addr
> is not pushed to stack.

It's possible that the compiler would previously have spilled other
values too, we only observed addr being spilled.

How about we reword this something like:

The current soft_restart and setup_restart implementations incorrectly
assume that the compiler will not spill/fill values to/from the stack,
but the compiler has been observed to do so around the cache being
disabled, resulting in stale values being restored.

As we cannot control the compiler's spilling behaviour we must rewrite
the functions in assembly to avoid use of the stack.

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

Rather than having a custom virt_to_phys here, I think it would be
better to leave that address translation and table setup in c, and have
the asm be a smaller function which disables and cleans the cache, then
branches to the provided address.

So we'd still have a soft_restart function in c that looked something
like:

void soft_restart(unsigned long addr)
{
	setup_mm_for_reboot();
	cpu_soft_restart(virt_to_phys(cpu_reset), addr);
}

> +
> +	/* Save it; We can't use stack as it is going to run with caches OFF */
> +	mov	x19, x0
> +	mov	x20, x1
> +
> +	bl	setup_mm_for_reboot
> +
> +	bl	flush_cache_all

This first cache flush can be dropped entirely.

> +	/* Turn D-cache off */
> +	bl	cpu_cache_off
> +	/* Push out any further dirty data, and ensure cache is empty */
> +	bl	flush_cache_all
> +
> +	mov	x0, x19
> +
> +	br	x20
> +	/* It should never come back */
> +	bl	panic

Given we didn't use blr x20, won't we get stuck in an infinite loop here
if we returned from the address in x20?

I don't think panic will work here given we disabled the MMU and caches.
A branch to self is probably the best we can do if it's worth doing
anything.

Thanks,
Mark.
