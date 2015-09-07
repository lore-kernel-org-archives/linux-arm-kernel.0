From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Sep 2015 17:54:41 +0100
Subject: [PATCH V4 1/2] arm64: copy_to-from-in_user optimization using
 copy template
In-Reply-To: <1440194493-4907-1-git-send-email-fkan@apm.com>
References: <1440194458-4837-1-git-send-email-fkan@apm.com>
 <1440194493-4907-1-git-send-email-fkan@apm.com>
Message-ID: <20150907165441.GC10645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 03:01:33PM -0700, Feng Kan wrote:
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 1be9ef2..cb085cf 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -18,6 +18,7 @@
>  
>  #include <asm/alternative.h>
>  #include <asm/assembler.h>
> +#include <asm/cache.h>
>  #include <asm/cpufeature.h>
>  #include <asm/sysreg.h>
>  
> @@ -31,49 +32,58 @@
>   * Returns:
>   *	x0 - bytes not copied
>   */
> +
> +	.macro ldrb1 label, ptr, regB, val
> +	USER(\label, ldrb  \ptr, [\regB], \val)
> +	.endm
> +
> +	.macro strb1 label, ptr, regB, val
> +	strb \ptr, [\regB], \val
> +	.endm
> +
> +	.macro ldrh1 label, ptr, regB, val
> +	USER(\label, ldrh  \ptr, [\regB], \val)
> +	.endm
> +
> +	.macro strh1 label, ptr, regB, val
> +	strh \ptr, [\regB], \val
> +	.endm
> +
> +	.macro ldr1 label, ptr, regB, val
> +	USER(\label, ldr \ptr, [\regB], \val)
> +	.endm
> +
> +	.macro str1 label, ptr, regB, val
> +	str \ptr, [\regB], \val
> +	.endm
> +
> +	.macro ldp1 label, ptr, regB, regC, val
> +	USER(\label, ldp \ptr, \regB, [\regC], \val)
> +	.endm
> +
> +	.macro stp1 label, ptr, regB, regC, val
> +	stp \ptr, \regB, [\regC], \val
> +	.endm

Since it's only the user access functions caring about the abort label
and this label is always the same (11f as I can see), we can ignore it
completely in copy_template.S. Just use a large label above, something
like:

	.macro ldp1 ptr, regB, regC, val
	USER(9998f, ldp \ptr, \regB, [\regC], \val)
	.endm

	.macro stp1 ptr, regB, regC, val
	stp \ptr, \regB, [\regC], \val
	.endm

>  ENTRY(__copy_from_user)
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> -	add	x5, x1, x2			// upper user buffer boundary
> -	subs	x2, x2, #16
> -	b.mi	1f
> -0:
> -USER(9f, ldp	x3, x4, [x1], #16)
> -	subs	x2, x2, #16
> -	stp	x3, x4, [x0], #16
> -	b.pl	0b
> -1:	adds	x2, x2, #8
> -	b.mi	2f
> -USER(9f, ldr	x3, [x1], #8	)
> -	sub	x2, x2, #8
> -	str	x3, [x0], #8
> -2:	adds	x2, x2, #4
> -	b.mi	3f
> -USER(9f, ldr	w3, [x1], #4	)
> -	sub	x2, x2, #4
> -	str	w3, [x0], #4
> -3:	adds	x2, x2, #2
> -	b.mi	4f
> -USER(9f, ldrh	w3, [x1], #2	)
> -	sub	x2, x2, #2
> -	strh	w3, [x0], #2
> -4:	adds	x2, x2, #1
> -	b.mi	5f
> -USER(9f, ldrb	w3, [x1]	)
> -	strb	w3, [x0]
> -5:	mov	x0, #0
> +#include "copy_template.S"
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> +	mov	x0, #0				// Nothing to copy
>  	ret
>  ENDPROC(__copy_from_user)
>  
>  	.section .fixup,"ax"
>  	.align	2
> -9:	sub	x2, x5, x1
> -	mov	x3, x2
> -10:	strb	wzr, [x0], #1			// zero remaining buffer space
> -	subs	x3, x3, #1
> -	b.ne	10b
> -	mov	x0, x2				// bytes not copied
> +11:
> +	sub	x4, tmp3, dst
> +	mov	x0, x4
> +	sub	dst, tmp3, x4

Here you would have the 9998: label

> +
> +20:	strb	wzr, [dst], #1			// zero remaining buffer space
> +	subs	x4, x4, #1
> +	b.ne	20b

and 9999 here.

BTW, you should use tmp1 instead of x4 to avoid clashes in case we
rename the register aliases. And you can probably write this with some
fewer instructions:

9998:
	sub	x0, tmp3, dst
9999:
	strb	wzr, [dst], #1			// zero remaining buffer space
	cmp	dst, tmp3
	b.lo	9999b

>  ENTRY(__copy_in_user)
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> -	add	x5, x0, x2			// upper user buffer boundary
> -	subs	x2, x2, #16
> -	b.mi	1f
> -0:
> -USER(9f, ldp	x3, x4, [x1], #16)
> -	subs	x2, x2, #16
> -USER(9f, stp	x3, x4, [x0], #16)
> -	b.pl	0b
> -1:	adds	x2, x2, #8
> -	b.mi	2f
> -USER(9f, ldr	x3, [x1], #8	)
> -	sub	x2, x2, #8
> -USER(9f, str	x3, [x0], #8	)
> -2:	adds	x2, x2, #4
> -	b.mi	3f
> -USER(9f, ldr	w3, [x1], #4	)
> -	sub	x2, x2, #4
> -USER(9f, str	w3, [x0], #4	)
> -3:	adds	x2, x2, #2
> -	b.mi	4f
> -USER(9f, ldrh	w3, [x1], #2	)
> -	sub	x2, x2, #2
> -USER(9f, strh	w3, [x0], #2	)
> -4:	adds	x2, x2, #1
> -	b.mi	5f
> -USER(9f, ldrb	w3, [x1]	)
> -USER(9f, strb	w3, [x0]	)
> -5:	mov	x0, #0
> +#include "copy_template.S"
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> +	mov	x0, #0
>  	ret
>  ENDPROC(__copy_in_user)
>  
>  	.section .fixup,"ax"
>  	.align	2
> -9:	sub	x0, x5, x0			// bytes not copied
> +11:	sub	tmp3, tmp3, dst			// bytes not copied
> +	mov	x0, tmp3

Why not "sub x0, tmp3, dst" directly?

> diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
> new file mode 100644
> index 0000000..c9ece2f
> --- /dev/null
> +++ b/arch/arm64/lib/copy_template.S
> @@ -0,0 +1,196 @@
[...]
> +/*
> + * Copy a buffer from src to dest (alignment handled by the hardware)
> + *
> + * Parameters:
> + *	x0 - dest
> + *	x1 - src
> + *	x2 - n
> + * Returns:
> + *	x0 - dest
> + */
> +dstin	.req	x0
> +src	.req	x1
> +count	.req	x2
> +tmp1	.req	x3
> +tmp1w	.req	w3
> +tmp2	.req	x4
> +tmp2w	.req	w4
> +tmp3	.req	x5
> +tmp3w	.req	w5
> +dst	.req	x6
> +
> +A_l	.req	x7
> +A_h	.req	x8
> +B_l	.req	x9
> +B_h	.req	x10
> +C_l	.req	x11
> +C_h	.req	x12
> +D_l	.req	x13
> +D_h	.req	x14
> +
> +	mov	dst, dstin
> +	add	tmp3, dst, count

You could keep this in in the copy_from_user.S etc. files to avoid
another addition for memcpy where it's not needed. And you could keep
the .req in there as well (together with the "end" alias):

end	.req	x5	// same as tmp3

ENTRY(__copy_from_user)
	...
	add	end, x0, x2
#include "copy_template.S"
	...

>  ENTRY(__copy_to_user)
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> -	add	x5, x0, x2			// upper user buffer boundary
> -	subs	x2, x2, #16
> -	b.mi	1f
> -0:
> -	ldp	x3, x4, [x1], #16
> -	subs	x2, x2, #16
> -USER(9f, stp	x3, x4, [x0], #16)
> -	b.pl	0b
> -1:	adds	x2, x2, #8
> -	b.mi	2f
> -	ldr	x3, [x1], #8
> -	sub	x2, x2, #8
> -USER(9f, str	x3, [x0], #8	)
> -2:	adds	x2, x2, #4
> -	b.mi	3f
> -	ldr	w3, [x1], #4
> -	sub	x2, x2, #4
> -USER(9f, str	w3, [x0], #4	)
> -3:	adds	x2, x2, #2
> -	b.mi	4f
> -	ldrh	w3, [x1], #2
> -	sub	x2, x2, #2
> -USER(9f, strh	w3, [x0], #2	)
> -4:	adds	x2, x2, #1
> -	b.mi	5f
> -	ldrb	w3, [x1]
> -USER(9f, strb	w3, [x0]	)
> -5:	mov	x0, #0
> +#include "copy_template.S"
>  ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
>  	    CONFIG_ARM64_PAN)
> +	mov	x0, #0
>  	ret
>  ENDPROC(__copy_to_user)
>  
>  	.section .fixup,"ax"
>  	.align	2
> -9:	sub	x0, x5, x0			// bytes not copied
> +11:	sub	tmp3, tmp3, dst			// bytes not copied
> +	mov	x0, tmp3

Same here, "sub x0, end, dst" directly.

-- 
Catalin
