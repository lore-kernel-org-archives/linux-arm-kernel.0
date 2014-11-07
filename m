From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Nov 2014 14:44:28 +0000
Subject: [PATCH 2/2] arm64: kvm: eliminate literal pool entries
In-Reply-To: <1415369554-7444-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1415369554-7444-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415369554-7444-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <545CDACC.5070406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/14 14:12, Ard Biesheuvel wrote:
> Replace two instances of 'ldr xN, =(constant)' in the world switch
> hot path with 'mov' instructions.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kvm/hyp.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index b72aa9f9215c..fbe909fb0a1a 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -761,10 +761,10 @@
>  .macro activate_traps
>  	ldr     x2, [x0, #VCPU_HCR_EL2]
>  	msr     hcr_el2, x2
> -	ldr	x2, =(CPTR_EL2_TTA)
> +	mov	x2, #CPTR_EL2_TTA
>  	msr	cptr_el2, x2
>  
> -	ldr	x2, =(1 << 15)	// Trap CP15 Cr=15
> +	mov	x2, #(1 << 15)	// Trap CP15 Cr=15
>  	msr	hstr_el2, x2
>  
>  	mrs	x2, mdcr_el2
> 

Looks good to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
