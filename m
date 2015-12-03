From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 12:13:03 +0000
Subject: [PATCH v6 07/19] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <1447795019-30176-8-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-8-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203121303.GK10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:47AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index 7fbed69..9700e5e 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -299,19 +299,44 @@ struct compat_shmid64_ds {
>  	compat_ulong_t __unused5;
>  };
>  
> -static inline int is_compat_task(void)
> +#ifdef CONFIG_AARCH32_EL0
> +
> +static inline int is_a32_compat_task(void)
>  {
>  	return test_thread_flag(TIF_32BIT);
>  }
>  
> -static inline int is_compat_thread(struct thread_info *thread)
> +static inline int is_a32_compat_thread(struct thread_info *thread)
>  {
>  	return test_ti_thread_flag(thread, TIF_32BIT);
>  }
>  
> +#else
> +
> +static inline int is_a32_compat_task(void)
> +{
> +	return 0;
> +}
> +
> +static inline int is_a32_compat_thread(struct thread_info *thread)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static inline int is_compat_task(void)
> +{
> +	return is_a32_compat_task();
> +}
> +
>  #else /* !CONFIG_COMPAT */
>  
> -static inline int is_compat_thread(struct thread_info *thread)
> +static inline int is_a32_compat_thread(struct thread_info *thread)
> +{
> +	return 0;
> +}
> +
> +static inline int is_a32_compat_task(void)
>  {
>  	return 0;
>  }

My main worry with this patch is a potential #include mess. I can see
that you already had to include asm/compat.h explicitly in
hw_breakpoint.c even though linux/compat.h was already included. In
subsequent files (asm/elf.h, asm/memory.h) you check is_compat_task()
without explicitly including asm/compat.h and hope that it won't break.

A solution would be to add these functions in a separate header file
that gets included where needed (also by asm/compat.h).

-- 
Catalin
