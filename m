From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 22 May 2014 16:23:53 -0400
Subject: [PATCH v4 1/2] arm64: adjust el0_sync so that a function can
 be called
In-Reply-To: <1400786855-32656-2-git-send-email-larry.bassel@linaro.org>
References: <1400786855-32656-1-git-send-email-larry.bassel@linaro.org>
 <1400786855-32656-2-git-send-email-larry.bassel@linaro.org>
Message-ID: <537E5CD9.80501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Larry,

On 05/22/2014 03:27 PM, Larry Bassel wrote:
> To implement the context tracker properly on arm64,
> a function call needs to be made after debugging and
> interrupts are turned on, but before the lr is changed
> to point to ret_to_user(). If the function call
> is made after the lr is changed the function will not
> return to the correct place.
> 
> For similar reasons, defer the setting of x0 so that
> it doesn't need to be saved around the function call
> (save far_el1 in x26 temporarily instead).
> 
> Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
> ---
>  arch/arm64/kernel/entry.S | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e8b23a3..20b336e 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -354,7 +354,6 @@ el0_sync:
>  	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
>  	cmp	x24, #ESR_EL1_EC_SVC64		// SVC in 64-bit state
>  	b.eq	el0_svc
> -	adr	lr, ret_to_user
>  	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
>  	b.eq	el0_da
>  	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
> @@ -383,7 +382,6 @@ el0_sync_compat:
>  	lsr	x24, x25, #ESR_EL1_EC_SHIFT	// exception class
>  	cmp	x24, #ESR_EL1_EC_SVC32		// SVC in 32-bit state
>  	b.eq	el0_svc_compat
> -	adr	lr, ret_to_user
>  	cmp	x24, #ESR_EL1_EC_DABT_EL0	// data abort in EL0
>  	b.eq	el0_da
>  	cmp	x24, #ESR_EL1_EC_IABT_EL0	// instruction abort in EL0
> @@ -426,22 +424,26 @@ el0_da:
>  	/*
>  	 * Data abort handling
>  	 */
> -	mrs	x0, far_el1
> -	bic	x0, x0, #(0xff << 56)
> +	mrs	x26, far_el1
>  	// enable interrupts before calling the main handler
>  	enable_dbg_and_irq
> +	mov	x0, x26
> +	bic	x0, x0, #(0xff << 56)

Nit: I believe you can bit clear with x26 as the source register and omit the
move instruction.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
