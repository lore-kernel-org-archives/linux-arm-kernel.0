From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Jun 2013 17:27:36 -0700
Subject: [PATCH 4/5] ARM: KVM: clear exclusive monitor on all exception
 returns
In-Reply-To: <1371648006-8036-5-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <1371648006-8036-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130620002736.GK7870@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 02:20:05PM +0100, Marc Zyngier wrote:
> Make sure we clear the exclusive movitor on all exception returns,
> which otherwise could lead to lock corruptions.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/interrupts.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 3124e0f..750f051 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -301,6 +301,7 @@ THUMB(	orr	r2, r2, #PSR_T_BIT	)
>  	ldr	r2, =BSYM(panic)
>  	msr	ELR_hyp, r2
>  	ldr	r0, =\panic_str
> +	clrex				@ Clear exclusive monitor

on a panic? sure, why not ;)

>  	eret
>  .endm
>  
> @@ -450,6 +451,7 @@ guest_trap:
>  
>  4:	pop	{r0, r1}		@ Failed translation, return to guest
>  	mcrr	p15, 0, r0, r1, c7	@ PAR
> +	clrex

I gather this is because any store can potentially leave the system with
an exclusive monitor taken?

patch looks fine.

>  	pop	{r0, r1, r2}
>  	eret
>  
> @@ -476,6 +478,7 @@ switch_to_guest_vfp:
>  
>  	pop	{r3-r7}
>  	pop	{r0-r2}
> +	clrex
>  	eret
>  #endif
>  
> -- 
> 1.8.2.3
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
