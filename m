From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 May 2014 18:47:44 +0100
Subject: [PATCH v3 18/19] KVM: ARM: vgic: add the GICv3 backend
In-Reply-To: <20140509140731.GS3362@lvm> (Christoffer Dall's message of "Fri,
 9 May 2014 15:07:31 +0100")
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-19-git-send-email-marc.zyngier@arm.com>
 <20140509140731.GS3362@lvm>
Message-ID: <87d2fggslb.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09 2014 at  3:07:31 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Apr 16, 2014 at 02:39:50PM +0100, Marc Zyngier wrote:
>> Introduce the support code for emulating a GICv2 on top of GICv3
>> hardware.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/kvm/arm_vgic.h |  26 ++++++
>>  virt/kvm/arm/vgic-v3.c | 220 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic.c    |   2 +
>>  3 files changed, 248 insertions(+)
>>  create mode 100644 virt/kvm/arm/vgic-v3.c
>>
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index c47dee5..6119a5a 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -32,6 +32,7 @@
>>  #define VGIC_NR_SHARED_IRQS  (VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
>>  #define VGIC_MAX_CPUS                KVM_MAX_VCPUS
>>  #define VGIC_MAX_LRS         (1 << 6)
>
> shouldn't these have been renamed to VGIC_V2_MAX_LRS etc.?

Yup.

>> +#define VGIC_V3_MAX_LRS              16
>>
>>  /* Sanity checks... */
>>  #if (VGIC_MAX_CPUS > 8)
>> @@ -71,6 +72,7 @@ struct kvm_vcpu;
>>
>>  enum vgic_type {
>>       VGIC_V2,                /* Good ol' GICv2 */
>> +     VGIC_V3,                /* v2 on v3, really */
>
> comment maybe a bit too misleading, this is about the hardware, not what
> we emulate.

Indeed.

>>  };
>>
>>  #define LR_STATE_PENDING     (1 << 0)
>> @@ -169,6 +171,19 @@ struct vgic_v2_cpu_if {
>>       u32             vgic_lr[VGIC_MAX_LRS];
>>  };
>>
>> +struct vgic_v3_cpu_if {
>> +#ifdef CONFIG_ARM_GIC_V3
>> +     u32             vgic_hcr;
>> +     u32             vgic_vmcr;
>> +     u32             vgic_misr;      /* Saved only */
>> +     u32             vgic_eisr;      /* Saved only */
>> +     u32             vgic_elrsr;     /* Saved only */
>> +     u32             vgic_ap0r[4];
>> +     u32             vgic_ap1r[4];
>> +     u64             vgic_lr[VGIC_V3_MAX_LRS];
>> +#endif
>> +};
>> +
>>  struct vgic_cpu {
>>  #ifdef CONFIG_KVM_ARM_VGIC
>>       /* per IRQ to LR mapping */
>> @@ -187,6 +202,7 @@ struct vgic_cpu {
>>       /* CPU vif control registers for world switch */
>>       union {
>>               struct vgic_v2_cpu_if   vgic_v2;
>> +             struct vgic_v3_cpu_if   vgic_v3;
>>       };
>>  #endif
>>  };
>> @@ -220,6 +236,16 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>
>>  int vgic_v2_probe(const struct vgic_ops **ops,
>>                 const struct vgic_params **params);
>> +#ifdef CONFIG_ARM_GIC_V3
>> +int vgic_v3_probe(const struct vgic_ops **ops,
>> +               const struct vgic_params **params);
>> +#else
>> +static inline int vgic_v3_probe(const struct vgic_ops **ops,
>> +                             const struct vgic_params **params)
>> +{
>> +     return -ENODEV;
>> +}
>> +#endif
>>
>>  #else
>>  static inline int kvm_vgic_hyp_init(void)
>> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
>> new file mode 100644
>> index 0000000..a804a73
>> --- /dev/null
>> +++ b/virt/kvm/arm/vgic-v3.c
>> @@ -0,0 +1,220 @@
>> +/*
>> + * Copyright (C) 2013 ARM Limited, All Rights Reserved.
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/kvm.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <linux/irqchip/arm-gic-v3.h>
>> +
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>> +
>> +/* These are for GICv2 emulation only */
>
> Is this really true, seems like you're using them to form the lr values
> for the hardware below.
>
>> +#define GICH_LR_VIRTUALID            (0x3ffUL << 0)
>> +#define GICH_LR_PHYSID_CPUID_SHIFT   (10)
>> +#define GICH_LR_PHYSID_CPUID         (7UL << GICH_LR_PHYSID_CPUID_SHIFT)
>
> can't we include them from the existing header file then?

Good point, I'll move them to the GICv3 header.

>> +
>> +static u32 ich_vtr_el2;
>> +
>> +static struct vgic_lr vgic_v3_get_lr(const struct kvm_vcpu *vcpu, int lr)
>> +{
>> +     struct vgic_lr lr_desc;
>> +     u64 val = vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[lr];
>> +
>> +     lr_desc.irq     = val & GICH_LR_VIRTUALID;
>> +     lr_desc.source  = (val >> GICH_LR_PHYSID_CPUID_SHIFT) & 0xff;
>
> isn't this mask only for bits [12:10] which would make it 0x7 ?

Yeah, same crap as the GICv2 version.

>> +     lr_desc.state   = 0;
>> +
>> +     if (val & GICH_LR_PENDING_BIT)
>> +             lr_desc.state |= LR_STATE_PENDING;
>> +     if (val & GICH_LR_ACTIVE_BIT)
>> +             lr_desc.state |= LR_STATE_ACTIVE;
>> +     if (val & GICH_LR_EOI)
>> +             lr_desc.state |= LR_EOI_INT;
>> +
>> +     return lr_desc;
>> +}
>> +
>> +#define MK_LR_PEND(src, irq) \
>> +     (GICH_LR_PENDING_BIT | \
>> +      (((u32)(src)) << GICH_LR_PHYSID_CPUID_SHIFT) | (irq))
>> +
>> +static void vgic_v3_set_lr(struct kvm_vcpu *vcpu, int lr,
>> +                        struct vgic_lr lr_desc)
>> +{
>> +     u64 lr_val = MK_LR_PEND(lr_desc.source, lr_desc.irq);
>> +
>> +     if (lr_desc.state & LR_STATE_PENDING)
>> +             lr_val |= GICH_LR_PENDING_BIT;
>> +     if (lr_desc.state & LR_STATE_ACTIVE)
>> +             lr_val |= GICH_LR_ACTIVE_BIT;
>> +     if (lr_desc.state & LR_EOI_INT)
>> +             lr_val |= GICH_LR_EOI;
>> +
>> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_lr[lr] = lr_val;
>> +
>> +     /*
>> +      * Despite being EOIed, the LR may not have been marked as
>> +      * empty.
>> +      */
>> +     if (!(lr_val & GICH_LR_STATE))
>> +             vcpu->arch.vgic_cpu.vgic_v3.vgic_elrsr |= (1U << lr);
>> +}
>
> these funcitons are _identical_ to those in vgic_v2.  Seems like they
> should share the code when emulating GICv2.

The code is quite similar indeed, but the data types are different,
hence the duplication.

>> +
>> +static u64 vgic_v3_get_elrsr(const struct kvm_vcpu *vcpu)
>> +{
>> +     return vcpu->arch.vgic_cpu.vgic_v3.vgic_elrsr;
>> +}
>> +
>> +static u64 vgic_v3_get_eisr(const struct kvm_vcpu *vcpu)
>> +{
>> +     return vcpu->arch.vgic_cpu.vgic_v3.vgic_eisr;
>> +}
>> +
>> +static u32 vgic_v3_get_interrupt_status(const struct kvm_vcpu *vcpu)
>> +{
>> +     u32 misr = vcpu->arch.vgic_cpu.vgic_v3.vgic_misr;
>> +     u32 ret = 0;
>> +
>> +     if (misr & GICH_MISR_EOI)
>> +             ret |= INT_STATUS_EOI;
>> +     if (misr & GICH_MISR_U)
>> +             ret |= INT_STATUS_UNDERFLOW;
>> +
>> +     return ret;
>> +}
>> +
>> +static void vgic_v3_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>> +{
>> +     u32 vmcr = vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr;
>
> vgic_v3?

Awesome. We got lucky! :-)

>> +
>> +     vmcrp->ctlr = (vmcr & GICH_VMCR_CTLR_MASK) >> GICH_VMCR_CTLR_SHIFT;
>> +     vmcrp->abpr = (vmcr & GICH_VMCR_BPR1_MASK) >> GICH_VMCR_BPR1_SHIFT;
>> +     vmcrp->bpr  = (vmcr & GICH_VMCR_BPR0_MASK) >> GICH_VMCR_BPR0_SHIFT;
>> +     vmcrp->pmr  = (vmcr & GICH_VMCR_PMR_MASK) >> GICH_VMCR_PMR_SHIFT;
>> +}
>> +
>> +static void vgic_v3_clear_underflow(struct kvm_vcpu *vcpu)
>> +{
>> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr &= ~GICH_HCR_UIE;
>> +}
>> +
>> +static void vgic_v3_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcrp)
>> +{
>> +     u32 vmcr;
>> +
>> +     vmcr  = (vmcrp->ctlr << GICH_VMCR_CTLR_SHIFT) & GICH_VMCR_CTLR_MASK;
>> +     vmcr |= (vmcrp->abpr << GICH_VMCR_BPR1_SHIFT) & GICH_VMCR_BPR1_MASK;
>> +     vmcr |= (vmcrp->bpr << GICH_VMCR_BPR0_SHIFT) & GICH_VMCR_BPR0_MASK;
>> +     vmcr |= (vmcrp->pmr << GICH_VMCR_PMR_SHIFT) & GICH_VMCR_PMR_MASK;
>> +
>> +     vcpu->arch.vgic_cpu.vgic_v2.vgic_vmcr = vmcr;
>
> vgic_v3?

Same.

>> +}
>> +
>> +static void vgic_v3_set_underflow(struct kvm_vcpu *vcpu)
>> +{
>> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr |= GICH_HCR_UIE;
>> +}
>
> can you group set/clear underflow please?

Yup.

>> +
>> +static void vgic_v3_enable(struct kvm_vcpu *vcpu)
>> +{
>> +     /*
>> +      * By forcing VMCR to zero, the GIC will restore the binary
>> +      * points to their reset values. Anything else resets to zero
>> +      * anyway.
>> +      */
>> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_vmcr = 0;
>> +
>> +     /* Get the show on the road... */
>> +     vcpu->arch.vgic_cpu.vgic_v3.vgic_hcr = GICH_HCR_EN;
>> +}
>> +
>> +static const struct vgic_ops vgic_v3_ops = {
>> +     .get_lr                 = vgic_v3_get_lr,
>> +     .set_lr                 = vgic_v3_set_lr,
>> +     .get_elrsr              = vgic_v3_get_elrsr,
>> +     .get_eisr               = vgic_v3_get_eisr,
>> +     .get_interrupt_status   = vgic_v3_get_interrupt_status,
>> +     .set_underflow          = vgic_v3_set_underflow,
>> +     .clear_underflow        = vgic_v3_clear_underflow,
>> +     .get_vmcr               = vgic_v3_get_vmcr,
>> +     .set_vmcr               = vgic_v3_set_vmcr,
>> +     .enable                 = vgic_v3_enable,
>> +};
>> +
>> +static struct vgic_params vgic_v3_params;
>> +
>> +int vgic_v3_probe(const struct vgic_ops **ops,
>> +               const struct vgic_params **params)
>> +{
>> +     int ret = 0;
>> +     u32 gicv_idx;
>> +     struct resource vcpu_res;
>> +     struct device_node *vgic_node;
>> +     struct vgic_params *vgic = &vgic_v3_params;
>> +
>> +     vgic_node = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
>> +     if (!vgic_node) {
>> +             kvm_err("error: no compatible GICv3 node in DT\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     vgic->maint_irq = irq_of_parse_and_map(vgic_node, 0);
>> +     if (!vgic->maint_irq) {
>> +             kvm_err("error getting vgic maintenance irq from DT\n");
>> +             ret = -ENXIO;
>> +             goto out;
>> +     }
>> +
>> +     ich_vtr_el2 = kvm_call_hyp(__vgic_v3_get_ich_vtr_el2);
>
> I'm just going to assume this actually returns ich_vtr_el2 for the rest
> of reviewing this patch and hope that I get to see this function in the
> next patch ;)

?$^&*$?$%!!!!! I really need to come up with this script that check each
effin' patch...

>> +
>> +     /*
>> +      * The ListRegs field is 5 bits, but there is a architectural
>> +      * maximum of 16 list registers. Just ignore bit 4...
>> +      */
>> +     vgic->nr_lr = (ich_vtr_el2 & 0xf) + 1;
>> +
>> +     if (of_property_read_u32(vgic_node, "#redistributor-regions", &gicv_idx))
>> +             gicv_idx = 1;
>> +
>> +     gicv_idx += 3; /* Also skip GICD, GICC, GICH */
>> +     if (of_address_to_resource(vgic_node, gicv_idx, &vcpu_res)) {
>> +             kvm_err("Cannot obtain GICV region\n");
>> +             ret = -ENXIO;
>> +             goto out;
>> +     }
>> +     vgic->vcpu_base = vcpu_res.start;
>> +     vgic->vctrl_base = (void *)(-1);
>
> this indicates to me that all mentioning of vctrl_base should be local
> to the vgic_v2 file?

It should, except that vctrl_base is used to implement
irqchip_in_kernel(). I'll change that as well.

>> +     vgic->type = VGIC_V3;
>> +
>> +     kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
>> +              vcpu_res.start, vgic->maint_irq);
>> +
>> +     *ops = &vgic_v3_ops;
>> +     *params = vgic;
>> +
>> +out:
>> +     of_node_put(vgic_node);
>> +     return ret;
>> +}
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 8365189..f29761b 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1514,6 +1514,8 @@ int kvm_vgic_hyp_init(void)
>>
>>       ret = vgic_v2_probe(&vgic_ops, &vgic);
>>       if (ret)
>> +             ret = vgic_v3_probe(&vgic_ops, &vgic);
>
> this doesn't compile for me, missing Makefile include but even when
> adding that, then other stuff breaks and the config option can actually
> be set here... :(
>
>> +     if (ret)
>>               return ret;
>>
>>       ret = request_percpu_irq(vgic->maint_irq, vgic_maintenance_handler,
>> --
>> 1.8.3.4
>>
>
> Please fix the bisectability of this entire series.
>
> I have reviewed the actual functional logic of this patch and have not
> found any issues.
>
> -Christoffer
>

-- 
Jazz is not dead. It just smells funny.
