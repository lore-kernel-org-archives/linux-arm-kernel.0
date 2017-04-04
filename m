From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 4 Apr 2017 11:27:07 -0700
Subject: [PATCH v6 2/4] x86/syscalls: Specific usage of
 verify_pre_usermode_state
In-Reply-To: <20170404174727.35478-2-thgarnie@google.com>
References: <20170404174727.35478-1-thgarnie@google.com>
 <20170404174727.35478-2-thgarnie@google.com>
Message-ID: <05d9c4a7-8acb-5997-1dd6-d534398e6f54@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/17 10:47, Thomas Garnier wrote:
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 516593e66bd6..12fa851c7fa8 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -78,4 +78,15 @@ typedef struct { pteval_t pte; } pte_t;
>  
>  #define EARLY_DYNAMIC_PAGE_TABLES	64
>  
> +/*
> + * User space process size. 47bits minus one guard page.  The guard
> + * page is necessary on Intel CPUs: if a SYSCALL instruction is at
> + * the highest possible canonical userspace address, then that
> + * syscall will enter the kernel with a non-canonical return
> + * address, and SYSRET will explode dangerously.  We avoid this
> + * particular problem by preventing anything from being mapped
> + * at the maximum canonical address.
> + */
> +#define TASK_SIZE_MAX	((_AC(1, UL) << 47) - PAGE_SIZE)
> +
>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 3cada998a402..e80822582d3e 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -825,17 +825,6 @@ static inline void spin_lock_prefetch(const void *x)
>  #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>  
>  #else
> -/*
> - * User space process size. 47bits minus one guard page.  The guard
> - * page is necessary on Intel CPUs: if a SYSCALL instruction is at
> - * the highest possible canonical userspace address, then that
> - * syscall will enter the kernel with a non-canonical return
> - * address, and SYSRET will explode dangerously.  We avoid this
> - * particular problem by preventing anything from being mapped
> - * at the maximum canonical address.
> - */
> -#define TASK_SIZE_MAX	((1UL << 47) - PAGE_SIZE)
> -
>  /* This decides where the kernel will search for a free chunk of vm
>   * space during mmap's.
>   */
> 

This should be an entirely separate patch; if nothing else you need to
explain it in the comments.

Also, you say this is for "x86", but I still don't see any code for i386
whatsoever.  Have you verified *all* the i386 and i386-compat paths to
make sure they go via prepare_exit_to_usermode()?  [Cc: Andy]

Finally, I can't really believe I'm the only person for whom "Specific
usage of verity_pre_usermode_state" is completely opaque.

	-hpa
