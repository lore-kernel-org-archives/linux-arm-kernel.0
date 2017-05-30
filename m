From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 30 May 2017 12:15:41 +0200
Subject: [PATCH 26/31] KVM: arm64: vgic-v3: Add ICV_DIR_EL1 handler
In-Reply-To: <20170503104606.19342-27-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-27-marc.zyngier@arm.com>
Message-ID: <6c34b576-a0d2-6e7d-b363-349a5319dcf6@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 03/05/2017 12:46, Marc Zyngier wrote:
> Add a handler for writing the guest's view of the ICC_DIR_EL1
> register, performing the deactivation of an interrupt if EOImode
> is set ot 1.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 9c639f57268b..563dd2d16c59 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -612,6 +612,26 @@ static void __hyp_text __vgic_v3_bump_eoicount(void)
>  	write_gicreg(hcr, ICH_HCR_EL2);
>  }
>  
> +static void __hyp_text __vgic_v3_write_dir(struct kvm_vcpu *vcpu,
> +					   u32 vmcr, int rt)
> +{
> +	u32 vid = vcpu_get_reg(vcpu, rt);
> +	u64 lr_val;
> +	int lr;
> +
> +	/* No deactivate to be performed on an LPI */
> +	if (vid >= VGIC_MIN_LPI)
> +		return;

don't you need to test the EOImode first? Spec says:
"
When EOImode == ?0?. GICv3 implementations must ignore such writes. In
systems supporting system error generation, an implementation might
generate an SEI.
"

Thanks

Eric

> +
> +	lr = __vgic_v3_find_active_lr(vcpu, vid, &lr_val);
> +	if (lr == -1) {
> +		__vgic_v3_bump_eoicount();
> +		return;
> +	}
> +
> +	__vgic_v3_clear_active_lr(lr, lr_val);
> +}
> +
>  static void __hyp_text __vgic_v3_write_eoir(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
>  {
>  	u32 vid = vcpu_get_reg(vcpu, rt);
> @@ -912,6 +932,9 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		else
>  			fn = __vgic_v3_write_bpr0;
>  		break;
> +	case SYS_ICC_DIR_EL1:
> +		fn = __vgic_v3_write_dir;
> +		break;
>  	default:
>  		return 0;
>  	}
> 
