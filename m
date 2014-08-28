From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 28 Aug 2014 11:34:49 +0100
Subject: [RFC PATCH V2] arm: fix get_user BE behavior for target variable
 with size of 8 bytes
In-Reply-To: <1408944296-10032-1-git-send-email-victor.kamensky@linaro.org>
References: <1408944296-10032-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <53FF05C9.30806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/14 06:24, Victor Kamensky wrote:
> e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
> broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
> is 32 bit or smaller. e38361d changed type of __r2 from 'register
> unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
> even when target variable size was 64 bit, __r2 was still 32 bit.
> But after e38361d commit, for target var of 64 bit size, __r2 became 64
> bit and now it should occupy 2 registers r2, and r3. The issue in BE case
> that r3 register is least significant word of __r2 and r2 register is most
> significant word of __r2. But __get_user_4 still copies result into r2 (most
> significant word of __r2). Subsequent code copies from __r2 into x, but
> for situation described it will pick up only garbage from r3 register.
> 
> It was discovered during 3.17-rc1 V7 BE KVM testing. Simple test case below.
> Note it works in LE case because r2 in LE case is still least significant
> word.
> 
> This is 2nd variant of the fix, idea was suggested by Daniel Thompson. In
> this variant of the fix for case of BE image and target variable size
> is 8 bytes, special __get_user_64t_(124) functions are introduced they
> are similar to corresponding __get_user_(124) function but result stored
> in r3 register (lsw in case of 64 bit __r2 in BE image).
> 
> Changelog:
> 
> v2: this version: uses __get_user_64t_(124) special function of BE
> sizeof(__r2) == 64 case
> 
> v1: first variant, that used different types for __r2 depending on brach
> in switch statement, has problem of generating multiple warnings in case
> of incorrect but single get_user usage.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

There are a few comments below, nevertheless...

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/arm/include/asm/uaccess.h | 36 +++++++++++++++++++++++++++++++++---
>  arch/arm/lib/getuser.S         | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index a4cd7af..58e53da 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -109,6 +109,9 @@ extern int __get_user_2(void *);
>  extern int __get_user_4(void *);
>  extern int __get_user_lo8(void *);
>  extern int __get_user_8(void *);
> +extern int __get_user_64t_1(void *);
> +extern int __get_user_64t_2(void *);
> +extern int __get_user_64t_4(void *);

Should we rename __get_user_lo8 to __get_user_32t_8? to make the naming
consistent?


>  #define __GUP_CLOBBER_1	"lr", "cc"
>  #ifdef CONFIG_CPU_USE_DOMAINS
> @@ -137,6 +140,24 @@ extern int __get_user_8(void *);
>  #define __get_user_xb __get_user_x
>  #endif
>  
> +/*
> + * storing result into proper least significant word of 64bit target var,
> + * different only for big endian case where 64 bit __r2 lsw is r3:
> + */
> +#ifdef __ARMEB__
> +#define __get_user_x_64t(__r2, __p, __e, __l, __s)		        \
> +	   __asm__ __volatile__ (					\
> +		__asmeq("%0", "r0") __asmeq("%1", "r2")			\
> +		__asmeq("%3", "r1")					\
> +		"bl	__get_user_64t_" #__s				\
> +		: "=&r" (__e), "=r" (__r2)				\
> +		: "0" (__p), "r" (__l)					\
> +		: __GUP_CLOBBER_##__s)
> +#else
> +#define __get_user_x_64t __get_user_x
> +#endif
> +
> +
>  #define __get_user_check(x,p)							\
>  	({								\
>  		unsigned long __limit = current_thread_info()->addr_limit - 1; \
> @@ -146,13 +167,22 @@ extern int __get_user_8(void *);
>  		register int __e asm("r0");				\
>  		switch (sizeof(*(__p))) {				\
>  		case 1:							\
> -			__get_user_x(__r2, __p, __e, __l, 1);		\
> +			if (sizeof((x)) >= 8)				\
> +				__get_user_x_64t(__r2, __p, __e, __l, 1); \
> +			else						\
> +				__get_user_x(__r2, __p, __e, __l, 1);	\
>  			break;						\
>  		case 2:							\
> -			__get_user_x(__r2, __p, __e, __l, 2);		\
> +			if (sizeof((x)) >= 8)				\
> +				__get_user_x_64t(__r2, __p, __e, __l, 2); \
> +			else						\
> +				__get_user_x(__r2, __p, __e, __l, 2);	\
>  			break;						\
>  		case 4:							\
> -			__get_user_x(__r2, __p, __e, __l, 4);		\
> +			if (sizeof((x)) >= 8)				\
> +				__get_user_x_64t(__r2, __p, __e, __l, 4); \
> +			else						\
> +				__get_user_x(__r2, __p, __e, __l, 4);	\
>  			break;						\
>  		case 8:							\
>  			if (sizeof((x)) < 8)

Similarly __get_user_xb() (which appears on the next line) would become
__get_user_x_32t.

				\
> diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
> index 9386000..5025459 100644
> --- a/arch/arm/lib/getuser.S
> +++ b/arch/arm/lib/getuser.S
> @@ -91,6 +91,40 @@ ENTRY(__get_user_lo8)
>  	mov	r0, #0
>  	ret	lr
>  ENDPROC(__get_user_lo8)
> +
> +ENTRY(__get_user_64t_1)
> +	check_uaccess r0, 1, r1, r2, __get_user_bad8
> +8: TUSER(ldrb)	r3, [r0]
> +	mov	r0, #0
> +	ret	lr
> +ENDPROC(__get_user_64t_1)
> +
> +ENTRY(__get_user_64t_2)
> +	check_uaccess r0, 2, r1, r2, __get_user_bad8
> +#ifdef CONFIG_CPU_USE_DOMAINS
> +rb	.req	ip
> +9:	ldrbt	r3, [r0], #1
> +10:	ldrbt	rb, [r0], #0
> +#else
> +rb	.req	r0
> +9:	ldrb	r3, [r0]
> +10:	ldrb	rb, [r0, #1]
> +#endif
> +#ifndef __ARMEB__
> +	orr	r3, r3, rb, lsl #8
> +#else
> +	orr	r3, rb, r3, lsl #8
> +#endif

The #ifndef isn't needed here since __ARMEB__ is already known to be
defined.


> +	mov	r0, #0
> +	ret	lr
> +ENDPROC(__get_user_64t_2)
> +
> +ENTRY(__get_user_64t_4)
> +	check_uaccess r0, 4, r1, r2, __get_user_bad8
> +11: TUSER(ldr)	r3, [r0]
> +	mov	r0, #0
> +	ret	lr
> +ENDPROC(__get_user_64t_4)
>  #endif
>  
>  __get_user_bad8:
> @@ -111,5 +145,9 @@ ENDPROC(__get_user_bad8)
>  	.long	6b, __get_user_bad8
>  #ifdef __ARMEB__
>  	.long   7b, __get_user_bad
> +	.long	8b, __get_user_bad8
> +	.long	9b, __get_user_bad8
> +	.long	10b, __get_user_bad8
> +	.long	11b, __get_user_bad8
