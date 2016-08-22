From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Aug 2016 12:37:39 +0100
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <1471636928-11177-1-git-send-email-bdegraaf@codeaurora.org>
References: <20160812114111.GA21484@leverpostej>
 <1471636928-11177-1-git-send-email-bdegraaf@codeaurora.org>
Message-ID: <20160822113739.GA30850@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 19, 2016 at 04:02:08PM -0400, Brent DeGraaf wrote:
> Introduce explicit control-flow logic immediately prior to virtual
> counter register read in all cases so that the mrs read will
> always be accessed after all vdso data elements are read and
> sequence count is verified. Ensure data elements under the
> protection provided by the sequence counter are read only within
> the protection logic loop.  Read the virtual counter as soon as
> possible after the data elements are confirmed correctly read,
> rather than after several other operations which can affect time.
> Reduce full barriers required in register read code in favor of
> the lighter-weight one-way barrier supplied by a load-acquire
> wherever possible.

As I commented previously, can you please explain *why* these chagnes
should be made?

* What problem does this patch address?

* Is this a bug fix? If so, what problem can be seen currently?

* Is this an optimisation? If so, how much of an improvement can be
  seen?

In the absence of answers to the above, this patch is impossible to
review, and will not get applied. It makes invasive changes, ans we need
a rationale for those.

I've made some comments below, but the above is key.

[...]

> +	.macro	seqdata_acquire fallback, tzonly=NO_TZ, skipvcnt=0, getdata
> +9999:	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
> +8888:	tbnz	seqcnt, #0, 9999b
>  	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
> -	cbnz	w_tmp, \fail
> +	cbnz	w_tmp, \fallback
> +	\getdata
> +	dmb	ishld	/* No loads from vdso_data after this point */

What ordering guarantee is the DMB attempting to provide? Given we have
the acquire, I assume some prior load, but I couldn't figure out what
specifically.

> +	mov	w9, seqcnt
> +	ldar	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]

Usually, acquire operations pair with a release operation elsewhere. What
does this pair with?

> +	cmp	w9, seqcnt
> +	bne	8888b	/* Do not needlessly repeat ldar and its implicit barrier */
> +	.if (\tzonly) != NO_TZ
> +		cbz	x0, \tzonly
> +	.endif
> +	.if (\skipvcnt) == 0
> +		isb
> +		mrs	x_tmp, cntvct_el0
> +	.endif
>  	.endm

All this conitional code makes the callers somehwat painful to read.

It might be nicer to have this explicit in the calelrs that require it
rather than conditional in the macro.

>  
>  	.macro get_nsec_per_sec res
> @@ -64,9 +70,6 @@ x_tmp		.req	x8
>  	 * shift.
>  	 */
>  	.macro	get_clock_shifted_nsec res, cycle_last, mult
> -	/* Read the virtual counter. */
> -	isb
> -	mrs	x_tmp, cntvct_el0
>  	/* Calculate cycle delta and convert to ns. */
>  	sub	\res, x_tmp, \cycle_last
>  	/* We can only guarantee 56 bits of precision. */
> @@ -137,17 +140,12 @@ x_tmp		.req	x8
>  ENTRY(__kernel_gettimeofday)
>  	.cfi_startproc
>  	adr	vdso_data, _vdso_data
> -	/* If tv is NULL, skip to the timezone code. */
> -	cbz	x0, 2f
> -
> -	/* Compute the time of day. */
> -1:	seqcnt_acquire
> -	syscall_check fail=4f
> -	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
> -	/* w11 = cs_mono_mult, w12 = cs_shift */
> -	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
> -	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
> -	seqcnt_check fail=1b
> +	seqdata_acquire fallback=4f tzonly=2f getdata=__stringify(\
> +		ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST];\
> +		/* w11 = cs_mono_mult, w12 = cs_shift */;\
> +		ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT];\
> +		ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC];\
> +		ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST])

Why do we need the stringify? Is that just so we can pass the code as a
macro parameter? If so, it really doesn't look like the way to go...

This is unfortunately painful to read.

Thanks,
Mark.
