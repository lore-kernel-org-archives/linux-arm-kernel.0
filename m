From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 6 Jun 2017 15:22:51 +0200
Subject: [PATCH v2 15/25] KVM: arm64: vgic-v3: Add misc Group-0 handlers
In-Reply-To: <20170601102117.17750-16-marc.zyngier@arm.com>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
 <20170601102117.17750-16-marc.zyngier@arm.com>
Message-ID: <20170606132251.GX9464@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 11:21:07AM +0100, Marc Zyngier wrote:
> A number of Group-0 registers can be handled by the same accessors
> as that of Group-1, so let's add the required system register encodings
> and catch them in the dispatching function.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm64/include/asm/sysreg.h | 4 ++++
>  virt/kvm/arm/hyp/vgic-v3-sr.c   | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index ba93bc7ac8e4..9971c5c435a7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -180,7 +180,11 @@
>  
>  #define SYS_VBAR_EL1			sys_reg(3, 0, 12, 0, 0)
>  
> +#define SYS_ICC_IAR0_EL1		sys_reg(3, 0, 12, 8, 0)
> +#define SYS_ICC_EOIR0_EL1		sys_reg(3, 0, 12, 8, 1)
> +#define SYS_ICC_HPPIR0_EL1		sys_reg(3, 0, 12, 8, 2)
>  #define SYS_ICC_BPR0_EL1		sys_reg(3, 0, 12, 8, 3)
> +#define SYS_ICC_AP0Rn_EL1(n)		sys_reg(3, 0, 12, 8, 4 | n)
>  #define SYS_ICC_AP1Rn_EL1(n)		sys_reg(3, 0, 12, 9, n)
>  #define SYS_ICC_DIR_EL1			sys_reg(3, 0, 12, 11, 1)
>  #define SYS_ICC_SGI1R_EL1		sys_reg(3, 0, 12, 11, 5)
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index b1b9129da045..5ff788d308ee 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -872,9 +872,11 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
>  
>  	switch (sysreg) {
> +	case SYS_ICC_IAR0_EL1:
>  	case SYS_ICC_IAR1_EL1:
>  		fn = __vgic_v3_read_iar;
>  		break;
> +	case SYS_ICC_EOIR0_EL1:
>  	case SYS_ICC_EOIR1_EL1:
>  		fn = __vgic_v3_write_eoir;
>  		break;
> @@ -890,30 +892,35 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  		else
>  			fn = __vgic_v3_write_bpr1;
>  		break;
> +	case SYS_ICC_AP0Rn_EL1(0):
>  	case SYS_ICC_AP1Rn_EL1(0):
>  		if (is_read)
>  			fn = __vgic_v3_read_apxr0;
>  		else
>  			fn = __vgic_v3_write_apxr0;
>  		break;
> +	case SYS_ICC_AP0Rn_EL1(1):
>  	case SYS_ICC_AP1Rn_EL1(1):
>  		if (is_read)
>  			fn = __vgic_v3_read_apxr1;
>  		else
>  			fn = __vgic_v3_write_apxr1;
>  		break;
> +	case SYS_ICC_AP0Rn_EL1(2):
>  	case SYS_ICC_AP1Rn_EL1(2):
>  		if (is_read)
>  			fn = __vgic_v3_read_apxr2;
>  		else
>  			fn = __vgic_v3_write_apxr2;
>  		break;
> +	case SYS_ICC_AP0Rn_EL1(3):
>  	case SYS_ICC_AP1Rn_EL1(3):
>  		if (is_read)
>  			fn = __vgic_v3_read_apxr3;
>  		else
>  			fn = __vgic_v3_write_apxr3;
>  		break;
> +	case SYS_ICC_HPPIR0_EL1:
>  	case SYS_ICC_HPPIR1_EL1:
>  		fn = __vgic_v3_read_hppir;
>  		break;
> -- 
> 2.11.0
> 
