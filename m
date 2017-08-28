From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 28 Aug 2017 20:20:39 +0200
Subject: [PATCH v3 54/59] KVM: arm/arm64: GICv4: Enable virtual cpuif if
 VLPIs can be delivered
In-Reply-To: <20170731172637.29355-55-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
 <20170731172637.29355-55-marc.zyngier@arm.com>
Message-ID: <20170828182039.GO24649@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 06:26:32PM +0100, Marc Zyngier wrote:
> In order for VLPIs to be delivered to the guest, we must make
> sure that the cpuif is always enabled, irrespective of the
> presence of virtual interrupt in the LRs.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index 91728faa13fd..f5c3d6d7019e 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -258,7 +258,8 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
>  			cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
>  		}
>  	} else {
> -		if (static_branch_unlikely(&vgic_v3_cpuif_trap))
> +		if (static_branch_unlikely(&vgic_v3_cpuif_trap) ||
> +		    cpu_if->its_vpe.its_vm)
>  			write_gicreg(0, ICH_HCR_EL2);
>  
>  		cpu_if->vgic_elrsr = 0xffff;
> @@ -337,9 +338,11 @@ void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
>  		/*
>  		 * If we need to trap system registers, we must write
>  		 * ICH_HCR_EL2 anyway, even if no interrupts are being
> -		 * injected,
> +		 * injected. Same thing if GICv4 is used, as VLPI
> +		 * delivery is gated by ICH_HCR_EL2.En.
>  		 */
> -		if (static_branch_unlikely(&vgic_v3_cpuif_trap))
> +		if (static_branch_unlikely(&vgic_v3_cpuif_trap) ||
> +		    cpu_if->its_vpe.its_vm)
>  			write_gicreg(cpu_if->vgic_hcr, ICH_HCR_EL2);
>  	}
>  
> -- 
> 2.11.0
> 

Acked-by: Christoffer Dall <cdall@linaro.org>
