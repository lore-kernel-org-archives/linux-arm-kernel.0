From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 14:19:49 +0100
Subject: [RFC 31/55] KVM: arm/arm64: Inject maintenance interrupts to the
 guest hypervisor
In-Reply-To: <1483943091-1364-32-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-32-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222131949.GR26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:27AM -0500, Jintack Lim wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> If we exit a nested VM with a pending maintenance interrupt from the
> GIC, then we need to forward this to the guest hypervisor so that it can
> re-sync the appropriate LRs and sample level triggered interrupts again.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm64/kvm/context.c           |  3 +++
>  include/kvm/arm_vgic.h             |  2 ++
>  virt/kvm/arm/vgic/vgic-v2-nested.c | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
> index 7a94c9d..a93ffe4 100644
> --- a/arch/arm64/kvm/context.c
> +++ b/arch/arm64/kvm/context.c
> @@ -140,6 +140,9 @@ static void sync_shadow_el1_state(struct kvm_vcpu *vcpu, bool setup)
>  void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
> +
> +	vgic_handle_nested_maint_irq(vcpu);
> +

It feels like I stuck this in some random place where it would work, but
now it looks weird to call a vgic function from the shadow_el1_state
function.  Can we find a more appropriate place to put it?

>  	if (unlikely(vcpu_mode_el2(vcpu))) {
>  		ctxt->hw_pstate = *vcpu_cpsr(vcpu) & ~PSR_MODE_MASK;
>  
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 484f6b1..fc882d6 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -315,9 +315,11 @@ int kvm_vgic_inject_mapped_irq(struct kvm *kvm, int cpuid, unsigned int intid,
>  #ifdef CONFIG_KVM_ARM_NESTED_HYP
>  void vgic_v2_setup_shadow_state(struct kvm_vcpu *vcpu);
>  void vgic_v2_restore_shadow_state(struct kvm_vcpu *vcpu);
> +void vgic_handle_nested_maint_irq(struct kvm_vcpu *vcpu);
>  #else
>  static inline void vgic_v2_setup_shadow_state(struct kvm_vcpu *vcpu) { }
>  static inline void vgic_v2_restore_shadow_state(struct kvm_vcpu *vcpu) { }
> +static inline void vgic_handle_nested_maint_irq(struct kvm_vcpu *vcpu) { }
>  #endif
>  
>  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.in_kernel))
> diff --git a/virt/kvm/arm/vgic/vgic-v2-nested.c b/virt/kvm/arm/vgic/vgic-v2-nested.c
> index a992da5..85f646b 100644
> --- a/virt/kvm/arm/vgic/vgic-v2-nested.c
> +++ b/virt/kvm/arm/vgic/vgic-v2-nested.c
> @@ -300,6 +300,22 @@ void vgic_v2_restore_shadow_state(struct kvm_vcpu *vcpu)
>  	vgic_cpu->nested_vgic_v2 = vgic_cpu->shadow_vgic_v2;
>  }
>  
> +void vgic_handle_nested_maint_irq(struct kvm_vcpu *vcpu)
> +{
> +	struct vgic_v2_cpu_if *cpu_if = vcpu_nested_if(vcpu);
> +
> +	/*
> +	 * If we exit a nested VM with a pending maintenance interrupt from the
> +	 * GIC, then we need to forward this to the guest hypervisor so that it
> +	 * can re-sync the appropriate LRs and sample level triggered interrupts
> +	 * again.
> +	 */
> +	if (vcpu_el2_imo_is_set(vcpu) && !vcpu_mode_el2(vcpu) &&

I think I made the same mistake here, that we shouldn't check if we're
in EL2 or not, because I don't think the GIC cares.  I think we should
check if EL2 can accept interrupts (i.e. PSTATE.I is clear if it is in
EL2 or IMO is set if not).

> +	    (cpu_if->vgic_hcr & GICH_HCR_EN) &&
> +	    vgic_mmio_read_v2_misr(vcpu, 0, 0))

what are the zeroes?  They look dodgy.

> +		kvm_inject_nested_irq(vcpu);
> +}
> +
>  void vgic_init_nested(struct kvm_vcpu *vcpu)
>  {
>  	vgic_v2_setup_shadow_state(vcpu);
> -- 
> 1.9.1
> 
> 

Thanks,
-Christoffer
