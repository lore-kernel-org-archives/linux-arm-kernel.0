From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jul 2018 13:40:59 +0100
Subject: [PATCH 4/6] ARM: use __inttype() in get_user()
In-Reply-To: <E1fctP0-0005vF-Iu@rmk-PC.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctP0-0005vF-Iu@rmk-PC.armlinux.org.uk>
Message-ID: <20180726124058.6ztpan37fa3jyghg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 03:14:02PM +0100, Russell King wrote:
> Borrow the x86 implementation of __inttype() to use in get_user() to
> select an integer type suitable to temporarily hold the result value.
> This is necessary to avoid propagating the volatile nature of the
> result argument, which can cause the following warning:
> 
> lib/iov_iter.c:413:5: warning: optimization may eliminate reads and/or writes to register variables [-Wvolatile-register-var]
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/include/asm/uaccess.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 0bf2347495f1..29fa6f3ea25a 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -85,6 +85,13 @@ static inline void set_fs(mm_segment_t fs)
>  	flag; })
>  
>  /*
> + * This is a type: either unsigned long, if the argument fits into
> + * that type, or otherwise unsigned long long.
> + */
> +#define __inttype(x) \
> +	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
> +
> +/*
>   * Single-value transfer routines.  They automatically use the right
>   * size if we just have the right pointer type.  Note that the functions
>   * which read from user space (*get_*) need to take care not to leak
> @@ -153,7 +160,7 @@ extern int __get_user_64t_4(void *);
>  	({								\
>  		unsigned long __limit = current_thread_info()->addr_limit - 1; \
>  		register const typeof(*(p)) __user *__p asm("r0") = (p);\
> -		register typeof(x) __r2 asm("r2");			\
> +		register __inttype(x) __r2 asm("r2");			\
>  		register unsigned long __l asm("r1") = __limit;		\
>  		register int __e asm("r0");				\
>  		unsigned int __ua_flags = uaccess_save_and_enable();	\
> -- 
> 2.7.4
> 
