From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 8 Nov 2017 09:44:42 +0100
Subject: [PATCH v5 25/26] KVM: arm/arm64: GICv4: Enable VLPI support
In-Reply-To: <20171027142855.21584-26-marc.zyngier@arm.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-26-marc.zyngier@arm.com>
Message-ID: <2d20a22e-214d-3835-7f61-29fc5e88413a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 27/10/2017 16:28, Marc Zyngier wrote:
> All it takes is the has_v4 flag to be set in gic_kvm_info
> as well as "kvm-arm.vgic_v4_enable=1" being passed on the
> command line for GICv4 to be enabled in KVM.

What did you motivate your choice of having an enable option instead of
a disable option?

Thanks

Eric
> 
> Acked-by: Christoffer Dall <cdall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  virt/kvm/arm/vgic/vgic-v3.c                     | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 05496622b4ef..93c8fff399eb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1874,6 +1874,10 @@
>  			[KVM,ARM] Trap guest accesses to GICv3 common
>  			system registers
>  
> +	kvm-arm.vgic_v4_enable=
> +			[KVM,ARM] Allow use of GICv4 for direct injection of
> +			LPIs.
> +
>  	kvm-intel.ept=	[KVM,Intel] Disable extended page tables
>  			(virtualized MMU) support on capable Intel chips.
>  			Default is 1 (enabled)
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 96ea597db0e7..405733678c2f 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -24,6 +24,7 @@
>  static bool group0_trap;
>  static bool group1_trap;
>  static bool common_trap;
> +static bool gicv4_enable;
>  
>  void vgic_v3_set_underflow(struct kvm_vcpu *vcpu)
>  {
> @@ -459,6 +460,12 @@ static int __init early_common_trap_cfg(char *buf)
>  }
>  early_param("kvm-arm.vgic_v3_common_trap", early_common_trap_cfg);
>  
> +static int __init early_gicv4_enable(char *buf)
> +{
> +	return strtobool(buf, &gicv4_enable);
> +}
> +early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
> +
>  /**
>   * vgic_v3_probe - probe for a GICv3 compatible interrupt controller in DT
>   * @node:	pointer to the DT node
> @@ -478,6 +485,13 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
>  	kvm_vgic_global_state.can_emulate_gicv2 = false;
>  	kvm_vgic_global_state.ich_vtr_el2 = ich_vtr_el2;
>  
> +	/* GICv4 support? */
> +	if (info->has_v4) {
> +		kvm_vgic_global_state.has_gicv4 = gicv4_enable;
> +		kvm_info("GICv4 support %sabled\n",
> +			 gicv4_enable ? "en" : "dis");
> +	}
> +
>  	if (!info->vcpu.start) {
>  		kvm_info("GICv3: no GICV resource entry\n");
>  		kvm_vgic_global_state.vcpu_base = 0;
> 
