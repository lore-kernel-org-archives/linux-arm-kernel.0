From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 1 Feb 2012 09:58:40 +0000
Subject: [PATCH] ARM: head-nommu.S: use long distance encoding for branch
 instruction
In-Reply-To: <1328086496-31184-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1328086496-31184-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120201095840.GA2811@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 09:54:56AM +0100, Uwe Kleine-K??nig wrote:
> This fixes a linker error when the kernel image gets bigger than approx.
> 1 MiB.
> 
> This is done analogous to the change to head.S in commit
> 
> 	a75e524 (ARM: 6504/1: Thumb-2: Fix long-distance conditional branches in head.S for Thumb-2.)
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> compared to a75e524 I didn't put the it instruction into THUMB(). I
> think this is OK? If so I can follow up with a patch that removes these
> THUMB()s from head.S, too.

I believe it can be outside THUMB()... there are macros in <asm/unified.h>
which expand to nothing if necessary.

However, after the original patch, I think that it may be better to code
it like this:

	ldreq	pc, =___error_p

This may end up being slightly less efficient, but on an error path that
doesn't really matter.  The good part is that we don't need any ARM or
Thumb special-case code.  Because the target address is loaded from the
literal pool, it can be relocated to absolutely any address without
difficulty.  From my point of view, this also cleaner and more
manitainable in the source code, since it uses a traditional, well-
understood method of achieving the long branch.

If you want to keep to your existing suggestion for consistency, I'd be
happy with that too, though.

> 
> And I wonder if it's correct that head-nommu.S doesn't check the machine
> type.

I don't know the answer to that -- it does sound a bit strange though.
Maybe that check happens somewhere else in the nommu case?  (Or maybe
people just never got around to adding the check, since the kernel build
and hardware tend to be very tightly coupled for nommu.)

> 
> I don't see a need to get this in before the next merge window.
> 
> Best regards
> Uwe
> 
> 
>  arch/arm/kernel/head-nommu.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index d46f259..1aca35d 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -51,6 +51,7 @@ ENTRY(stext)
>  #endif
>  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
>  	movs	r10, r5				@ invalid processor (r5=0)?
> +	it	eq
>  	beq	__error_p				@ yes, error 'p'
>  
>  	adr	lr, BSYM(__after_proc_init)	@ return (PIC) address
> -- 
> 1.7.8.3
> 
