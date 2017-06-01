From: bsd@redhat.com (Bandan Das)
Date: Thu, 01 Jun 2017 16:22:17 -0400
Subject: [RFC 08/55] KVM: arm64: Set virtual EL2 context depending on the
 guest exception level
In-Reply-To: <1483943091-1364-9-git-send-email-jintack@cs.columbia.edu>
 (Jintack Lim's message of "Mon, 9 Jan 2017 01:24:04 -0500")
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-9-git-send-email-jintack@cs.columbia.edu>
Message-ID: <jpgtw3zzcee.fsf@linux.bootlegged.copy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jintack Lim <jintack@cs.columbia.edu> writes:

> From: Christoffer Dall <christoffer.dall@linaro.org>
>
> Set up virutal EL2 context to hardware if the guest exception level is
> EL2.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm64/kvm/context.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
> index 320afc6..acb4b1e 100644
> --- a/arch/arm64/kvm/context.c
> +++ b/arch/arm64/kvm/context.c
> @@ -25,10 +25,25 @@
>  void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
> +	if (unlikely(vcpu_mode_el2(vcpu))) {
> +		ctxt->hw_pstate = *vcpu_cpsr(vcpu) & ~PSR_MODE_MASK;
>  
> -	ctxt->hw_pstate = *vcpu_cpsr(vcpu);
> -	ctxt->hw_sys_regs = ctxt->sys_regs;
> -	ctxt->hw_sp_el1 = ctxt->gp_regs.sp_el1;
> +		/*
> +		 * We emulate virtual EL2 mode in hardware EL1 mode using the
> +		 * same stack pointer mode as the guest expects.
> +		 */
> +		if ((*vcpu_cpsr(vcpu) & PSR_MODE_MASK) == PSR_MODE_EL2h)
> +			ctxt->hw_pstate |= PSR_MODE_EL1h;
> +		else
> +			ctxt->hw_pstate |= PSR_MODE_EL1t;
> +

I see vcpu_mode(el2) does
return mode == PSR_MODE_EL2h || mode == PSR_MODE_EL2t;

I can't seem to find this, what's the difference between
the modes: PSR_MODE_EL2h/EL2t ?

Bandan

> +		ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
> +		ctxt->hw_sp_el1 = ctxt->el2_regs[SP_EL2];
> +	} else {
> +		ctxt->hw_pstate = *vcpu_cpsr(vcpu);
> +		ctxt->hw_sys_regs = ctxt->sys_regs;
> +		ctxt->hw_sp_el1 = ctxt->gp_regs.sp_el1;
> +	}
>  }
>  
>  /**
> @@ -38,9 +53,14 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
>  void kvm_arm_restore_shadow_state(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
> -
> -	*vcpu_cpsr(vcpu) = ctxt->hw_pstate;
> -	ctxt->gp_regs.sp_el1 = ctxt->hw_sp_el1;
> +	if (unlikely(vcpu_mode_el2(vcpu))) {
> +		*vcpu_cpsr(vcpu) &= PSR_MODE_MASK;
> +		*vcpu_cpsr(vcpu) |= ctxt->hw_pstate & ~PSR_MODE_MASK;
> +		ctxt->el2_regs[SP_EL2] = ctxt->hw_sp_el1;
> +	} else {
> +		*vcpu_cpsr(vcpu) = ctxt->hw_pstate;
> +		ctxt->gp_regs.sp_el1 = ctxt->hw_sp_el1;
> +	}
>  }
>  
>  void kvm_arm_init_cpu_context(kvm_cpu_context_t *cpu_ctxt)
