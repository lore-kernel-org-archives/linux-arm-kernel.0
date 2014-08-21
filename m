From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Aug 2014 10:30:54 +0100
Subject: [PATCHv3 2/7] arm64: Switch to ldr for loading the stub vectors
In-Reply-To: <1408584039-12735-3-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140821093054.GI21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Thu, Aug 21, 2014 at 02:20:34AM +0100, Laura Abbott wrote:
> The hyp stub vectors are currently loaded using adr. This
> instruction has a +/- 1MB range for the loading address. If
> the alignment for sections is changed. the address may be more

Nit: that '.' looks out of place.

> than 1MB away, resulting in reclocation errors. Switch to using
> ldr for getting the address to ensure we aren't affected by the
> location of the __hyp_stub_vectors.

The subject and commit message don't seem to have been updated to
reflect that the patch uses adrp + add (with a range of ~4GB) rather
than ldr.

Otherwise, the patch itself seems fine to me.

Mark.

> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/kernel/head.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 144f105..61bc210 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -331,7 +331,8 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
>  	msr	vttbr_el2, xzr
>  
>  	/* Hypervisor stub */
> -	adr	x0, __hyp_stub_vectors
> +	adrp	x0, __hyp_stub_vectors
> +	add	x0, x0, #:lo12:__hyp_stub_vectors
>  	msr	vbar_el2, x0
>  
>  	/* spsr */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
