From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Mar 2016 10:56:20 +0000
Subject: [PATCHv2] arm64: kasan: clear stale stack poison
In-Reply-To: <1456862465-31505-1-git-send-email-mark.rutland@arm.com>
References: <1456862465-31505-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160302105620.GB25547@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 08:01:05PM +0000, Mark Rutland wrote:

[...]

> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
> index 2774fa3..6f00b76 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -1,10 +1,30 @@
>  #ifndef __ASM_KASAN_H
>  #define __ASM_KASAN_H
>  
> -#ifndef __ASSEMBLY__
> -
> +#ifndef LINKER_SCRIPT
>  #ifdef CONFIG_KASAN
>  
> +#ifdef __ASSEMBLY__
> +
> +#include <asm/asm-offsets.h>
> +#include <asm/thread_info.h>
> +
> +	/*
> +	 * Remove stale shadow posion for the stack left over from a prior
> +	 * hot-unplug or idle exit, from the lowest stack address in the
> +	 * thread_union up to the covering up to the current stack pointer.
> +	 * Shadow poison above this is preserved.
> +	 */
> +	.macro kasan_unpoison_stack
> +	mov	x1, sp
> +	and	x0, x1, #~(THREAD_SIZE - 1)

I suspect you did not use sp_el0 on purpose here (that contains a
pointer to thread_info), just asking.

> +	add	x0, x0, #(THREAD_INFO_SIZE)
> +	sub	x1, x1, x0
> +	bl	kasan_unpoison_shadow

I wonder whether a wrapper function eg kasan_unpoison_stack(addr) is
better, where the thread info/stack address computation can be done in C
we just pass it the precise bottom of the stack location watermark, which
is the only reason why we want to call it from assembly.

Other than that:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +	.endm

> +
> +#else /* __ASSEMBLY__ */
> +
>  #include <linux/linkage.h>
>  #include <asm/memory.h>
>  
> @@ -30,9 +50,17 @@
>  void kasan_init(void);
>  asmlinkage void kasan_early_init(void);
>  
> -#else
> +#endif /* __ASSEMBLY__ */
> +
> +#else /* CONFIG_KASAN */
> +
> +#ifdef __ASSEMBLY__
> +	.macro kasan_unpoison_stack
> +	.endm
> +#else /* __ASSEMBLY */
>  static inline void kasan_init(void) { }
> -#endif
> +#endif /* __ASSEMBLY__ */
>  
> -#endif
> -#endif
> +#endif /* CONFIG_KASAN */
> +#endif /* LINKER_SCRIPT */
> +#endif /* __ASM_KASAN_H */
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index fffa4ac6..c615fa3 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ int main(void)
>    DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
>    DEFINE(TI_TASK,		offsetof(struct thread_info, task));
>    DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
> +  DEFINE(THREAD_INFO_SIZE,	sizeof(struct thread_info));
>    BLANK();
>    DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
>    BLANK();
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 917d981..35ae2cb 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -29,6 +29,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/cache.h>
>  #include <asm/cputype.h>
> +#include <asm/kasan.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
> @@ -616,6 +617,7 @@ ENTRY(__secondary_switched)
>  	and	x0, x0, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x0			// save thread_info
>  	mov	x29, #0
> +	kasan_unpoison_stack
>  	b	secondary_start_kernel
>  ENDPROC(__secondary_switched)
>  
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index e33fe33..3ad7681 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -2,6 +2,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
> +#include <asm/kasan.h>
>  
>  	.text
>  /*
> @@ -145,6 +146,7 @@ ENTRY(cpu_resume_mmu)
>  ENDPROC(cpu_resume_mmu)
>  	.popsection
>  cpu_resume_after_mmu:
> +	kasan_unpoison_stack
>  	mov	x0, #0			// return zero on success
>  	ldp	x19, x20, [sp, #16]
>  	ldp	x21, x22, [sp, #32]
> -- 
> 1.9.1
> 
