From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Jun 2015 16:44:47 +0100
Subject: [RESEND PATCH v2 2/2] arm: KVM: keep arm vfp/simd exit handling
 consistent with arm64
In-Reply-To: <1434739306-23417-1-git-send-email-m.smarduch@samsung.com>
References: <1434739306-23417-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <558AD06F.6090103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mario,

On 19/06/15 19:41, Mario Smarduch wrote:
> After enhancing arm64 FP/SIMD exit handling, 32-bit VFP exit branch is moved
> to guest trap handling, keeping exit handling flow for both architectures 
> consistent.
> 
> Also replaced an unused label with a comment.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/kvm/interrupts.S |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 79caf79..16f00f1 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -363,10 +363,6 @@ hyp_hvc:
>  	@ Check syndrome register
>  	mrc	p15, 4, r1, c5, c2, 0	@ HSR
>  	lsr	r0, r1, #HSR_EC_SHIFT
> -#ifdef CONFIG_VFPv3
> -	cmp	r0, #HSR_EC_CP_0_13
> -	beq	switch_to_guest_vfp
> -#endif
>  	cmp	r0, #HSR_EC_HVC
>  	bne	guest_trap		@ Not HVC instr.
>  
> @@ -380,7 +376,7 @@ hyp_hvc:
>  	cmp     r2, #0
>  	bne	guest_trap		@ Guest called HVC
>  
> -host_switch_to_hyp:
> +	/* Guest is calling a hyp function, save minimum context branch to it */
>  	pop	{r0, r1, r2}
>  
>  	/* Check for __hyp_get_vectors */
> @@ -411,6 +407,10 @@ guest_trap:
>  
>  	@ Check if we need the fault information
>  	lsr	r1, r1, #HSR_EC_SHIFT
> +#ifdef CONFIG_VFPv3
> +	cmp	r1, #HSR_EC_CP_0_13
> +	beq	switch_to_guest_vfp
> +#endif
>  	cmp	r1, #HSR_EC_IABT
>  	mrceq	p15, 4, r2, c6, c0, 2	@ HIFAR
>  	beq	2f
> 

Two things: I think you can now drop the load_vcpu that is in
switch_to_guest_vfp (you just executed it in guest_trap). You also have
an extra store to VCPU_HSR, but I don't think that's a big deal.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
