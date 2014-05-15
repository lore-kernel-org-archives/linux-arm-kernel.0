From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 May 2014 10:42:00 +0100
Subject: [PATCH v6 15/15] virt: arm: support hip04 gic
In-Reply-To: <1399795571-17231-16-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-16-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <53748BE8.8060203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/14 09:06, Haojian Zhuang wrote:
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
>  arch/arm/kvm/interrupts_head.S  | 32 ++++++++++++++++++++++------
>  include/kvm/arm_vgic.h          |  5 ++++-
>  include/linux/irqchip/arm-gic.h |  6 ++++++
>  virt/kvm/arm/vgic.c             | 47 +++++++++++++++++++++++++++++------------
>  4 files changed, 69 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 76af9302..7aacaff 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -419,7 +419,10 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r7, [r2, #GICH_EISR1]
>  	ldr	r8, [r2, #GICH_ELRSR0]
>  	ldr	r9, [r2, #GICH_ELRSR1]
> -	ldr	r10, [r2, #GICH_APR]
> +	ldr	r10, [r11, #VGIC_CPU_NR_LR]

Please rename this field to something else, now that it contains more
than the number of LRs.

> +	movs	r10, r10, lsr #HWCFG_APR_SHIFT
> +	ldrne	r10, [r2, r10]
> +	ldreq	r10, [r2, #GICH_APR]

No. Just encode the offset there always. No need for a test.

>  	str	r3, [r11, #VGIC_CPU_HCR]
>  	str	r4, [r11, #VGIC_CPU_VMCR]
> @@ -435,9 +438,16 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	str	r5, [r2, #GICH_HCR]
>  
>  	/* Save list registers */
> -	add	r2, r2, #GICH_LR0
> -	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
> +	addeq	r2, r2, #GICH_LR0
> +	movne	r10, r4, lsr #HWCFG_APR_SHIFT
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	addne	r10, r10, #0x10
> +	addne	r2, r2, r10
> +	add	r3, r11, #VGIC_CPU_LR
> +	/* Get NR_LR from VGIC_CPU_NR_LR */
> +	ldr	r6, =HWCFG_NR_LR_MASK
> +	and	r4, r4, r6

And the above simplifies all this complicated mess.

>  1:	ldr	r6, [r2], #4
>  	str	r6, [r3], #4
>  	subs	r4, r4, #1
> @@ -469,12 +479,22 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  
>  	str	r3, [r2, #GICH_HCR]
>  	str	r4, [r2, #GICH_VMCR]
> -	str	r8, [r2, #GICH_APR]
> +	ldr	r6, [r11, #VGIC_CPU_NR_LR]
> +	movs	r6, r6, lsr #HWCFG_APR_SHIFT
> +	strne	r8, [r2, r6]
> +	streq	r8, [r2, #GICH_APR]
>  
>  	/* Restore list registers */
> -	add	r2, r2, #GICH_LR0
> -	add	r3, r11, #VGIC_CPU_LR
>  	ldr	r4, [r11, #VGIC_CPU_NR_LR]
> +	addeq	r2, r2, #GICH_LR0
> +	movne	r6, r4, lsr #HWCFG_APR_SHIFT
> +	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
> +	addne	r6, r6, #0x10
> +	addne	r2, r2, r6
> +	/* Get NR_LR from VGIC_CPU_NR_LR */
> +	add	r3, r11, #VGIC_CPU_LR
> +	ldr	r6, =HWCFG_NR_LR_MASK
> +	and	r4, r4, r6

Same here.

>  1:	ldr	r6, [r3], #4
>  	str	r6, [r2], #4
>  	subs	r4, r4, #1
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index f27000f..089de25 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -122,7 +122,10 @@ struct vgic_cpu {
>  	/* Bitmap of used/free list registers */
>  	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
>  
> -	/* Number of list registers on this CPU */
> +	/*
> +	 * bit[31:16]: GICH_APR offset
> +	 * bit[15:0]:  Number of list registers on this CPU
> +	 */
>  	int		nr_lr;

Make it a u32 to reflect the encoding, rename it to reflect the change
in functionality.

>  
>  	/* CPU vif control registers for world switch */
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 45e2d8c..5530388 100644
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
> +#define HWCFG_APR_MASK		0xffff
> +#define HWCFG_APR_SHIFT		16

HWCFG_APR_MASK is wrong, as it should be shifted.

>  #ifndef __ASSEMBLY__
>  
>  struct device_node;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 47b2983..e635b9b 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -97,7 +97,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
>  static void vgic_update_state(struct kvm *kvm);
>  static void vgic_kick_vcpus(struct kvm *kvm);
>  static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
> -static u32 vgic_nr_lr;
> +static u32 vgic_hw_cfg;
>  
>  static unsigned int vgic_maint_irq;
>  
> @@ -624,9 +624,9 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int vcpu_id = vcpu->vcpu_id;
>  	int i, irq, source_cpu;
> -	u32 *lr;
> +	u32 *lr, nr_lr = vgic_cpu->nr_lr & HWCFG_NR_LR_MASK;

Define an accessor (vgic_nr_lr(vcpu)). and use it everywhere you've
introduced this construct.

>  
> -	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> +	for_each_set_bit(i, vgic_cpu->lr_used, nr_lr) {
>  		lr = &vgic_cpu->vgic_lr[i];
>  		irq = LR_IRQID(*lr);
>  		source_cpu = LR_CPUID(*lr);
> @@ -1005,8 +1005,9 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int lr;
> +	int nr_lr = vgic_cpu->nr_lr & HWCFG_NR_LR_MASK;
>  
> -	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> +	for_each_set_bit(lr, vgic_cpu->lr_used, nr_lr) {
>  		int irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
>  
>  		if (!vgic_irq_is_enabled(vcpu, irq)) {
> @@ -1025,6 +1026,7 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int lr;
> +	int nr_lr = vgic_cpu->nr_lr & HWCFG_NR_LR_MASK;
>  
>  	/* Sanitize the input... */
>  	BUG_ON(sgi_source_id & ~7);
> @@ -1046,9 +1048,8 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  	}
>  
>  	/* Try to use another LR for this interrupt */
> -	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
> -			       vgic_cpu->nr_lr);
> -	if (lr >= vgic_cpu->nr_lr)
> +	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used, nr_lr);
> +	if (lr >= nr_lr)
>  		return false;
>  
>  	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
> @@ -1181,9 +1182,10 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		 * active bit.
>  		 */
>  		int lr, irq;
> +		int nr_lr = vgic_cpu->nr_lr & HWCFG_NR_LR_MASK;
>  
>  		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
> -				 vgic_cpu->nr_lr) {
> +				 nr_lr) {
>  			irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
>  
>  			vgic_irq_clear_active(vcpu, irq);
> @@ -1221,13 +1223,13 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>  	int lr, pending;
> +	int nr_lr = vgic_cpu->nr_lr & HWCFG_NR_LR_MASK;
>  	bool level_pending;
>  
>  	level_pending = vgic_process_maintenance(vcpu);
>  
>  	/* Clear mappings for empty LRs */
> -	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr,
> -			 vgic_cpu->nr_lr) {
> +	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr, nr_lr) {
>  		int irq;
>  
>  		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
> @@ -1241,8 +1243,8 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  
>  	/* Check if we still have something up our sleeve... */
>  	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
> -				      vgic_cpu->nr_lr);
> -	if (level_pending || pending < vgic_cpu->nr_lr)
> +				      nr_lr);
> +	if (level_pending || pending < nr_lr)
>  		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
>  }
>  
> @@ -1438,7 +1440,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  	 */
>  	vgic_cpu->vgic_vmcr = 0;
>  
> -	vgic_cpu->nr_lr = vgic_nr_lr;
> +	vgic_cpu->nr_lr = vgic_hw_cfg;
>  	vgic_cpu->vgic_hcr = GICH_HCR_EN; /* Get the show on the road... */
>  
>  	return 0;
> @@ -1470,17 +1472,33 @@ static struct notifier_block vgic_cpu_nb = {
>  	.notifier_call = vgic_cpu_notify,
>  };
>  
> +static const struct of_device_id of_vgic_ids[] = {
> +	{
> +		.compatible = "arm,cortex-a15-gic",
> +	}, {
> +		.compatible = "hisilicon,hip04-gic",
> +		.data = (void *)HIP04_GICH_APR,
> +	}, {
> +	},
> +};
> +
>  int kvm_vgic_hyp_init(void)
>  {
>  	int ret;
>  	struct resource vctrl_res;
>  	struct resource vcpu_res;
> +	const struct of_device_id *match;
> +	u32 vgic_nr_lr;
>  
> -	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
> +	vgic_node = of_find_matching_node_and_match(NULL, of_vgic_ids, &match);
>  	if (!vgic_node) {
>  		kvm_err("error: no compatible vgic node in DT\n");
>  		return -ENODEV;
>  	}
> +	/* If it's standard ARM GIC, high word in vgic_hw_cfg is 0.
> +	 * Otherwise, it's the offset of non-standard GICH_APR (in HiP04).
> +	 */
> +	vgic_hw_cfg = (unsigned int)match->data << HWCFG_APR_SHIFT;
>  
>  	vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
>  	if (!vgic_maint_irq) {
> @@ -1517,6 +1535,7 @@ int kvm_vgic_hyp_init(void)
>  
>  	vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
>  	vgic_nr_lr = (vgic_nr_lr & 0x3f) + 1;
> +	vgic_hw_cfg |= vgic_nr_lr;
>  
>  	ret = create_hyp_io_mappings(vgic_vctrl_base,
>  				     vgic_vctrl_base + resource_size(&vctrl_res),
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
