From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 18:47:10 +0100
Subject: [PATCH 10/24] ARM64: Introduce is_a32_task and is_a32_thread.
 Use them in the correct locations.
In-Reply-To: <1400914939-9708-11-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-11-git-send-email-apinski@cavium.com>
Message-ID: <20140618174710.GB11977@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 12:02:05AM -0700, Andrew Pinski wrote:
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index e71f81f..fad7612 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -293,28 +293,47 @@ struct compat_shmid64_ds {
>  	compat_ulong_t __unused5;
>  };
>  
> -static inline int is_compat_task(void)
> +#ifdef CONFIG_AARCH32_EL0
> +static inline int is_a32_compat_task(void)
>  {
>  	return test_thread_flag(TIF_32BIT);
>  }
> -
> -static inline int is_compat_thread(struct thread_info *thread)
> +static inline int is_a32_compat_thread(struct thread_info *thread)
>  {
>  	return test_ti_thread_flag(thread, TIF_32BIT);
>  }
> +#else
> +static inline int is_a32_compat_task(void)
> +{
> +	return 0;
> +}
> +static inline int is_a32_compat_thread(struct thread_info *thread)
> +{
> +	return 0;
> +}
> +#endif
>  
>  #else /* !CONFIG_COMPAT */
>  
> -static inline int is_compat_task(void)
> +static inline int is_a32_compat_task(void)
>  {
>  	return 0;
>  }
> -
> -static inline int is_compat_thread(struct thread_info *thread)
> +static inline int is_a32_compat_thread(struct thread_info *thread)
>  {
>  	return 0;
>  }

Why do we have 2 dummy definitions for is_a32_compat_task()? Could we
not squash them into one with different #ifdefs?

>  
>  #endif /* CONFIG_COMPAT */
> +
> +static inline int is_compat_task(void)
> +{
> +	return is_a32_compat_task();
> +}
> +
> +static inline int is_compat_thread(struct thread_info *thread)
> +{
> +	return is_a32_compat_thread(thread);
> +}
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_COMPAT_H */
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 36c3603..8180511 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -150,7 +150,7 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  
>  /* 1GB of VA */
>  #ifdef CONFIG_COMPAT
> -#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
> +#define STACK_RND_MASK			(is_compat_task() ? \
>  						0x7ff >> (PAGE_SHIFT - 12) : \
>  						0x3ffff >> (PAGE_SHIFT - 12))

I think I tried something similar in the past and while it works most of
the time, you can easily get into an #include mess since now elf.h needs
compat.h. Similarly for other header files where you've changed this.

> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 720e70b..b2bf728 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -106,7 +106,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20
>  #define TIF_SINGLESTEP		21
> -#define TIF_32BIT		22	/* 32bit process */
> +#define TIF_32BIT		22	/* AARCH32 process */

Can we not just keep TIF_32BIT for limiting the address space to 32-bit
and use another bit for AArch32 applications?

-- 
Catalin
