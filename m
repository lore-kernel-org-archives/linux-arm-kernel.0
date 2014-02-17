From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Feb 2014 19:32:10 +0000
Subject: [PATCH 2/2] arm64: is_compat_task is defined both in
 asm/compat.h and linux/compat.h
In-Reply-To: <1391767892-5395-3-git-send-email-takahiro.akashi@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140217193210.GI26590@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:11:32AM +0000, AKASHI Takahiro wrote:
> kernel/seccomp.c includes linux/compat.h and, indicrectly, asm/compat.h
> via asm/syscall.h. Due to the duplicated definition of is_compat_task,
> compiling this file will fail in the case of !CONFIG_COMPAT.
> This patch makes the definition in asm/compat.h valid only if necessary.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/include/asm/compat.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index fda2704..72f3b18 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -305,10 +305,12 @@ static inline int is_compat_thread(struct thread_info *thread)
>  
>  #else /* !CONFIG_COMPAT */
>  
> +#ifndef is_compat_task /* it's there in linux/compat.h */
>  static inline int is_compat_task(void)
>  {
>  	return 0;
>  }
> +#endif

This is horrible! Can we instead include linux/compat.h where we need this
macro and then remove this definition?

Will
