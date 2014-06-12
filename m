From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 19:04:52 +0200
Subject: [PATCH v3] ARM: add get_user() support for 8 byte types
In-Reply-To: <1402587755-29245-1-git-send-email-daniel.thompson@linaro.org>
References: <1402587755-29245-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <4740478.2oOtz84PUv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 16:42:35 Daniel Thompson wrote:
>  #define __get_user_check(x,p)                                                  \
>         ({                                                              \
>                 unsigned long __limit = current_thread_info()->addr_limit - 1; \
>                 register const typeof(*(p)) __user *__p asm("r0") = (p);\
> -               register unsigned long __r2 asm("r2");                  \
> +               register typeof(x) __r2 asm("r2");                      \
>                 register unsigned long __l asm("r1") = __limit;         \
>                 register int __e asm("r0");                             \
>                 switch (sizeof(*(__p))) {                               \
> @@ -142,6 +152,12 @@ extern int __get_user_4(void *);
>                 case 4:                                                 \
>                         __get_user_x(__r2, __p, __e, __l, 4);           \
>                         break;                                          \
> +               case 8:                                                 \
> +                       if (sizeof((x)) < 8)                            \
> +                               __get_user_xb(__r2, __p, __e, __l, 4);  \
> +                       else                                            \
> +                               __get_user_x(__r2, __p, __e, __l, 8);   \
> +                       break;                                          \
>                 default: __e = __get_user_bad(); break;                 \
>                 }                                                       \
>                 x = (typeof(*(p))) __r2;                                \
> 

I don't think there is a way to do this without copying the
__builtin_choose_expr() hack from x86.

	Arnd
