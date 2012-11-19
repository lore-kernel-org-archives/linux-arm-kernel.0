From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:41:10 +0000
Subject: [PATCH v4 04/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20121110154238.2836.74915.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154238.2836.74915.stgit@chazy-air>
Message-ID: <20121119144110.GW3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:42:38PM +0000, Christoffer Dall wrote:
> Targets KVM support for Cortex A-15 processors.
> 
> Contains all the framework components, make files, header files, some
> tracing functionality, and basic user space API.
> 
> Only supported core is Cortex-A15 for now.
> 
> Most functionality is in arch/arm/kvm/* or arch/arm/include/asm/kvm_*.h.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

[...]

>  4.69 KVM_GET_ONE_REG
> 
>  Capability: KVM_CAP_ONE_REG
> @@ -1791,6 +1800,7 @@ The list of registers accessible using this interface is identical to the
>  list in 4.68.
> 
> 
> +

Whitespace.

>  4.70 KVM_KVMCLOCK_CTRL
> 
>  Capability: KVM_CAP_KVMCLOCK_CTRL
> @@ -2072,6 +2082,46 @@ KVM_S390_INT_EXTERNAL_CALL (vcpu) - sigp external call; source cpu in parm
>  Note that the vcpu ioctl is asynchronous to vcpu execution.
> 
> 
> +4.77 KVM_ARM_VCPU_INIT
> +
> +Capability: basic
> +Architectures: arm
> +Type: vcpu ioctl
> +Parameters: struct struct kvm_vcpu_init (in)
> +Returns: 0 on success; -1 on error
> +Errors:
> +  EINVAL:    the target is unknown, or the combination of features is invalid.
> +  ENOENT:    a features bit specified is unknown.
> +
> +This tells KVM what type of CPU to present to the guest, and what
> +optional features it should have.  This will cause a reset of the cpu
> +registers to their initial values.  If this is not called, KVM_RUN will
> +return ENOEXEC for that vcpu.
> +
> +Note that because some registers reflect machine topology, all vcpus
> +should be created before this ioctl is invoked.
> +
> +
> +4.78 KVM_GET_REG_LIST
> +
> +Capability: basic
> +Architectures: arm
> +Type: vcpu ioctl
> +Parameters: struct kvm_reg_list (in/out)
> +Returns: 0 on success; -1 on error
> +Errors:
> +  E2BIG:     the reg index list is too big to fit in the array specified by
> +             the user (the number required will be written into n).
> +
> +struct kvm_reg_list {
> +       __u64 n; /* number of registers in reg[] */
> +       __u64 reg[0];
> +};
> +
> +This ioctl returns the guest registers that are supported for the
> +KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> +
> +
>  5. The kvm_run structure
>  ------------------------
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ade7e92..43a997a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2311,3 +2311,5 @@ source "security/Kconfig"
>  source "crypto/Kconfig"
> 
>  source "lib/Kconfig"
> +
> +source "arch/arm/kvm/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 5f914fc..433becd 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -257,6 +257,7 @@ core-$(CONFIG_XEN)          += arch/arm/xen/
>  core-y                         += arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
>  core-y                         += arch/arm/net/
>  core-y                         += arch/arm/crypto/
> +core-y                                 += arch/arm/kvm/

Predicate this on CONFIG_KVM_ARM_HOST, then add some obj-y to the
kvm/Makefile.

>  core-y                         += $(machdirs) $(platdirs)
> 
>  drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> new file mode 100644
> index 0000000..67826b2
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -0,0 +1,114 @@
> +/*
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#ifndef __ARM_KVM_HOST_H__
> +#define __ARM_KVM_HOST_H__
> +
> +#include <asm/kvm.h>
> +#include <asm/kvm_asm.h>
> +
> +#define KVM_MAX_VCPUS CONFIG_KVM_ARM_MAX_VCPUS

One thing I noticed when hacking kvmtool is that we don't support the
KVM_CAP_{MAX,NR}_VCPUS capabilities. Why is this? Since we have a
maximum of 8 due to limitations of the GIC, it might be nice to put that
somewhere visible to userspace.

> +#define KVM_MEMORY_SLOTS 32
> +#define KVM_PRIVATE_MEM_SLOTS 4
> +#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +
> +#define KVM_VCPU_MAX_FEATURES 0
> +
> +/* We don't currently support large pages. */
> +#define KVM_HPAGE_GFN_SHIFT(x) 0
> +#define KVM_NR_PAGE_SIZES      1
> +#define KVM_PAGES_PER_HPAGE(x) (1UL<<31)
> +
> +struct kvm_vcpu;
> +u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
> +int kvm_target_cpu(void);
> +int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
> +void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
> +
> +struct kvm_arch {
> +       /* VTTBR value associated with below pgd and vmid */
> +       u64    vttbr;
> +
> +       /*
> +        * Anything that is not used directly from assembly code goes
> +        * here.
> +        */
> +
> +       /* The VMID generation used for the virt. memory system */
> +       u64    vmid_gen;
> +       u32    vmid;
> +
> +       /* Stage-2 page table */
> +       pgd_t *pgd;
> +};
> +
> +#define KVM_NR_MEM_OBJS     40
> +
> +/*
> + * We don't want allocation failures within the mmu code, so we preallocate
> + * enough memory for a single page fault in a cache.
> + */
> +struct kvm_mmu_memory_cache {
> +       int nobjs;
> +       void *objects[KVM_NR_MEM_OBJS];
> +};
> +
> +struct kvm_vcpu_arch {
> +       struct kvm_regs regs;
> +
> +       int target; /* Processor target */
> +       DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
> +
> +       /* System control coprocessor (cp15) */
> +       u32 cp15[NR_CP15_REGS];
> +
> +       /* The CPU type we expose to the VM */
> +       u32 midr;
> +
> +       /* Exception Information */
> +       u32 hsr;                /* Hyp Syndrom Register */

pedantic: syndrome

> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> new file mode 100644
> index 0000000..00d61a6
> --- /dev/null
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -0,0 +1,82 @@
> +/*
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#ifndef __ARM_KVM_H__
> +#define __ARM_KVM_H__
> +
> +#include <asm/types.h>
> +#include <asm/ptrace.h>
> +
> +#define __KVM_HAVE_GUEST_DEBUG
> +
> +#define KVM_REG_SIZE(id)                                               \
> +       (1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
> +
> +struct kvm_regs {
> +       struct pt_regs usr_regs;/* R0_usr - R14_usr, PC, CPSR */
> +       __u32 svc_regs[3];      /* SP_svc, LR_svc, SPSR_svc */
> +       __u32 abt_regs[3];      /* SP_abt, LR_abt, SPSR_abt */
> +       __u32 und_regs[3];      /* SP_und, LR_und, SPSR_und */
> +       __u32 irq_regs[3];      /* SP_irq, LR_irq, SPSR_irq */
> +       __u32 fiq_regs[8];      /* R8_fiq - R14_fiq, SPSR_fiq */
> +};
> +
> +/* Supported Processor Types */
> +#define KVM_ARM_TARGET_CORTEX_A15      0
> +#define KVM_ARM_NUM_TARGETS            1

In future, it would be nice to have a way of probing the supported
targets, rather than trying a bunch of them and seeing which ioctl
finally succeeds.

> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> new file mode 100644
> index 0000000..c7eb178
> --- /dev/null
> +++ b/arch/arm/kvm/Kconfig
> @@ -0,0 +1,55 @@
> +#
> +# KVM configuration
> +#
> +
> +source "virt/kvm/Kconfig"
> +
> +menuconfig VIRTUALIZATION
> +       bool "Virtualization"
> +       ---help---
> +         Say Y here to get to see options for using your Linux host to run
> +         other operating systems inside virtual machines (guests).
> +         This option alone does not add any kernel code.
> +
> +         If you say N, all options in this submenu will be skipped and
> +         disabled.
> +
> +if VIRTUALIZATION
> +
> +config KVM
> +       bool "Kernel-based Virtual Machine (KVM) support"
> +       select PREEMPT_NOTIFIERS
> +       select ANON_INODES
> +       select KVM_MMIO
> +       depends on ARM_VIRT_EXT && ARM_LPAE
> +       ---help---
> +         Support hosting virtualized guest machines. You will also
> +         need to select one or more of the processor modules below.
> +
> +         This module provides access to the hardware capabilities through
> +         a character device node named /dev/kvm.
> +
> +         If unsure, say N.
> +
> +config KVM_ARM_HOST
> +       bool "KVM host support for ARM cpus."
> +       depends on KVM
> +       depends on MMU
> +       depends on CPU_V7 && ARM_VIRT_EXT

ARM_VIRT_EXT already implies CPU_V7 but, as I suggested earlier, it
should probably imply ARM_LPAE which would make much of this simpler.

> +       ---help---
> +         Provides host support for ARM processors.
> +
> +config KVM_ARM_MAX_VCPUS
> +       int "Number maximum supported virtual CPUs per VM"
> +       depends on KVM_ARM_HOST
> +       default 4
> +       help
> +         Static number of max supported virtual CPUs per VM.
> +
> +         If you choose a high number, the vcpu structures will be quite
> +         large, so only choose a reasonable number that you expect to
> +         actually use.
> +
> +source drivers/virtio/Kconfig
> +
> +endif # VIRTUALIZATION

I guess the XEN config options should also be moved under here?

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> new file mode 100644
> index 0000000..ead5a4e
> --- /dev/null
> +++ b/arch/arm/kvm/arm.c

[...]

> +long kvm_arch_vcpu_ioctl(struct file *filp,
> +                        unsigned int ioctl, unsigned long arg)
> +{
> +       struct kvm_vcpu *vcpu = filp->private_data;
> +       void __user *argp = (void __user *)arg;
> +
> +       switch (ioctl) {
> +       case KVM_ARM_VCPU_INIT: {
> +               struct kvm_vcpu_init init;
> +
> +               if (copy_from_user(&init, argp, sizeof init))
> +                       return -EFAULT;
> +
> +               return kvm_vcpu_set_target(vcpu, &init);
> +
> +       }
> +       case KVM_SET_ONE_REG:
> +       case KVM_GET_ONE_REG: {
> +               struct kvm_one_reg reg;
> +               if (copy_from_user(&reg, argp, sizeof(reg)))
> +                       return -EFAULT;
> +               if (ioctl == KVM_SET_ONE_REG)
> +                       return kvm_arm_set_reg(vcpu, &reg);
> +               else
> +                       return kvm_arm_get_reg(vcpu, &reg);
> +       }
> +       case KVM_GET_REG_LIST: {
> +               struct kvm_reg_list __user *user_list = argp;
> +               struct kvm_reg_list reg_list;
> +               unsigned n;
> +
> +               if (copy_from_user(&reg_list, user_list, sizeof reg_list))
> +                       return -EFAULT;
> +               n = reg_list.n;
> +               reg_list.n = kvm_arm_num_regs(vcpu);
> +               if (copy_to_user(user_list, &reg_list, sizeof reg_list))
> +                       return -EFAULT;
> +               if (n < reg_list.n)
> +                       return -E2BIG;
> +               return kvm_arm_copy_reg_indices(vcpu, user_list->reg);
> +       }
> +       default:
> +               return -EINVAL;
> +       }
> +}

Your use of brackets with sizeof is inconsistent -- just always make it
look like a function call.

> diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
> new file mode 100644
> index 0000000..32e1172
> --- /dev/null
> +++ b/arch/arm/kvm/emulate.c
> @@ -0,0 +1,149 @@
> +/*
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#include <asm/kvm_emulate.h>
> +
> +#define VCPU_NR_MODES 6
> +#define REG_OFFSET(_reg) \
> +       (offsetof(struct kvm_regs, _reg) / sizeof(u32))
> +
> +#define USR_REG_OFFSET(_num) REG_OFFSET(usr_regs.uregs[_num])
> +
> +static const unsigned long vcpu_reg_offsets[VCPU_NR_MODES][15] = {
> +       /* USR/SYS Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12), USR_REG_OFFSET(13), USR_REG_OFFSET(14),
> +       },
> +
> +       /* FIQ Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7),
> +               REG_OFFSET(fiq_regs[0]), /* r8 */
> +               REG_OFFSET(fiq_regs[1]), /* r9 */
> +               REG_OFFSET(fiq_regs[2]), /* r10 */
> +               REG_OFFSET(fiq_regs[3]), /* r11 */
> +               REG_OFFSET(fiq_regs[4]), /* r12 */
> +               REG_OFFSET(fiq_regs[5]), /* r13 */
> +               REG_OFFSET(fiq_regs[6]), /* r14 */
> +       },
> +
> +       /* IRQ Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(irq_regs[0]), /* r13 */
> +               REG_OFFSET(irq_regs[1]), /* r14 */
> +       },
> +
> +       /* SVC Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(svc_regs[0]), /* r13 */
> +               REG_OFFSET(svc_regs[1]), /* r14 */
> +       },
> +
> +       /* ABT Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(abt_regs[0]), /* r13 */
> +               REG_OFFSET(abt_regs[1]), /* r14 */
> +       },
> +
> +       /* UND Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(und_regs[0]), /* r13 */
> +               REG_OFFSET(und_regs[1]), /* r14 */
> +       },
> +};
> +
> +/*
> + * Return a pointer to the register number valid in the current mode of
> + * the virtual CPU.
> + */
> +u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num)
> +{
> +       u32 *reg_array = (u32 *)&vcpu->arch.regs;
> +       u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
> +
> +       switch (mode) {
> +       case USR_MODE...SVC_MODE:
> +               mode &= ~MODE32_BIT; /* 0 ... 3 */
> +               break;
> +
> +       case ABT_MODE:
> +               mode = 4;
> +               break;
> +
> +       case UND_MODE:
> +               mode = 5;
> +               break;
> +
> +       case SYSTEM_MODE:
> +               mode = 0;
> +               break;
> +
> +       default:
> +               BUG();
> +       }
> +
> +       return reg_array + vcpu_reg_offsets[mode][reg_num];
> +}
]
Have some file-local #defines for those magic mode numbers.

> +
> +/*
> + * Return the SPSR for the current mode of the virtual CPU.
> + */
> +u32 *vcpu_spsr(struct kvm_vcpu *vcpu)
> +{
> +       u32 mode = *vcpu_cpsr(vcpu) & MODE_MASK;
> +       switch (mode) {
> +       case SVC_MODE:
> +               return &vcpu->arch.regs.svc_regs[2];
> +       case ABT_MODE:
> +               return &vcpu->arch.regs.abt_regs[2];
> +       case UND_MODE:
> +               return &vcpu->arch.regs.und_regs[2];
> +       case IRQ_MODE:
> +               return &vcpu->arch.regs.irq_regs[2];
> +       case FIQ_MODE:
> +               return &vcpu->arch.regs.fiq_regs[7];
> +       default:
> +               BUG();
> +       }
> +}

Same here: have some #defines for the reg indices. They would also be
useful to userspace when manipulating the vcpu state (currently there is
just a comment in the header).

Will
