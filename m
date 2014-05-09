From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:06:52 +0200
Subject: [PATCH v3 13/19] KVM: ARM: introduce vgic_params structure
In-Reply-To: <1397655591-2761-14-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-14-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140652.GN3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:45PM +0100, Marc Zyngier wrote:
> Move all the data specific to a given GIC implementation into its own
> little structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  include/kvm/arm_vgic.h | 11 +++++++++
>  virt/kvm/arm/vgic.c    | 66 +++++++++++++++++++++-----------------------------
>  2 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 58a938f..23922b9 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -101,6 +101,17 @@ struct vgic_ops {
>  	void	(*enable)(struct kvm_vcpu *vcpu);
>  };
>  
> +struct vgic_params {
> +	/* Physical address of vgic virtual cpu interface */
> +	phys_addr_t	vcpu_base;
> +	/* Number of list registers */
> +	u32		nr_lr;
> +	/* Interrupt number */
> +	unsigned int	maint_irq;
> +	/* Virtual control interface base address */
> +	void __iomem	*vctrl_base;
> +};
> +
>  struct vgic_dist {
>  #ifdef CONFIG_KVM_ARM_VGIC
>  	spinlock_t		lock;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index a6d70fc..c22afce 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -76,14 +76,6 @@
>  #define IMPLEMENTER_ARM		0x43b
>  #define GICC_ARCH_VERSION_V2	0x2
>  
> -/* Physical address of vgic virtual cpu interface */
> -static phys_addr_t vgic_vcpu_base;
> -
> -/* Virtual control interface base address */
> -static void __iomem *vgic_vctrl_base;
> -
> -static struct device_node *vgic_node;
> -
>  #define ACCESS_READ_VALUE	(1 << 0)
>  #define ACCESS_READ_RAZ		(0 << 0)
>  #define ACCESS_READ_MASK(x)	((x) & (1 << 0))
> @@ -103,8 +95,7 @@ static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
>  static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  
> -static u32 vgic_nr_lr;
> -static unsigned int vgic_maint_irq;
> +static struct vgic_params vgic;
>  
>  static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
>  				int cpuid, u32 offset)
> @@ -1183,7 +1174,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int lr;
>  
> -	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
> +	for_each_set_bit(lr, vgic_cpu->lr_used, vgic.nr_lr) {

Does the architecture mandate the same number of list registers per CPU
interface?  Couldn't quickly find this in the spec.

>  		struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>  
>  		if (!vgic_irq_is_enabled(vcpu, vlr.irq)) {
> @@ -1227,8 +1218,8 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  
>  	/* Try to use another LR for this interrupt */
>  	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
> -			       vgic_cpu->nr_lr);
> -	if (lr >= vgic_cpu->nr_lr)
> +			       vgic.nr_lr);
> +	if (lr >= vgic.nr_lr)
>  		return false;
>  
>  	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
> @@ -1354,7 +1345,6 @@ epilog:
>  
>  static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  {
> -	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	u32 status = vgic_get_interrupt_status(vcpu);
>  	bool level_pending = false;
>  
> @@ -1369,8 +1359,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		unsigned long *eisr_ptr = (unsigned long *)&eisr;
>  		int lr;
>  
> -		for_each_set_bit(lr, eisr_ptr, vgic_cpu->nr_lr) {
> -				 vgic_cpu->nr_lr) {
> +		for_each_set_bit(lr, eisr_ptr, vgic.nr_lr) {

ah, compile is happy again

>  			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>  
>  			vgic_irq_clear_active(vcpu, vlr.irq);
> @@ -1409,7 +1398,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  	level_pending = vgic_process_maintenance(vcpu);
>  
>  	/* Clear mappings for empty LRs */
> -	for_each_set_bit(lr, elrsr_ptr, vgic_cpu->nr_lr) {
> +	for_each_set_bit(lr, elrsr_ptr, vgic.nr_lr) {
>  		struct vgic_lr vlr;
>  
>  		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
> @@ -1422,8 +1411,8 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  	}
>  
>  	/* Check if we still have something up our sleeve... */
> -	pending = find_first_zero_bit(elrsr_ptr, vgic_cpu->nr_lr);
> -	if (level_pending || pending < vgic_cpu->nr_lr)
> +	pending = find_first_zero_bit(elrsr_ptr, vgic.nr_lr);
> +	if (level_pending || pending < vgic.nr_lr)
>  		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
>  }
>  
> @@ -1612,7 +1601,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
>  	}
>  
> -	vgic_cpu->nr_lr = vgic_nr_lr;
> +	vgic_cpu->nr_lr = vgic.nr_lr;

why are we setting this is we're keeping this globally and stopped
referring to this all over the code?  assembly code that only has a
vgic_cpu pointer?  If so, comment so new code knows which value to use?

>  
>  	vgic_enable(vcpu);
>  
> @@ -1621,7 +1610,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  
>  static void vgic_init_maintenance_interrupt(void *info)
>  {
> -	enable_percpu_irq(vgic_maint_irq, 0);
> +	enable_percpu_irq(vgic.maint_irq, 0);
>  }
>  
>  static int vgic_cpu_notify(struct notifier_block *self,
> @@ -1634,7 +1623,7 @@ static int vgic_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		disable_percpu_irq(vgic_maint_irq);
> +		disable_percpu_irq(vgic.maint_irq);
>  		break;
>  	}
>  
> @@ -1650,6 +1639,7 @@ int kvm_vgic_hyp_init(void)
>  	int ret;
>  	struct resource vctrl_res;
>  	struct resource vcpu_res;
> +	struct device_node *vgic_node;
>  
>  	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
>  	if (!vgic_node) {
> @@ -1657,17 +1647,17 @@ int kvm_vgic_hyp_init(void)
>  		return -ENODEV;
>  	}
>  
> -	vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
> -	if (!vgic_maint_irq) {
> +	vgic.maint_irq = irq_of_parse_and_map(vgic_node, 0);
> +	if (!vgic.maint_irq) {
>  		kvm_err("error getting vgic maintenance irq from DT\n");
>  		ret = -ENXIO;
>  		goto out;
>  	}
>  
> -	ret = request_percpu_irq(vgic_maint_irq, vgic_maintenance_handler,
> +	ret = request_percpu_irq(vgic.maint_irq, vgic_maintenance_handler,
>  				 "vgic", kvm_get_running_vcpus());
>  	if (ret) {
> -		kvm_err("Cannot register interrupt %d\n", vgic_maint_irq);
> +		kvm_err("Cannot register interrupt %d\n", vgic.maint_irq);
>  		goto out;
>  	}
>  
> @@ -1683,18 +1673,18 @@ int kvm_vgic_hyp_init(void)
>  		goto out_free_irq;
>  	}
>  
> -	vgic_vctrl_base = of_iomap(vgic_node, 2);
> -	if (!vgic_vctrl_base) {
> +	vgic.vctrl_base = of_iomap(vgic_node, 2);
> +	if (!vgic.vctrl_base) {
>  		kvm_err("Cannot ioremap VCTRL\n");
>  		ret = -ENOMEM;
>  		goto out_free_irq;
>  	}
>  
> -	vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
> -	vgic_nr_lr = (vgic_nr_lr & 0x3f) + 1;
> +	vgic.nr_lr = readl_relaxed(vgic.vctrl_base + GICH_VTR);
> +	vgic.nr_lr = (vgic.nr_lr & 0x3f) + 1;
>  
> -	ret = create_hyp_io_mappings(vgic_vctrl_base,
> -				     vgic_vctrl_base + resource_size(&vctrl_res),
> +	ret = create_hyp_io_mappings(vgic.vctrl_base,
> +				     vgic.vctrl_base + resource_size(&vctrl_res),
>  				     vctrl_res.start);
>  	if (ret) {
>  		kvm_err("Cannot map VCTRL into hyp\n");
> @@ -1702,7 +1692,7 @@ int kvm_vgic_hyp_init(void)
>  	}
>  
>  	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
> -		 vctrl_res.start, vgic_maint_irq);
> +		 vctrl_res.start, vgic.maint_irq);
>  	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
>  
>  	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
> @@ -1710,14 +1700,14 @@ int kvm_vgic_hyp_init(void)
>  		ret = -ENXIO;
>  		goto out_unmap;
>  	}
> -	vgic_vcpu_base = vcpu_res.start;
> +	vgic.vcpu_base = vcpu_res.start;
>  
>  	goto out;
>  
>  out_unmap:
> -	iounmap(vgic_vctrl_base);
> +	iounmap(vgic.vctrl_base);
>  out_free_irq:
> -	free_percpu_irq(vgic_maint_irq, kvm_get_running_vcpus());
> +	free_percpu_irq(vgic.maint_irq, kvm_get_running_vcpus());
>  out:
>  	of_node_put(vgic_node);
>  	return ret;
> @@ -1752,7 +1742,7 @@ int kvm_vgic_init(struct kvm *kvm)
>  	}
>  
>  	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
> -				    vgic_vcpu_base, KVM_VGIC_V2_CPU_SIZE);
> +				    vgic.vcpu_base, KVM_VGIC_V2_CPU_SIZE);
>  	if (ret) {
>  		kvm_err("Unable to remap VGIC CPU to VCPU\n");
>  		goto out;
> @@ -1798,7 +1788,7 @@ int kvm_vgic_create(struct kvm *kvm)
>  	}
>  
>  	spin_lock_init(&kvm->arch.vgic.lock);
> -	kvm->arch.vgic.vctrl_base = vgic_vctrl_base;
> +	kvm->arch.vgic.vctrl_base = vgic.vctrl_base;
>  	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>  
> -- 
> 1.8.3.4
> 

Besides the small question,

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
