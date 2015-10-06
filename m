From: andrey.konovalov@linaro.org (Andrey Konovalov)
Date: Tue, 6 Oct 2015 12:21:33 +0300
Subject: [PATCH v5 10/23] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <1443564860-31208-11-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <1443564860-31208-11-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5613929D.6070802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

With this patch set 4.3 kernel fails to build with arch/arm64/configs/defconfig plus CONFIG_AARCH32_EL0=y
and CONFIG_ARM64_ILP32=y giving the following three errors (the 3d one is warning actually):

-----8<-----
13:21:16 In file included from ../arch/arm64/kernel/process.c:48:0:
13:21:16 ../arch/arm64/include/asm/compat.h:370:38: error: macro "is_compat_task" passed 1 arguments, but takes just 0
13:21:16  static inline int is_compat_task(void)
13:21:16                                       ^
13:21:16 ../arch/arm64/include/asm/compat.h:371:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
13:21:16  {
13:21:16  ^
13:21:16 ../arch/arm64/include/asm/compat.h:375:19: error: redefinition of 'is_compat_thread'
13:21:16  static inline int is_compat_thread(struct thread_info *thread)
13:21:16                    ^
13:21:16 ../arch/arm64/include/asm/compat.h:350:19: note: previous definition of 'is_compat_thread' was here
13:21:16  static inline int is_compat_thread(struct thread_info *thread)
13:21:16                    ^
13:21:16 ../arch/arm64/include/asm/compat.h: In function 'is_compat_thread':
13:21:16 ../arch/arm64/include/asm/compat.h:377:2: error: implicit declaration of function 'is_a32_compat_thread' 
[-Werror=implicit-function-declaration]
13:21:16   return is_a32_compat_thread(thread) || is_ilp32_compat_thread(thread);
13:21:16   ^
13:21:16 cc1: some warnings being treated as errors
-----8<-----

See more details below.

Thanks,
Andrey

On 09/30/2015 01:14 AM, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
>
> This patch introduces is_a32_compat_task and is_a32_thread so it is
> easier
> to say this is a a32 specific thread or a generic compat thread/task.
>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index 7fbed69..3a2976d 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -299,15 +299,25 @@ struct compat_shmid64_ds {
>   	compat_ulong_t __unused5;
>   };
>
> -static inline int is_compat_task(void)
> +#ifdef CONFIG_AARCH32_EL0
> +static inline int is_a32_compat_task(void)
>   {
>   	return test_thread_flag(TIF_32BIT);
>   }
> -
> -static inline int is_compat_thread(struct thread_info *thread)
> +static inline int is_a32_compat_thread(struct thread_info *thread)
>   {
>   	return test_ti_thread_flag(thread, TIF_32BIT);
>   }
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
>   #else /* !CONFIG_COMPAT */
>
> @@ -316,6 +326,21 @@ static inline int is_compat_thread(struct thread_info *thread)

- this misprint is the reason for the last two errors. That is_compat_thread above
should be is_a32_compat_thread.

>   	return 0;
>   }
>
> +static inline int is_a32_compat_task(void)
> +{
> +	return 0;
> +}
> +
>   #endif /* CONFIG_COMPAT */
> +
> +static inline int is_compat_task(void)
> +{
> +	return is_a32_compat_task();
> +}

- the above definition causes the 1st of the errors as in the !CONFIG_COMPAT case
include/linux/compat.h has:

-----8<-----
#define is_compat_task() (0)
-----8<-----

is_compat_task() should not be defined outside #ifdef CONFIG_COMPAT.

> +static inline int is_compat_thread(struct thread_info *thread)
> +{
> +	return is_a32_compat_thread(thread);
> +}
>   #endif /* __KERNEL__ */
>   #endif /* __ASM_COMPAT_H */
<snip>
