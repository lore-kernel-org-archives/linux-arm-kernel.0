From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 27 Oct 2015 21:21:24 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151026012710.GA17365@laptop>
References: <20151026012710.GA17365@laptop>
Message-ID: <20151027202124.GK4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ezequiel,

On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
> I've been trying to make my ARM v7-M LPC43xx board
> boot a XIP kernel from flash. Currently, this seems
> to be broken in mainline due to this:
> 
> arch/arm/mm/proc-v7m.S
> [..]
>         @ SVC to run the kernel in this mode
>         badr    r1, 1f
>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
>         mov     r6, lr                  @ save LR
>         mov     r7, sp                  @ save SP
> 	ldr     sp, =__v7m_setup_stack_top @ <<< Breaks XIP!

How does this fail for you?

>         cpsie   i
>         svc     #0
> 1:      cpsid   i
>         str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
>         mov     lr, r6                  @ restore LR
>         mov     sp, r7                  @ restore SP
> 
> Here, a temporary stack is prepared before making a
> supervisor call (SVC) to switch to handler mode.

OK, the effect of svc is that something is written to where sp points
to. On my efm32 nothing obvious happens when something random is written
there. I guess if that results in some CFI commands I have a problem
though. What about your machine?

> The temporary stack is allocated in the .text.init section
> and so this doesn't work when the kernel is executing from ROM.
> 
> A similar problem has been reported for v7:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357106.html
> 
> While trying to come up with a proper fix, I've noticed how
> the stack doesn't seem to be used.
> 
> So, I've been trying to understand why the need for the temporary
> stack at all, but I still can't get it. 
> 
> The below patch seems to work just fine, and allows to boot a
> LPC43xx kernel either as XIP from ROM or non-XIP from RAM.
> 
> However, I'm still wondering if the stack is really unused or not,
> so any lights that can be shed here will be appreciated.
> 
> Thanks!
> 
> From a7c880c73b8ad2e4c4b07f4d11809ea541a65e1d Mon Sep 17 00:00:00 2001
> From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Date: Sat, 24 Oct 2015 13:27:27 -0300
> Subject: [PATCH] ARM: Don't prepare any temporary stack in __v7m_setup
> 
> Since __v7m_setup() is implemented as the PROCINFO_INITFUNC
> called in head-nommu.S it's called at the very beggining to
> do some very basic setup.
> 
> The function prepares a temporary stack in the .text.init
> section before calling SVC. However, this stack seems to
> be completely unused and hence is not needed.
> 
> Moreover, this breaks on XIP kernels, when the text is in ROM.
> Hence, this commit simply removes the temporary stack setup.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  arch/arm/mm/proc-v7m.S | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 67d9209077c6..6a383e619a0c 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -103,7 +103,6 @@ __v7m_setup:
>  	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
>  	mov	r6, lr			@ save LR
>  	mov	r7, sp			@ save SP
> -	ldr	sp, =__v7m_setup_stack_top
>  	cpsie	i
>  	svc	#0
>  1:	cpsid	i
> @@ -123,11 +122,6 @@ __v7m_setup:
>  	ret	lr
>  ENDPROC(__v7m_setup)
>  
> -	.align 2
> -__v7m_setup_stack:
> -	.space	4 * 8				@ 8 registers
> -__v7m_setup_stack_top:
> -

The effect of your patch is that the value of sp as it is when
__v7m_setup is entered is used. I didn't check, but I wouldn't be
surprised if that's the value of sp when the boot loader gave control to
Linux. This might or might not work. Something more robust would be
better of course.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
