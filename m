From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 May 2014 11:53:56 +0200
Subject: [PATCH RESEND 1/7] ARM: Make thread_save_fp macro aware of
 THUMB2 mode
In-Reply-To: <1400837196-22339-2-git-send-email-Nikolay.Borisov@arm.com>
References: <1400837196-22339-1-git-send-email-Nikolay.Borisov@arm.com>
 <1400837196-22339-2-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140523095356.GH20155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 23, 2014 at 10:26:30AM +0100, Nikolay Borisov wrote:
> The thread_save_fp macro has been defined so that it always reads the fp member
> of the cpu_context_save struct. However, in the case of THUMB2 the fp is saved
> not in the fp (r11) member but rather in r7.
> 
> This patch changes the way the macro is defined such that FP is read from the
> correct place depending on whether we are a THUMB2 kernel or not. This enables
> the backtrace in sitaution such as "echo t > /proc/sysrq-trigger" or the
> function in which a process sleeping when "ps -Al" is invoked.
> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> Reviewed-by: Anurag Aggarwal <anurag19aggarwal@gmail.com>
> ---
>  arch/arm/include/asm/thread_info.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index f989d7c..e4e4208 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -114,8 +114,14 @@ static inline struct thread_info *current_thread_info(void)
>  	((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
>  #define thread_saved_sp(tsk)	\
>  	((unsigned long)(task_thread_info(tsk)->cpu_context.sp))
> +
> +#ifndef CONFIG_THUMB2_KERNEL
>  #define thread_saved_fp(tsk)	\
>  	((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
> +#else
> +#define thread_saved_fp(tsk)	\
> +	((unsigned long)(task_thread_info(tsk)->cpu_context.r7))
> +#endif
A comment would be nice here describing that it's gcc who forces this on
us. Did you test if the same happens with clang?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
