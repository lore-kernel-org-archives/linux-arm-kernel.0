From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Aug 2014 11:58:29 +0100
Subject: [PATCH] Arm64: convert part of soft_restart() to assembly
In-Reply-To: <1407915801-8703-1-git-send-email-achandran@mvista.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1407915801-8703-1-git-send-email-achandran@mvista.com>
Message-ID: <20140813105829.GC32644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Wed, Aug 13, 2014 at 08:43:21AM +0100, Arun Chandran wrote:
> The current soft_restart() and setup_restart implementations incorrectly
> assume that compiler will not spill/fill values to/from stack. However
> this assumption seems to be wrong, revealed by the disassembly of the
> currently existing code.
> 
> Pseudo code for disassembly looks like
> 
> soft_restart(addr)
> {
> 	__push_to_stack(addr)
> 
> 	branch to setup_mm_for_reboot()
> 	branch to flush_cache_all() --> This is unnecessary
> 	branch to cpu_cache_off()
> 	branch to flush_cache_all() --> Not guaranteed of flushing to PoC
> 
> 	__pop_from_stack(addr) --> Fails here as addr is not at PoC
> 
> 	cpu_reset(addr) --> cpu_reset receives invalid reset address
> }

As I mentioned before, I think having pseudocode here is confusing.
Either we should have a real disassembly or we should drop it. I get the
following when I build a v3.16 arm64 defconfig with Linaro GCC
4.9-2014.05:

ffffffc000085224 <soft_restart>:
ffffffc000085224:       a9be7bfd        stp     x29, x30, [sp,#-32]!
ffffffc000085228:       910003fd        mov     x29, sp
ffffffc00008522c:       f9000fa0        str     x0, [x29,#24]
ffffffc000085230:       94003b16        bl      ffffffc000093e88 <setup_mm_for_reboot>
ffffffc000085234:       94003927        bl      ffffffc0000936d0 <flush_cache_all>
ffffffc000085238:       94003bf2        bl      ffffffc000094200 <cpu_cache_off>
ffffffc00008523c:       94003925        bl      ffffffc0000936d0 <flush_cache_all>
ffffffc000085240:       b00031c1        adrp    x1, ffffffc0006be000 <reset_devices>
ffffffc000085244:       f9400fa0        ldr     x0, [x29,#24]
ffffffc000085248:       f941c822        ldr     x2, [x1,#912]
ffffffc00008524c:       f0000061        adrp    x1, ffffffc000094000 <set_mm_context+0x10>
ffffffc000085250:       91088021        add     x1, x1, #0x220
ffffffc000085254:       8b010041        add     x1, x2, x1
ffffffc000085258:       d2c00802        mov     x2, #0x4000000000               // #274877906944
ffffffc00008525c:       8b020021        add     x1, x1, x2
ffffffc000085260:       d63f0020        blr     x1
...

The two ldrs correspond to the spilled addr variable and memstart_addr
respectively.

> 
> The compiler is clearly spilling here around the cache being disabled,
> resulting in stale values being restored.  As we cannot control the compiler's

Nit: double spacing here doesn't match the rest of the message.

> spilling behaviour we must rewrite the functions in assembly to
> avoid use of the stack.
> 
> Signed-off-by: Arun Chandran <achandran@mvista.com>
> ---
>  arch/arm64/include/asm/proc-fns.h |    2 ++
>  arch/arm64/kernel/process.c       |   30 ++----------------------------
>  arch/arm64/mm/proc.S              |   14 ++++++++++++++
>  3 files changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
> index 0c657bb..86be4f9 100644
> --- a/arch/arm64/include/asm/proc-fns.h
> +++ b/arch/arm64/include/asm/proc-fns.h
> @@ -32,6 +32,8 @@ extern void cpu_cache_off(void);
>  extern void cpu_do_idle(void);
>  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
>  extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
> +extern void cpu_soft_restart(phys_addr_t cpu_reset,
> +		unsigned long addr) __attribute__((noreturn));
>  extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
>  extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
>  
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1309d64..bf66922 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -57,36 +57,10 @@ unsigned long __stack_chk_guard __read_mostly;
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
>  void soft_restart(unsigned long addr)
>  {
> -	typedef void (*phys_reset_t)(unsigned long);
> -	phys_reset_t phys_reset;
> -
> -	setup_restart();
> -
> -	/* Switch to the identity mapping */
> -	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> -	phys_reset(addr);
> -
> +	setup_mm_for_reboot();
> +	cpu_soft_restart(virt_to_phys(cpu_reset), addr);
>  	/* Should never get here */
>  	BUG();
>  }
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 7736779..0eff5ee 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -76,6 +76,20 @@ ENTRY(cpu_reset)
>  	ret	x0
>  ENDPROC(cpu_reset)
>  
> +ENTRY(cpu_soft_restart)
> +	/* Save address of cpu_reset() and reset address */
> +	mov	x19, x0
> +	mov	x20, x1
> +
> +	/* Turn D-cache off */
> +	bl	cpu_cache_off
> +	/* Push out all dirty data, and ensure cache is empty */
> +	bl	flush_cache_all
> +
> +	mov	x0, x20
> +	ret	x19
> +ENDPROC(cpu_soft_restart)

The code change looks good to me.

Cheers,
Mark.
