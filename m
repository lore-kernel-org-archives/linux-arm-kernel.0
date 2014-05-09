From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:07:15 +0200
Subject: [PATCH v3 16/19] arm64: KVM: split GICv2 world switch from hyp
 code
In-Reply-To: <1397655591-2761-17-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140715.GQ3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:48PM +0100, Marc Zyngier wrote:
> Move the GICv2 world switch code into its own file, and add the
> necessary indirection to the arm64 switch code.
> 
> Also introduce a new type field to the vgic_params structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   |   5 ++
>  arch/arm64/include/asm/kvm_asm.h  |   4 ++
>  arch/arm64/include/asm/kvm_host.h |  21 ++++++
>  arch/arm64/kernel/asm-offsets.c   |   3 +
>  arch/arm64/kvm/Makefile           |   4 +-
>  arch/arm64/kvm/hyp.S              | 120 ++++++--------------------------
>  arch/arm64/kvm/vgic-v2-switch.S   | 141 ++++++++++++++++++++++++++++++++++++++
>  include/kvm/arm_vgic.h            |   7 +-
>  virt/kvm/arm/vgic-v2.c            |  15 ++--
>  virt/kvm/arm/vgic.c               |   3 +
>  10 files changed, 213 insertions(+), 110 deletions(-)
>  create mode 100644 arch/arm64/kvm/vgic-v2-switch.S
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 098f7dd..228ae1c 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -222,6 +222,11 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>  	return 0;
>  }
>  
> +static inline void vgic_arch_setup(const struct vgic_params *vgic)
> +{
> +	BUG_ON(vgic->type != VGIC_V2);
> +}
> +
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index dddb345..6515a52 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -104,6 +104,10 @@ extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>  
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
> +
> +extern char __save_vgic_v2_state[];
> +extern char __restore_vgic_v2_state[];
> +
>  #endif
>  
>  #endif /* __ARM_KVM_ASM_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0a1d697..65f0c43 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -200,4 +200,25 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>  		     hyp_stack_ptr, vector_ptr);
>  }
>  
> +struct vgic_sr_vectors {
> +	void	*save_vgic;
> +	void	*restore_vgic;
> +};
> +
> +static inline void vgic_arch_setup(const struct vgic_params *vgic)
> +{
> +	extern struct vgic_sr_vectors __vgic_sr_vectors;
> +
> +	switch(vgic->type)
> +	{
> +	case VGIC_V2:
> +		__vgic_sr_vectors.save_vgic	= __save_vgic_v2_state;
> +		__vgic_sr_vectors.restore_vgic	= __restore_vgic_v2_state;
> +		break;
> +
> +	default:
> +		BUG();
> +	}
> +}
> +
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 20fd488..dafc415 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -129,6 +129,9 @@ int main(void)
>    DEFINE(KVM_TIMER_ENABLED,	offsetof(struct kvm, arch.timer.enabled));
>    DEFINE(VCPU_KVM,		offsetof(struct kvm_vcpu, kvm));
>    DEFINE(VCPU_VGIC_CPU,		offsetof(struct kvm_vcpu, arch.vgic_cpu));
> +  DEFINE(VGIC_SAVE_FN,		offsetof(struct vgic_sr_vectors, save_vgic));
> +  DEFINE(VGIC_RESTORE_FN,	offsetof(struct vgic_sr_vectors, restore_vgic));
> +  DEFINE(VGIC_SR_VECTOR_SZ,	sizeof(struct vgic_sr_vectors));
>    DEFINE(VGIC_V2_CPU_HCR,	offsetof(struct vgic_cpu, vgic_v2.vgic_hcr));
>    DEFINE(VGIC_V2_CPU_VMCR,	offsetof(struct vgic_cpu, vgic_v2.vgic_vmcr));
>    DEFINE(VGIC_V2_CPU_MISR,	offsetof(struct vgic_cpu, vgic_v2.vgic_misr));
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 7e92952..daf24dc 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -19,5 +19,7 @@ kvm-$(CONFIG_KVM_ARM_HOST) += emulate.o inject_fault.o regmap.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += hyp.o hyp-init.o handle_exit.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += guest.o reset.o sys_regs.o sys_regs_generic_v8.o
>  
> -kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o $(KVM)/arm/vgic-v2.o
> +kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
> +kvm-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic-v2.o
> +kvm-$(CONFIG_KVM_ARM_VGIC) += vgic-v2-switch.o
>  kvm-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 9e3364b..aed72d0 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -16,7 +16,6 @@
>   */
>  
>  #include <linux/linkage.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/assembler.h>
>  #include <asm/memory.h>
> @@ -375,103 +374,6 @@
>  	msr	vttbr_el2, xzr
>  .endm
>  
> -/*
> - * Save the VGIC CPU state into memory
> - * x0: Register pointing to VCPU struct
> - * Do not corrupt x1!!!
> - */
> -.macro save_vgic_state
> -	/* Get VGIC VCTRL base into x2 */
> -	ldr	x2, [x0, #VCPU_KVM]
> -	kern_hyp_va	x2
> -	ldr	x2, [x2, #KVM_VGIC_VCTRL]
> -	kern_hyp_va	x2
> -	cbz	x2, 2f		// disabled
> -
> -	/* Compute the address of struct vgic_cpu */
> -	add	x3, x0, #VCPU_VGIC_CPU
> -
> -	/* Save all interesting registers */
> -	ldr	w4, [x2, #GICH_HCR]
> -	ldr	w5, [x2, #GICH_VMCR]
> -	ldr	w6, [x2, #GICH_MISR]
> -	ldr	w7, [x2, #GICH_EISR0]
> -	ldr	w8, [x2, #GICH_EISR1]
> -	ldr	w9, [x2, #GICH_ELRSR0]
> -	ldr	w10, [x2, #GICH_ELRSR1]
> -	ldr	w11, [x2, #GICH_APR]
> -CPU_BE(	rev	w4,  w4  )
> -CPU_BE(	rev	w5,  w5  )
> -CPU_BE(	rev	w6,  w6  )
> -CPU_BE(	rev	w7,  w7  )
> -CPU_BE(	rev	w8,  w8  )
> -CPU_BE(	rev	w9,  w9  )
> -CPU_BE(	rev	w10, w10 )
> -CPU_BE(	rev	w11, w11 )
> -
> -	str	w4, [x3, #VGIC_V2_CPU_HCR]
> -	str	w5, [x3, #VGIC_V2_CPU_VMCR]
> -	str	w6, [x3, #VGIC_V2_CPU_MISR]
> -	str	w7, [x3, #VGIC_V2_CPU_EISR]
> -	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
> -	str	w9, [x3, #VGIC_V2_CPU_ELRSR]
> -	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
> -	str	w11, [x3, #VGIC_V2_CPU_APR]
> -
> -	/* Clear GICH_HCR */
> -	str	wzr, [x2, #GICH_HCR]
> -
> -	/* Save list registers */
> -	add	x2, x2, #GICH_LR0
> -	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> -	add	x3, x3, #VGIC_V2_CPU_LR
> -1:	ldr	w5, [x2], #4
> -CPU_BE(	rev	w5, w5 )
> -	str	w5, [x3], #4
> -	sub	w4, w4, #1
> -	cbnz	w4, 1b
> -2:
> -.endm
> -
> -/*
> - * Restore the VGIC CPU state from memory
> - * x0: Register pointing to VCPU struct
> - */
> -.macro restore_vgic_state
> -	/* Get VGIC VCTRL base into x2 */
> -	ldr	x2, [x0, #VCPU_KVM]
> -	kern_hyp_va	x2
> -	ldr	x2, [x2, #KVM_VGIC_VCTRL]
> -	kern_hyp_va	x2
> -	cbz	x2, 2f		// disabled
> -
> -	/* Compute the address of struct vgic_cpu */
> -	add	x3, x0, #VCPU_VGIC_CPU
> -
> -	/* We only restore a minimal set of registers */
> -	ldr	w4, [x3, #VGIC_V2_CPU_HCR]
> -	ldr	w5, [x3, #VGIC_V2_CPU_VMCR]
> -	ldr	w6, [x3, #VGIC_V2_CPU_APR]
> -CPU_BE(	rev	w4, w4 )
> -CPU_BE(	rev	w5, w5 )
> -CPU_BE(	rev	w6, w6 )
> -
> -	str	w4, [x2, #GICH_HCR]
> -	str	w5, [x2, #GICH_VMCR]
> -	str	w6, [x2, #GICH_APR]
> -
> -	/* Restore list registers */
> -	add	x2, x2, #GICH_LR0
> -	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> -	add	x3, x3, #VGIC_V2_CPU_LR
> -1:	ldr	w5, [x3], #4
> -CPU_BE(	rev	w5, w5 )
> -	str	w5, [x2], #4
> -	sub	w4, w4, #1
> -	cbnz	w4, 1b
> -2:
> -.endm
> -
>  .macro save_timer_state
>  	// x0: vcpu pointer
>  	ldr	x2, [x0, #VCPU_KVM]
> @@ -568,7 +470,10 @@ ENTRY(__kvm_vcpu_run)
>  	activate_traps
>  	activate_vm
>  
> -	restore_vgic_state
> +	adr	x24, __vgic_sr_vectors
> +	ldr	x24, [x24, #VGIC_RESTORE_FN]
> +	kern_hyp_va	x24
> +	blr	x24

could you not keep the restore_vgic_state macro name that expands to
these four lines; the Hyp code was so pretty and compact before this
mess ;)

>  	restore_timer_state
>  
>  	// Guest context
> @@ -595,7 +500,10 @@ __kvm_vcpu_return:
>  	save_guest_32bit_state
>  
>  	save_timer_state
> -	save_vgic_state
> +	adr	x24, __vgic_sr_vectors
> +	ldr	x24, [x24, VGIC_SAVE_FN]
> +	kern_hyp_va	x24
> +	blr	x24
>  
>  	deactivate_traps
>  	deactivate_vm
> @@ -644,6 +552,12 @@ ENTRY(__kvm_flush_vm_context)
>  	ret
>  ENDPROC(__kvm_flush_vm_context)
>  
> +	// struct vgic_sr_vectors __vgi_sr_vectors;
> +	.align 3
> +ENTRY(__vgic_sr_vectors)
> +	.skip	VGIC_SR_VECTOR_SZ
> +ENDPROC(__vgic_sr_vectors)
> +
>  __kvm_hyp_panic:
>  	// Guess the context by looking at VTTBR:
>  	// If zero, then we're already a host.
> @@ -653,6 +567,12 @@ __kvm_hyp_panic:
>  
>  	mrs	x0, tpidr_el2
>  
> +	save_timer_state
> +	adr	x24, __vgic_sr_vectors
> +	ldr	x24, [x24, VGIC_SAVE_FN]
> +	kern_hyp_va	x24
> +	blr	x24
> +

why are we doing this?  If something bad happened, aren't we just trying
to get to print a panic string with as little in our way as possible?

I could see it if we were also restoring the host state, but this seems
faily pointless...

>  	deactivate_traps
>  	deactivate_vm
>  
> diff --git a/arch/arm64/kvm/vgic-v2-switch.S b/arch/arm64/kvm/vgic-v2-switch.S
> new file mode 100644
> index 0000000..c5dc777
> --- /dev/null
> +++ b/arch/arm64/kvm/vgic-v2-switch.S
> @@ -0,0 +1,141 @@
> +/*
> + * Copyright (C) 2012,2013 - ARM Ltd
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
> +#include <linux/linkage.h>
> +#include <linux/irqchip/arm-gic.h>
> +
> +#include <asm/assembler.h>
> +#include <asm/memory.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/kvm.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_mmu.h>
> +
> +	.text
> +	.pushsection	.hyp.text, "ax"
> +
> +/*
> + * Save the VGIC CPU state into memory
> + * x0: Register pointing to VCPU struct
> + * Do not corrupt x1!!!
> + */
> +.macro save_vgic_v2_state
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
> +CPU_BE(	rev	w4,  w4  )
> +CPU_BE(	rev	w5,  w5  )
> +CPU_BE(	rev	w6,  w6  )
> +CPU_BE(	rev	w7,  w7  )
> +CPU_BE(	rev	w8,  w8  )
> +CPU_BE(	rev	w9,  w9  )
> +CPU_BE(	rev	w10, w10 )
> +CPU_BE(	rev	w11, w11 )
> +
> +	str	w4, [x3, #VGIC_V2_CPU_HCR]
> +	str	w5, [x3, #VGIC_V2_CPU_VMCR]
> +	str	w6, [x3, #VGIC_V2_CPU_MISR]
> +	str	w7, [x3, #VGIC_V2_CPU_EISR]
> +	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
> +	str	w9, [x3, #VGIC_V2_CPU_ELRSR]
> +	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
> +	str	w11, [x3, #VGIC_V2_CPU_APR]
> +
> +	/* Clear GICH_HCR */
> +	str	wzr, [x2, #GICH_HCR]
> +
> +	/* Save list registers */
> +	add	x2, x2, #GICH_LR0
> +	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	add	x3, x3, #VGIC_V2_CPU_LR
> +1:	ldr	w5, [x2], #4
> +CPU_BE(	rev	w5, w5 )
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
> +.macro restore_vgic_v2_state
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
> +	ldr	w4, [x3, #VGIC_V2_CPU_HCR]
> +	ldr	w5, [x3, #VGIC_V2_CPU_VMCR]
> +	ldr	w6, [x3, #VGIC_V2_CPU_APR]
> +CPU_BE(	rev	w4, w4 )
> +CPU_BE(	rev	w5, w5 )
> +CPU_BE(	rev	w6, w6 )
> +
> +	str	w4, [x2, #GICH_HCR]
> +	str	w5, [x2, #GICH_VMCR]
> +	str	w6, [x2, #GICH_APR]
> +
> +	/* Restore list registers */
> +	add	x2, x2, #GICH_LR0
> +	ldr	w4, [x3, #VGIC_CPU_NR_LR]
> +	add	x3, x3, #VGIC_V2_CPU_LR
> +1:	ldr	w5, [x3], #4
> +CPU_BE(	rev	w5, w5 )
> +	str	w5, [x2], #4
> +	sub	w4, w4, #1
> +	cbnz	w4, 1b
> +2:
> +.endm

again relying on this being copied verbatim from the other file

> +
> +ENTRY(__save_vgic_v2_state)
> +	save_vgic_v2_state
> +	ret
> +ENDPROC(__save_vgic_v2_state)
> +
> +ENTRY(__restore_vgic_v2_state)
> +__restore_vgic_v2_state:
> +	restore_vgic_v2_state
> +	ret
> +ENDPROC(__restore_vgic_v2_state)

why the macro indirection, couldn't we just have the code be the
functions?

> +
> +
> +	.popsection
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index d8ec2eb..c47dee5 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -24,7 +24,6 @@
>  #include <linux/irqreturn.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #define VGIC_NR_IRQS		256
>  #define VGIC_NR_SGIS		16
> @@ -70,6 +69,10 @@ struct vgic_bytemap {
>  
>  struct kvm_vcpu;
>  
> +enum vgic_type {
> +	VGIC_V2,		/* Good ol' GICv2 */

love it ;)

> +};
> +
>  #define LR_STATE_PENDING	(1 << 0)
>  #define LR_STATE_ACTIVE		(1 << 1)
>  #define LR_STATE_MASK		(3 << 0)
> @@ -102,6 +105,8 @@ struct vgic_ops {
>  };
>  
>  struct vgic_params {
> +	/* vgic type */
> +	enum vgic_type	type;
>  	/* Physical address of vgic virtual cpu interface */
>  	phys_addr_t	vcpu_base;
>  	/* Number of list registers */
> diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
> index 52f438f..4c6606e 100644
> --- a/virt/kvm/arm/vgic-v2.c
> +++ b/virt/kvm/arm/vgic-v2.c
> @@ -170,7 +170,7 @@ int vgic_v2_probe(const struct vgic_ops **ops,
>  
>  	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
>  	if (!vgic_node) {
> -		kvm_err("error: no compatible vgic node in DT\n");
> +		kvm_err("error: no compatible GICv2 node in DT\n");
>  		return -ENODEV;
>  	}
>  
> @@ -183,15 +183,15 @@ int vgic_v2_probe(const struct vgic_ops **ops,
>  
>  	ret = of_address_to_resource(vgic_node, 2, &vctrl_res);
>  	if (ret) {
> -		kvm_err("Cannot obtain VCTRL resource\n");
> -		goto out_free_irq;
> +		kvm_err("Cannot obtain GICH resource\n");
> +		goto out;

changing these labels and getting rid of the out_free_irq seems like it
should be part of the previous patch.

>  	}
>  
>  	vgic->vctrl_base = of_iomap(vgic_node, 2);
>  	if (!vgic->vctrl_base) {
> -		kvm_err("Cannot ioremap VCTRL\n");
> +		kvm_err("Cannot ioremap GICH\n");
>  		ret = -ENOMEM;
> -		goto out_free_irq;
> +		goto out;
>  	}
>  
>  	vgic->nr_lr = readl_relaxed(vgic->vctrl_base + GICH_VTR);
> @@ -206,7 +206,7 @@ int vgic_v2_probe(const struct vgic_ops **ops,
>  	}
>  
>  	if (of_address_to_resource(vgic_node, 3, &vcpu_res)) {
> -		kvm_err("Cannot obtain VCPU resource\n");
> +		kvm_err("Cannot obtain GICV resource\n");
>  		ret = -ENXIO;
>  		goto out_unmap;
>  	}
> @@ -215,14 +215,13 @@ int vgic_v2_probe(const struct vgic_ops **ops,
>  	kvm_info("%s@%llx IRQ%d\n", vgic_node->name,
>  		 vctrl_res.start, vgic->maint_irq);
>  
> +	vgic->type = VGIC_V2;
>  	*ops = &vgic_v2_ops;
>  	*params = vgic;
>  	goto out;
>  
>  out_unmap:
>  	iounmap(vgic->vctrl_base);
> -out_free_irq:
> -	free_percpu_irq(vgic->maint_irq, kvm_get_running_vcpus());
>  out:
>  	of_node_put(vgic_node);
>  	return ret;
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 613b492..8365189 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1531,6 +1531,9 @@ int kvm_vgic_hyp_init(void)
>  
>  	on_each_cpu(vgic_init_maintenance_interrupt, NULL, 1);
>  
> +	/* Callback into for arch code for setup */
> +	vgic_arch_setup(vgic);
> +
>  	return 0;
>  
>  out_free_irq:
> -- 
> 1.8.3.4
> 

-Christoffer
