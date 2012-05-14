From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 14 May 2012 18:50:44 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <20120514173757.GJ11088@mudshark.cambridge.arm.com>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
 <1337006035.16954.21.camel@linaro1.home>
 <20120514145931.GF11088@mudshark.cambridge.arm.com>
 <1337011379.16954.40.camel@linaro1.home>
 <20120514173757.GJ11088@mudshark.cambridge.arm.com>
Message-ID: <1337017844.16954.49.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-05-14 at 18:37 +0100, Will Deacon wrote:
> You're right, in the lazy case (i.e. SMP) we update the hwstate on
> context-switch rather than on the fault. Your quick fix looks good to me
> (that is, unconditionally flushing the state after handling a signal). I was
> initially worried that the added flushing would cause a performance hit on
> the usual path, where VFP is not used in the handler, however since we flush
> before the signal handler, it really won't make a lot of difference.
> 
> I took the liberty of writing a commit message, so can I add your S-o-B to
> this please (I wasn't sure which email address to use)?

Thanks, it's the day job, so...

Signed-off-by: Jon Medhurst <tixy@linaro.org>

> Thanks,
> 
> Will
> 
> Subject: [PATCH] ARM: vfp: fix VFP flushing regression on sigreturn path
> 
> Commit ff9a184c ("ARM: 7400/1: vfp: clear fpscr length and stride bits
> on entry to sig handler") flushes the VFP state prior to entering a
> signal handler so that a VFP operation inside the handler will trap and
> force a restore of ABI-compliant registers. Restoring the registers on
> the sigreturn path is predicated on the saved thread state indicating
> that VFP was used by the handler -- however for SMP platforms this is
> only set on context-switch, making the check unreliable and causing VFP
> register corruption in userspace.
> 
> This patch unconditionally flushes the VFP state after a signal handler.
> Since we already perform the flush before the handler and the flushing
> itself happens lazily, the effect on performance is negligible.
> 
> Reported-by: Jon Medhurst <tixy@yxit.co.uk>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/vfp/vfpmodule.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index c5767b5..b0197b2 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -577,12 +577,6 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
>  	 * entry.
>  	 */
>  	hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
> -
> -	/*
> -	 * Disable VFP in the hwstate so that we can detect if it gets
> -	 * used.
> -	 */
> -	hwstate->fpexc &= ~FPEXC_EN;
>  	return 0;
>  }
>  
> @@ -595,12 +589,8 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
>  	unsigned long fpexc;
>  	int err = 0;
>  
> -	/*
> -	 * If VFP has been used, then disable it to avoid corrupting
> -	 * the new thread state.
> -	 */
> -	if (hwstate->fpexc & FPEXC_EN)
> -		vfp_flush_hwstate(thread);
> +	/* Disable VFP to avoid corrupting the new thread state. */
> +	vfp_flush_hwstate(thread);
>  
>  	/*
>  	 * Copy the floating point registers. There can be unused
