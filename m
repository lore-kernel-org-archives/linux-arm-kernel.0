From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 16:39:59 +0000
Subject: [PATCH v6 11/19] arm64:ilp32: support core dump generation for
 ILP32
In-Reply-To: <1447795019-30176-12-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-12-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203163959.GM10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:51AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 01e032c..8f13dac 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -134,7 +134,11 @@ typedef struct user_fpsimd_state elf_fpregset_t;
[...]
> @@ -179,24 +186,80 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_A32_ELF_NGREG];
>  					 ((x)->e_flags & EF_ARM_EABI_MASK))
>  
>  #define compat_start_thread		compat_start_thread
> -#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
> -#define COMPAT_ARCH_DLINFO
> -extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
> -				      int uses_interp);
> -#define compat_arch_setup_additional_pages \
> -					aarch32_setup_vectors_page
> +#define COMPAT_A32_SET_PERSONALITY(ex)		\
> +do {						\
> +	clear_thread_flag(TIF_32BIT_AARCH64);	\
> +	set_thread_flag(TIF_32BIT);		\
> +} while (0)
> +#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
>  
>  #else
>  
>  typedef elf_greg_t			compat_elf_greg_t;
>  typedef elf_gregset_t			compat_elf_gregset_t;
>  #define compat_a32_elf_check_arch(x)	0
> -#define COMPAT_SET_PERSONALITY(ex)
> -#define COMPAT_ARCH_DLINFO
> +#define COMPAT_A32_SET_PERSONALITY(ex)	do {} while (0)
> +#define COMPAT_A32_ARCH_DLINFO		do {} while (0)
> +#endif
> +
> +/* If ILP32 is turned on, we want to define the compat_elf_greg_t to the non compat
> +   one and define PR_REG_SIZE/PRSTATUS_SIZE/SET_PR_FPVALID so we pick up the correct
> +   ones for AARCH32. Note also the definition of the macros have to be correct for
> +   LP64 as this file is included in the standard binfmt_elf.c. */
> +#ifdef CONFIG_ARM64_ILP32
> +typedef elf_greg_t			compat_elf_greg_t;
> +typedef elf_gregset_t			compat_elf_gregset_t;
> +#define PR_REG_SIZE(S)			(is_a32_compat_task() ? 72 : 272)
> +#define PRSTATUS_SIZE(S)		(is_a32_compat_task() ? 124 : (is_ilp32_compat_task() ? 352 : 392))

Can you be more specific about these numbers, what they represent, how
they are calculated? Can you not use some sizeof()?

> +#define SET_PR_FPVALID(S, V)							\
> +do {										\
> +	*(int *) (((void *) &((S)->pr_reg)) + PR_REG_SIZE((S)->pr_reg)) = (V);	\
> +} while (0)
> +#else
> +typedef compat_a32_elf_greg_t compat_elf_greg_t;
> +typedef compat_a32_elf_gregset_t compat_elf_gregset_t;
> +#endif
>  
> +#ifdef CONFIG_ARM64_ILP32
> +#define compat_ilp32_elf_check_arch(x) ((x)->e_machine == EM_AARCH64)
> +#define COMPAT_ILP32_SET_PERSONALITY(ex)	\
> +do {						\
> +	set_thread_flag(TIF_32BIT_AARCH64);	\
> +	clear_thread_flag(TIF_32BIT);		\
> +} while (0)
> +#define COMPAT_ILP32_ARCH_DLINFO					\
> +do {									\
> +	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
> +		    (elf_addr_t)(long)current->mm->context.vdso);	\
> +} while (0)
> +#else
> +#define compat_ilp32_elf_check_arch(x) 0
> +#define COMPAT_ILP32_SET_PERSONALITY(ex)	do {} while (0)
> +#define COMPAT_ILP32_ARCH_DLINFO		do {} while (0)
>  #endif
>  
> -#define compat_elf_check_arch(x)	compat_a32_elf_check_arch(x)
> +#define compat_elf_check_arch(x)	(compat_a32_elf_check_arch(x) || compat_ilp32_elf_check_arch(x))
> +#define COMPAT_SET_PERSONALITY(ex)			\
> +do {							\
> +	if (compat_a32_elf_check_arch(&ex))		\
> +		COMPAT_A32_SET_PERSONALITY(ex);		\
> +	else						\
> +		COMPAT_ILP32_SET_PERSONALITY(ex);	\
> +} while (0)
> +
> +/* ILP32 uses the "LP64-like" vdso pages */
> +#define compat_arch_setup_additional_pages	\
> +	(is_a32_compat_task()			\
> +	 ? &aarch32_setup_vectors_page		\
> +	 : &(arch_setup_additional_pages))

I thought vdso is not yet supported for ILP32. Do you still want to
insert the special mapping?

BTW, what do you do for sigreturn? It's handled by the vdso code on
AArch64.

> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 26352a6..b239b9b 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -107,6 +107,14 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
>  
>  	return PTR_ERR_OR_ZERO(ret);
>  }
> +#else
> +int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
> +{
> +	(void) bprm;
> +	(void) uses_interp;

Do you get a warning for unused function arguments?

> +
> +	return -EINVAL;
> +}

A BUG() would be useful here.

Alternatively, you can define this aarch32_setup_vectors_page as NULL
when !AARCH32_EL0.

-- 
Catalin
