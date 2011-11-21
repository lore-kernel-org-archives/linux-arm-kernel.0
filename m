From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Nov 2011 14:24:08 -0500 (EST)
Subject: [PATCH 5/6] ARM: Atomic64: fix 64bit ops in BE mode
In-Reply-To: <1321322785-2981-5-git-send-email-junxiao.bi@windriver.com>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
 <1321322785-2981-5-git-send-email-junxiao.bi@windriver.com>
Message-ID: <alpine.LFD.2.02.1111211423420.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2011, Junxiao Bi wrote:

> The add/sub ops to 64 bits double word are made by adds/subs to the least
> significant 32 bits first and then adc/sbc to the most significant 32 bits.
> Using %0 and %H0 can only work in LE mode. If we change them to %Q0 and %R0,
> it will work in both endian modes since %Q0 always represents the least
> significant 32 bits and %R0 represents the most.
> 
> Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/include/asm/atomic.h |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index 86976d0..00fcc4f 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -275,8 +275,8 @@ static inline void atomic64_add(u64 i, atomic64_t *v)
>  
>  	__asm__ __volatile__("@ atomic64_add\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
> -"	adds	%0, %0, %4\n"
> -"	adc	%H0, %H0, %H4\n"
> +"	adds	%Q0, %Q0, %Q4\n"
> +"	adc	%R0, %R0, %R4\n"
>  "	strexd	%1, %0, %H0, [%3]\n"
>  "	teq	%1, #0\n"
>  "	bne	1b"
> @@ -294,8 +294,8 @@ static inline u64 atomic64_add_return(u64 i, atomic64_t *v)
>  
>  	__asm__ __volatile__("@ atomic64_add_return\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
> -"	adds	%0, %0, %4\n"
> -"	adc	%H0, %H0, %H4\n"
> +"	adds	%Q0, %Q0, %Q4\n"
> +"	adc	%R0, %R0, %R4\n"
>  "	strexd	%1, %0, %H0, [%3]\n"
>  "	teq	%1, #0\n"
>  "	bne	1b"
> @@ -315,8 +315,8 @@ static inline void atomic64_sub(u64 i, atomic64_t *v)
>  
>  	__asm__ __volatile__("@ atomic64_sub\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
> -"	subs	%0, %0, %4\n"
> -"	sbc	%H0, %H0, %H4\n"
> +"	subs	%Q0, %Q0, %Q4\n"
> +"	sbc	%R0, %R0, %R4\n"
>  "	strexd	%1, %0, %H0, [%3]\n"
>  "	teq	%1, #0\n"
>  "	bne	1b"
> @@ -334,8 +334,8 @@ static inline u64 atomic64_sub_return(u64 i, atomic64_t *v)
>  
>  	__asm__ __volatile__("@ atomic64_sub_return\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
> -"	subs	%0, %0, %4\n"
> -"	sbc	%H0, %H0, %H4\n"
> +"	subs	%Q0, %Q0, %Q4\n"
> +"	sbc	%R0, %R0, %R4\n"
>  "	strexd	%1, %0, %H0, [%3]\n"
>  "	teq	%1, #0\n"
>  "	bne	1b"
> @@ -402,9 +402,9 @@ static inline u64 atomic64_dec_if_positive(atomic64_t *v)
>  
>  	__asm__ __volatile__("@ atomic64_dec_if_positive\n"
>  "1:	ldrexd	%0, %H0, [%3]\n"
> -"	subs	%0, %0, #1\n"
> -"	sbc	%H0, %H0, #0\n"
> -"	teq	%H0, #0\n"
> +"	subs	%Q0, %Q0, #1\n"
> +"	sbc	%R0, %R0, #0\n"
> +"	teq	%R0, #0\n"
>  "	bmi	2f\n"
>  "	strexd	%1, %0, %H0, [%3]\n"
>  "	teq	%1, #0\n"
> @@ -433,8 +433,8 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
>  "	teqeq	%H0, %H5\n"
>  "	moveq	%1, #0\n"
>  "	beq	2f\n"
> -"	adds	%0, %0, %6\n"
> -"	adc	%H0, %H0, %H6\n"
> +"	adds	%Q0, %Q0, %Q6\n"
> +"	adc	%R0, %R0, %R6\n"
>  "	strexd	%2, %0, %H0, [%4]\n"
>  "	teq	%2, #0\n"
>  "	bne	1b\n"
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
