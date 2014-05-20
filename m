From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 14:44:41 +0100
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140520134441.GK5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 09:10:27PM +0800, Haojian Zhuang wrote:
> In ARM standard GIC, GICH_APR offset is 0xf0 & GICH_LR0 offset is 0x100.
> In HiP04 GIC, GICH_APR offset is 0x70 & GICH_LR0 offset is 0x80.
> 
> Now reuse the nr_lr field in struct vgic_cpu. Bit[31:16] is used to store
> GICH_APR offset in HiP04, and bit[15:0] is used to store real nr_lr
> variable. In ARM standard GIC, don't set bit[31:16]. So we could avoid
> to change the VGIC implementation in arm64.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/kernel/asm-offsets.c   |  2 +-
>  arch/arm/kvm/interrupts_head.S  | 29 +++++++++++++++++++------
>  arch/arm64/kernel/asm-offsets.c |  2 +-
>  arch/arm64/kvm/hyp.S            | 28 ++++++++++++++++++------
>  include/kvm/arm_vgic.h          |  7 ++++--
>  include/linux/irqchip/arm-gic.h |  6 ++++++
>  virt/kvm/arm/vgic.c             | 48 +++++++++++++++++++++++++++++------------
>  7 files changed, 92 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 85598b5..166cc98 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -189,7 +189,7 @@ int main(void)
>    DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
>    DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
>    DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
> -  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
> +  DEFINE(VGIC_CPU_HW_CFG,	offsetof(struct vgic_cpu, hw_cfg));
>  #ifdef CONFIG_KVM_ARM_TIMER
>    DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
>    DEFINE(VCPU_TIMER_CNTV_CVAL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval));
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 76af9302..9fbbf99 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -419,7 +419,9 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r7, [r2, #GICH_EISR1]
>  	ldr	r8, [r2, #GICH_ELRSR0]
>  	ldr	r9, [r2, #GICH_ELRSR1]
> -	ldr	r10, [r2, #GICH_APR]
> +	ldr	r10, [r11, #VGIC_CPU_HW_CFG]
> +	mov	r10, r10, lsr #HWCFG_APR_SHIFT
> +	ldr	r10, [r2, r10]
>  
>  	str	r3, [r11, #VGIC_CPU_HCR]
>  	str	r4, [r11, #VGIC_CPU_VMCR]
> @@ -435,9 +437,15 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	str	r5, [r2, #GICH_HCR]
>  
>  	/* Save list registers */
> -	add	r2, r2, #GICH_LR0
> +	ldr	r4, [r11, #VGIC_CPU_HW_CFG]
> +	mov	r10, r4, lsr #HWCFG_APR_SHIFT
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	add	r10, r10, #0x10
> +	add	r2, r2, r10
>  	add	r3, r11, #VGIC_CPU_LR
> -	ldr	r4, [r11, #VGIC_CPU_NR_LR]
> +	/* Get NR_LR from VGIC_CPU_HW_CFG */
> +	ldr	r6, =HWCFG_NR_LR_MASK
> +	and	r4, r4, r6
>  1:	ldr	r6, [r2], #4
>  	str	r6, [r3], #4
>  	subs	r4, r4, #1
> @@ -469,12 +477,21 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  
>  	str	r3, [r2, #GICH_HCR]
>  	str	r4, [r2, #GICH_VMCR]
> -	str	r8, [r2, #GICH_APR]
> +	ldr	r6, [r11, #VGIC_CPU_HW_CFG]
> +	mov	r6, r6, lsr #HWCFG_APR_SHIFT
> +	str	r8, [r2, r6]
>  
>  	/* Restore list registers */
> -	add	r2, r2, #GICH_LR0
> +	ldr	r4, [r11, #VGIC_CPU_HW_CFG]
> +	mov	r6, r4, lsr #HWCFG_APR_SHIFT
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	add	r6, r6, #0x10
> +	/* get offset of GICH_LR0 */
> +	add	r2, r2, r6
> +	/* Get NR_LR from VGIC_CPU_HW_CFG */
>  	add	r3, r11, #VGIC_CPU_LR
> -	ldr	r4, [r11, #VGIC_CPU_NR_LR]
> +	ldr	r6, =HWCFG_NR_LR_MASK
> +	and	r4, r4, r6
>  1:	ldr	r6, [r3], #4
>  	str	r6, [r2], #4
>  	subs	r4, r4, #1
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 646f888..2422358 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -136,7 +136,7 @@ int main(void)
>    DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
>    DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
>    DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
> -  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
> +  DEFINE(VGIC_CPU_HW_CFG,	offsetof(struct vgic_cpu, hw_cfg));
>    DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
>    DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
>  #endif
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 2c56012..a4a8b3d 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -402,7 +402,9 @@ __kvm_hyp_code_start:
>  	ldr	w8, [x2, #GICH_EISR1]
>  	ldr	w9, [x2, #GICH_ELRSR0]
>  	ldr	w10, [x2, #GICH_ELRSR1]
> -	ldr	w11, [x2, #GICH_APR]
> +	ldr	w11, [x3, #VGIC_CPU_HW_CFG]
> +	mov	w11, w11, lsr #HWCFG_APR_SHIFT
> +	ldr	w11, [x2, w10]
>  CPU_BE(	rev	w4,  w4  )
>  CPU_BE(	rev	w5,  w5  )
>  CPU_BE(	rev	w6,  w6  )
> @@ -425,8 +427,13 @@ CPU_BE(	rev	w11, w11 )
>  	str	wzr, [x2, #GICH_HCR]
>  
>  	/* Save list registers */
> -	add	x2, x2, #GICH_LR0
> -	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	ldr	w4, [x3, #VGIC_CPU_HW_CFG]
> +	mov	w6, w4, lsr #HWCFG_APR_SHIFT
> +	ldr	w7, =HWCFG_NR_LR_MASK
> +	and	w4, w4, w7
> +	/* the offset between GICH_APR and GICH_LR0 is 0x10 */
> +	add	w6, w6, 0x10
> +	add	x2, x2, w6
>  	add	x3, x3, #VGIC_CPU_LR
>  1:	ldr	w5, [x2], #4
>  CPU_BE(	rev	w5, w5 )
> @@ -461,11 +468,20 @@ CPU_BE(	rev	w6, w6 )
>  
>  	str	w4, [x2, #GICH_HCR]
>  	str	w5, [x2, #GICH_VMCR]
> -	str	w6, [x2, #GICH_APR]
> +	ldr	w4, [x3, #VGIC_CPU_HW_CFG]
> +	mov	w4, w4, #HWCFG_APR_SHIFT
> +	str	w6, [x2, w4]
>  
>  	/* Restore list registers */
> -	add	x2, x2, #GICH_LR0
> -	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	ldr	w4, [x3, #VGIC_CPU_HW_CFG]
> +	mov	w6, w4, #HWCFG_APR_SHIFT
> +	/* the offset between GICH_APR and GICH_LR0 is 0x10 */
> +	add	w6, w6, #0x10
> +	/* get offset of GICH_LR0 */
> +	add	x2, x2, w6
> +	/* get NR_LR from VGIC_CPU_HW_CFG */
> +	ldr	w6, =HWCFG_NR_LR_MASK
> +	and	w4, w4, w6
>  	add	x3, x3, #VGIC_CPU_LR
>  1:	ldr	w5, [x3], #4
>  CPU_BE(	rev	w5, w5 )
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index f27000f..eba4b51 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -122,8 +122,11 @@ struct vgic_cpu {
>  	/* Bitmap of used/free list registers */
>  	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
>  
> -	/* Number of list registers on this CPU */
> -	int		nr_lr;
> +	/*
> +	 * bit[31:16]: GICH_APR offset
> +	 * bit[15:0]:  Number of list registers on this CPU
> +	 */
> +	u32		hw_cfg;
>  
>  	/* CPU vif control registers for world switch */
>  	u32		vgic_hcr;
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 45e2d8c..b055f92 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -49,6 +49,8 @@
>  #define GICH_ELRSR1 			0x34
>  #define GICH_APR			0xf0
>  #define GICH_LR0			0x100
> +#define HIP04_GICH_APR			0x70
> +/* GICH_LR0 offset in HiP04 is 0x80 */
>  
>  #define GICH_HCR_EN			(1 << 0)
>  #define GICH_HCR_UIE			(1 << 1)
> @@ -73,6 +75,10 @@
>  #define GICH_MISR_EOI			(1 << 0)
>  #define GICH_MISR_U			(1 << 1)
>  
> +#define HWCFG_NR_LR_MASK	0xffff
> +#define HWCFG_APR_SHIFT		16
> +#define HWCFG_APR_MASK		(0xffff << HWCFG_APR_SHIFT)
> +
>  #ifndef __ASSEMBLY__
>  
>  struct device_node;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 47b2983..4c0c1e9 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -76,6 +76,8 @@
>  #define IMPLEMENTER_ARM		0x43b
>  #define GICC_ARCH_VERSION_V2	0x2
>  
> +#define vgic_nr_lr(vcpu)	(vcpu->hw_cfg & HWCFG_NR_LR_MASK)
> +
>  /* Physical address of vgic virtual cpu interface */
>  static phys_addr_t vgic_vcpu_base;
>  
> @@ -97,7 +99,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
>  static void vgic_update_state(struct kvm *kvm);
>  static void vgic_kick_vcpus(struct kvm *kvm);
>  static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
> -static u32 vgic_nr_lr;
> +static u32 vgic_hw_cfg;
>  
>  static unsigned int vgic_maint_irq;
>  
> @@ -624,9 +626,9 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int vcpu_id = vcpu->vcpu_id;
>  	int i, irq, source_cpu;
> -	u32 *lr;
> +	u32 *lr, nr_lr = vgic_nr_lr(vgic_cpu);

This is static for any system post-boot, right?  Can't we set this
global variable once like we did before instead of having to define
these extra variables and do the bit manipulation all over the place?

-Christoffer
