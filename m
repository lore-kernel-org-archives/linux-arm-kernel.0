From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Apr 2014 10:27:57 +0200
Subject: [PATCH] ARM: fix v7-M signal return
In-Reply-To: <1398103664-23078-1-git-send-email-rabin@rab.in>
References: <1398103664-23078-1-git-send-email-rabin@rab.in>
Message-ID: <20140428082757.GD28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 08:07:44PM +0200, Rabin Vincent wrote:
> According to the ARM ARM, the behaviour is UNDPREDICTABLE if the PC read
> from the exception return stack is not half word aligned.  See the
> pseudo code for ExceptionReturn() and PopStack().
> 
> The signal handler's address has the bit 0 set, and setup_return()
> directly writes this to regs->ARM_pc.  Mask out bit 0 before the
> exception return to get predictable behaviour.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/entry-header.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index 1420725..ef72f4b 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -133,6 +133,7 @@
>  	biceq	r5, V7M_xPSR_FRAMEPTRALIGN
>  
>  	@ write basic exception frame
> +	bic	r4, r4, #1
>  	stmdb	r2!, {r1, r3-r5}
>  	ldmia	sp, {r1, r3-r5}
>  	.if	\ret_r0
This is a valid fix, but it seems on my efm32 the unpredictable
behaviour is to just discard the LSB. How did you find that? Is it an
issue on your machine? Which cpu are you using?

I'd like to have the instruction clearing the thumb bit above the
comment about the basic exception frame and please add a comment for
your instruction, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
