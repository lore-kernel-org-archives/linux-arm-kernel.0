From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 13 Mar 2018 09:35:47 +0000
Subject: [PATCH v5 09/23] KVM: arm/arm64: Keep GICv2 HYP VAs in
 kvm_vgic_global_state
In-Reply-To: <20180301155538.26860-10-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-10-marc.zyngier@arm.com>
Message-ID: <2dd9e07b-1fa7-72da-c10d-c4621294a886@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 15:55, Marc Zyngier wrote:
> As we're about to change the way we map devices at HYP, we need
> to move away from kern_hyp_va on an IO address.
> 
> One way of achieving this is to store the VAs in kvm_vgic_global_state,
> and use that directly from the HYP code. This requires a small change
> to create_hyp_io_mappings so that it can also return a HYP VA.
> 
> We take this opportunity to nuke the vctrl_base field in the emulated
> distributor, as it is not used anymore.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h   |  3 ++-
>   arch/arm64/include/asm/kvm_mmu.h |  3 ++-
>   include/kvm/arm_vgic.h           | 12 ++++++------
>   virt/kvm/arm/hyp/vgic-v2-sr.c    | 10 +++-------
>   virt/kvm/arm/mmu.c               | 20 +++++++++++++++-----
>   virt/kvm/arm/vgic/vgic-init.c    |  6 ------
>   virt/kvm/arm/vgic/vgic-v2.c      | 13 +++++++------
>   7 files changed, 35 insertions(+), 32 deletions(-)
> 

...

> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index 21f963f9780e..38406825e663 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -364,7 +364,8 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
>   
>   		ret = create_hyp_io_mappings(info->vcpu.start,
>   					     resource_size(&info->vcpu),
> -					     &kvm_vgic_global_state.vcpu_base_va);
> +					     &kvm_vgic_global_state.vcpu_base_va,
> +					     &kvm_vgic_global_state.vcpu_hyp_va);
>   		if (ret) {
>   			kvm_err("Cannot map GICV into hyp\n");
>   			goto out;
> @@ -375,7 +376,8 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
>   
>   	ret = create_hyp_io_mappings(info->vctrl.start,
>   				     resource_size(&info->vctrl),
> -				     &kvm_vgic_global_state.vctrl_base);
> +				     &kvm_vgic_global_state.vctrl_base,
> +				     &kvm_vgic_global_state.vctrl_hyp);

Now that we have the hyp VA, does it make sense to unmap the hyp VA, just
like we unmap the kernel io mapping if we fail to register the device ?

Suzuki
