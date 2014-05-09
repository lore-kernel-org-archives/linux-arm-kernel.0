From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:07:01 +0200
Subject: [PATCH v3 14/19] KVM: ARM: vgic: split GICv2 backend from the
 main vgic code
In-Reply-To: <1397655591-2761-15-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140701.GO3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:46PM +0100, Marc Zyngier wrote:
> Brutally hack the innocent vgic code, and move the GICv2 specific code
> to its own file, using vgic_ops and vgic_params as a way to pass
> information between the two blocks.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/Makefile   |   1 +
>  arch/arm64/kvm/Makefile |   2 +-
>  include/kvm/arm_vgic.h  |   3 +
>  virt/kvm/arm/vgic-v2.c  | 229 ++++++++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic.c     | 239 +++++++-----------------------------------------
>  5 files changed, 266 insertions(+), 208 deletions(-)
>  create mode 100644 virt/kvm/arm/vgic-v2.c
> 
> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
> index 789bca9..f7057ed 100644
> --- a/arch/arm/kvm/Makefile
> +++ b/arch/arm/kvm/Makefile
> @@ -21,4 +21,5 @@ obj-y += kvm-arm.o init.o interrupts.o
>  obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
>  obj-y += coproc.o coproc_a15.o coproc_a7.o mmio.o psci.o perf.o
>  obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
> +obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
>  obj-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 72a9fd5..7e92952 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -19,5 +19,5 @@ kvm-$(CONFIG_KVM_ARM_HOST) += emulate.o inject_fault.o regmap.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
>  
> -kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
> +kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o $(KVM)/arm/vgic-v2.o
>  kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 23922b9..d8ec2eb 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -213,6 +213,9 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
>  #define vgic_initialized(k)	((k)->arch.vgic.ready)
>  
> +int vgic_v2_probe(const struct vgic_ops **ops,
> +		  const struct vgic_params **params);
> +
>  #else
>  static inline int kvm_vgic_hyp_init(void)
>  {
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> new file mode 100644
> index 0000000..52f438f
> --- /dev/null
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -0,0 +1,229 @@
> +/*
> + * Copyright (C) 2012,2013 ARM Limited, All Rights Reserved.
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#include <linux/irqchip/arm-gic.h>
> +
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_mmu.h>
> +
> +static struct vgic_lr vgic_v2_get_lr(const struct kvm_vcpu *vcpu, int lr)
> +{
> +	struct vgic_lr lr_desc;
> +	u32 val = vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr];
> +
> +	lr_desc.irq	= val & GICH_LR_VIRTUALID;
> +	lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0xff;
> +	lr_desc.state	= 0;
> +
> +	if (val & GICH_LR_PENDING_BIT)
> +		lr_desc.state |= LR_STATE_PENDING;
> +	if (val & GICH_LR_ACTIVE_BIT)
> +		lr_desc.state |= LR_STATE_ACTIVE;
> +	if (val & GICH_LR_EOI)
> +		lr_desc.state |= LR_EOI_INT;
> +
> +	return lr_desc;
> +}
> +
> +#define MK_LR_PEND(src, irq)	\
> +	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
> +
> +static void vgic_v2_set_lr(struct kvm_vcpu *vcpu, int lr,
> +			   struct vgic_lr lr_desc)
> +{
> +	u32 lr_val = MK_LR_PEND(lr_desc.source, lr_desc.irq);
> +
> +	if (lr_desc.state & LR_STATE_PENDING)
> +		lr_val |= GICH_LR_PENDING_BIT;
> +	if (lr_desc.state & LR_STATE_ACTIVE)
> +		lr_val |= GICH_LR_ACTIVE_BIT;
> +	if (lr_desc.state & LR_EOI_INT)
> +		lr_val |= GICH_LR_EOI;
> +
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr] = lr_val;
> +
> +	/*
> +	 * Despite being EOIed, the LR may not have been marked as
> +	 * empty.
> +	 */
> +	if (!(lr_val & GICH_LR_STATE))
> +		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
> +}
> +
> +static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
> +{
> +	const u32 *elrsr = vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
> +	return *(u64 *)elrsr;
> +}
> +
> +static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
> +{
> +	const u32 *eisr = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
> +	return *(u64 *)eisr;
> +}
> +
> +static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
> +{
> +	u32 misr = vcpu->arch.vgic_cpu.vgic_v2.vgic_misr;
> +	u32 ret = 0;
> +
> +	if (misr & GICH_MISR_EOI)
> +		ret |= INT_STATUS_EOI;
> +	if (misr & GICH_MISR_U)
> +		ret |= INT_STATUS_UNDERFLOW;
> +
> +	return ret;
> +}
> +
> +static void vgic_v2_set_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr |= GICH_HCR_UIE;
> +}
> +
> +static void vgic_v2_clear_underflow(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
> +}
> +
> +static void vgic_v2_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> +{
> +	u32 vmcr = vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr;
> +
> +	vmcrp->ctlr = (vmcr & GICH_VMCR_CTRL_MASK) >> GICH_VMCR_CTRL_SHIFT;
> +	vmcrp->abpr = (vmcr & GICH_VMCR_ALIAS_BINPOINT_MASK) >> GICH_VMCR_ALIAS_BINPOINT_SHIFT;
> +	vmcrp->bpr  = (vmcr & GICH_VMCR_BINPOINT_MASK) >> GICH_VMCR_BINPOINT_SHIFT;
> +	vmcrp->pmr  = (vmcr & GICH_VMCR_PRIMASK_MASK) >> GICH_VMCR_PRIMASK_SHIFT;
> +}
> +
> +static void vgic_v2_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> +{
> +	u32 vmcr;
> +
> +	vmcr  = (vmcrp->ctlr << GICH_VMCR_CTRL_SHIFT) & GICH_VMCR_CTRL_MASK;
> +	vmcr |= (vmcrp->abpr << GICH_VMCR_ALIAS_BINPOINT_SHIFT) & GICH_VMCR_ALIAS_BINPOINT_MASK;
> +	vmcr |= (vmcrp->bpr << GICH_VMCR_BINPOINT_SHIFT) & GICH_VMCR_BINPOINT_MASK;
> +	vmcr |= (vmcrp->pmr << GICH_VMCR_PRIMASK_SHIFT) & GICH_VMCR_PRIMASK_MASK;
> +
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
> +}
> +
> +static void vgic_v2_enable(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * By forcing VMCR to zero, the GIC will restore the binary
> +	 * points to their reset values. Anything else resets to zero
> +	 * anyway.
> +	 */
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = 0;
> +
> +	/* Get the show on the road... */
> +	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr = GICH_HCR_EN;
> +}
> +
> +static const struct vgic_ops vgic_v2_ops = {
> +	.get_lr			= vgic_v2_get_lr,
> +	.set_lr			= vgic_v2_set_lr,
> +	.get_elrsr		= vgic_v2_get_elrsr,
> +	.get_eisr		= vgic_v2_get_eisr,
> +	.get_interrupt_status	= vgic_v2_get_interrupt_status,
> +	.set_underflow		= vgic_v2_set_underflow,
> +	.clear_underflow	= vgic_v2_clear_underflow,
> +	.get_vmcr		= vgic_v2_get_vmcr,
> +	.set_vmcr		= vgic_v2_set_vmcr,
> +	.enable			= vgic_v2_enable,
> +};

relying on all these being copied verbatim from the other file...

> +
> +static struct vgic_params vgic_v2_params;
> +
> +int vgic_v2_probe(const struct vgic_ops **ops,
> +		  const struct vgic_params **params)
> +{

Could you add some kdocs to this function, please?

> +	int ret;
> +	struct resource vctrl_res;
> +	struct resource vcpu_res;
> +	struct device_node *vgic_node;
> +	struct vgic_params *vgic = &vgic_v2_params;
> +
> +	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
> +	if (!vgic_node) {
> +		kvm_err("error: no compatible vgic node in DT\n");
> +		return -ENODEV;
> +	}
> +
> +	vgic->maint_irq = irq_of_parse_and_map(vgic_node, 0);
> +	if (!vgic->maint_irq) {
> +		kvm_err("error getting vgic maintenance irq from DT\n");
> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(vgic_node, 2, &vctrl_res);
> +	if (ret) {
> +		kvm_err("Cannot obtain VCTRL resource\n");
> +		goto out_free_irq;
> +	}
> +
> +	vgic->vctrl_base = of_iomap(vgic_node, 2);
> +	if (!vgic->vctrl_base) {
> +		kvm_err("Cannot ioremap VCTRL\n");
> +		ret = -ENOMEM;
> +		goto out_free_irq;
> +	}
> +
> +	vgic->nr_lr = readl_relaxed(vgic->vctrl_base + GICH_VTR);
> +	vgic->nr_lr = (vgic->nr_lr & 0x3f) + 1;
> +
> +	ret = create_hyp_io_mappings(vgic->vctrl_base,
> +				     vgic->vctrl_base + resource_size(&vctrl_res),
> +				     vctrl_res.start);
> +	if (ret) {
> +		kvm_err("Cannot map VCTRL into hyp\n");
> +		goto out_unmap;
> +	}
> +
> +	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
> +		kvm_err("Cannot obtain VCPU resource\n");
> +		ret = -ENXIO;
> +		goto out_unmap;
> +	}
> +	vgic->vcpu_base = vcpu_res.start;
> +
> +	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
> +		 vctrl_res.start, vgic->maint_irq);
> +
> +	*ops = &vgic_v2_ops;
> +	*params = vgic;
> +	goto out;
> +
> +out_unmap:
> +	iounmap(vgic->vctrl_base);
> +out_free_irq:
> +	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());

shouldn't you only free this if you actually request it?

> +out:
> +	of_node_put(vgic_node);
> +	return ret;
> +}
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index c22afce..613b492 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -95,7 +95,8 @@ static void vgic_set_lr(struct kvm_vcpu *vcpu, int lr, struct vgic_lr lr_desc);
>  static void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>  
> -static struct vgic_params vgic;
> +static const struct vgic_ops *vgic_ops;
> +static const struct vgic_params *vgic;
>  
>  static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
>  				int cpuid, u32 offset)
> @@ -971,182 +972,55 @@ static void vgic_update_state(struct kvm *kvm)
>  	}
>  }
>  
> -static struct vgic_lr vgic_v2_get_lr(const struct kvm_vcpu *vcpu, int lr)
> -{
> -	struct vgic_lr lr_desc;
> -	u32 val = vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr];
> -
> -	lr_desc.irq	= val & GICH_LR_VIRTUALID;
> -	lr_desc.source	= (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0xff;
> -	lr_desc.state	= 0;
> -
> -	if (val & GICH_LR_PENDING_BIT)
> -		lr_desc.state |= LR_STATE_PENDING;
> -	if (val & GICH_LR_ACTIVE_BIT)
> -		lr_desc.state |= LR_STATE_ACTIVE;
> -	if (val & GICH_LR_EOI)
> -		lr_desc.state |= LR_EOI_INT;
> -
> -	return lr_desc;
> -}
> -
> -#define MK_LR_PEND(src, irq)	\
> -	(GICH_LR_PENDING_BIT | ((src) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
> -
> -static void vgic_v2_set_lr(struct kvm_vcpu *vcpu, int lr,
> -			   struct vgic_lr lr_desc)
> -{
> -	u32 lr_val = MK_LR_PEND(lr_desc.source, lr_desc.irq);
> -
> -	if (lr_desc.state & LR_STATE_PENDING)
> -		lr_val |= GICH_LR_PENDING_BIT;
> -	if (lr_desc.state & LR_STATE_ACTIVE)
> -		lr_val |= GICH_LR_ACTIVE_BIT;
> -	if (lr_desc.state & LR_EOI_INT)
> -		lr_val |= GICH_LR_EOI;
> -
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_lr[lr] = lr_val;
> -
> -	/*
> -	 * Despite being EOIed, the LR may not have been marked as
> -	 * empty.
> -	 */
> -	if (!(lr_val & GICH_LR_STATE))
> -		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
> -}
> -
> -static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
> -{
> -	const u32 *elrsr = vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
> -	return *(u64 *)elrsr;
> -}
> -
> -static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
> -{
> -	const u32 *eisr = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
> -	return *(u64 *)eisr;
> -}
> -
> -static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
> -{
> -	u32 misr = vcpu->arch.vgic_cpu.vgic_v2.vgic_misr;
> -	u32 ret = 0;
> -
> -	if (misr & GICH_MISR_EOI)
> -		ret |= INT_STATUS_EOI;
> -	if (misr & GICH_MISR_U)
> -		ret |= INT_STATUS_UNDERFLOW;
> -
> -	return ret;
> -}
> -
> -static void vgic_v2_set_underflow(struct kvm_vcpu *vcpu)
> -{
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr |= GICH_HCR_UIE;
> -}
> -
> -static void vgic_v2_clear_underflow(struct kvm_vcpu *vcpu)
> -{
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr &= ~GICH_HCR_UIE;
> -}
> -
> -static void vgic_v2_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> -{
> -	u32 vmcr = vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr;
> -
> -	vmcrp->ctlr = (vmcr & GICH_VMCR_CTRL_MASK) >> GICH_VMCR_CTRL_SHIFT;
> -	vmcrp->abpr = (vmcr & GICH_VMCR_ALIAS_BINPOINT_MASK) >> GICH_VMCR_ALIAS_BINPOINT_SHIFT;
> -	vmcrp->bpr  = (vmcr & GICH_VMCR_BINPOINT_MASK) >> GICH_VMCR_BINPOINT_SHIFT;
> -	vmcrp->pmr  = (vmcr & GICH_VMCR_PRIMASK_MASK) >> GICH_VMCR_PRIMASK_SHIFT;
> -}
> -
> -static void vgic_v2_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
> -{
> -	u32 vmcr;
> -
> -	vmcr  = (vmcrp->ctlr << GICH_VMCR_CTRL_SHIFT) & GICH_VMCR_CTRL_MASK;
> -	vmcr |= (vmcrp->abpr << GICH_VMCR_ALIAS_BINPOINT_SHIFT) & GICH_VMCR_ALIAS_BINPOINT_MASK;
> -	vmcr |= (vmcrp->bpr << GICH_VMCR_BINPOINT_SHIFT) & GICH_VMCR_BINPOINT_MASK;
> -	vmcr |= (vmcrp->pmr << GICH_VMCR_PRIMASK_SHIFT) & GICH_VMCR_PRIMASK_MASK;
> -
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
> -}
> -
> -static void vgic_v2_enable(struct kvm_vcpu *vcpu)
> -{
> -	/*
> -	 * By forcing VMCR to zero, the GIC will restore the binary
> -	 * points to their reset values. Anything else resets to zero
> -	 * anyway.
> -	 */
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = 0;
> -
> -	/* Get the show on the road... */
> -	vcpu->arch.vgic_cpu.vgic_v2.vgic_hcr = GICH_HCR_EN;
> -}
> -
> -static const struct vgic_ops vgic_ops = {
> -	.get_lr			= vgic_v2_get_lr,
> -	.set_lr			= vgic_v2_set_lr,
> -	.get_elrsr		= vgic_v2_get_elrsr,
> -	.get_eisr		= vgic_v2_get_eisr,
> -	.get_interrupt_status	= vgic_v2_get_interrupt_status,
> -	.set_underflow		= vgic_v2_set_underflow,
> -	.clear_underflow	= vgic_v2_clear_underflow,
> -	.get_vmcr		= vgic_v2_get_vmcr,
> -	.set_vmcr		= vgic_v2_set_vmcr,
> -	.enable			= vgic_v2_enable,
> -};
> -
>  static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
>  {
> -	return vgic_ops.get_lr(vcpu, lr);
> +	return vgic_ops->get_lr(vcpu, lr);
>  }
>  
>  static inline void vgic_set_lr(struct kvm_vcpu *vcpu, int lr,
>  			       struct vgic_lr vlr)
>  {
> -	vgic_ops.set_lr(vcpu, lr, vlr);
> +	vgic_ops->set_lr(vcpu, lr, vlr);
>  }
>  
>  static inline u64 vgic_get_elrsr(struct kvm_vcpu *vcpu)
>  {
> -	return vgic_ops.get_elrsr(vcpu);
> +	return vgic_ops->get_elrsr(vcpu);
>  }
>  
>  static inline u64 vgic_get_eisr(struct kvm_vcpu *vcpu)
>  {
> -	return vgic_ops.get_eisr(vcpu);
> +	return vgic_ops->get_eisr(vcpu);
>  }
>  
>  static inline u32 vgic_get_interrupt_status(struct kvm_vcpu *vcpu)
>  {
> -	return vgic_ops.get_interrupt_status(vcpu);
> +	return vgic_ops->get_interrupt_status(vcpu);
>  }
>  
>  static inline void vgic_set_underflow(struct kvm_vcpu *vcpu)
>  {
> -	vgic_ops.set_underflow(vcpu);
> +	vgic_ops->set_underflow(vcpu);
>  }
>  
>  static inline void vgic_clear_underflow(struct kvm_vcpu *vcpu)
>  {
> -	vgic_ops.clear_underflow(vcpu);
> +	vgic_ops->clear_underflow(vcpu);
>  }
>  
>  static inline void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
>  {
> -	vgic_ops.get_vmcr(vcpu, vmcr);
> +	vgic_ops->get_vmcr(vcpu, vmcr);
>  }
>  
>  static void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
>  {
> -	vgic_ops.set_vmcr(vcpu, vmcr);
> +	vgic_ops->set_vmcr(vcpu, vmcr);
>  }
>  
>  static inline void vgic_enable(struct kvm_vcpu *vcpu)
>  {
> -	vgic_ops.enable(vcpu);
> +	vgic_ops->enable(vcpu);
>  }
>  
>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
> @@ -1174,7 +1048,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>  	int lr;
>  
> -	for_each_set_bit(lr, vgic_cpu->lr_used, vgic.nr_lr) {
> +	for_each_set_bit(lr, vgic_cpu->lr_used, vgic->nr_lr) {
>  		struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>  
>  		if (!vgic_irq_is_enabled(vcpu, vlr.irq)) {
> @@ -1218,8 +1092,8 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
>  
>  	/* Try to use another LR for this interrupt */
>  	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
> -			       vgic.nr_lr);
> -	if (lr >= vgic.nr_lr)
> +			       vgic->nr_lr);
> +	if (lr >= vgic->nr_lr)
>  		return false;
>  
>  	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
> @@ -1359,7 +1233,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
>  		unsigned long *eisr_ptr = (unsigned long *)&eisr;
>  		int lr;
>  
> -		for_each_set_bit(lr, eisr_ptr, vgic.nr_lr) {
> +		for_each_set_bit(lr, eisr_ptr, vgic->nr_lr) {
>  			struct vgic_lr vlr = vgic_get_lr(vcpu, lr);
>  
>  			vgic_irq_clear_active(vcpu, vlr.irq);
> @@ -1398,7 +1272,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  	level_pending = vgic_process_maintenance(vcpu);
>  
>  	/* Clear mappings for empty LRs */
> -	for_each_set_bit(lr, elrsr_ptr, vgic.nr_lr) {
> +	for_each_set_bit(lr, elrsr_ptr, vgic->nr_lr) {
>  		struct vgic_lr vlr;
>  
>  		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
> @@ -1411,8 +1285,8 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>  	}
>  
>  	/* Check if we still have something up our sleeve... */
> -	pending = find_first_zero_bit(elrsr_ptr, vgic.nr_lr);
> -	if (level_pending || pending < vgic.nr_lr)
> +	pending = find_first_zero_bit(elrsr_ptr, vgic->nr_lr);
> +	if (level_pending || pending < vgic->nr_lr)
>  		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
>  }
>  
> @@ -1601,7 +1475,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  		vgic_cpu->vgic_irq_lr_map[i] = LR_EMPTY;
>  	}
>  
> -	vgic_cpu->nr_lr = vgic.nr_lr;
> +	vgic_cpu->nr_lr = vgic->nr_lr;
>  
>  	vgic_enable(vcpu);
>  
> @@ -1610,7 +1484,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  
>  static void vgic_init_maintenance_interrupt(void *info)
>  {
> -	enable_percpu_irq(vgic.maint_irq, 0);
> +	enable_percpu_irq(vgic->maint_irq, 0);
>  }
>  
>  static int vgic_cpu_notify(struct notifier_block *self,
> @@ -1623,7 +1497,7 @@ static int vgic_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		disable_percpu_irq(vgic.maint_irq);
> +		disable_percpu_irq(vgic->maint_irq);
>  		break;
>  	}
>  
> @@ -1637,28 +1511,16 @@ static struct notifier_block vgic_cpu_nb = {
>  int kvm_vgic_hyp_init(void)
>  {
>  	int ret;
> -	struct resource vctrl_res;
> -	struct resource vcpu_res;
> -	struct device_node *vgic_node;
>  
> -	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
> -	if (!vgic_node) {
> -		kvm_err("error: no compatible vgic node in DT\n");
> -		return -ENODEV;
> -	}
> -
> -	vgic.maint_irq = irq_of_parse_and_map(vgic_node, 0);
> -	if (!vgic.maint_irq) {
> -		kvm_err("error getting vgic maintenance irq from DT\n");
> -		ret = -ENXIO;
> -		goto out;
> -	}
> +	ret = vgic_v2_probe(&vgic_ops, &vgic);
> +	if (ret)
> +		return ret;
>  
> -	ret = request_percpu_irq(vgic.maint_irq, vgic_maintenance_handler,
> +	ret = request_percpu_irq(vgic->maint_irq, vgic_maintenance_handler,
>  				 "vgic", kvm_get_running_vcpus());
>  	if (ret) {
> -		kvm_err("Cannot register interrupt %d\n", vgic.maint_irq);
> -		goto out;
> +		kvm_err("Cannot register interrupt %d\n", vgic->maint_irq);
> +		return ret;
>  	}
>  
>  	ret = register_cpu_notifier(&vgic_cpu_nb);
> @@ -1667,49 +1529,12 @@ int kvm_vgic_hyp_init(void)
>  		goto out_free_irq;
>  	}
>  
> -	ret = of_address_to_resource(vgic_node, 2, &vctrl_res);
> -	if (ret) {
> -		kvm_err("Cannot obtain VCTRL resource\n");
> -		goto out_free_irq;
> -	}
> -
> -	vgic.vctrl_base = of_iomap(vgic_node, 2);
> -	if (!vgic.vctrl_base) {
> -		kvm_err("Cannot ioremap VCTRL\n");
> -		ret = -ENOMEM;
> -		goto out_free_irq;
> -	}
> -
> -	vgic.nr_lr = readl_relaxed(vgic.vctrl_base + GICH_VTR);
> -	vgic.nr_lr = (vgic.nr_lr & 0x3f) + 1;
> -
> -	ret = create_hyp_io_mappings(vgic.vctrl_base,
> -				     vgic.vctrl_base + resource_size(&vctrl_res),
> -				     vctrl_res.start);
> -	if (ret) {
> -		kvm_err("Cannot map VCTRL into hyp\n");
> -		goto out_unmap;
> -	}
> -
> -	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
> -		 vctrl_res.start, vgic.maint_irq);
>  	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
>  
> -	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
> -		kvm_err("Cannot obtain VCPU resource\n");
> -		ret = -ENXIO;
> -		goto out_unmap;
> -	}
> -	vgic.vcpu_base = vcpu_res.start;
> -
> -	goto out;
> +	return 0;
>  
> -out_unmap:
> -	iounmap(vgic.vctrl_base);
>  out_free_irq:
> -	free_percpu_irq(vgic.maint_irq, kvm_get_running_vcpus());
> -out:
> -	of_node_put(vgic_node);
> +	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
>  	return ret;
>  }
>  
> @@ -1742,7 +1567,7 @@ int kvm_vgic_init(struct kvm *kvm)
>  	}
>  
>  	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
> -				    vgic.vcpu_base, KVM_VGIC_V2_CPU_SIZE);
> +				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE);

Shouldn't this be factored out to the v2-specific file then?
>  	if (ret) {
>  		kvm_err("Unable to remap VGIC CPU to VCPU\n");
>  		goto out;
> @@ -1788,7 +1613,7 @@ int kvm_vgic_create(struct kvm *kvm)
>  	}
>  
>  	spin_lock_init(&kvm->arch.vgic.lock);
> -	kvm->arch.vgic.vctrl_base = vgic.vctrl_base;
> +	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
>  	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>  	kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>  
> -- 
> 1.8.3.4
> 

Otherwise,

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
