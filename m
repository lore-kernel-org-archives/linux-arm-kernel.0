From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 18 Nov 2014 15:24:39 +0000
Subject: [PATCH v4 12/19] arm/arm64: KVM: add vgic.h header file
In-Reply-To: <546B529A.7030901@linaro.org>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-13-git-send-email-andre.przywara@arm.com>
 <546B529A.7030901@linaro.org>
Message-ID: <546B64B7.6000208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 18/11/14 14:07, Eric Auger wrote:
> On 11/14/2014 11:07 AM, Andre Przywara wrote:
>> vgic.c is currently a mixture of generic vGIC emulation code and
>> functions specific to emulating a GICv2. To ease the addition of
>> GICv3 later, we create new header file vgic.h, which holds constants
>> and prototypes of commonly used functions.
>> Rename some identifiers to avoid name space clutter.
>> I removed the long-standing comment about using the kvm_io_bus API
>> to tackle the GIC register ranges, as it wouldn't be a win for us
>> anymore.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>
>> -------
>> As the diff isn't always obvious here (and to aid eventual rebases),
>> here is a list of high-level changes done to the code:
>> * moved definitions and prototypes from vgic.c to vgic.h:
>>   - VGIC_ADDR_UNDEF
>>   - ACCESS_{READ,WRITE}_*
>>   - vgic_update_state()
>>   - vgic_kick_vcpus()
>>   - vgic_get_vmcr()
>>   - vgic_set_vmcr()
>>   - struct mmio_range {} (renamed to struct kvm_mmio_range)
>> * removed static keyword and exported prototype in vgic.h:
>>   - vgic_bitmap_get_reg()
>>   - vgic_bitmap_set_irq_val()
>>   - vgic_bitmap_get_shared_map()
>>   - vgic_bytemap_get_reg()
>>   - vgic_dist_irq_set()
>>   - vgic_dist_irq_clear()
>>   - vgic_cpu_irq_clear()
>>   - vgic_reg_access()
>>   - handle_mmio_raz_wi()
>>   - vgic_handle_enable_reg()
>>   - vgic_handle_pending_reg()
>>   - vgic_handle_cfg_reg()
>>   - vgic_unqueue_irqs()
>>   - find_matching_range() (renamed to vgic_find_range)
>>   - vgic_handle_mmio_range()
>>   - vgic_update_state()
>>   - vgic_get_vmcr()
>>   - vgic_set_vmcr()
>>   - vgic_queue_irq()
>>   - vgic_kick_vcpus()
>>   - vgic_init_maps()
>>   - vgic_has_attr_regs()
>>   - vgic_set_common_attr()
>>   - vgic_get_common_attr()
>> * moved functions to vgic.h (static inline):
>>   - mmio_data_read()
>>   - mmio_data_write()
>>   - is_in_range()
>> ---
>> Changelog v3...v4:
>> - rename struct mmio_range to struct kvm_mmio_range
>> - rename find_matching_range() to vgic_find_range()
> Hi Andre,
> 
> It might have helped here to split the patch into 2: first renamings (
> mmio_range, find_matching_range ...) in anticipation and then the move.

Possibly. I didn't make so much sense before, because there was only one
rename, but I may take a look at this again.

> I would rather use kvm_*vgic*_mmio_range to emphasize it is not kvm wide.

I think I shortened it because it broke quite some lines (the type being
mentioned in some function's parameter list).
But I could rename it to vgic_mmio_range to avoid that kvm-wide notion.

>> - remove vgic_create() and vgic_destroy() from header
>>

[ ... ]

>> diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
>> new file mode 100644
>> index 0000000..ff3171a
>> --- /dev/null
>> +++ b/virt/kvm/arm/vgic.h
>> @@ -0,0 +1,119 @@
>> +/*
>> + * Copyright (C) 2012-2014 ARM Ltd.
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from virt/kvm/arm/vgic.c
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
>> +#ifndef __KVM_VGIC_H__
>> +#define __KVM_VGIC_H__
>> +
>> +#define VGIC_ADDR_UNDEF              (-1)
>> +#define IS_VGIC_ADDR_UNDEF(_x)  ((_x) == VGIC_ADDR_UNDEF)
>> +
>> +#define PRODUCT_ID_KVM               0x4b    /* ASCII code K */
>> +#define IMPLEMENTER_ARM              0x43b
>> +
>> +#define ACCESS_READ_VALUE    (1 << 0)
>> +#define ACCESS_READ_RAZ              (0 << 0)
>> +#define ACCESS_READ_MASK(x)  ((x) & (1 << 0))
>> +#define ACCESS_WRITE_IGNORED (0 << 1)
>> +#define ACCESS_WRITE_SETBIT  (1 << 1)
>> +#define ACCESS_WRITE_CLEARBIT        (2 << 1)
>> +#define ACCESS_WRITE_VALUE   (3 << 1)
>> +#define ACCESS_WRITE_MASK(x) ((x) & (3 << 1))
>> +
>> +unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
>> +
>> +void vgic_update_state(struct kvm *kvm);
>> +int vgic_init_maps(struct kvm *kvm);
>> +
>> +u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x, int cpuid, u32 offset);
>> +u32 *vgic_bytemap_get_reg(struct vgic_bytemap *x, int cpuid, u32 offset);
>> +
>> +void vgic_dist_irq_set_pending(struct kvm_vcpu *vcpu, int irq);
>> +void vgic_dist_irq_clear_pending(struct kvm_vcpu *vcpu, int irq);
>> +void vgic_cpu_irq_clear(struct kvm_vcpu *vcpu, int irq);
>> +void vgic_bitmap_set_irq_val(struct vgic_bitmap *x, int cpuid,
>> +                          int irq, int val);
>> +
>> +void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>> +void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr);
>> +
>> +bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq);
>> +void vgic_unqueue_irqs(struct kvm_vcpu *vcpu);
>> +
>> +void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
>> +                  phys_addr_t offset, int mode);
>> +bool handle_mmio_raz_wi(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
>> +                     phys_addr_t offset);
>> +
>> +static inline
>> +u32 mmio_data_read(struct kvm_exit_mmio *mmio, u32 mask)
>> +{
>> +     return le32_to_cpu(*((u32 *)mmio->data)) & mask;
>> +}
>> +
>> +static inline
>> +void mmio_data_write(struct kvm_exit_mmio *mmio, u32 mask, u32 value)
>> +{
>> +     *((u32 *)mmio->data) = cpu_to_le32(value) & mask;
>> +}
>> +
>> +struct kvm_mmio_range {
>> +     phys_addr_t base;
>> +     unsigned long len;
>> +     int bits_per_irq;
>> +     bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
>> +                         phys_addr_t offset);
>> +};
>> +
>> +static inline bool is_in_range(phys_addr_t addr, unsigned long len,
>> +                            phys_addr_t baseaddr, unsigned long size)
>> +{
>> +     return (addr >= baseaddr) && (addr + len <= baseaddr + size);
>> +}
> don't it deserve a renaming too?
> same for mmio_data_write/read? defines?

Those are static inlines in the header file, so they are not visible
outside.

Thanks for taking care!
Andr?

> Best Regards
> 
> Eric
>> +
>> +const
>> +struct kvm_mmio_range *vgic_find_range(const struct kvm_mmio_range *ranges,
>> +                                    struct kvm_exit_mmio *mmio,
>> +                                    phys_addr_t offset);
>> +
>> +bool vgic_handle_mmio_range(struct kvm_vcpu *vcpu, struct kvm_run *run,
>> +                         struct kvm_exit_mmio *mmio,
>> +                         const struct kvm_mmio_range *ranges,
>> +                         unsigned long mmio_base);
>> +
>> +bool vgic_handle_enable_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
>> +                         phys_addr_t offset, int vcpu_id, int access);
>> +
>> +bool vgic_handle_set_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
>> +                              phys_addr_t offset, int vcpu_id);
>> +
>> +bool vgic_handle_clear_pending_reg(struct kvm *kvm, struct kvm_exit_mmio *mmio,
>> +                                phys_addr_t offset, int vcpu_id);
>> +
>> +bool vgic_handle_cfg_reg(u32 *reg, struct kvm_exit_mmio *mmio,
>> +                      phys_addr_t offset);
>> +
>> +void vgic_kick_vcpus(struct kvm *kvm);
>> +
>> +int vgic_has_attr_regs(const struct kvm_mmio_range *ranges, phys_addr_t offset);
>> +int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
>> +int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
>> +
>> +int vgic_v2_init_emulation(struct kvm *kvm);
>> +
>> +#endif
>>
> 
> 
