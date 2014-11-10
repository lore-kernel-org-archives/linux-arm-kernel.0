From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 10 Nov 2014 17:30:11 +0000
Subject: [PATCH v3 16/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation / PART 1
In-Reply-To: <20141107143040.GR16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-17-git-send-email-andre.przywara@arm.com>
 <20141107143040.GR16132@cbox>
Message-ID: <5460F623.5060207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej,

I split the reply in two mails to make it easier accessible and reduce
the latency.
Would it make any sense to split the patch, too? Maybe distributor /
redistri

On 07/11/14 14:30, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:51PM +0000, Andre Przywara wrote:
>> With everything separated and prepared, we implement a model of a
>> GICv3 distributor and redistributors by using the existing framework
>> to provide handler functions for each register group.
> 
> new paragraph
> 
>> Currently we limit the emulation to a model enforcing a single
>> security state, with SRE==1 (forcing system register access) and
>> ARE==1 (allowing more than 8 VCPUs).
> 
> new paragraph
> 
>> We share some of functions provided for GICv2 emulation, but take
>> the different ways of addressing (v)CPUs into account.
>> Save and restore is currently not implemented.
>>
>> Similar to the split-off GICv2 specific code, the new emulation code
>> goes into a new file (vgic-v3-emul.c).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/kvm/Makefile            |    1 +
>>  include/kvm/arm_vgic.h             |   10 +-
>>  include/linux/irqchip/arm-gic-v3.h |   26 ++
>>  include/linux/kvm_host.h           |    1 +
>>  include/uapi/linux/kvm.h           |    2 +
>>  virt/kvm/arm/vgic-v3-emul.c        |  891 ++++++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic.c                |   11 +-
>>  virt/kvm/arm/vgic.h                |    3 +
>>  8 files changed, 942 insertions(+), 3 deletions(-)
>>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
>>
>> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
>> index d957353..4e6e09e 100644
>> --- a/arch/arm64/kvm/Makefile
>> +++ b/arch/arm64/kvm/Makefile
>> @@ -24,5 +24,6 @@ kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
>>  kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
>>  kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
>>  kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
>> +kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3-emul.o
>>  kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
>>  kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 8827bc7..c303083 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -160,7 +160,11 @@ struct vgic_dist {
>>
>>       /* Distributor and vcpu interface mapping in the guest */
>>       phys_addr_t             vgic_dist_base;
>> -     phys_addr_t             vgic_cpu_base;
>> +     /* GICv2 and GICv3 use different mapped register blocks */
>> +     union {
>> +             phys_addr_t             vgic_cpu_base;
>> +             phys_addr_t             vgic_redist_base;
>> +     };
>>
>>       /* Distributor enabled */
>>       u32                     enabled;
>> @@ -222,6 +226,9 @@ struct vgic_dist {
>>        */
>>       struct vgic_bitmap      *irq_spi_target;
>>
>> +     /* Target MPIDR for each IRQ (needed for GICv3 IROUTERn) only */
>> +     u32                     *irq_spi_mpidr;
>> +
>>       /* Bitmap indicating which CPU has something pending */
>>       unsigned long           *irq_pending_on_cpu;
>>
>> @@ -297,6 +304,7 @@ void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
>>  void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
>>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>                       bool level);
>> +void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
>>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
>>  bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>                     struct kvm_exit_mmio *mmio);
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 03a4ea3..6a649bc 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -33,6 +33,7 @@
>>  #define GICD_SETSPI_SR                       0x0050
>>  #define GICD_CLRSPI_SR                       0x0058
>>  #define GICD_SEIR                    0x0068
>> +#define GICD_IGROUPR                 0x0080
>>  #define GICD_ISENABLER                       0x0100
>>  #define GICD_ICENABLER                       0x0180
>>  #define GICD_ISPENDR                 0x0200
>> @@ -41,14 +42,31 @@
>>  #define GICD_ICACTIVER                       0x0380
>>  #define GICD_IPRIORITYR                      0x0400
>>  #define GICD_ICFGR                   0x0C00
>> +#define GICD_IGRPMODR                        0x0D00
>> +#define GICD_NSACR                   0x0E00
>>  #define GICD_IROUTER                 0x6000
>> +#define GICD_IDREGS                  0xFFD0
>>  #define GICD_PIDR2                   0xFFE8
>>
>> +/*
>> + * Non-ARE distributor registers, needed to provide the RES0
>> + * semantics for KVM's emulated GICv3
>> + */
> 
> huh?  I think this comment as to do a better job at explaining this, or,
> just go away.
> 
> Why are we re-defining these registers?  Is it just a conincidence that
> the offsets happen to be the same as for GICv2 so it would be
> semantically incorrect to reuse the defines, or?

The header files for GICv2 and v3 are distinct, and v3 does not include
v2. This is what we do in the backend (vgic-v2.c and vgic-v3.c), so I
repeated this here. AFAICT we cannot reuse the v2 definitions easily
other than copying them.
The comment is there because we don't implement the actual GICv2
semantics of these registers, but just the RAZ/WI one.
Will reword the comment to make this more clear.

>> +#define GICD_ITARGETSR                       0x0800
>> +#define GICD_SGIR                    0x0F00
>> +#define GICD_CPENDSGIR                       0x0F10
>> +#define GICD_SPENDSGIR                       0x0F20
>> +
>> +
>>  #define GICD_CTLR_RWP                        (1U << 31)
>> +#define GICD_CTLR_DS                 (1U << 6)
>>  #define GICD_CTLR_ARE_NS             (1U << 4)
>>  #define GICD_CTLR_ENABLE_G1A         (1U << 1)
>>  #define GICD_CTLR_ENABLE_G1          (1U << 0)
>>
>> +#define GICD_TYPER_LPIS                      (1U << 17)
>> +#define GICD_TYPER_MBIS                      (1U << 16)
>> +
>>  #define GICD_IROUTER_SPI_MODE_ONE    (0U << 31)
>>  #define GICD_IROUTER_SPI_MODE_ANY    (1U << 31)
>>
>> @@ -56,6 +74,8 @@
>>  #define GIC_PIDR2_ARCH_GICv3         0x30
>>  #define GIC_PIDR2_ARCH_GICv4         0x40
>>
>> +#define GIC_V3_DIST_SIZE             0x10000
>> +
>>  /*
>>   * Re-Distributor registers, offsets from RD_base
>>   */
>> @@ -74,6 +94,7 @@
>>  #define GICR_SYNCR                   0x00C0
>>  #define GICR_MOVLPIR                 0x0100
>>  #define GICR_MOVALLR                 0x0110
>> +#define GICR_IDREGS                  GICD_IDREGS
>>  #define GICR_PIDR2                   GICD_PIDR2
>>
>>  #define GICR_WAKER_ProcessorSleep    (1U << 1)
>> @@ -82,6 +103,7 @@
>>  /*
>>   * Re-Distributor registers, offsets from SGI_base
>>   */
>> +#define GICR_IGROUPR0                        GICD_IGROUPR
>>  #define GICR_ISENABLER0                      GICD_ISENABLER
>>  #define GICR_ICENABLER0                      GICD_ICENABLER
>>  #define GICR_ISPENDR0                        GICD_ISPENDR
>> @@ -90,10 +112,14 @@
>>  #define GICR_ICACTIVER0                      GICD_ICACTIVER
>>  #define GICR_IPRIORITYR0             GICD_IPRIORITYR
>>  #define GICR_ICFGR0                  GICD_ICFGR
>> +#define GICR_IGRPMODR0                       GICD_IGRPMODR
>> +#define GICR_NSACR                   GICD_NSACR
>>
>>  #define GICR_TYPER_VLPIS             (1U << 1)
>>  #define GICR_TYPER_LAST                      (1U << 4)
>>
>> +#define GIC_V3_REDIST_SIZE           0x20000
>> +
>>  /*
>>   * CPU interface registers
>>   */
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 326ba7a..4a7798e 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1085,6 +1085,7 @@ void kvm_unregister_device_ops(u32 type);
>>  extern struct kvm_device_ops kvm_mpic_ops;
>>  extern struct kvm_device_ops kvm_xics_ops;
>>  extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
>> +extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
>>
>>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 6076882..24cb129 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -960,6 +960,8 @@ enum kvm_device_type {
>>  #define KVM_DEV_TYPE_ARM_VGIC_V2     KVM_DEV_TYPE_ARM_VGIC_V2
>>       KVM_DEV_TYPE_FLIC,
>>  #define KVM_DEV_TYPE_FLIC            KVM_DEV_TYPE_FLIC
>> +     KVM_DEV_TYPE_ARM_VGIC_V3,
>> +#define KVM_DEV_TYPE_ARM_VGIC_V3     KVM_DEV_TYPE_ARM_VGIC_V3
> 
> You need to document this device type in
> Documentation/virtual/kvm/devices/ (probably in arm-vgic.txt).
> 
> That goes for patch 19 as well, but I'll remind you when I look at that
> patch more closely.

Ah right, thanks for the pointer.

>>       KVM_DEV_TYPE_MAX,
>>  };
>>
>> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
>> new file mode 100644
>> index 0000000..bcb5374
>> --- /dev/null
>> +++ b/virt/kvm/arm/vgic-v3-emul.c
>> @@ -0,0 +1,891 @@
>> +/*
>> + * GICv3 distributor and redistributor emulation on GICv3 hardware
>> + *
>> + * able to run on a pure native host GICv3 (which forces ARE=1)
>> + *
>> + * forcing ARE=1 and DS=1, not covering LPIs yet (TYPER.LPIS=0)
> 
> I think the above two lines require rewriting, may I suggest:

You may ... ;-)

> GICv3 emulation is currently only supported on a GICv3 host, but
> supports both hardware with or without the optional GICv2 backwards
> compatibility features.
> 
> We emulate a GICv3 without the backwards compatibility features (meaning
> the emulated GICD_CTLR.ARE resets to 1 and is RAO/WI) and with only a
> single security state (the emulated GICD_CTLR.DS=1, RAO/WI).  This
> emulated GICv3 does not yet include support for LPIs (TYPER.LIPS=0,
> RAZ/WI).
> 
> But pay particular attention to the bit about us emulating a GICv3 with
> only a single security state, because you're implementing GICD_IGROUPR
> and GICR_IGROUPR as RAZ/WI, which is then a limitation of the emulated
> GIC (just like we don't emulate priorities), which is fine, but let's
> then state that as such.
> 
>> + *
>> + * Copyright (C) 2014 ARM Ltd.
>> + * Author: Andre Przywara <andre.przywara@arm.com>
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
>> +
>> +#include <linux/irqchip/arm-gic-v3.h>
>> +#include <kvm/arm_vgic.h>
>> +
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>> +
>> +#include "vgic.h"
>> +
>> +#define INTERRUPT_ID_BITS 10
>> +
>> +static bool handle_mmio_misc(struct kvm_vcpu *vcpu,
>> +                          struct kvm_exit_mmio *mmio, phys_addr_t offset,
>> +                          void *private)
>> +{
>> +     u32 reg = 0, val;
>> +     u32 word_offset = offset & 3;
>> +
>> +     switch (offset & ~3) {
>> +     case GICD_CTLR:
>> +             /*
>> +              * Force ARE and DS to 1, the guest cannot change this.
>> +              * For the time being we only support Group1 interrupts.
>> +              */
>> +             if (vcpu->kvm->arch.vgic.enabled)
>> +                     reg = GICD_CTLR_ENABLE_G1A;
>> +             reg |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
>> +
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                             ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
>> +             if (mmio->is_write) {
>> +                     vcpu->kvm->arch.vgic.enabled = !!(reg & GICD_CTLR_ENABLE_G1A);
> 
>> +                     vgic_update_state(vcpu->kvm);
>> +                     return true;
>> +             }
>> +             break;
> 
> so we don't implement read-as-written for this register, should we at
> least print a warning or something if the guest tries to enable group 0
> interrupts?

Good suggestion.

>> +     case GICD_TYPER:
>> +             /*
>> +              * as this implementation does not provide compatibility
> 
>        Upper-case  ^
> 
>> +              * with GICv2 (ARE==1), we report zero CPUs in the lower 5 bits.
> 
> lower 5 bits?  You mean we report bits [7:5] as 000 right?

Right, thanks for spotting this.

> 
>> +              * Also TYPER.LPIS is 0 for now and TYPER.MBIS is not supported.
> 
> drop the 'for now' just say we report TYPER.LPIS=0 and TYPER.MBIS=0;
> because we don't support LBIs or MBIs.
> 
>> +              */
>> +
>> +             /* claim we support at most 1024 (-4) SPIs via this interface */
> 
> claim?  Does this not hold in reality?  It doesn't seem to be what the
> code does.  I'm doubting the usefulnes of this comment.

I had ITS already in mind, so nr_irqs could be potentially much higher,
but we only report up to 1024/1020 via _this interface_. Not sure if we
would actually use nr_irqs for including LPIs later, but better safe
than sorry.

>> +             val = min(vcpu->kvm->arch.vgic.nr_irqs, 1024);
>> +             reg |= (val >> 5) - 1;
>> +
>> +             reg |= (INTERRUPT_ID_BITS - 1) << 19;
> 
> but it happens that we have no explanation about the arbitrarily chosen
> 10 bits?

To cover the 1020 interrupts that we support at most for now. Will add a
comment about that.

>> +
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                             ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     case GICD_IIDR:
>> +             reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                     ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     default:
>> +             vgic_reg_access(mmio, NULL, word_offset,
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     }
> 
> I'm getting increasingly skeptic about the value of combining these
> registers into a single misc function?

Indeed. That started with a GICv2 copy originally ...

>> +
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_set_enable_reg_dist(struct kvm_vcpu *vcpu,
>> +                                         struct kvm_exit_mmio *mmio,
>> +                                         phys_addr_t offset,
>> +                                         void *private)
>> +{
>> +     if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
>> +             return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
>> +                                           vcpu->vcpu_id,
>> +                                           ACCESS_WRITE_SETBIT);
>> +
>> +     vgic_reg_access(mmio, NULL, offset & 3,
>> +                     ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> 
> Somewhat general question:
> 
> This made me wonder if we check for unaligned accesses anywhere or could
> the guest get away with (offset & 3) = 2 and mmio->len = 4?  Then
> semantics for this would start being weird...

AFAIK non-natural aligned accesses to the GIC are not allowed and are
issuing an alignment exception before trapping on the MMIO access.
This is what the comment in vgic_reg_access() says.

>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_clear_enable_reg_dist(struct kvm_vcpu *vcpu,
>> +                                           struct kvm_exit_mmio *mmio,
>> +                                           phys_addr_t offset,
>> +                                           void *private)
>> +{
>> +     if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
>> +             return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
>> +                                           vcpu->vcpu_id,
>> +                                           ACCESS_WRITE_CLEARBIT);
>> +
>> +     vgic_reg_access(mmio, NULL, offset & 3,
>> +                     ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_set_pending_reg_dist(struct kvm_vcpu *vcpu,
>> +                                          struct kvm_exit_mmio *mmio,
>> +                                          phys_addr_t offset,
>> +                                          void *private)
>> +{
>> +     if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
>> +             return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
>> +                                                vcpu->vcpu_id);
>> +
>> +     vgic_reg_access(mmio, NULL, offset & 3,
>> +                     ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_clear_pending_reg_dist(struct kvm_vcpu *vcpu,
>> +                                            struct kvm_exit_mmio *mmio,
>> +                                            phys_addr_t offset,
>> +                                            void *private)
>> +{
>> +     if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
>> +             return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
>> +                                                  vcpu->vcpu_id);
>> +
>> +     vgic_reg_access(mmio, NULL, offset & 3,
>> +                     ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_priority_reg_dist(struct kvm_vcpu *vcpu,
>> +                                       struct kvm_exit_mmio *mmio,
>> +                                       phys_addr_t offset,
>> +                                       void *private)
>> +{
>> +     u32 *reg;
>> +
>> +     if (unlikely(offset < VGIC_NR_PRIVATE_IRQS)) {
>> +             vgic_reg_access(mmio, NULL, offset & 3,
> 
> Just noticed, you don't need to mask off the upper bits all these places, do you?
> 
> I think it should be consistent with what we do in the v2 emulation.

Right, that's done in vgic_reg_access(). Will remove that.

> The only place you may need to do that is in the handle_mmio_misc function.
> 
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             return false;
>> +     }
>> +
>> +     reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
>> +                                vcpu->vcpu_id, offset);
>> +     vgic_reg_access(mmio, reg, offset,
>> +             ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_cfg_reg_dist(struct kvm_vcpu *vcpu,
>> +                                  struct kvm_exit_mmio *mmio,
>> +                                  phys_addr_t offset,
>> +                                  void *private)
>> +{
>> +     u32 *reg;
>> +
>> +     if (unlikely(offset < VGIC_NR_PRIVATE_IRQS / 4)) {
>> +             vgic_reg_access(mmio, NULL, offset & 3,
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             return false;
>> +     }
>> +
>> +     reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
>> +                               vcpu->vcpu_id, offset >> 1);
>> +
>> +     return vgic_handle_cfg_reg(reg, mmio, offset);
>> +}
>> +
>> +static u32 compress_mpidr(unsigned long mpidr)
> 
> can you comment on this function which format it returns and which
> context that's useful in?

Yes.

>> +{
>> +     u32 ret;
>> +
>> +     ret = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> +     ret |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8;
>> +     ret |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16;
>> +     ret |= MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24;
>> +
>> +     return ret;
>> +}
>> +
>> +static unsigned long uncompress_mpidr(u32 value)
>> +{
>> +     unsigned long mpidr;
>> +
>> +     mpidr = ((value >> 0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
>> +     mpidr |= ((value >> 8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
>> +     mpidr |= ((value >> 16) & 0xFF) << MPIDR_LEVEL_SHIFT(2);
>> +     mpidr |= (u64)((value >> 24) & 0xFF) << MPIDR_LEVEL_SHIFT(3);
>> +
>> +     return mpidr;
>> +}
>> +
>> +/*
>> + * Lookup the given MPIDR value to get the vcpu_id (if there is one)
>> + * and store that in the irq_spi_cpu[] array.
>> + * This limits the number of VCPUs to 255 for now, extending the data
>> + * type (or storing kvm_vcpu poiners) should lift the limit.
>> + * Store the original MPIDR value in an extra array.
> 
> why?  To maintain read-as-written?

Yes. Marc mentioned some use case, I think it was about hot-(un)plugging
CPUs.

>> + * Unallocated MPIDRs are translated to a special value and catched
> 
> s/catched/caught/
> 
>> + * before any array accesses.
>> + */
>> +static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
>> +                               struct kvm_exit_mmio *mmio,
>> +                               phys_addr_t offset, void *private)
>> +{
>> +     struct kvm *kvm = vcpu->kvm;
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +     int irq;
>> +     u32 reg;
>> +     int vcpu_id;
>> +     unsigned long *bmap, mpidr;
>> +     u32 word_offset = offset & 3;
>> +
>> +     /*
>> +      * Private interrupts cannot be re-routed, so this register
>> +      * is RES0 for any IRQ < 32.
>> +      * Also the upper 32 bits of each 64 bit register are zero,
>> +      * as we don't support Aff3 and that's the only value up there.
> 
> drop the rest of the sentence after Aff3.
> 
>> +      */
>> +     if (unlikely(offset < VGIC_NR_PRIVATE_IRQS * 8) || (offset & 4) == 4) {
> 
> you don't need the '== 4' part.
> 
>> +             vgic_reg_access(mmio, NULL, word_offset,
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             return false;
>> +     }
>> +
>> +     irq = (offset / 8) - VGIC_NR_PRIVATE_IRQS;
> 
> can we not call this irq? spi instead maybe?

Yes (to all the four comments above).

>> +
>> +     /* get the stored MPIDR for this IRQ */
>> +     mpidr = uncompress_mpidr(dist->irq_spi_mpidr[irq]);
>> +     mpidr &= MPIDR_HWID_BITMASK;
>> +     reg = mpidr;
>> +
>> +     vgic_reg_access(mmio, &reg, word_offset,
>> +                     ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
>> +
>> +     if (!mmio->is_write)
>> +             return false;
>> +
>> +     /*
>> +      * Now clear the currently assigned vCPU from the map, making room
>> +      * for the new one to be written below
>> +      */
>> +     vcpu = kvm_mpidr_to_vcpu(kvm, mpidr);
>> +     if (likely(vcpu)) {
>> +             vcpu_id = vcpu->vcpu_id;
>> +             bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
>> +             clear_bit(irq, bmap);
> 
> this is the atomic version, right?  is it known to be faster on arm64
> because it's written in assembly and that's why we're using it instead
> of __clear_bit?

No, because I was unaware of the difference when writing this and was
assuming the the non-underscore version is the canonical one.
Inside the vgic lock __clear_bit and __set_bit are safe, right?

>> +     }
>> +
>> +     dist->irq_spi_mpidr[irq] = compress_mpidr(reg);
>> +     vcpu = kvm_mpidr_to_vcpu(kvm, reg & MPIDR_HWID_BITMASK);
>> +
>> +     /*
>> +      * The spec says that non-existent MPIDR values should not be
>> +      * forwarded to any existent (v)CPU, but should be able to become
>> +      * pending anyway. We simply keep the irq_spi_target[] array empty, so
>> +      * the interrupt will never be injected.
>> +      * irq_spi_cpu[irq] gets a magic value in this case.
>> +      */
>> +     if (likely(vcpu)) {
>> +             vcpu_id = vcpu->vcpu_id;
>> +             dist->irq_spi_cpu[irq] = vcpu_id;
>> +             bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
>> +             set_bit(irq, bmap);
> 
> __set_bit ?
> 
>> +     } else
>> +             dist->irq_spi_cpu[irq] = VCPU_NOT_ALLOCATED;
> 
> according to the CodingStyle (and me) this wants braces.
> 
>> +
>> +     vgic_update_state(kvm);
>> +
>> +     return true;
>> +}
>> +
>> +static bool handle_mmio_idregs(struct kvm_vcpu *vcpu,
>> +                            struct kvm_exit_mmio *mmio,
>> +                            phys_addr_t offset, void *private)
>> +{
>> +     u32 reg = 0;
>> +
>> +     switch (offset + GICD_IDREGS) {
>> +     case GICD_PIDR2:
>> +             reg = 0x3b;
>> +             break;
>> +     }
>> +
>> +     vgic_reg_access(mmio, &reg, offset & 3,
>> +                     ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +
>> +     return false;
>> +}
>> +
>> +static const struct mmio_range vgic_dist_ranges[] = {
> 
> can we call this vgic_v3_dist_ranges ?

If that doesn't break the 80 characters limit somewhere: Yes! ;-)

>> +     {       /*
>> +              * handling CTLR, TYPER, IIDR and STATUSR
>> +              */
> 
> this one doesn't need wings (and you're not doing that below)
> 
>> +             .base           = GICD_CTLR,
>> +             .len            = 20,
> 
> nit: why do we specify this len as decimal and the others in hex?
> 
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_misc,
>> +     },
> 
> are we not mentioning the status register here because it's optional?

We will be mentioning this fact in a comment ...

>> +     {
>> +             /* when DS=1, this is RAZ/WI */
>> +             .base           = GICD_SETSPI_SR,
>> +             .len            = 0x04,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             /* when DS=1, this is RAZ/WI */
>> +             .base           = GICD_CLRSPI_SR,
>> +             .len            = 0x04,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
> 
> why are we only listing the _SR versions and not the _NSR versions?

Section 5.3.18 of the GICv3 spec states that this register is RAZ/WI if
GICD_CTLR.DS is one. As we do not implement MSIs from the guest, we omit
the _NSR registers from this list to provoke a MMIO error when they are
used (we have GICD_TYPER.MBIS == 0). The spec does not mention what
happens on an access in this case, though. Will check back with Marc.

>> +     {
>> +             .base           = GICD_IGROUPR,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
> 
> this one may warrant a TODO: Group 0 interrupts not yet supported.

Sure.

>> +     {
>> +             .base           = GICD_ISENABLER,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_set_enable_reg_dist,
>> +     },
>> +     {
>> +             .base           = GICD_ICENABLER,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_clear_enable_reg_dist,
>> +     },
>> +     {
>> +             .base           = GICD_ISPENDR,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_set_pending_reg_dist,
>> +     },
>> +     {
>> +             .base           = GICD_ICPENDR,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_clear_pending_reg_dist,
>> +     },
>> +     {
>> +             .base           = GICD_ISACTIVER,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_ICACTIVER,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_IPRIORITYR,
>> +             .len            = 0x400,
>> +             .bits_per_irq   = 8,
>> +             .handle_mmio    = handle_mmio_priority_reg_dist,
>> +     },
>> +     {
>> +             /* TARGETSRn is RES0 when ARE=1 */
>> +             .base           = GICD_ITARGETSR,
>> +             .len            = 0x400,
>> +             .bits_per_irq   = 8,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_ICFGR,
>> +             .len            = 0x100,
>> +             .bits_per_irq   = 2,
>> +             .handle_mmio    = handle_mmio_cfg_reg_dist,
>> +     },
>> +     {
>> +             /* this is RAZ/WI when DS=1 */
>> +             .base           = GICD_IGRPMODR,
>> +             .len            = 0x80,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             /* with DS==1 this is RAZ/WI */
> 
> any reason why the two comments above are not identical?  (I know, I
> have OCD).

That was left in to check whether you would actually read the middle of
the patch ;-)

Which tempts me to split up the reply here. Will answer the rest of the
comments in a second mail.

Hej Hej,
Andre

P.S.: now you witnessed about 20% of my Danish, the rest is about
various food items you can buy in Marielyst ;-)
