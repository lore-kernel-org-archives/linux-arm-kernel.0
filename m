From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Sep 2012 16:20:55 +0100
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20120915153508.21241.47712.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
Message-ID: <20120925152055.GC28728@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:35:08PM +0100, Christoffer Dall wrote:
> Targets KVM support for Cortex A-15 processors.
> 
> Contains all the framework components, make files, header files, some
> tracing functionality, and basic user space API.
> 
> Only supported core is Cortex-A15 for now.
> 
> Most functionality is in arch/arm/kvm/* or arch/arm/include/asm/kvm_*.h.
> 
> ?Nothing to see here. Move along, move along..."

[...]

> diff --git a/arch/arm/include/asm/kvm.h b/arch/arm/include/asm/kvm.h
> new file mode 100644
> index 0000000..a13b582
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm.h
> @@ -0,0 +1,88 @@
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
> +
> +#define __KVM_HAVE_GUEST_DEBUG
> +
> +#define KVM_REG_SIZE(id)                                               \
> +       (1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
> +
> +struct kvm_regs {
> +       __u32 usr_regs[15];     /* R0_usr - R14_usr */
> +       __u32 svc_regs[3];      /* SP_svc, LR_svc, SPSR_svc */
> +       __u32 abt_regs[3];      /* SP_abt, LR_abt, SPSR_abt */
> +       __u32 und_regs[3];      /* SP_und, LR_und, SPSR_und */
> +       __u32 irq_regs[3];      /* SP_irq, LR_irq, SPSR_irq */
> +       __u32 fiq_regs[8];      /* R8_fiq - R14_fiq, SPSR_fiq */
> +       __u32 pc;               /* The program counter (r15) */
> +       __u32 cpsr;             /* The guest CPSR */
> +};
> +
> +/* Supported Processor Types */
> +#define KVM_ARM_TARGET_CORTEX_A15      (0xC0F)

So there's this define...

> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> new file mode 100644
> index 0000000..2f9d28e
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -0,0 +1,28 @@
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
> +#ifndef __ARM_KVM_ARM_H__
> +#define __ARM_KVM_ARM_H__
> +
> +/* Supported Processor Types */
> +#define CORTEX_A15     (0xC0F)

... and then this one. Do we really need both?

> +/* Multiprocessor Affinity Register */
> +#define MPIDR_CPUID    (0x3 << 0)

I'm fairly sure we already have code under arch/arm/ for dealing with the
mpidr. Let's re-use that rather than reinventing it here.

> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> new file mode 100644
> index 0000000..44591f9
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -0,0 +1,30 @@
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
> +#ifndef __ARM_KVM_ASM_H__
> +#define __ARM_KVM_ASM_H__
> +
> +#define ARM_EXCEPTION_RESET      0
> +#define ARM_EXCEPTION_UNDEFINED   1
> +#define ARM_EXCEPTION_SOFTWARE    2
> +#define ARM_EXCEPTION_PREF_ABORT  3
> +#define ARM_EXCEPTION_DATA_ABORT  4
> +#define ARM_EXCEPTION_IRQ        5
> +#define ARM_EXCEPTION_FIQ        6

Again, you have these defines (which look more suited to an enum type), but
later (in kvm_host.h) you have:

> +#define EXCEPTION_NONE      0
> +#define EXCEPTION_RESET     0x80
> +#define EXCEPTION_UNDEFINED 0x40
> +#define EXCEPTION_SOFTWARE  0x20
> +#define EXCEPTION_PREFETCH  0x10
> +#define EXCEPTION_DATA      0x08
> +#define EXCEPTION_IMPRECISE 0x04
> +#define EXCEPTION_IRQ       0x02
> +#define EXCEPTION_FIQ       0x01

Why the noise?

> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> new file mode 100644
> index 0000000..9e29335
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -0,0 +1,108 @@
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
> +#ifndef __ARM_KVM_EMULATE_H__
> +#define __ARM_KVM_EMULATE_H__
> +
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_asm.h>
> +
> +u32 *vcpu_reg_mode(struct kvm_vcpu *vcpu, u8 reg_num, enum vcpu_mode mode);
> +
> +static inline u8 __vcpu_mode(u32 cpsr)
> +{
> +       u8 modes_table[32] = {
> +               0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf,
> +               0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf, 0xf,
> +               MODE_USR,       /* 0x0 */
> +               MODE_FIQ,       /* 0x1 */
> +               MODE_IRQ,       /* 0x2 */
> +               MODE_SVC,       /* 0x3 */
> +               0xf, 0xf, 0xf,
> +               MODE_ABT,       /* 0x7 */
> +               0xf, 0xf, 0xf,
> +               MODE_UND,       /* 0xb */
> +               0xf, 0xf, 0xf,
> +               MODE_SYS        /* 0xf */
> +       };

These MODE_* definitions sound like our *_MODE definitions... except they're
not. It would probably be far more readable as a switch, but at least change
the name of those things!

> +static inline enum vcpu_mode vcpu_mode(struct kvm_vcpu *vcpu)
> +{
> +       u8 mode = __vcpu_mode(vcpu->arch.regs.cpsr);
> +       BUG_ON(mode == 0xf);
> +       return mode;
> +}

I noticed that you have a fair few BUG_ONs throughout the series. Fair
enough, but for hyp code is that really the right thing to do? Killing the
guest could make more sense, perhaps?

> +static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
> +{
> +       return vcpu_reg(vcpu, 15);
> +}

If you stick a struct pt_regs into struct kvm_regs, you could reuse ARM_pc
here etc.

> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> new file mode 100644
> index 0000000..24959f4
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -0,0 +1,172 @@
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
> +
> +#define KVM_MAX_VCPUS 4

NR_CPUS?

> +#define KVM_MEMORY_SLOTS 32
> +#define KVM_PRIVATE_MEM_SLOTS 4
> +#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +
> +#define NUM_FEATURES 0

Ha! No idea what that means, but hopefully there's less code to review
because of it :)

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
> +       /* The VMID generation used for the virt. memory system */
> +       u64    vmid_gen;
> +       u32    vmid;
> +
> +       /* 1-level 2nd stage table and lock */
> +       spinlock_t pgd_lock;
> +       pgd_t *pgd;
> +
> +       /* VTTBR value associated with above pgd and vmid */
> +       u64    vttbr;
> +};
> +
> +#define EXCEPTION_NONE      0
> +#define EXCEPTION_RESET     0x80
> +#define EXCEPTION_UNDEFINED 0x40
> +#define EXCEPTION_SOFTWARE  0x20
> +#define EXCEPTION_PREFETCH  0x10
> +#define EXCEPTION_DATA      0x08
> +#define EXCEPTION_IMPRECISE 0x04
> +#define EXCEPTION_IRQ       0x02
> +#define EXCEPTION_FIQ       0x01
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
> +/*
> + * Modes used for short-hand mode determinition in the world-switch code and
> + * in emulation code.
> + *
> + * Note: These indices do NOT correspond to the value of the CPSR mode bits!
> + */
> +enum vcpu_mode {
> +       MODE_FIQ = 0,
> +       MODE_IRQ,
> +       MODE_SVC,
> +       MODE_ABT,
> +       MODE_UND,
> +       MODE_USR,
> +       MODE_SYS
> +};

So the need for this enum is for indexing the array of modes, right? But
accesses to that array are already hidden behind an accessor function from
what I can tell, so I'd rather the arithmetic from cpsr -> index was
restricted to that function and the rest of the code just passed either the
raw mode or the full cpsr around.

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> new file mode 100644
> index 0000000..fd6fa9b
> --- /dev/null
> +++ b/arch/arm/kvm/arm.c
> @@ -0,0 +1,345 @@
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
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/kvm_host.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/fs.h>
> +#include <linux/mman.h>
> +#include <linux/sched.h>
> +#include <trace/events/kvm.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +
> +#include <asm/unified.h>
> +#include <asm/uaccess.h>
> +#include <asm/ptrace.h>
> +#include <asm/mman.h>
> +#include <asm/cputype.h>
> +
> +#ifdef REQUIRES_VIRT
> +__asm__(".arch_extension       virt");
> +#endif
> +
> +int kvm_arch_hardware_enable(void *garbage)
> +{
> +       return 0;
> +}
> +
> +int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
> +{
> +       return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
> +}
> +
> +void kvm_arch_hardware_disable(void *garbage)
> +{
> +}
> +
> +int kvm_arch_hardware_setup(void)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_hardware_unsetup(void)
> +{
> +}
> +
> +void kvm_arch_check_processor_compat(void *rtn)
> +{
> +       *(int *)rtn = 0;
> +}
> +
> +void kvm_arch_sync_events(struct kvm *kvm)
> +{
> +}
> +
> +int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> +{
> +       if (type)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
> +{
> +       return VM_FAULT_SIGBUS;
> +}
> +
> +void kvm_arch_free_memslot(struct kvm_memory_slot *free,
> +                          struct kvm_memory_slot *dont)
> +{
> +}
> +
> +int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_destroy_vm(struct kvm *kvm)
> +{
> +       int i;
> +
> +       for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> +               if (kvm->vcpus[i]) {
> +                       kvm_arch_vcpu_free(kvm->vcpus[i]);
> +                       kvm->vcpus[i] = NULL;
> +               }
> +       }
> +}
> +
> +int kvm_dev_ioctl_check_extension(long ext)
> +{
> +       int r;
> +       switch (ext) {
> +       case KVM_CAP_USER_MEMORY:
> +       case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
> +       case KVM_CAP_ONE_REG:
> +               r = 1;
> +               break;
> +       case KVM_CAP_COALESCED_MMIO:
> +               r = KVM_COALESCED_MMIO_PAGE_OFFSET;
> +               break;
> +       default:
> +               r = 0;
> +               break;
> +       }
> +       return r;
> +}
> +
> +long kvm_arch_dev_ioctl(struct file *filp,
> +                       unsigned int ioctl, unsigned long arg)
> +{
> +       return -EINVAL;
> +}
> +
> +int kvm_arch_set_memory_region(struct kvm *kvm,
> +                              struct kvm_userspace_memory_region *mem,
> +                              struct kvm_memory_slot old,
> +                              int user_alloc)
> +{
> +       return 0;
> +}
> +
> +int kvm_arch_prepare_memory_region(struct kvm *kvm,
> +                                  struct kvm_memory_slot *memslot,
> +                                  struct kvm_memory_slot old,
> +                                  struct kvm_userspace_memory_region *mem,
> +                                  int user_alloc)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_commit_memory_region(struct kvm *kvm,
> +                                  struct kvm_userspace_memory_region *mem,
> +                                  struct kvm_memory_slot old,
> +                                  int user_alloc)
> +{
> +}
> +
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +}
> +
> +void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> +                                  struct kvm_memory_slot *slot)
> +{
> +}
> +
> +struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
> +{
> +       int err;
> +       struct kvm_vcpu *vcpu;
> +
> +       vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
> +       if (!vcpu) {
> +               err = -ENOMEM;
> +               goto out;
> +       }
> +
> +       err = kvm_vcpu_init(vcpu, kvm, id);
> +       if (err)
> +               goto free_vcpu;
> +
> +       return vcpu;
> +free_vcpu:
> +       kmem_cache_free(kvm_vcpu_cache, vcpu);
> +out:
> +       return ERR_PTR(err);
> +}
> +
> +void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> +{
> +       kvm_arch_vcpu_free(vcpu);
> +}
> +
> +int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +int __attribute_const__ kvm_target_cpu(void)
> +{
> +       unsigned int midr;
> +
> +       midr = read_cpuid_id();
> +       switch ((midr >> 4) & 0xfff) {
> +       case KVM_ARM_TARGET_CORTEX_A15:
> +               return KVM_ARM_TARGET_CORTEX_A15;

I have this code already in perf_event.c. Can we move it somewhere common
and share it? You should also check that the implementor field is 0x41.

> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> +{
> +}
> +
> +void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> +                                       struct kvm_guest_debug *dbg)
> +{
> +       return -EINVAL;
> +}
> +
> +
> +int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
> +                                   struct kvm_mp_state *mp_state)
> +{
> +       return -EINVAL;
> +}
> +
> +int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
> +                                   struct kvm_mp_state *mp_state)
> +{
> +       return -EINVAL;
> +}
> +
> +int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
> +{
> +       return 0;
> +}
> +
> +int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
> +{
> +       return 0;
> +}
> +
> +int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +{
> +       return -EINVAL;
> +}
> +
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

kvm_reg_list sounds like it could be done using a regset instead.

> diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
> new file mode 100644
> index 0000000..690bbb3
> --- /dev/null
> +++ b/arch/arm/kvm/emulate.c
> @@ -0,0 +1,127 @@
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
> +#define REG_OFFSET(_reg) \
> +       (offsetof(struct kvm_regs, _reg) / sizeof(u32))
> +
> +#define USR_REG_OFFSET(_num) REG_OFFSET(usr_regs[_num])
> +
> +static const unsigned long vcpu_reg_offsets[MODE_SYS + 1][16] = {
> +       /* FIQ Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7),
> +               REG_OFFSET(fiq_regs[1]), /* r8 */
> +               REG_OFFSET(fiq_regs[1]), /* r9 */
> +               REG_OFFSET(fiq_regs[2]), /* r10 */
> +               REG_OFFSET(fiq_regs[3]), /* r11 */
> +               REG_OFFSET(fiq_regs[4]), /* r12 */
> +               REG_OFFSET(fiq_regs[5]), /* r13 */
> +               REG_OFFSET(fiq_regs[6]), /* r14 */
> +               REG_OFFSET(pc)           /* r15 */
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
> +               REG_OFFSET(pc)           /* r15 */
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
> +               REG_OFFSET(pc)           /* r15 */
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
> +               REG_OFFSET(pc)           /* r15 */
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
> +               REG_OFFSET(pc)           /* r15 */
> +       },
> +
> +       /* USR Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(usr_regs[13]), /* r13 */
> +               REG_OFFSET(usr_regs[14]), /* r14 */
> +               REG_OFFSET(pc)            /* r15 */
> +       },
> +
> +       /* SYS Registers */
> +       {
> +               USR_REG_OFFSET(0), USR_REG_OFFSET(1), USR_REG_OFFSET(2),
> +               USR_REG_OFFSET(3), USR_REG_OFFSET(4), USR_REG_OFFSET(5),
> +               USR_REG_OFFSET(6), USR_REG_OFFSET(7), USR_REG_OFFSET(8),
> +               USR_REG_OFFSET(9), USR_REG_OFFSET(10), USR_REG_OFFSET(11),
> +               USR_REG_OFFSET(12),
> +               REG_OFFSET(usr_regs[13]), /* r13 */
> +               REG_OFFSET(usr_regs[14]), /* r14 */
> +               REG_OFFSET(pc)            /* r15 */
> +       },
> +};
> +
> +/*
> + * Return a pointer to the register number valid in the specified mode of
> + * the virtual CPU.
> + */
> +u32 *vcpu_reg_mode(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode)
> +{
> +       u32 *reg_array = (u32 *)&vcpu->arch.regs;
> +
> +       BUG_ON(reg_num > 15);
> +       BUG_ON(mode > MODE_SYS);

Again, BUG_ON seems a bit OTT here. Also, this is where the mode => idx
calculation should happen.

> +       return reg_array + vcpu_reg_offsets[mode][reg_num];
> +}
> diff --git a/arch/arm/kvm/exports.c b/arch/arm/kvm/exports.c
> new file mode 100644
> index 0000000..3e38c95
> --- /dev/null
> +++ b/arch/arm/kvm/exports.c
> @@ -0,0 +1,21 @@
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
> +#include <linux/module.h>
> +
> +EXPORT_SYMBOL_GPL(smp_send_reschedule);

Erm...

We already have arch/arm/kernel/armksyms.c for exports -- please use that.
However, exporting such low-level operations sounds like a bad idea. How
realistic is kvm-as-a-module on ARM anyway?

> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> new file mode 100644
> index 0000000..19a5389
> --- /dev/null
> +++ b/arch/arm/kvm/guest.c
> @@ -0,0 +1,211 @@
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
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/kvm_host.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/fs.h>
> +#include <asm/uaccess.h>
> +#include <asm/kvm.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_emulate.h>
> +
> +#define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
> +#define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
> +
> +struct kvm_stats_debugfs_item debugfs_entries[] = {
> +       { NULL }
> +};
> +
> +int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
> +{
> +       return 0;
> +}
> +
> +static u64 core_reg_offset_from_id(u64 id)
> +{
> +       return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
> +}
> +
> +static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +       u32 __user *uaddr = (u32 __user *)(long)reg->addr;
> +       struct kvm_regs *regs = &vcpu->arch.regs;
> +       u64 off;
> +
> +       if (KVM_REG_SIZE(reg->id) != 4)
> +               return -ENOENT;
> +
> +       /* Our ID is an index into the kvm_regs struct. */
> +       off = core_reg_offset_from_id(reg->id);
> +       if (off >= sizeof(*regs) / KVM_REG_SIZE(reg->id))
> +               return -ENOENT;
> +
> +       return put_user(((u32 *)regs)[off], uaddr);
> +}
> +
> +static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +       u32 __user *uaddr = (u32 __user *)(long)reg->addr;
> +       struct kvm_regs *regs = &vcpu->arch.regs;
> +       u64 off, val;
> +
> +       if (KVM_REG_SIZE(reg->id) != 4)
> +               return -ENOENT;
> +
> +       /* Our ID is an index into the kvm_regs struct. */
> +       off = core_reg_offset_from_id(reg->id);
> +       if (off >= sizeof(*regs) / KVM_REG_SIZE(reg->id))
> +               return -ENOENT;
> +
> +       if (get_user(val, uaddr) != 0)
> +               return -EFAULT;
> +
> +       if (off == KVM_REG_ARM_CORE_REG(cpsr)) {
> +               if (__vcpu_mode(val) == 0xf)
> +                       return -EINVAL;
> +       }
> +
> +       ((u32 *)regs)[off] = val;
> +       return 0;
> +}
> +
> +int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> +{
> +       return -EINVAL;
> +}
> +
> +int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> +{
> +       return -EINVAL;
> +}

Again, all looks like this should be implemented using regsets from what I
can tell.

> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> new file mode 100644
> index 0000000..290a13d
> --- /dev/null
> +++ b/arch/arm/kvm/reset.c
> @@ -0,0 +1,74 @@
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
> +#include <linux/compiler.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/kvm_host.h>
> +#include <linux/kvm.h>
> +
> +#include <asm/unified.h>
> +#include <asm/ptrace.h>
> +#include <asm/cputype.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_coproc.h>
> +
> +/******************************************************************************
> + * Cortex-A15 Reset Values
> + */
> +
> +static const int a15_max_cpu_idx = 3;
> +
> +static struct kvm_regs a15_regs_reset = {
> +       .cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
> +};
> +
> +
> +/*******************************************************************************
> + * Exported reset function
> + */
> +
> +/**
> + * kvm_reset_vcpu - sets core registers and cp15 registers to reset value
> + * @vcpu: The VCPU pointer
> + *
> + * This function finds the right table above and sets the registers on the
> + * virtual CPU struct to their architectually defined reset values.
> + */
> +int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_regs *cpu_reset;
> +
> +       switch (vcpu->arch.target) {
> +       case KVM_ARM_TARGET_CORTEX_A15:
> +               if (vcpu->vcpu_id > a15_max_cpu_idx)
> +                       return -EINVAL;
> +               cpu_reset = &a15_regs_reset;
> +               vcpu->arch.midr = read_cpuid_id();
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       /* Reset core registers */
> +       memcpy(&vcpu->arch.regs, cpu_reset, sizeof(vcpu->arch.regs));
> +
> +       /* Reset CP15 registers */
> +       kvm_reset_coprocs(vcpu);
> +
> +       return 0;
> +}

This is a nice way to plug in new CPUs but the way the rest of the code is
currently written, all the ARMv7 and Cortex-A15 code is merged together. I
*strongly* suggest you isolate this from the start, as it will help you see
what is architected and what is implementation-specific.

Will
