From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Nov 2010 15:08:19 -0500 (EST)
Subject: [PATCH] ARM: Allow SMP_ON_UP to work with Thumb-2 kernels.
In-Reply-To: <1290449631-29100-1-git-send-email-dave.martin@linaro.org>
References: <1290449631-29100-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011221446260.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

>   * __fixup_smp_on_up has been modified with support for the THUMB2_KERNEL
> 	case.  For THUMB2_KERNEL only, fixups are split into halfwords in
> 	case of misalignment, since we can't rely on unaligned accesses
> 	working before turning the MMU on.
> 
> 	No attempt is made to optimise the aligned case, since the number
> 	of fixups is typically small, and it seems best to keep the code
> 	as simple as possible.

ACK.

>   * A "mode" parameter has been added to smp_dmb:
> 
> 	smp_dmp arm	@ assumes 4-byte instructions (for ARM code, e.g. kuser)
> 	smp_dmp		@ uses W() to ensure 4-byte instructions for ALT_SMP()
> 
> 	This avoids assembly failures due to use of W() inside smp_dmb,
> 	when assembling pure-ARM code in the vectors page.
> 
> 	There might be a better way to achieve this.

Is the W() sufficient to indicate an ARM encoding?  To me it is meant to 
specify a wide encoding when using Thumb2 encoding.  And if this is for 
the kuser code segments (which should always be ARM mode by the way) 
then this shouldn't make any difference.

And did you mean "smp_dmb" instead of "smp_dmp" above?

>   * Kconfig: make SMP_ON_UP depend on (!THUMB2_KERNEL || !BIG_ENDIAN)
> 	i.e., THUMB2_KERNEL is now supported, but only if !BIG_ENDIAN
> 	(The fixup code for Thumb-2 currently assumes little-endian order.)
[...]
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -407,10 +407,14 @@ __fixup_smp_on_up:
>  	add	r6, r6, r3
>  	add	r7, r7, r3
>  2:	cmp	r6, r7
> +	movhs	pc, lr
>  	ldmia	r6!, {r0, r4}
> -	strlo	r4, [r0, r3]
> -	blo	2b
> -	mov	pc, lr
> + ARM(	str	r4, [r0, r3]	)
> + THUMB(	add	r0, r0, r3	)
> + THUMB(	strh	r4, [r0], #2	)	@ For Thumb-2, store as two halfwords
> + THUMB(	mov	r4, r4, lsr #16	)	@ to be robust against misaligned r3.
> + THUMB(	strh	r4, [r0]	)	@ NOTE: currently assumes little-endian.
> +	b	2b

All you minimally need to support big endian here is to insert:

#ifndef __ARMEB__
THUMB(	mov	r4, r4, ror #16	)
#endif

just before the first store.


Nicolas
