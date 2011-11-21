From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 21 Nov 2011 14:21:50 +0000
Subject: [PATCH v2] ARM: unwind: add unwind directives to bitops assembly
 macros
In-Reply-To: <1321870994-2914-1-git-send-email-will.deacon@arm.com>
References: <1321870994-2914-1-git-send-email-will.deacon@arm.com>
Message-ID: <20111121142150.GC14679@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 10:23:14AM +0000, Will Deacon wrote:
> The bitops functions (e.g. _test_and_set_bit) on ARM do not have unwind
> annotations and therefore the kernel cannot backtrace out of them on a
> fatal error (for example, NULL pointer dereference).
> 
> This patch annotates the bitops assembly macros with UNWIND annotations
> so that we can produce a meaningful backtrace on error. Callers of the
> macros are modified to pass their function name as a macro parameter,
> enforcing that the macros are used as standalone function implementations.
> 
> Cc: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Dave Martin <dave.martin@linaro.org>

It turns out that readelf -u prints out garbage for the unwind tables if
you try to use it the resulting .o files...  but that seems to be a bug
in binutils, where some invalid assumptions are made about how to relocate
the unwind information.

readelf -u vmlinux looks sensible though.

Cheers
---Dave


> ---
> 
> v2: Added function name argument to bitops macros, as suggested by Dave.
> 
>  arch/arm/lib/bitops.h        |   26 ++++++++++++++++++++++----
>  arch/arm/lib/changebit.S     |    4 +---
>  arch/arm/lib/clearbit.S      |    4 +---
>  arch/arm/lib/setbit.S        |    4 +---
>  arch/arm/lib/testchangebit.S |    4 +---
>  arch/arm/lib/testclearbit.S  |    4 +---
>  arch/arm/lib/testsetbit.S    |    4 +---
>  7 files changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
> index 10d868a..d6408d1 100644
> --- a/arch/arm/lib/bitops.h
> +++ b/arch/arm/lib/bitops.h
> @@ -1,5 +1,9 @@
> +#include <asm/unwind.h>
> +
>  #if __LINUX_ARM_ARCH__ >= 6
> -	.macro	bitop, instr
> +	.macro	bitop, name, instr
> +ENTRY(	\name		)
> +UNWIND(	.fnstart	)
>  	ands	ip, r1, #3
>  	strneb	r1, [ip]		@ assert word-aligned
>  	mov	r2, #1
> @@ -13,9 +17,13 @@
>  	cmp	r0, #0
>  	bne	1b
>  	bx	lr
> +UNWIND(	.fnend		)
> +ENDPROC(\name		)
>  	.endm
>  
> -	.macro	testop, instr, store
> +	.macro	testop, name, instr, store
> +ENTRY(	\name		)
> +UNWIND(	.fnstart	)
>  	ands	ip, r1, #3
>  	strneb	r1, [ip]		@ assert word-aligned
>  	mov	r2, #1
> @@ -34,9 +42,13 @@
>  	cmp	r0, #0
>  	movne	r0, #1
>  2:	bx	lr
> +UNWIND(	.fnend		)
> +ENDPROC(\name		)
>  	.endm
>  #else
> -	.macro	bitop, instr
> +	.macro	bitop, name, instr
> +ENTRY(	\name		)
> +UNWIND(	.fnstart	)
>  	ands	ip, r1, #3
>  	strneb	r1, [ip]		@ assert word-aligned
>  	and	r2, r0, #31
> @@ -49,6 +61,8 @@
>  	str	r2, [r1, r0, lsl #2]
>  	restore_irqs ip
>  	mov	pc, lr
> +UNWIND(	.fnend		)
> +ENDPROC(\name		)
>  	.endm
>  
>  /**
> @@ -59,7 +73,9 @@
>   * Note: we can trivially conditionalise the store instruction
>   * to avoid dirtying the data cache.
>   */
> -	.macro	testop, instr, store
> +	.macro	testop, name, instr, store
> +ENTRY(	\name		)
> +UNWIND(	.fnstart	)
>  	ands	ip, r1, #3
>  	strneb	r1, [ip]		@ assert word-aligned
>  	and	r3, r0, #31
> @@ -73,5 +89,7 @@
>  	moveq	r0, #0
>  	restore_irqs ip
>  	mov	pc, lr
> +UNWIND(	.fnend		)
> +ENDPROC(\name		)
>  	.endm
>  #endif
> diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
> index 68ed5b6..f402786 100644
> --- a/arch/arm/lib/changebit.S
> +++ b/arch/arm/lib/changebit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>                  .text
>  
> -ENTRY(_change_bit)
> -	bitop	eor
> -ENDPROC(_change_bit)
> +bitop	_change_bit, eor
> diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
> index 4c04c3b..f6b75fb 100644
> --- a/arch/arm/lib/clearbit.S
> +++ b/arch/arm/lib/clearbit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>                  .text
>  
> -ENTRY(_clear_bit)
> -	bitop	bic
> -ENDPROC(_clear_bit)
> +bitop	_clear_bit, bic
> diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
> index bbee5c6..618feda 100644
> --- a/arch/arm/lib/setbit.S
> +++ b/arch/arm/lib/setbit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>  		.text
>  
> -ENTRY(_set_bit)
> -	bitop	orr
> -ENDPROC(_set_bit)
> +bitop	_set_bit, orr
> diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
> index 15a4d43..4becdc3 100644
> --- a/arch/arm/lib/testchangebit.S
> +++ b/arch/arm/lib/testchangebit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>                  .text
>  
> -ENTRY(_test_and_change_bit)
> -	testop	eor, str
> -ENDPROC(_test_and_change_bit)
> +testop	_test_and_change_bit, eor, str
> diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
> index 521b66b..918841d 100644
> --- a/arch/arm/lib/testclearbit.S
> +++ b/arch/arm/lib/testclearbit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>                  .text
>  
> -ENTRY(_test_and_clear_bit)
> -	testop	bicne, strne
> -ENDPROC(_test_and_clear_bit)
> +testop	_test_and_clear_bit, bicne, strne
> diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
> index 1c98cc2..8d1b2fe 100644
> --- a/arch/arm/lib/testsetbit.S
> +++ b/arch/arm/lib/testsetbit.S
> @@ -12,6 +12,4 @@
>  #include "bitops.h"
>                  .text
>  
> -ENTRY(_test_and_set_bit)
> -	testop	orreq, streq
> -ENDPROC(_test_and_set_bit)
> +testop	_test_and_set_bit, orreq, streq
> -- 
> 1.7.4.1
> 
