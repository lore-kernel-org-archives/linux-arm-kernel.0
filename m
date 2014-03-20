From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:41:49 -0700
Subject: [PATCH 3/5] ARM64: KVM: store kvm_vcpu_fault_info est_el2 as word
In-Reply-To: <1392184643-6108-4-git-send-email-victor.kamensky@linaro.org>
References: <1392184643-6108-1-git-send-email-victor.kamensky@linaro.org>
 <1392184643-6108-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320034149.GS1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:57:21PM -0800, Victor Kamensky wrote:
> esr_el2 field of struct kvm_vcpu_fault_info has u32 type.
> It should be stored as word. Current code works in LE case
> because existing puts least significant word of x1 into
> esr_el2, and it puts most significant work of x1 into next
> field, which accidentally is OK because it is updated again
> by next instruction. But existing code breaks in BE case.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm64/kvm/hyp.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 3b47c36..104216c 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -801,7 +801,7 @@ el1_trap:
>  	mrs	x2, far_el2
>  
>  2:	mrs	x0, tpidr_el2
> -	str	x1, [x0, #VCPU_ESR_EL2]
> +	str	w1, [x0, #VCPU_ESR_EL2]
>  	str	x2, [x0, #VCPU_FAR_EL2]
>  	str	x3, [x0, #VCPU_HPFAR_EL2]
>  
> -- 
> 1.8.1.4
> 

Ouch,

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
