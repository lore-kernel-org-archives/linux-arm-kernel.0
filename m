From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 May 2014 16:13:24 -0400 (EDT)
Subject: [PATCHv2] arm: put_user: fix possible data corruption in put_user
In-Reply-To: <1399360312-13843-1-git-send-email-a.ryabinin@samsung.com>
References: <alpine.LFD.2.11.1405050950410.980@knanqh.ubzr>
 <1399360312-13843-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.LFD.2.11.1405061610450.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 May 2014, Andrey Ryabinin wrote:

> According to arm procedure call standart r2 register is call-cloberred.
> So after the result of x expression was put into r2 any following
> function call in p may overwrite r2. To fix this, the result of p
> expression must be saved to the temporary variable before the
> assigment x expression to __r2.
> 
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> Cc: stable at vger.kernel.org

Please push this patch into Russell's patch system.

Thanks.

> ---
> Since v1:
>  - tmp_p variable renamed to __tmp_p
>  - added Reviewed-by tag
>  - added Cc: stable at vger.kernel.org
> 
>  arch/arm/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 12c3a5d..75d9579 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -171,8 +171,9 @@ extern int __put_user_8(void *, unsigned long long);
>  #define __put_user_check(x,p)							\
>  	({								\
>  		unsigned long __limit = current_thread_info()->addr_limit - 1; \
> +		const typeof(*(p)) __user *__tmp_p = (p);		\
>  		register const typeof(*(p)) __r2 asm("r2") = (x);	\
> -		register const typeof(*(p)) __user *__p asm("r0") = (p);\
> +		register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
>  		register unsigned long __l asm("r1") = __limit;		\
>  		register int __e asm("r0");				\
>  		switch (sizeof(*(__p))) {				\
> -- 
> 1.8.5.5
> 
