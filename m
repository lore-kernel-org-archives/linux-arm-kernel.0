From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Aug 2017 14:55:05 +0100
Subject: [PATCH 2/2] arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro
In-Reply-To: <20170805144022.17260-3-ynorov@caviumnetworks.com>
References: <20170805144022.17260-1-ynorov@caviumnetworks.com>
 <20170805144022.17260-3-ynorov@caviumnetworks.com>
Message-ID: <20170808135504.pgbc5bbk6nytoc6u@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 05, 2017 at 05:40:22PM +0300, Yury Norov wrote:
> Originally {COMPAT_,}SET_PERSONALITY() only sets the 32-bit flag in thread_info
> structure. But there is some work that should be done after setting the personality.
> Currently it's done in the macro, which is not the best idea.
> 
> In this patch new arch_setup_new_exec() routine is introduced, and all setup code
> is moved there, as suggested by Catalin:
> https://lkml.org/lkml/2017/8/4/494
> 
> Note: mm->context.flags doesn't require the atomic strong ordered acceess to the
> field, so use __set_bit() there;

As I replied to patch 1, we don't even need __set_bit() but just '|='
for setting and '&' for testing.

> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index de11ed1484e3..615953243961 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -137,11 +137,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>   */
>  #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
>  
> +/*
> + * Don't modify this macro unless you add new personality.
> + * All personality-related setup should be done at proper place.
> + * If not sure, consider the arch_setup_new_exec() function.
> + */
>  #define SET_PERSONALITY(ex)						\
>  ({									\
> -	clear_bit(MMCF_AARCH32, &current->mm->context.flags);		\
>  	clear_thread_flag(TIF_32BIT);					\
> -	current->personality &= ~READ_IMPLIES_EXEC;			\
>  })

What I meant is that we keep the personality setting in SET_PERSONALITY,
together with the existing TIF bits but just move the mm->context.flags
setting out.

> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 46c3b93cf865..c823d2f12b4c 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -68,6 +68,9 @@ struct thread_info {
>  #define thread_saved_fp(tsk)	\
>  	((unsigned long)(tsk->thread.cpu_context.fp))
>  
> +void arch_setup_new_exec(void);
> +#define arch_setup_new_exec     arch_setup_new_exec

I'm fine with out of line implementation, it probably helps with any
header conflicts (and it's not a fast path anyway).

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 659ae8094ed5..ebca9e4f62c7 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -417,3 +417,20 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
>  	else
>  		return randomize_page(mm->brk, SZ_1G);
>  }
> +
> +/*
> + * Called immediately after a successful exec.
> + */
> +void arch_setup_new_exec(void)
> +{
> +	current->mm->context.flags = 0;
> +
> +	/*
> +	 * Unlike the native one, the compat version of exec() inherits
> +	 * READ_IMPLIES_EXEC since this is the behaviour on arch/arm/.
> +	 */
> +	if (is_compat_task())
> +		__set_bit(MMCF_AARCH32, &current->mm->context.flags);
> +	else
> +		current->personality &= ~READ_IMPLIES_EXEC;
> +}

As I said above, just context.flags |= MMCF_AARCH32.

Thanks.

-- 
Catalin
