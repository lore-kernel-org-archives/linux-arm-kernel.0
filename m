From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Oct 2014 10:27:24 +0000
Subject: [PATCHv4 2/7] arm64: Switch to ldr for loading the stub vectors
In-Reply-To: <1414440752-9411-3-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141028102724.GB9796@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 08:12:27PM +0000, Laura Abbott wrote:
> The hyp stub vectors are currently loaded using adr. This
> instruction has a +/- 1MB range for the loading address. If
> the alignment for sections is changed the address may be more
> than 1MB away, resulting in reclocation errors. Switch to using
> adrp for getting the address to ensure we aren't affected by the
> location of the __hyp_stub_vectors.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

I've just given this a spin and nothing has blown up on my Juno, so:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v4: Commit text tweaks
> ---
>  arch/arm64/kernel/head.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0a6e4f9..10f5cc0 100644
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
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> 
