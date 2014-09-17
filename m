From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Sep 2014 09:47:19 +0100
Subject: Cortex-M and zImage
In-Reply-To: <20140917061110.GM3755@pengutronix.de>
References: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
 <20140917061110.GM3755@pengutronix.de>
Message-ID: <20140917084719.GP12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 08:11:10AM +0200, Uwe Kleine-K?nig wrote:
> I was able to compile a zImage with the patch below. For the
> "Conflicting architecture profiles" error the most relevant hunk is the
> first. And of course this needs some #ifdefs.

However, when I see crap like this, I really have to say something.

> @@ -145,7 +145,7 @@ start:
>  		 * FIQs/IRQs (numeric definitions from angel arm.h source).
>  		 * We only do this if we were in user mode on entry.
>  		 */
> -		mrs	r2, cpsr		@ get current mode
> +		@mrs	r2, cpsr		@ get current mode
>  		tst	r2, #3			@ not user?
>  		bne	not_angel

This *reads* into r2, which is then tested, and the path through the code
changes according to the value read.  You've commented out the read, so
now r2 is effective uninitialised.  How do you know which path will be
used?

>  		mov	r0, #0x17		@ angel_SWIreason_EnterSVC
> @@ -153,7 +153,7 @@ start:
>   THUMB(		svc	0xab		)	@ angel_SWI_THUMB
>  not_angel:
>  		safe_svcmode_maskall r0
> -		msr	spsr_cxsf, r9		@ Save the CPU boot mode in
> +		@msr	spsr_cxsf, r9		@ Save the CPU boot mode in
>  						@ SPSR
>  		/*
>  		 * Note that some cache flushing and other stuff may
> @@ -366,7 +366,7 @@ dtb_check_done:
>  
>  /* Relocate the hyp vector base if necessary */
>  #ifdef CONFIG_ARM_VIRT_EXT
> -		mrs	r0, spsr
> +		@mrs	r0, spsr
>  		and	r0, r0, #MODE_MASK
>  		cmp	r0, #HYP_MODE
>  		bne	1f

Same here.

> @@ -500,7 +500,7 @@ not_relocated:	mov	r0, #0
>  		mov	r2, r8			@ restore atags pointer
>  
>  #ifdef CONFIG_ARM_VIRT_EXT
> -		mrs	r0, spsr		@ Get saved CPU boot mode
> +		@mrs	r0, spsr		@ Get saved CPU boot mode
>  		and	r0, r0, #MODE_MASK
>  		cmp	r0, #HYP_MODE		@ if not booted in HYP mode...
>  		bne	__enter_kernel		@ boot kernel directly

And here.

> @@ -791,7 +791,7 @@ call_cache_fn:	adr	r12, proc_types
>  #ifdef CONFIG_CPU_CP15
>  		mrc	p15, 0, r9, c0, c0	@ get processor ID
>  #else
> -		ldr	r9, =CONFIG_PROCESSOR_ID
> +		@ldr	r9, =CONFIG_PROCESSOR_ID

And here.

Please, don't post such utter trash, and don't post such utter trash for
others to possibly use either.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
