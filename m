From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Dec 2013 16:08:45 +0000
Subject: [PATCH 1/6] arm64: lib: Implement optimized memcpy routine
In-Reply-To: <1386743082-5231-2-git-send-email-zhichang.yuan@linaro.org>
References: <1386743082-5231-1-git-send-email-zhichang.yuan@linaro.org>
 <1386743082-5231-2-git-send-email-zhichang.yuan@linaro.org>
Message-ID: <20131216160845.GD20193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 06:24:37AM +0000, zhichang.yuan at linaro.org wrote:
> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
> 
> This patch, based on Linaro's Cortex Strings library, improves
> the performance of the assembly optimized memcpy() function.
> 
> Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> ---
>  arch/arm64/lib/memcpy.S |  182 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 160 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
> index 27b5003..e3bab71 100644
> --- a/arch/arm64/lib/memcpy.S
> +++ b/arch/arm64/lib/memcpy.S
> @@ -1,5 +1,13 @@
>  /*
>   * Copyright (C) 2013 ARM Ltd.
> + * Copyright (C) 2013 Linaro.
> + *
> + * This code is based on glibc cortex strings work originally authored by Linaro
> + * and re-licensed under GPLv2 for the Linux kernel. The original code can
> + * be found @
> + *
> + * http://bazaar.launchpad.net/~linaro-toolchain-dev/cortex-strings/trunk/
> + * files/head:/src/aarch64/
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -27,27 +35,157 @@
>   * Returns:
>   *	x0 - dest
>   */
> +#define dstin	x0
> +#define src	x1
> +#define count	x2
> +#define tmp1	x3
> +#define tmp1w	w3
> +#define tmp2	x4
> +#define tmp2w	w4
> +#define tmp3	x5
> +#define tmp3w	w5
> +#define dst	x6
> +
> +#define A_l	x7
> +#define A_h	x8
> +#define B_l	x9
> +#define B_h	x10
> +#define C_l	x11
> +#define C_h	x12
> +#define D_l	x13
> +#define D_h	x14

Use .req instead of #define?

>  ENTRY(memcpy)
> -	mov	x4, x0
> -	subs	x2, x2, #8
> -	b.mi	2f
> -1:	ldr	x3, [x1], #8
> -	subs	x2, x2, #8
> -	str	x3, [x4], #8
> -	b.pl	1b
> -2:	adds	x2, x2, #4
> -	b.mi	3f
> -	ldr	w3, [x1], #4
> -	sub	x2, x2, #4
> -	str	w3, [x4], #4
> -3:	adds	x2, x2, #2
> -	b.mi	4f
> -	ldrh	w3, [x1], #2
> -	sub	x2, x2, #2
> -	strh	w3, [x4], #2
> -4:	adds	x2, x2, #1
> -	b.mi	5f
> -	ldrb	w3, [x1]
> -	strb	w3, [x4]
> -5:	ret
> +	mov	dst, dstin
> +	cmp	count, #16
> +	/*If memory length is less than 16, stp or ldp can not be used.*/
> +	b.lo	.Ltiny15
> +.Lover16:
> +	neg	tmp2, src
> +	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
> +	b.eq	.LSrcAligned
> +	sub	count, count, tmp2
> +	/*
> +	* Use ldp and sdp to copy 16 bytes,then backward the src to
> +	* aligned address.This way is more efficient.
> +	* But the risk overwriting the source area exists.Here,prefer to
> +	* access memory forward straight,no backward.It will need a bit
> +	* more instructions, but on the same time,the accesses are aligned.
> +	*/

This comment reads very badly:

  - sdp doesn't exist
  - `more efficient' than what? How is this measured?
  - `access memory forward straight,no backward' What?

Please re-write it in a clearer fashion, so that reviewers have some
understanding of your optimisations when potentially trying to change the
code later on.

> +	tbz	tmp2, #0, 1f
> +	ldrb	tmp1w, [src], #1
> +	strb	tmp1w, [dst], #1
> +1:
> +	tbz	tmp2, #1, 1f
> +	ldrh	tmp1w, [src], #2
> +	strh	tmp1w, [dst], #2
> +1:
> +	tbz	tmp2, #2, 1f
> +	ldr	tmp1w, [src], #4
> +	str	tmp1w, [dst], #4
> +1:

Three labels called '1:' ? Can you make them unique please (the old code
just incremented a counter).

> +	tbz	tmp2, #3, .LSrcAligned
> +	ldr	tmp1, [src],#8
> +	str	tmp1, [dst],#8
> +
> +.LSrcAligned:
> +	cmp	count, #64
> +	b.ge	.Lcpy_over64
> +	/*
> +	* Deal with small copies quickly by dropping straight into the
> +	* exit block.
> +	*/
> +.Ltail63:
> +	/*
> +	* Copy up to 48 bytes of data. At this point we only need the
> +	* bottom 6 bits of count to be accurate.
> +	*/
> +	ands	tmp1, count, #0x30
> +	b.eq	.Ltiny15
> +	cmp	tmp1w, #0x20
> +	b.eq	1f
> +	b.lt	2f
> +	ldp	A_l, A_h, [src], #16
> +	stp	A_l, A_h, [dst], #16
> +1:
> +	ldp	A_l, A_h, [src], #16
> +	stp	A_l, A_h, [dst], #16
> +2:
> +	ldp	A_l, A_h, [src], #16
> +	stp	A_l, A_h, [dst], #16
> +.Ltiny15:
> +	/*
> +	* To make memmove simpler, here don't make src backwards.
> +	* since backwards will probably overwrite the src area where src
> +	* data for nex copy located,if dst is not so far from src.
> +	*/

Another awful comment...

> +	tbz	count, #3, 1f
> +	ldr	tmp1, [src], #8
> +	str	tmp1, [dst], #8
> +1:
> +	tbz	count, #2, 1f
> +	ldr	tmp1w, [src], #4
> +	str	tmp1w, [dst], #4
> +1:
> +	tbz	count, #1, 1f
> +	ldrh	tmp1w, [src], #2
> +	strh	tmp1w, [dst], #2
> +1:

... and more of these labels.

> +	tbz	count, #0, .Lexitfunc
> +	ldrb	tmp1w, [src]
> +	strb	tmp1w, [dst]
> +
> +.Lexitfunc:
> +	ret
> +
> +.Lcpy_over64:
> +	subs	count, count, #128
> +	b.ge	.Lcpy_body_large
> +	/*
> +	* Less than 128 bytes to copy, so handle 64 here and then jump
> +	* to the tail.
> +	*/
> +	ldp	A_l, A_h, [src],#16
> +	stp	A_l, A_h, [dst],#16
> +	ldp	B_l, B_h, [src],#16
> +	ldp	C_l, C_h, [src],#16
> +	stp	B_l, B_h, [dst],#16
> +	stp	C_l, C_h, [dst],#16
> +	ldp	D_l, D_h, [src],#16
> +	stp	D_l, D_h, [dst],#16
> +
> +	tst	count, #0x3f
> +	b.ne	.Ltail63
> +	ret
> +
> +	/*
> +	* Critical loop.  Start at a new cache line boundary.  Assuming
> +	* 64 bytes per line this ensures the entire loop is in one line.
> +	*/
> +	.p2align	6

Can you parameterise this with L1_CACHE_SHIFT instead?

Will
