From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 9 Jun 2017 17:34:19 +0200
Subject: [PATCH v3 27/27] KVM: arm64: Log an error if trapping a
 write-to-read-only GICv3 access
In-Reply-To: <20170609114956.25963-28-marc.zyngier@arm.com>
References: <20170609114956.25963-1-marc.zyngier@arm.com>
 <20170609114956.25963-28-marc.zyngier@arm.com>
Message-ID: <20170609153419.GI11099@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 12:49:56PM +0100, Marc Zyngier wrote:
> A write-to-read-only GICv3 access should UNDEF at EL1. But since
> we're in complete paranoia-land with broken CPUs, let's assume the
> worse and gracefully handle the case.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm64/kvm/sys_regs.c     | 15 +++++++++++++++
>  virt/kvm/arm/hyp/vgic-v3-sr.c |  6 ++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 8d51c075966d..77862881ae86 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -65,6 +65,16 @@ static bool read_from_write_only(struct kvm_vcpu *vcpu,
>  	return false;
>  }
>  
> +static bool write_to_read_only(struct kvm_vcpu *vcpu,
> +			       struct sys_reg_params *params,
> +			       const struct sys_reg_desc *r)
> +{
> +	WARN_ONCE(1, "Unexpected sys_reg write to read-only register\n");
> +	print_sys_reg_instr(params);
> +	kvm_inject_undefined(vcpu);
> +	return false;
> +}
> +
>  /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>  static u32 cache_levels;
>  
> @@ -954,10 +964,15 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	{ SYS_DESC(SYS_VBAR_EL1), NULL, reset_val, VBAR_EL1, 0 },
>  
> +	{ SYS_DESC(SYS_ICC_IAR0_EL1), write_to_read_only },
>  	{ SYS_DESC(SYS_ICC_EOIR0_EL1), read_from_write_only },
> +	{ SYS_DESC(SYS_ICC_HPPIR0_EL1), write_to_read_only },
>  	{ SYS_DESC(SYS_ICC_DIR_EL1), read_from_write_only },
> +	{ SYS_DESC(SYS_ICC_RPR_EL1), write_to_read_only },
>  	{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
> +	{ SYS_DESC(SYS_ICC_IAR1_EL1), write_to_read_only },
>  	{ SYS_DESC(SYS_ICC_EOIR1_EL1), read_from_write_only },
> +	{ SYS_DESC(SYS_ICC_HPPIR1_EL1), write_to_read_only },
>  	{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
>  
>  	{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index b26ce58b012a..79e3c2d3b754 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -976,6 +976,8 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  	switch (sysreg) {
>  	case SYS_ICC_IAR0_EL1:
>  	case SYS_ICC_IAR1_EL1:
> +		if (unlikely(!is_read))
> +			return 0;
>  		fn = __vgic_v3_read_iar;
>  		break;
>  	case SYS_ICC_EOIR0_EL1:
> @@ -1026,6 +1028,8 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		break;
>  	case SYS_ICC_HPPIR0_EL1:
>  	case SYS_ICC_HPPIR1_EL1:
> +		if (unlikely(!is_read))
> +			return 0;
>  		fn = __vgic_v3_read_hppir;
>  		break;
>  	case SYS_ICC_GRPEN0_EL1:
> @@ -1046,6 +1050,8 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		fn = __vgic_v3_write_dir;
>  		break;
>  	case SYS_ICC_RPR_EL1:
> +		if (unlikely(!is_read))
> +			return 0;
>  		fn = __vgic_v3_read_rpr;
>  		break;
>  	case SYS_ICC_CTLR_EL1:
> -- 
> 2.11.0
> 
