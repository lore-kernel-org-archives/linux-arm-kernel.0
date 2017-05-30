From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 30 May 2017 12:34:43 +0200
Subject: [PATCH 29/31] KVM: arm64: vgic-v3: Add ICV_PMR_EL1 handler
In-Reply-To: <20170503104606.19342-30-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-30-marc.zyngier@arm.com>
Message-ID: <d3b3785d-9cfe-ac53-e0e3-59fae60ef6a6@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/05/2017 12:46, Marc Zyngier wrote:
> Add a handler for reading/writing the guest's view of the ICC_PMR_EL1
> register, which is located in the ICH_VMCR_EL2.VPMR field.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 981201bf7a5e..4fbeeb54704e 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -848,6 +848,27 @@ static void __hyp_text __vgic_v3_read_hppir(struct kvm_vcpu *vcpu,
>  	vcpu_set_reg(vcpu, rt, lr_val & ICH_LR_VIRTUAL_ID_MASK);
>  }
>  
> +static void __hyp_text __vgic_v3_read_pmr(struct kvm_vcpu *vcpu,
> +					  u32 vmcr, int rt)
> +{
> +	vmcr &= ICH_VMCR_PMR_MASK;
> +	vmcr >>= ICH_VMCR_PMR_SHIFT;
> +	vcpu_set_reg(vcpu, rt, vmcr);
> +}
> +
> +static void __hyp_text __vgic_v3_write_pmr(struct kvm_vcpu *vcpu,
> +					   u32 vmcr, int rt)
> +{
> +	u32 val = vcpu_get_reg(vcpu, rt);
> +
> +	val <<= ICH_VMCR_PMR_SHIFT;
> +	val &= ICH_VMCR_PMR_MASK;
> +	vmcr &= ~ICH_VMCR_PMR_MASK;
> +	vmcr |= val;
> +
> +	write_gicreg(vmcr, ICH_VMCR_EL2);
> +}
> +
>  static void __hyp_text __vgic_v3_read_rpr(struct kvm_vcpu *vcpu,
>  					  u32 vmcr, int rt)
>  {
> @@ -991,6 +1012,12 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		else
>  			fn = __vgic_v3_write_ctlr;
>  		break;
> +	case SYS_ICC_PMR_EL1:
> +		if (is_read)
> +			fn = __vgic_v3_read_pmr;
> +		else
> +			fn = __vgic_v3_write_pmr;
> +		break;
>  	default:
>  		return 0;
>  	}
> 
