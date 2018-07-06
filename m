From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 17:38:45 +0100
Subject: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180702110415.10465-12-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
Message-ID: <20180706163844.GB27483@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 12:04:07PM +0100, Mark Rutland wrote:
> Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> can safely corrupt x0-x3 in the entry paths, and we no longer need to
> restore them. So let's remove the logic doing so.
> 
> With that logic gone, we can fold the branch target into the macro, so
> that callers need not deal with this. GAS provides \@, which provides a
> unique value per macro invocation, which we can use to create a unique
> label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index c41b84d06644..728bc7cc5bbb 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -130,20 +130,21 @@ alternative_else_nop_endif
>  
>  	// This macro corrupts x0-x3. It is the caller's duty
>  	// to save/restore them if required.
> -	.macro	apply_ssbd, state, targ, tmp1, tmp2
> +	.macro	apply_ssbd, state, tmp1, tmp2
>  #ifdef CONFIG_ARM64_SSBD
>  alternative_cb	arm64_enable_wa2_handling
> -	b	\targ
> +	b	skip_apply_ssbd\@
>  alternative_cb_end
>  	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
> -	cbz	\tmp2, \targ
> +	cbz	\tmp2, skip_apply_ssbd\@
>  	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
> -	tbnz	\tmp2, #TIF_SSBD, \targ
> +	tbnz	\tmp2, #TIF_SSBD, skip_apply_ssbd\@

Talking to Dave, he makes a good point that this is pretty fragile if a
macro expansion within the macro itself uses \@, since this would result
in an unexpected label update and everything would go wrong.

Can you default initialise an extra label argument to \@, or does that not
work?

Will
