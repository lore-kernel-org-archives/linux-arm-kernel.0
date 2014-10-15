From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 15 Oct 2014 09:27:47 -0700
Subject: [PATCH v2 07/15] arm/arm64: KVM: make the value of ICC_SRE_EL1 a
 per-VM variable
In-Reply-To: <1408626416-11326-8-git-send-email-andre.przywara@arm.com>
References: <1408626416-11326-1-git-send-email-andre.przywara@arm.com>
 <1408626416-11326-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20141015162747.GH14272@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:06:48PM +0100, Andre Przywara wrote:
> ICC_SRE_EL1 is a system register allowing msr/mrs accesses to the
> GIC CPU interface for EL1 (guests). Currently we force it to 0, but
> for proper GICv3 support we have to allow guests to use it (depending
> on their selected virtual GIC model).
> So add ICC_SRE_EL1 to the list of saved/restored registers on a
> world switch, but actually disallow a guest to change it by only
> restoring a fixed, once-initialized value.
> This value depends on the GIC model userland has chosen for a guest.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/kernel/asm-offsets.c |    1 +
>  arch/arm64/kvm/vgic-v3-switch.S |   14 +++++++++-----
>  include/kvm/arm_vgic.h          |    1 +
>  virt/kvm/arm/vgic-v3.c          |    9 +++++++--
>  4 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 9a9fce0..9d34486 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -140,6 +140,7 @@ int main(void)
>    DEFINE(VGIC_V2_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_v2.vgic_elrsr));
>    DEFINE(VGIC_V2_CPU_APR,	offsetof(struct vgic_cpu, vgic_v2.vgic_apr));
>    DEFINE(VGIC_V2_CPU_LR,	offsetof(struct vgic_cpu, vgic_v2.vgic_lr));
> +  DEFINE(VGIC_V3_CPU_SRE,	offsetof(struct vgic_cpu, vgic_v3.vgic_sre));
>    DEFINE(VGIC_V3_CPU_HCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_hcr));
>    DEFINE(VGIC_V3_CPU_VMCR,	offsetof(struct vgic_cpu, vgic_v3.vgic_vmcr));
>    DEFINE(VGIC_V3_CPU_MISR,	offsetof(struct vgic_cpu, vgic_v3.vgic_misr));
> diff --git a/arch/arm64/kvm/vgic-v3-switch.S b/arch/arm64/kvm/vgic-v3-switch.S
> index d160469..617a012 100644
> --- a/arch/arm64/kvm/vgic-v3-switch.S
> +++ b/arch/arm64/kvm/vgic-v3-switch.S
> @@ -148,17 +148,18 @@
>   * x0: Register pointing to VCPU struct
>   */
>  .macro	restore_vgic_v3_state
> -	// Disable SRE_EL1 access. Necessary, otherwise
> -	// ICH_VMCR_EL2.VFIQEn becomes one, and FIQ happens...
> -	msr_s	ICC_SRE_EL1, xzr
> -	isb
> -
>  	// Compute the address of struct vgic_cpu
>  	add	x3, x0, #VCPU_VGIC_CPU
>  
>  	// Restore all interesting registers
>  	ldr	w4, [x3, #VGIC_V3_CPU_HCR]
>  	ldr	w5, [x3, #VGIC_V3_CPU_VMCR]
> +	ldr	w25, [x3, #VGIC_V3_CPU_SRE]
> +
> +	msr_s	ICC_SRE_EL1, x25
> +
> +	// make sure SRE is valid before writing the other registers
> +	isb
>  
>  	msr_s	ICH_HCR_EL2, x4
>  	msr_s	ICH_VMCR_EL2, x5
> @@ -244,9 +245,12 @@
>  	dsb	sy
>  
>  	// Prevent the guest from touching the GIC system registers
> +	// if SRE isn't enabled for GICv3 emulation
> +	cbnz	x25, 1f
>  	mrs_s	x5, ICC_SRE_EL2
>  	and	x5, x5, #~ICC_SRE_EL2_ENABLE
>  	msr_s	ICC_SRE_EL2, x5
> +1:
>  .endm
>  
>  ENTRY(__save_vgic_v3_state)
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 7e7c99e..8aa8482 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -199,6 +199,7 @@ struct vgic_v3_cpu_if {
>  #ifdef CONFIG_ARM_GIC_V3
>  	u32		vgic_hcr;
>  	u32		vgic_vmcr;
> +	u32		vgic_sre;	/* Restored only, change ignored */
>  	u32		vgic_misr;	/* Saved only */
>  	u32		vgic_eisr;	/* Saved only */
>  	u32		vgic_elrsr;	/* Saved only */
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index 86e8b99..8af8037 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -145,15 +145,20 @@ static void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>  
>  static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>  {
> +	struct vgic_v3_cpu_if *vgic_v3;
> +
> +	vgic_v3 = &vcpu->arch.vgic_cpu.vgic_v3;
>  	/*
>  	 * By forcing VMCR to zero, the GIC will restore the binary
>  	 * points to their reset values. Anything else resets to zero
>  	 * anyway.
>  	 */
> -	vcpu->arch.vgic_cpu.vgic_v3.vgic_vmcr = 0;
> +	vgic_v3->vgic_vmcr = 0;
> +
> +	vgic_v3->vgic_sre	= 0;
               why the tab ^^^ ?
>  
>  	/* Get the show on the road... */
> -	vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr = ICH_HCR_EN;
> +	vgic_v3->vgic_hcr = ICH_HCR_EN;
>  }
>  
>  static const struct vgic_ops vgic_v3_ops = {
> -- 
> 1.7.9.5
> 

Besides the nit:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
