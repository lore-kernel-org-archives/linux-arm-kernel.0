From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 16:00:12 -0700
Subject: [PATCH v3 19/32] arm64: KVM: Plug the VGIC
In-Reply-To: <1365437854-30214-20-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423230012.GG20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:21PM +0100, Marc Zyngier wrote:
> Add support for the in-kernel GIC emulation. The include file
> is a complete duplicate of the 32bit one - something to fix
> at one point.

seems like something that should be fixed sooner as opposed to later...
Is it hard?

> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_vgic.h | 156 ++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp.S              |  88 +++++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kvm_vgic.h
> 
> diff --git a/arch/arm64/include/asm/kvm_vgic.h b/arch/arm64/include/asm/kvm_vgic.h
> new file mode 100644
> index 0000000..f353f22
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_vgic.h
> @@ -0,0 +1,156 @@
> +/*
> + * Copyright (C) 2012 ARM Ltd.
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
> +#ifndef __ARM64_KVM_VGIC_H
> +#define __ARM64_KVM_VGIC_H
> +
> +#include <linux/kernel.h>
> +#include <linux/kvm.h>
> +#include <linux/irqreturn.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/irqchip/arm-gic.h>
> +
> +#define VGIC_NR_IRQS		128
> +#define VGIC_NR_SGIS		16
> +#define VGIC_NR_PPIS		16
> +#define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
> +#define VGIC_NR_SHARED_IRQS	(VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
> +#define VGIC_MAX_CPUS		KVM_MAX_VCPUS
> +
> +/* Sanity checks... */
> +#if (VGIC_MAX_CPUS > 8)
> +#error	Invalid number of CPU interfaces
> +#endif
> +
> +#if (VGIC_NR_IRQS & 31)
> +#error "VGIC_NR_IRQS must be a multiple of 32"
> +#endif
> +
> +#if (VGIC_NR_IRQS > 1024)
> +#error "VGIC_NR_IRQS must be <= 1024"
> +#endif
> +
> +/*
> + * The GIC distributor registers describing interrupts have two parts:
> + * - 32 per-CPU interrupts (SGI + PPI)
> + * - a bunch of shared interrupts (SPI)
> + */
> +struct vgic_bitmap {
> +	union {
> +		u32 reg[VGIC_NR_PRIVATE_IRQS / 32];
> +		DECLARE_BITMAP(reg_ul, VGIC_NR_PRIVATE_IRQS);
> +	} percpu[VGIC_MAX_CPUS];
> +	union {
> +		u32 reg[VGIC_NR_SHARED_IRQS / 32];
> +		DECLARE_BITMAP(reg_ul, VGIC_NR_SHARED_IRQS);
> +	} shared;
> +};
> +
> +struct vgic_bytemap {
> +	u32 percpu[VGIC_MAX_CPUS][VGIC_NR_PRIVATE_IRQS / 4];
> +	u32 shared[VGIC_NR_SHARED_IRQS  / 4];
> +};
> +
> +struct vgic_dist {
> +	spinlock_t		lock;
> +	bool			ready;
> +
> +	/* Virtual control interface mapping */
> +	void __iomem		*vctrl_base;
> +
> +	/* Distributor and vcpu interface mapping in the guest */
> +	phys_addr_t		vgic_dist_base;
> +	phys_addr_t		vgic_cpu_base;
> +
> +	/* Distributor enabled */
> +	u32			enabled;
> +
> +	/* Interrupt enabled (one bit per IRQ) */
> +	struct vgic_bitmap	irq_enabled;
> +
> +	/* Interrupt 'pin' level */
> +	struct vgic_bitmap	irq_state;
> +
> +	/* Level-triggered interrupt in progress */
> +	struct vgic_bitmap	irq_active;
> +
> +	/* Interrupt priority. Not used yet. */
> +	struct vgic_bytemap	irq_priority;
> +
> +	/* Level/edge triggered */
> +	struct vgic_bitmap	irq_cfg;
> +
> +	/* Source CPU per SGI and target CPU */
> +	u8			irq_sgi_sources[VGIC_MAX_CPUS][16];
> +
> +	/* Target CPU for each IRQ */
> +	u8			irq_spi_cpu[VGIC_NR_SHARED_IRQS];
> +	struct vgic_bitmap	irq_spi_target[VGIC_MAX_CPUS];
> +
> +	/* Bitmap indicating which CPU has something pending */
> +	unsigned long		irq_pending_on_cpu;
> +};
> +
> +struct vgic_cpu {
> +	/* per IRQ to LR mapping */
> +	u8		vgic_irq_lr_map[VGIC_NR_IRQS];
> +
> +	/* Pending interrupts on this VCPU */
> +	DECLARE_BITMAP(	pending_percpu, VGIC_NR_PRIVATE_IRQS);
> +	DECLARE_BITMAP(	pending_shared, VGIC_NR_SHARED_IRQS);
> +
> +	/* Bitmap of used/free list registers */
> +	DECLARE_BITMAP(	lr_used, 64);
> +
> +	/* Number of list registers on this CPU */
> +	int		nr_lr;
> +
> +	/* CPU vif control registers for world switch */
> +	u32		vgic_hcr;
> +	u32		vgic_vmcr;
> +	u32		vgic_misr;	/* Saved only */
> +	u32		vgic_eisr[2];	/* Saved only */
> +	u32		vgic_elrsr[2];	/* Saved only */
> +	u32		vgic_apr;
> +	u32		vgic_lr[64];	/* A15 has only 4... */
> +};
> +
> +#define LR_EMPTY	0xff
> +
> +struct kvm;
> +struct kvm_vcpu;
> +struct kvm_run;
> +struct kvm_exit_mmio;
> +
> +int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr);
> +int kvm_vgic_hyp_init(void);
> +int kvm_vgic_init(struct kvm *kvm);
> +int kvm_vgic_create(struct kvm *kvm);
> +int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
> +void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
> +void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
> +int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
> +			bool level);
> +int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
> +bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +		      struct kvm_exit_mmio *mmio);
> +
> +#define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
> +#define vgic_initialized(k)	((k)->arch.vgic.ready)
> +
> +#endif
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index c745d20..cc3192e 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -306,6 +306,90 @@ __kvm_hyp_code_start:
>  	msr	vttbr_el2, xzr
>  .endm
>  
> +/*
> + * Save the VGIC CPU state into memory
> + * x0: Register pointing to VCPU struct
> + * Do not corrupt x1!!!
> + */
> +.macro save_vgic_state
> +	/* Get VGIC VCTRL base into x2 */
> +	ldr	x2, [x0, #VCPU_KVM]
> +	kern_hyp_va	x2
> +	ldr	x2, [x2, #KVM_VGIC_VCTRL]
> +	kern_hyp_va	x2
> +	cbz	x2, 2f		// disabled
> +
> +	/* Compute the address of struct vgic_cpu */
> +	add	x3, x0, #VCPU_VGIC_CPU
> +
> +	/* Save all interesting registers */
> +	ldr	w4, [x2, #GICH_HCR]
> +	ldr	w5, [x2, #GICH_VMCR]
> +	ldr	w6, [x2, #GICH_MISR]
> +	ldr	w7, [x2, #GICH_EISR0]
> +	ldr	w8, [x2, #GICH_EISR1]
> +	ldr	w9, [x2, #GICH_ELRSR0]
> +	ldr	w10, [x2, #GICH_ELRSR1]
> +	ldr	w11, [x2, #GICH_APR]
> +
> +	str	w4, [x3, #VGIC_CPU_HCR]
> +	str	w5, [x3, #VGIC_CPU_VMCR]
> +	str	w6, [x3, #VGIC_CPU_MISR]
> +	str	w7, [x3, #VGIC_CPU_EISR]
> +	str	w8, [x3, #(VGIC_CPU_EISR + 4)]
> +	str	w9, [x3, #VGIC_CPU_ELRSR]
> +	str	w10, [x3, #(VGIC_CPU_ELRSR + 4)]
> +	str	w11, [x3, #VGIC_CPU_APR]
> +
> +	/* Clear GICH_HCR */
> +	str	wzr, [x2, #GICH_HCR]
> +
> +	/* Save list registers */
> +	add	x2, x2, #GICH_LR0
> +	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	add	x3, x3, #VGIC_CPU_LR
> +1:	ldr	w5, [x2], #4
> +	str	w5, [x3], #4
> +	sub	w4, w4, #1
> +	cbnz	w4, 1b
> +2:
> +.endm
> +
> +/*
> + * Restore the VGIC CPU state from memory
> + * x0: Register pointing to VCPU struct
> + */
> +.macro restore_vgic_state
> +	/* Get VGIC VCTRL base into x2 */
> +	ldr	x2, [x0, #VCPU_KVM]
> +	kern_hyp_va	x2
> +	ldr	x2, [x2, #KVM_VGIC_VCTRL]
> +	kern_hyp_va	x2
> +	cbz	x2, 2f		// disabled
> +
> +	/* Compute the address of struct vgic_cpu */
> +	add	x3, x0, #VCPU_VGIC_CPU
> +
> +	/* We only restore a minimal set of registers */
> +	ldr	w4, [x3, #VGIC_CPU_HCR]
> +	ldr	w5, [x3, #VGIC_CPU_VMCR]
> +	ldr	w6, [x3, #VGIC_CPU_APR]
> +
> +	str	w4, [x2, #GICH_HCR]
> +	str	w5, [x2, #GICH_VMCR]
> +	str	w6, [x2, #GICH_APR]
> +
> +	/* Restore list registers */
> +	add	x2, x2, #GICH_LR0
> +	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	add	x3, x3, #VGIC_CPU_LR
> +1:	ldr	w5, [x3], #4
> +	str	w5, [x2], #4
> +	sub	w4, w4, #1
> +	cbnz	w4, 1b
> +2:
> +.endm
> +
>  __save_sysregs:
>  	save_sysregs
>  	ret
> @@ -348,6 +432,8 @@ ENTRY(__kvm_vcpu_run)
>  	activate_traps
>  	activate_vm
>  
> +	restore_vgic_state
> +
>  	// Guest context
>  	add	x2, x0, #VCPU_CONTEXT
>  
> @@ -370,6 +456,8 @@ __kvm_vcpu_return:
>  	bl __save_fpsimd
>  	bl __save_sysregs
>  
> +	save_vgic_state
> +
>  	deactivate_traps
>  	deactivate_vm
>  
> -- 
> 1.8.1.4
> 
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
