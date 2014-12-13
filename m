From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 13 Dec 2014 14:37:07 +0100
Subject: [PATCH v5 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <1418042274-3246-16-git-send-email-andre.przywara@arm.com>
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-16-git-send-email-andre.przywara@arm.com>
Message-ID: <20141213133707.GF16855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 12:37:50PM +0000, Andre Przywara wrote:
> With everything separated and prepared, we implement a model of a
> GICv3 distributor and redistributors by using the existing framework
> to provide handler functions for each register group.
> 
> Currently we limit the emulation to a model enforcing a single
> security state, with SRE==1 (forcing system register access) and
> ARE==1 (allowing more than 8 VCPUs).
> 
> We share some of the functions provided for GICv2 emulation, but take
> the different ways of addressing (v)CPUs into account.
> Save and restore is currently not implemented.
> 
> Similar to the split-off of the GICv2 specific code, the new emulation
> code goes into a new file (vgic-v3-emul.c).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v4...v5:
> - correct GICD_IROUTER region length
> - adapt GICv3 specific memory allocation to new init_maps()
> - minor styles changes and fixed comments
> 
> Changelog v3...v4:
> - remove ICC_SGI1R_EL1 register handling (moved into later patch)
> - add definitions for single security state
> - document emulation limitations in vgic-v3-emul.c header
> - move CTLR, TYPER and IIDR handling into separate functions
> - add RAO/WI handling for IGROUPRn registers
> - remove unneeded offset masking on calling vgic_reg_access()
> - rework handle_mmio_route_reg() to only handle SPIs
> - refine IROUTERn register range
> - use non-atomic bitops functions (__clear_bit() and __set_bit())
> - rename vgic_dist_ranges[] to vgic_v3_dist_ranges[]
> - add (RAZ/WI) implementation of GICD_STATUSR
> - add (RAZ/WI) implementations of MBI registers
> - adapt to new private passing (in struct kvm_exit_mmio instead of a paramter)
> - fix vcpu_id calculation bug in handle CFG registers
> - always use hexadecimal numbers for .len member
> - simplify vgic_v3_handle_mmio()
> - add vgic_v3_create() and vgic_v3_destroy()
> - swap vgic_v3_[sg]et_attr() code location
> - add and improve comments
> - (adaptions to changes from earlier patches)
> 
>  arch/arm64/kvm/Makefile            |    1 +
>  include/kvm/arm_vgic.h             |    9 +-
>  include/linux/irqchip/arm-gic-v3.h |   32 ++
>  include/linux/kvm_host.h           |    1 +
>  include/uapi/linux/kvm.h           |    2 +
>  virt/kvm/arm/vgic-v3-emul.c        |  899 ++++++++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic.c                |   11 +-
>  virt/kvm/arm/vgic.h                |    3 +
>  8 files changed, 955 insertions(+), 3 deletions(-)
>  create mode 100644 virt/kvm/arm/vgic-v3-emul.c
> 
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index d957353..4e6e09e 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -24,5 +24,6 @@ kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
>  kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2-emul.o
>  kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
>  kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3.o
> +kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v3-emul.o
>  kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v3-switch.o
>  kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index f7570f83..668d575 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -162,7 +162,11 @@ struct vgic_dist {
>  
>  	/* Distributor and vcpu interface mapping in the guest */
>  	phys_addr_t		vgic_dist_base;
> -	phys_addr_t		vgic_cpu_base;
> +	/* GICv2 and GICv3 use different mapped register blocks */
> +	union {
> +		phys_addr_t		vgic_cpu_base;
> +		phys_addr_t		vgic_redist_base;
> +	};
>  
>  	/* Distributor enabled */
>  	u32			enabled;
> @@ -224,6 +228,9 @@ struct vgic_dist {
>  	 */
>  	struct vgic_bitmap	*irq_spi_target;
>  
> +	/* Target MPIDR for each IRQ (needed for GICv3 IROUTERn) only */
> +	u32			*irq_spi_mpidr;
> +
>  	/* Bitmap indicating which CPU has something pending */
>  	unsigned long		*irq_pending_on_cpu;
>  
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 03a4ea3..726d898 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -33,6 +33,7 @@
>  #define GICD_SETSPI_SR			0x0050
>  #define GICD_CLRSPI_SR			0x0058
>  #define GICD_SEIR			0x0068
> +#define GICD_IGROUPR			0x0080
>  #define GICD_ISENABLER			0x0100
>  #define GICD_ICENABLER			0x0180
>  #define GICD_ISPENDR			0x0200
> @@ -41,14 +42,37 @@
>  #define GICD_ICACTIVER			0x0380
>  #define GICD_IPRIORITYR			0x0400
>  #define GICD_ICFGR			0x0C00
> +#define GICD_IGRPMODR			0x0D00
> +#define GICD_NSACR			0x0E00
>  #define GICD_IROUTER			0x6000
> +#define GICD_IDREGS			0xFFD0
>  #define GICD_PIDR2			0xFFE8
>  
> +/*
> + * Those registers are actually from GICv2, but the spec demands that they
> + * are implemented as RES0 if ARE is 1 (which we do in KVM's emulated GICv3).
> + */
> +#define GICD_ITARGETSR			0x0800
> +#define GICD_SGIR			0x0F00
> +#define GICD_CPENDSGIR			0x0F10
> +#define GICD_SPENDSGIR			0x0F20
> +
>  #define GICD_CTLR_RWP			(1U << 31)
> +#define GICD_CTLR_DS			(1U << 6)
>  #define GICD_CTLR_ARE_NS		(1U << 4)
>  #define GICD_CTLR_ENABLE_G1A		(1U << 1)
>  #define GICD_CTLR_ENABLE_G1		(1U << 0)
>  
> +/*
> + * In systems with a single security state (what we emulate in KVM)
> + * the meaning of the interrupt group enable bits is slightly different
> + */
> +#define GICD_CTLR_ENABLE_SS_G1		(1U << 1)
> +#define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
> +
> +#define GICD_TYPER_LPIS			(1U << 17)
> +#define GICD_TYPER_MBIS			(1U << 16)
> +
>  #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
>  #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
>  
> @@ -56,6 +80,8 @@
>  #define GIC_PIDR2_ARCH_GICv3		0x30
>  #define GIC_PIDR2_ARCH_GICv4		0x40
>  
> +#define GIC_V3_DIST_SIZE		0x10000
> +
>  /*
>   * Re-Distributor registers, offsets from RD_base
>   */
> @@ -74,6 +100,7 @@
>  #define GICR_SYNCR			0x00C0
>  #define GICR_MOVLPIR			0x0100
>  #define GICR_MOVALLR			0x0110
> +#define GICR_IDREGS			GICD_IDREGS
>  #define GICR_PIDR2			GICD_PIDR2
>  
>  #define GICR_WAKER_ProcessorSleep	(1U << 1)
> @@ -82,6 +109,7 @@
>  /*
>   * Re-Distributor registers, offsets from SGI_base
>   */
> +#define GICR_IGROUPR0			GICD_IGROUPR
>  #define GICR_ISENABLER0			GICD_ISENABLER
>  #define GICR_ICENABLER0			GICD_ICENABLER
>  #define GICR_ISPENDR0			GICD_ISPENDR
> @@ -90,10 +118,14 @@
>  #define GICR_ICACTIVER0			GICD_ICACTIVER
>  #define GICR_IPRIORITYR0		GICD_IPRIORITYR
>  #define GICR_ICFGR0			GICD_ICFGR
> +#define GICR_IGRPMODR0			GICD_IGRPMODR
> +#define GICR_NSACR			GICD_NSACR
>  
>  #define GICR_TYPER_VLPIS		(1U << 1)
>  #define GICR_TYPER_LAST			(1U << 4)
>  
> +#define GIC_V3_REDIST_SIZE		0x20000
> +
>  /*
>   * CPU interface registers
>   */
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e674693..b1aa88d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1085,6 +1085,7 @@ void kvm_unregister_device_ops(u32 type);
>  extern struct kvm_device_ops kvm_mpic_ops;
>  extern struct kvm_device_ops kvm_xics_ops;
>  extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
> +extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
>  
>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6076882..24cb129 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -960,6 +960,8 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_ARM_VGIC_V2	KVM_DEV_TYPE_ARM_VGIC_V2
>  	KVM_DEV_TYPE_FLIC,
>  #define KVM_DEV_TYPE_FLIC		KVM_DEV_TYPE_FLIC
> +	KVM_DEV_TYPE_ARM_VGIC_V3,
> +#define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
>  	KVM_DEV_TYPE_MAX,
>  };
>  
> diff --git a/virt/kvm/arm/vgic-v3-emul.c b/virt/kvm/arm/vgic-v3-emul.c
> new file mode 100644
> index 0000000..18af188
> --- /dev/null
> +++ b/virt/kvm/arm/vgic-v3-emul.c
> @@ -0,0 +1,899 @@
> +/*
> + * GICv3 distributor and redistributor emulation
> + *
> + * GICv3 emulation is currently only supported on a GICv3 host (because
> + * we rely on the hardware's CPU interface virtualization support), but
> + * supports both hardware with or without the optional GICv2 backwards
> + * compatibility features.
> + *
> + * Limitations of the emulation:
> + * (RAZ/WI: read as zero, write ignore, RAO/WI: read as one, write ignore)
> + * - We do not support LPIs (yet). TYPER.LPIS is reported as 0 and is RAZ/WI.
> + * - We do not support the message based interrupts (MBIs) triggered by
> + *   writes to the GICD_{SET,CLR}SPI_* registers. TYPER.MBIS is reported as 0.
> + * - We do not support the (optional) backwards compatibility feature.
> + *   GICD_CTLR.ARE resets to 1 and is RAO/WI. If the _host_ GIC supports
> + *   the compatiblity feature, you can use a GICv2 in the guest, though.
> + * - We only support a single security state. GICD_CTLR.DS is 1 and is RAO/WI.
> + * - Priorities are not emulated (same as the GICv2 emulation). Linux
> + *   as a guest is fine with this, because it does not use priorities.
> + * - We only support Group1 interrupts. Again Linux uses only those.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + * Author: Andre Przywara <andre.przywara@arm.com>
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
> +
> +#include <linux/irqchip/arm-gic-v3.h>
> +#include <kvm/arm_vgic.h>
> +
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_mmu.h>
> +
> +#include "vgic.h"
> +
> +static bool handle_mmio_rao_wi(struct kvm_vcpu *vcpu,
> +			       struct kvm_exit_mmio *mmio, phys_addr_t offset)
> +{
> +	u32 reg = 0xffffffff;
> +
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +
> +	return false;
> +}
> +
> +static bool handle_mmio_ctlr(struct kvm_vcpu *vcpu,
> +			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
> +{
> +	u32 reg = 0;
> +
> +	/*
> +	 * Force ARE and DS to 1, the guest cannot change this.
> +	 * For the time being we only support Group1 interrupts.
> +	 */
> +	if (vcpu->kvm->arch.vgic.enabled)
> +		reg = GICD_CTLR_ENABLE_SS_G1;
> +	reg |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
> +
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +	if (mmio->is_write) {
> +		if (reg & GICD_CTLR_ENABLE_SS_G0)
> +			kvm_info("guest tried to enable unsupported Group0 interrupts\n");
> +		vcpu->kvm->arch.vgic.enabled = !!(reg & GICD_CTLR_ENABLE_SS_G1);
> +		vgic_update_state(vcpu->kvm);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * As this implementation does not provide compatibility
> + * with GICv2 (ARE==1), we report zero CPUs in bits [5..7].
> + * Also LPIs and MBIs are not supported, so we set the respective bits to 0.
> + * Also we report at most 2**10=1024 interrupt IDs (to match 1024 SPIs).
> + */
> +#define INTERRUPT_ID_BITS 10
> +static bool handle_mmio_typer(struct kvm_vcpu *vcpu,
> +			      struct kvm_exit_mmio *mmio, phys_addr_t offset)
> +{
> +	u32 reg;
> +
> +	reg = (min(vcpu->kvm->arch.vgic.nr_irqs, 1024) >> 5) - 1;
> +
> +	reg |= (INTERRUPT_ID_BITS - 1) << 19;
> +
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +
> +	return false;
> +}
> +
> +static bool handle_mmio_iidr(struct kvm_vcpu *vcpu,
> +			     struct kvm_exit_mmio *mmio, phys_addr_t offset)
> +{
> +	u32 reg;
> +
> +	reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +
> +	return false;
> +}
> +
> +static bool handle_mmio_set_enable_reg_dist(struct kvm_vcpu *vcpu,
> +					    struct kvm_exit_mmio *mmio,
> +					    phys_addr_t offset)
> +{
> +	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
> +		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
> +					      vcpu->vcpu_id,
> +					      ACCESS_WRITE_SETBIT);
> +
> +	vgic_reg_access(mmio, NULL, offset,
> +			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +	return false;
> +}
> +
> +static bool handle_mmio_clear_enable_reg_dist(struct kvm_vcpu *vcpu,
> +					      struct kvm_exit_mmio *mmio,
> +					      phys_addr_t offset)
> +{
> +	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
> +		return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
> +					      vcpu->vcpu_id,
> +					      ACCESS_WRITE_CLEARBIT);
> +
> +	vgic_reg_access(mmio, NULL, offset,
> +			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +	return false;
> +}
> +
> +static bool handle_mmio_set_pending_reg_dist(struct kvm_vcpu *vcpu,
> +					     struct kvm_exit_mmio *mmio,
> +					     phys_addr_t offset)
> +{
> +	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
> +		return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
> +						   vcpu->vcpu_id);
> +
> +	vgic_reg_access(mmio, NULL, offset,
> +			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +	return false;
> +}
> +
> +static bool handle_mmio_clear_pending_reg_dist(struct kvm_vcpu *vcpu,
> +					       struct kvm_exit_mmio *mmio,
> +					       phys_addr_t offset)
> +{
> +	if (likely(offset >= VGIC_NR_PRIVATE_IRQS / 8))
> +		return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
> +						     vcpu->vcpu_id);
> +
> +	vgic_reg_access(mmio, NULL, offset,
> +			ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +	return false;
> +}
> +
> +static bool handle_mmio_priority_reg_dist(struct kvm_vcpu *vcpu,
> +					  struct kvm_exit_mmio *mmio,
> +					  phys_addr_t offset)
> +{
> +	u32 *reg;
> +
> +	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS)) {
> +		vgic_reg_access(mmio, NULL, offset,
> +				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +		return false;
> +	}
> +
> +	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
> +				   vcpu->vcpu_id, offset);
> +	vgic_reg_access(mmio, reg, offset,
> +		ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +	return false;
> +}
> +
> +static bool handle_mmio_cfg_reg_dist(struct kvm_vcpu *vcpu,
> +				     struct kvm_exit_mmio *mmio,
> +				     phys_addr_t offset)
> +{
> +	u32 *reg;
> +
> +	if (unlikely(offset < VGIC_NR_PRIVATE_IRQS / 4)) {
> +		vgic_reg_access(mmio, NULL, offset,
> +				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +		return false;
> +	}
> +
> +	reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
> +				  vcpu->vcpu_id, offset >> 1);
> +
> +	return vgic_handle_cfg_reg(reg, mmio, offset);
> +}
> +
> +/*
> + * We use a compressed version of the MPIDR (all 32 bits in one 32-bit word)
> + * when we store the target MPIDR written by the guest.
> + */
> +static u32 compress_mpidr(unsigned long mpidr)
> +{
> +	u32 ret;
> +
> +	ret = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8;
> +	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16;
> +	ret |= MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24;
> +
> +	return ret;
> +}
> +
> +static unsigned long uncompress_mpidr(u32 value)
> +{
> +	unsigned long mpidr;
> +
> +	mpidr  = ((value >>  0) & 0xFF) << MPIDR_LEVEL_SHIFT(0);
> +	mpidr |= ((value >>  8) & 0xFF) << MPIDR_LEVEL_SHIFT(1);
> +	mpidr |= ((value >> 16) & 0xFF) << MPIDR_LEVEL_SHIFT(2);
> +	mpidr |= (u64)((value >> 24) & 0xFF) << MPIDR_LEVEL_SHIFT(3);
> +
> +	return mpidr;
> +}
> +
> +/*
> + * Lookup the given MPIDR value to get the vcpu_id (if there is one)
> + * and store that in the irq_spi_cpu[] array.
> + * This limits the number of VCPUs to 255 for now, extending the data
> + * type (or storing kvm_vcpu poiners) should lift the limit.

s/poiners/pointers/

> + * Store the original MPIDR value in an extra array to support read-as-written.
> + * Unallocated MPIDRs are translated to a special value and caught
> + * before any array accesses.
> + */
> +static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
> +				  struct kvm_exit_mmio *mmio,
> +				  phys_addr_t offset)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	int spi;
> +	u32 reg;
> +	int vcpu_id;
> +	unsigned long *bmap, mpidr;
> +
> +	/*
> +	 * The upper 32 bits of each 64 bit register are zero,
> +	 * as we don't support Aff3.
> +	 */
> +	if ((offset & 4)) {
> +		vgic_reg_access(mmio, NULL, offset,
> +				ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> +		return false;
> +	}
> +
> +	/* This region only covers SPIs, so no handling of private IRQs here. */
> +	spi = offset / 8;
> +
> +	/* get the stored MPIDR for this IRQ */
> +	mpidr = uncompress_mpidr(dist->irq_spi_mpidr[spi]);
> +	reg = mpidr;
> +
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +
> +	if (!mmio->is_write)
> +		return false;
> +
> +	/*
> +	 * Now clear the currently assigned vCPU from the map, making room
> +	 * for the new one to be written below
> +	 */
> +	vcpu = kvm_mpidr_to_vcpu(kvm, mpidr);
> +	if (likely(vcpu)) {
> +		vcpu_id = vcpu->vcpu_id;
> +		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
> +		__clear_bit(spi, bmap);
> +	}
> +
> +	dist->irq_spi_mpidr[spi] = compress_mpidr(reg);
> +	vcpu = kvm_mpidr_to_vcpu(kvm, reg & MPIDR_HWID_BITMASK);
> +
> +	/*
> +	 * The spec says that non-existent MPIDR values should not be
> +	 * forwarded to any existent (v)CPU, but should be able to become
> +	 * pending anyway. We simply keep the irq_spi_target[] array empty, so
> +	 * the interrupt will never be injected.
> +	 * irq_spi_cpu[irq] gets a magic value in this case.
> +	 */
> +	if (likely(vcpu)) {
> +		vcpu_id = vcpu->vcpu_id;
> +		dist->irq_spi_cpu[spi] = vcpu_id;
> +		bmap = vgic_bitmap_get_shared_map(&dist->irq_spi_target[vcpu_id]);
> +		__set_bit(spi, bmap);
> +	} else {
> +		dist->irq_spi_cpu[spi] = VCPU_NOT_ALLOCATED;
> +	}
> +
> +	vgic_update_state(kvm);
> +
> +	return true;
> +}
> +
> +/*
> + * We should be careful about promising too much when a guest reads
> + * this register. Don't claim to be like any hardware implementation,
> + * but just report the GIC as version 3 - which is what a Linux guest
> + * would check.
> + */
> +static bool handle_mmio_idregs(struct kvm_vcpu *vcpu,
> +			       struct kvm_exit_mmio *mmio,
> +			       phys_addr_t offset)
> +{
> +	u32 reg = 0;
> +
> +	switch (offset + GICD_IDREGS) {
> +	case GICD_PIDR2:
> +		reg = 0x3b;
> +		break;
> +	}
> +
> +	vgic_reg_access(mmio, &reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> +
> +	return false;
> +}
> +
> +static const struct kvm_mmio_range vgic_v3_dist_ranges[] = {
> +	{
> +		.base           = GICD_CTLR,
> +		.len            = 0x04,
> +		.bits_per_irq   = 0,
> +		.handle_mmio    = handle_mmio_ctlr,
> +	},
> +	{
> +		.base           = GICD_TYPER,
> +		.len            = 0x04,
> +		.bits_per_irq   = 0,
> +		.handle_mmio    = handle_mmio_typer,
> +	},
> +	{
> +		.base           = GICD_IIDR,
> +		.len            = 0x04,
> +		.bits_per_irq   = 0,
> +		.handle_mmio    = handle_mmio_iidr,
> +	},
> +	{
> +		/* this register is optional, it is RAZ/WI if not implemented */
> +		.base           = GICD_STATUSR,
> +		.len            = 0x04,
> +		.bits_per_irq   = 0,
> +		.handle_mmio    = handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this write only register is WI when TYPER.MBIS=0 */
> +		.base		= GICD_SETSPI_NSR,
> +		.len		= 0x04,
> +		.bits_per_irq	= 0,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this write only register is WI when TYPER.MBIS=0 */
> +		.base		= GICD_CLRSPI_NSR,
> +		.len		= 0x04,
> +		.bits_per_irq	= 0,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when DS=1 */
> +		.base		= GICD_SETSPI_SR,
> +		.len		= 0x04,
> +		.bits_per_irq	= 0,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when DS=1 */
> +		.base		= GICD_CLRSPI_SR,
> +		.len		= 0x04,
> +		.bits_per_irq	= 0,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		.base		= GICD_IGROUPR,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_rao_wi,
> +	},
> +	{
> +		.base		= GICD_ISENABLER,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_set_enable_reg_dist,
> +	},
> +	{
> +		.base		= GICD_ICENABLER,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_clear_enable_reg_dist,
> +	},
> +	{
> +		.base		= GICD_ISPENDR,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_set_pending_reg_dist,
> +	},
> +	{
> +		.base		= GICD_ICPENDR,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_clear_pending_reg_dist,
> +	},
> +	{
> +		.base		= GICD_ISACTIVER,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		.base		= GICD_ICACTIVER,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		.base		= GICD_IPRIORITYR,
> +		.len		= 0x400,
> +		.bits_per_irq	= 8,
> +		.handle_mmio	= handle_mmio_priority_reg_dist,
> +	},
> +	{
> +		/* TARGETSRn is RES0 when ARE=1 */
> +		.base		= GICD_ITARGETSR,
> +		.len		= 0x400,
> +		.bits_per_irq	= 8,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		.base		= GICD_ICFGR,
> +		.len		= 0x100,
> +		.bits_per_irq	= 2,
> +		.handle_mmio	= handle_mmio_cfg_reg_dist,
> +	},
> +	{
> +		/* this is RAZ/WI when DS=1 */
> +		.base		= GICD_IGRPMODR,
> +		.len		= 0x80,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when DS=1 */
> +		.base		= GICD_NSACR,
> +		.len		= 0x100,
> +		.bits_per_irq	= 2,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when ARE=1 */
> +		.base		= GICD_SGIR,
> +		.len		= 0x04,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when ARE=1 */
> +		.base		= GICD_CPENDSGIR,
> +		.len		= 0x10,
> +		.handle_mmio	= handle_mmio_raz_wi,
> +	},
> +	{
> +		/* this is RAZ/WI when ARE=1 */
> +		.base           = GICD_SPENDSGIR,
> +		.len            = 0x10,
> +		.handle_mmio    = handle_mmio_raz_wi,
> +	},
> +	{
> +		.base		= GICD_IROUTER + 0x100,
> +		.len		= 0x1ee0,
> +		.bits_per_irq	= 64,
> +		.handle_mmio	= handle_mmio_route_reg,
> +	},
> +	{
> +		.base           = GICD_IDREGS,
> +		.len            = 0x30,
> +		.bits_per_irq   = 0,
> +		.handle_mmio    = handle_mmio_idregs,
> +	},
> +	{},
> +};
> +
> +static bool handle_mmio_set_enable_reg_redist(struct kvm_vcpu *vcpu,
> +					      struct kvm_exit_mmio *mmio,
> +					      phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +
> +	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
> +				      redist_vcpu->vcpu_id,
> +				      ACCESS_WRITE_SETBIT);
> +}
> +
> +static bool handle_mmio_clear_enable_reg_redist(struct kvm_vcpu *vcpu,
> +						struct kvm_exit_mmio *mmio,
> +						phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +
> +	return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
> +				      redist_vcpu->vcpu_id,
> +				      ACCESS_WRITE_CLEARBIT);
> +}
> +
> +static bool handle_mmio_set_pending_reg_redist(struct kvm_vcpu *vcpu,
> +					       struct kvm_exit_mmio *mmio,
> +					       phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +
> +	return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
> +					   redist_vcpu->vcpu_id);
> +}
> +
> +static bool handle_mmio_clear_pending_reg_redist(struct kvm_vcpu *vcpu,
> +						 struct kvm_exit_mmio *mmio,
> +						 phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +
> +	return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
> +					     redist_vcpu->vcpu_id);
> +}
> +
> +static bool handle_mmio_priority_reg_redist(struct kvm_vcpu *vcpu,
> +					    struct kvm_exit_mmio *mmio,
> +					    phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +	u32 *reg;
> +
> +	reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
> +				   redist_vcpu->vcpu_id, offset);
> +	vgic_reg_access(mmio, reg, offset,
> +			ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
> +	return false;
> +}
> +
> +static bool handle_mmio_cfg_reg_redist(struct kvm_vcpu *vcpu,
> +				       struct kvm_exit_mmio *mmio,
> +				       phys_addr_t offset)
> +{
> +	struct kvm_vcpu *redist_vcpu = mmio->private;
> +
> +	u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
> +				       redist_vcpu->vcpu_id, offset >> 1);
> +
> +	return vgic_handle_cfg_reg(reg, mmio, offset);
> +}
> +
> +static const struct kvm_mmio_range vgic_redist_sgi_ranges[] = {
> +	{
> +		.base		= GICR_IGROUPR0,
> +		.len		= 0x04,
> +		.bits_per_irq	= 1,
> +		.handle_mmio	= handle_mmio_raz_wi,

weren't we going to change this to handle_mmio_rao_wi()?

(this is the third time I'm bringing it up)


Assuming you fix the two minor issues above:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
