From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 17 May 2017 17:39:24 +0200
Subject: [PATCH 11/31] KVM: arm64: vgic-v3: Add ICV_BPR1_EL1 handler
In-Reply-To: <20170503104606.19342-12-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-12-marc.zyngier@arm.com>
Message-ID: <9cb78018-5f9a-7cee-693b-29dacceab4d2@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/05/2017 12:45, Marc Zyngier wrote:
> Add a handler for reading/writing the guest's view of the ICC_BPR1_EL1
> register, which is located in the ICH_VMCR_EL2.BPR1 field.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 61 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 435787a93c6c..f0f038c490a5 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -375,9 +375,57 @@ void __hyp_text __vgic_v3_write_vmcr(u32 vmcr)
>  
>  #ifdef CONFIG_ARM64
>  
> +static unsigned int __hyp_text __vgic_v3_get_bpr0(u32 vmcr)
> +{
> +	return (vmcr & ICH_VMCR_BPR0_MASK) >> ICH_VMCR_BPR0_SHIFT;
> +}
> +
> +static unsigned int __hyp_text __vgic_v3_get_bpr1(u32 vmcr)
> +{
> +	unsigned int bpr;
> +
> +	if (vmcr & ICH_VMCR_CBPR_MASK) {
> +		bpr = __vgic_v3_get_bpr0(vmcr);
> +		if (bpr < 7)
> +			bpr++;
> +	} else {
> +		bpr = (vmcr & ICH_VMCR_BPR1_MASK) >> ICH_VMCR_BPR1_SHIFT;
> +	}
> +
> +	return bpr;
> +}
> +
> +static void __hyp_text __vgic_v3_read_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
> +{
> +	vcpu_set_reg(vcpu, rt, __vgic_v3_get_bpr1(vmcr));
> +}
> +
> +static void __hyp_text __vgic_v3_write_bpr1(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
> +{
> +	u64 val = vcpu_get_reg(vcpu, rt);
> +	u8 bpr_min = 8 - vtr_to_nr_pre_bits(read_gicreg(ICH_VTR_EL2));
> +
> +	if (vmcr & ICH_VMCR_CBPR_MASK)
> +		return;
> +
> +	/* Enforce BPR limiting */
> +	if (val < bpr_min)
> +		val = bpr_min;
> +
> +	val <<= ICH_VMCR_BPR1_SHIFT;
> +	val &= ICH_VMCR_BPR1_MASK;
> +	vmcr &= ~ICH_VMCR_BPR1_MASK;
> +	vmcr |= val;
> +
> +	__vgic_v3_write_vmcr(vmcr);
> +}
> +
>  int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  {
> -	u32 esr = kvm_vcpu_get_hsr(vcpu);
> +	int rt = kvm_vcpu_sys_get_rt(vcpu);
nit: could be done later when setting is_read.

> +	u32 vmcr, esr = kvm_vcpu_get_hsr(vcpu);
Christoffer does not like this ;-)

Besides looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


> +	void (*fn)(struct kvm_vcpu *, u32, int);
> +	bool is_read;
>  	u32 sysreg;
>  
>  	if (vcpu_mode_is_32bit(vcpu)) {
> @@ -389,11 +437,22 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		sysreg = esr_sys64_to_sysreg(esr);
>  	}
>  
> +	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
> +
>  	switch (sysreg) {
> +	case SYS_ICC_BPR1_EL1:
> +		if (is_read)
> +			fn = __vgic_v3_read_bpr1;
> +		else
> +			fn = __vgic_v3_write_bpr1;
> +		break;
>  	default:
>  		return 0;
>  	}
>  
> +	vmcr = __vgic_v3_read_vmcr();
> +	fn(vcpu, vmcr, rt);
> +
>  	return 1;
>  }
>  
> 
