From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Dec 2012 13:31:29 +0000
Subject: [PATCH v4 10/13] ARM: KVM: VGIC control interface world switch
In-Reply-To: <20121110154525.3061.45070.stgit@chazy-air>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154525.3061.45070.stgit@chazy-air>
Message-ID: <20121203133129.GF20074@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:45:25PM +0000, Christoffer Dall wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Enable the VGIC control interface to be save-restored on world switch.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> ---
>  arch/arm/include/asm/kvm_arm.h |   12 +++++++
>  arch/arm/kernel/asm-offsets.c  |   12 +++++++
>  arch/arm/kvm/interrupts_head.S |   68 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> index 246afd7..8f5dd22 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -192,4 +192,16 @@
>  #define HSR_EC_DABT	(0x24)
>  #define HSR_EC_DABT_HYP	(0x25)
>  
> +/* GICH offsets */
> +#define GICH_HCR	0x0
> +#define GICH_VTR	0x4
> +#define GICH_VMCR	0x8
> +#define GICH_MISR	0x10
> +#define GICH_EISR0 	0x20
> +#define GICH_EISR1 	0x24
> +#define GICH_ELRSR0 	0x30
> +#define GICH_ELRSR1 	0x34
> +#define GICH_APR	0xf0
> +#define GICH_LR0	0x100

Similar thing to the other new gic defines -- they're probably better off
in gic.h

> +
>  #endif /* __ARM_KVM_ARM_H__ */
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 95cab37..39b6221 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -167,6 +167,18 @@ int main(void)
>    DEFINE(VCPU_HxFAR,		offsetof(struct kvm_vcpu, arch.hxfar));
>    DEFINE(VCPU_HPFAR,		offsetof(struct kvm_vcpu, arch.hpfar));
>    DEFINE(VCPU_HYP_PC,		offsetof(struct kvm_vcpu, arch.hyp_pc));
> +#ifdef CONFIG_KVM_ARM_VGIC
> +  DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
> +  DEFINE(VGIC_CPU_HCR,		offsetof(struct vgic_cpu, vgic_hcr));
> +  DEFINE(VGIC_CPU_VMCR,		offsetof(struct vgic_cpu, vgic_vmcr));
> +  DEFINE(VGIC_CPU_MISR,		offsetof(struct vgic_cpu, vgic_misr));
> +  DEFINE(VGIC_CPU_EISR,		offsetof(struct vgic_cpu, vgic_eisr));
> +  DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
> +  DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
> +  DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
> +  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
> +  DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
> +#endif
>    DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
>  #endif
>    return 0; 
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 2ac8b4a..c2423d8 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -341,6 +341,45 @@
>   * @vcpup: Register pointing to VCPU struct
>   */
>  .macro save_vgic_state	vcpup
> +#ifdef CONFIG_KVM_ARM_VGIC
> +	/* Get VGIC VCTRL base into r2 */
> +	ldr	r2, [\vcpup, #VCPU_KVM]
> +	ldr	r2, [r2, #KVM_VGIC_VCTRL]
> +	cmp	r2, #0
> +	beq	2f
> +
> +	/* Compute the address of struct vgic_cpu */
> +	add	r11, \vcpup, #VCPU_VGIC_CPU

Given that we're dealing with constants, it would be more efficient to
express this addition as part of the immediate offset and let gas spit
out the final computed address for the stores below.

> +
> +	/* Save all interesting registers */
> +	ldr	r3, [r2, #GICH_HCR]
> +	ldr	r4, [r2, #GICH_VMCR]
> +	ldr	r5, [r2, #GICH_MISR]
> +	ldr	r6, [r2, #GICH_EISR0]
> +	ldr	r7, [r2, #GICH_EISR1]
> +	ldr	r8, [r2, #GICH_ELRSR0]
> +	ldr	r9, [r2, #GICH_ELRSR1]
> +	ldr	r10, [r2, #GICH_APR]
> +
> +	str	r3, [r11, #VGIC_CPU_HCR]
> +	str	r4, [r11, #VGIC_CPU_VMCR]
> +	str	r5, [r11, #VGIC_CPU_MISR]
> +	str	r6, [r11, #VGIC_CPU_EISR]
> +	str	r7, [r11, #(VGIC_CPU_EISR + 4)]
> +	str	r8, [r11, #VGIC_CPU_ELRSR]
> +	str	r9, [r11, #(VGIC_CPU_ELRSR + 4)]
> +	str	r10, [r11, #VGIC_CPU_APR]
> +
> +	/* Save list registers */
> +	add	r2, r2, #GICH_LR0
> +	add	r3, r11, #VGIC_CPU_LR
> +	ldr	r4, [r11, #VGIC_CPU_NR_LR]
> +1:	ldr	r6, [r2], #4
> +	str	r6, [r3], #4
> +	subs	r4, r4, #1
> +	bne	1b
> +2:
> +#endif
>  .endm

Will
