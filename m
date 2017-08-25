From: florent.revest@arm.com (Florent Revest)
Date: Fri, 25 Aug 2017 09:31:40 +0100
Subject: [RFC 10/11] efi, arm64: Sandbox Runtime Services in a VM
In-Reply-To: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
References: <1503649901-5834-1-git-send-email-florent.revest@arm.com>
Message-ID: <1503649901-5834-11-git-send-email-florent.revest@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EFI Runtime Services are binary blobs currently executed in a special
memory context but with the privileges of the kernel. This can potentially
cause security or stability issues (registers corruption for example).

This patch adds a CONFIG_EFI_SANDBOX option that can be used on arm64 to
enclose the Runtime Services in a virtual machine and limit the impact they
can potentially have on the kernel. This sandboxing can also be useful for
debugging as exceptions caused by the firmware code can be recovered and
examined.

When booting the machine, an internal KVM virtual machine is created with
physical and virtual addresses mirroring the host's EFI context.

One page of code and at least 16K of data pages are kept in low memory for
the usage of an internal (in the VM) assembly function call wrapper
(efi_sandbox_wrapper). Calling this internal wrapper is done from external
C function wrappers (e.g: efi_sandbox_get_next_variable) filling the VCPU
registers with arguments and the data page with copies of memory buffers
first.

When a Runtime Service returns, the internal wrapper issues an HVC to let
the host know the efi status return value in x1. In case of exception,
an internal handler also sends an HVC with an EFI_ABORTED error code.

Details of the VCPU initialization, VM memory mapping and service call/ret
are extensively documented in arm-sandbox.c and arm-sandbox-payload.S.

Note: The current version of this patch could potentially cause problems of
arguments alignment when calling an EFI Runtime Service. Indeed, the
buffers arguments are just pushed onto a stack in a data page without any
regards to the ARM Calling Convention alignments.

Signed-off-by: Florent Revest <florent.revest@arm.com>
---
 arch/arm/include/asm/efi.h                 |   5 +
 arch/arm64/include/asm/efi.h               |  69 ++++
 arch/arm64/kernel/asm-offsets.c            |   3 +
 arch/arm64/kvm/handle_exit.c               |   3 +
 drivers/firmware/efi/Kconfig               |  10 +
 drivers/firmware/efi/Makefile              |   1 +
 drivers/firmware/efi/arm-runtime.c         |   2 +
 drivers/firmware/efi/arm-sandbox-payload.S |  96 +++++
 drivers/firmware/efi/arm-sandbox.c         | 569 +++++++++++++++++++++++++++++
 include/linux/smccc_fn.h                   |   3 +
 10 files changed, 761 insertions(+)
 create mode 100644 drivers/firmware/efi/arm-sandbox-payload.S
 create mode 100644 drivers/firmware/efi/arm-sandbox.c

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index ed575ae..524f0dd 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -35,6 +35,11 @@
        __f(args);                                                      \
 })

+struct kvm_vcpu;
+static inline void efi_arm_sandbox_init(struct mm_struct *efi_mm) { }
+static inline bool efi_sandbox_is_exit(struct kvm_vcpu *vcpu) { return false; }
+static inline int efi_sandbox_exit(struct kvm_vcpu *vcpu) { return -1; }
+
 int efi_arch_late_enable_runtime_services(void);

 #define ARCH_EFI_IRQ_FLAGS_MASK \
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 373d94d..f1c33cd 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_EFI_H
 #define _ASM_EFI_H

+#include <linux/efi.h>
+
 #include <asm/boot.h>
 #include <asm/cpufeature.h>
 #include <asm/io.h>
@@ -18,6 +20,10 @@
 int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
 int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);

+struct kvm_vcpu;
+
+#ifndef CONFIG_EFI_SANDBOX
+
 #define arch_efi_call_virt_setup()                                     \
 ({                                                                     \
        kernel_neon_begin();                                            \
@@ -37,6 +43,69 @@
        kernel_neon_end();                                              \
 })

+static inline void efi_arm_sandbox_init(struct mm_struct *efi_mm) { }
+static inline bool efi_sandbox_is_exit(struct kvm_vcpu *vcpu) { return false; }
+static inline int efi_sandbox_exit(struct kvm_vcpu *vcpu) { return -1; }
+
+#else
+
+void efi_arm_sandbox_init(struct mm_struct *efi_mm);
+bool efi_sandbox_is_exit(struct kvm_vcpu *vcpu);
+int efi_sandbox_exit(struct kvm_vcpu *vcpu);
+
+void efi_sandbox_excpt(void);
+void efi_sandbox_wrapper(void);
+void efi_sandbox_vectors(void);
+
+#define arch_efi_call_virt_setup() ({})
+#define arch_efi_call_virt(p, f, args...)      efi_sandbox_##f(args)
+#define arch_efi_call_virt_teardown() ({})
+
+/*
+ * The following function wrappers are needed in order to serialize the variadic
+ * macro's arguments (arch_efi_call_virt(p, f, args...)) in the vcpu's registers
+ * p is also ignored since it is available in the context of the virtual machine
+ */
+
+efi_status_t efi_sandbox_get_time(efi_time_t *tm,
+                                  efi_time_cap_t *tc);
+efi_status_t efi_sandbox_set_time(efi_time_t *tm);
+efi_status_t efi_sandbox_get_wakeup_time(efi_bool_t *enabled,
+                                        efi_bool_t *pending,
+                                        efi_time_t *tm);
+efi_status_t efi_sandbox_set_wakeup_time(efi_bool_t enabled,
+                                        efi_time_t *tm);
+efi_status_t efi_sandbox_get_variable(efi_char16_t *name,
+                                     efi_guid_t *vendor,
+                                     u32 *attr,
+                                     unsigned long *data_size,
+                                     void *data);
+efi_status_t efi_sandbox_get_next_variable(unsigned long *name_size,
+                                          efi_char16_t *name,
+                                          efi_guid_t *vendor);
+efi_status_t efi_sandbox_set_variable(efi_char16_t *name,
+                                     efi_guid_t *vendor,
+                                     u32 attr,
+                                     unsigned long data_size,
+                                     void *data);
+efi_status_t efi_sandbox_query_variable_info(u32 attr,
+                                            u64 *storage_space,
+                                            u64 *remaining_space,
+                                            u64 *max_variable_size);
+efi_status_t efi_sandbox_get_next_high_mono_count(u32 *count);
+efi_status_t efi_sandbox_reset_system(int reset_type,
+                                     efi_status_t status,
+                                     unsigned long data_size,
+                                     efi_char16_t *data);
+efi_status_t efi_sandbox_update_capsule(efi_capsule_header_t **capsules,
+                                       unsigned long count,
+                                       unsigned long sg_list);
+efi_status_t efi_sandbox_query_capsule_caps(efi_capsule_header_t **capsules,
+                                           unsigned long count,
+                                           u64 *max_size,
+                                           int *reset_type);
+#endif
+
 int efi_arch_late_enable_runtime_services(void);

 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b3bb7ef..c6d7ef7a 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -31,6 +31,7 @@
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+#include <linux/efi.h>

 int main(void)
 {
@@ -153,5 +154,7 @@ int main(void)
   DEFINE(HIBERN_PBE_ADDR,      offsetof(struct pbe, address));
   DEFINE(HIBERN_PBE_NEXT,      offsetof(struct pbe, next));
   DEFINE(ARM64_FTR_SYSVAL,     offsetof(struct arm64_ftr_reg, sys_val));
+
+  DEFINE(EFI_SYSTAB_RUNTIME,   offsetof(efi_system_table_t, runtime));
   return 0;
 }
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index bc7ade5..389402a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -23,6 +23,7 @@
 #include <linux/kvm_host.h>
 #include <linux/smccc_fn.h>

+#include <asm/efi.h>
 #include <asm/esr.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
@@ -57,6 +58,8 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)

        if (kvm_psci_is_call(vcpu))
                ret = kvm_psci_call(vcpu);
+       else if (efi_sandbox_is_exit(vcpu))
+               ret = efi_sandbox_exit(vcpu);
        else
                vcpu_set_reg(vcpu, 0, SMCCC_STD_RET_UNKNOWN_ID);

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 394db40..a441acc 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -151,6 +151,16 @@ config APPLE_PROPERTIES

          If unsure, say Y if you have a Mac.  Otherwise N.

+config EFI_SANDBOX
+       bool "EFI Runtime Services sandboxing"
+       depends on EFI && KVM && ARM64
+       default n
+       help
+         Select this option to sandbox Runtime Services in a virtual machine
+         and limit their possible impact on security and stability.
+
+         Say Y here to enable the runtime services sandbox. If unsure, say N.
+
 endmenu

 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 0329d31..2da9ad4 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_DEV_PATH_PARSER)     += dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)         += apple-properties.o

 arm-obj-$(CONFIG_EFI)                  := arm-init.o arm-runtime.o
+arm-obj-$(CONFIG_EFI_SANDBOX)          += arm-sandbox.o arm-sandbox-payload.o
 obj-$(CONFIG_ARM)                      += $(arm-obj-y)
 obj-$(CONFIG_ARM64)                    += $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)       += capsule-loader.o
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index d94d240..81ce0de 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,6 +107,8 @@ static bool __init efi_virtmap_init(void)
        if (efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions))
                return false;

+       efi_arm_sandbox_init(&efi_mm);
+
        return true;
 }

diff --git a/drivers/firmware/efi/arm-sandbox-payload.S b/drivers/firmware/efi/arm-sandbox-payload.S
new file mode 100644
index 0000000..0f34576
--- /dev/null
+++ b/drivers/firmware/efi/arm-sandbox-payload.S
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2017 ARM Ltd.
+ * Author: Florent Revest <florent.revest@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/smccc_fn.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+
+#define EFI_ABORTED    0x8000000000000015
+
+/*
+ * The following assembly is meant to be a page of payload code mapped at the
+ * address 0x0 of the EFI Runtime Services sandbox memory. Hence, align to page:
+ */
+.align PAGE_SHIFT
+
+/*
+ * efi_sandbox_excpt - Exception handler
+ *
+ * Exit the virtual machine cleanly with an EFI status that allows recovering
+ * and debugging in case of an exception.
+ */
+ENTRY(efi_sandbox_excpt)
+       ldr     x1, =EFI_ABORTED                /* Error code for debugging */
+       mov     x0, SMCCC_FN_EFI_SANDBOX_RET    /* Fill the Function ID reg */
+       hvc     #0                              /* Notify the host of the ret */
+
+efi_sandbox_excpt_safeguard:
+       b       efi_sandbox_excpt_safeguard     /* Should never be executed */
+ENDPROC(efi_sandbox_excpt)
+
+/*
+ * efi_sandbox_wrapper - Runtime Service internal wrapper
+ *
+ * When called, the registers are expected to be in the following state:
+ *  - x0, x1, x2...: EFI parameters according to the ARM calling convention
+ *  - x10: Virtual address of the UEFI System Table
+ *  - x11: Offset of the wanted service in the runtime services table
+ *
+ * When this wrapper returns with an HVC, the registers should be as follow:
+ *  - x0: HVC Function ID (SMCCC_FN_EFI_SANDBOX_RET) according to SMCCC
+ *  - x1: The EFI status returned by the runtime service
+ */
+ENTRY(efi_sandbox_wrapper)
+       ldr     x10, [x10, #EFI_SYSTAB_RUNTIME] /* Get systab.runtime */
+       ldr     x10, [x10, x11]                 /* Get function pointer */
+
+       blr     x10                             /* Call the runtime service */
+
+       mov     x1, x0                          /* Keep ret in x1 */
+       mov     x0, SMCCC_FN_EFI_SANDBOX_RET    /* Fill the Function ID reg */
+       hvc     #0                              /* Notify the host of the ret */
+
+efi_sandbox_wrapper_safeguard:
+       b       efi_sandbox_wrapper_safeguard   /* Should never be executed */
+ENDPROC(efi_sandbox_wrapper)
+
+/*
+ * efi_sandbox_vectors - Exception vectors table
+ *
+ * Always call efi_sandbox_excpt (mapped at 0x0) in case of an exception.
+ */
+.align 11
+ENTRY(efi_sandbox_vectors)
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+       ventry  efi_sandbox_excpt
+END(efi_sandbox_vectors)
diff --git a/drivers/firmware/efi/arm-sandbox.c b/drivers/firmware/efi/arm-sandbox.c
new file mode 100644
index 0000000..009037d
--- /dev/null
+++ b/drivers/firmware/efi/arm-sandbox.c
@@ -0,0 +1,569 @@
+/*
+ * Copyright (C) 2017 ARM Ltd.
+ * Author: Florent Revest <florent.revest@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/smccc_fn.h>
+
+#include <asm/efi.h>
+#include <asm/pgtable-hwdef.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/sysreg.h>
+
+/*
+ * RUNTIME SERVICES SANDBOX
+ *
+ * If CONFIG_EFI_SANDBOX is enabled, an internal virtual machine with one VCPU
+ * is spawned using KVM early in the boot process. The memory (both stage 2 and
+ * stage 1) and registers (general purpose, system etc) are setup from the host
+ * code in efi_arm_sandbox_init to prepare a suitable execution environment for
+ * EFI. The VCPU's system registers(SCTLR & TCR) are configured as follow.
+ */
+
+static struct kvm_vcpu *sandbox_vcpu;
+
+/* Translation Control Register - Enable TTBR0 only, with host's page size */
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#define EFI_SANDBOX_TCR_TG     TCR_TG0_64K
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define EFI_SANDBOX_TCR_TG     TCR_TG0_16K
+#else /* CONFIG_ARM64_64K_PAGES */
+#define EFI_SANDBOX_TCR_TG     TCR_TG0_4K
+#endif
+
+#define EFI_SANDBOX_TCR_EPD1   (1UL << 23)
+
+#define EFI_SANDBOX_TCR_IPS    ((read_sysreg(id_aa64mmfr0_el1) & 7) << 32)
+
+#define EFI_SANDBOX_TCR                (TCR_T0SZ(VA_BITS)    | TCR_IRGN0_WBWA     | \
+                                TCR_ORGN0_WBWA       | TCR_SH0_INNER      | \
+                                EFI_SANDBOX_TCR_EPD1 | EFI_SANDBOX_TCR_TG | \
+                                EFI_SANDBOX_TCR_TG   | EFI_SANDBOX_TCR_IPS)
+
+/* System Control Register - Enables MMU, Cache, Stack Alignment and I-Cache */
+
+#define SCTLR_EL1_RES1         ((1UL << 11) | (1UL << 20) | (1UL << 22) | \
+                                (1UL << 23) | (1UL << 28) | (1UL << 29))
+#define EFI_SANDBOX_SCTLR      (SCTLR_ELx_M | SCTLR_ELx_C | SCTLR_ELx_SA | \
+                                SCTLR_ELx_I | SCTLR_EL1_RES1)
+
+/*
+ * GUEST'S PHYSICAL MEMORY MAPPING
+ *
+ * Quite a few pages are idmapped from the host physical memory to the guest
+ * intermediary physical memory. The addresses of the GPAs are then those of the
+ * HPAs. Those pages cover:
+ *
+ * - The code page:
+ *  A code payload (the content of arm-sandbox-payload.S) offers an internal
+ *  wrapper to call a Runtime Service then leave the VM with a hypercall and
+ *  also an exception handler.
+ *
+ * - The data page(s):
+ *  A range of writable memory is reserved to pass internal copies of buffer
+ *  args (maintained as a stack growing positively) and also for the VCPU's own
+ *  stack (growing negatively). The EFI Runtime Services need a VCPU stack size
+ *  of 8K, so the total writable memory must be at least 16K long which can
+ *  represent a different number of pages depending on our PAGE_SIZE.
+ *
+ * - The page tables:
+ *  Since the host takes care of the guest's stage1 virtual mapping (cf. next
+ *  section), stage1 page tables need to be created from the host kernel and
+ *  then mapped into the guest.
+ *
+ * - Various EFI segments:
+ *  The rest of the physical memory can be made of any number of memory ranges
+ *  given by EFI memory descriptors at boottime. Those regions can possibly be
+ *  non-contiguous and cover everything needed to run the Runtime Services (i.e:
+ *  the code, data and IO).
+ *
+ * The above stage2 mapping is achieved using several memslots, one for each
+ * contiguous area of idmapped memory.
+ */
+
+static void *efi_data_pages;
+#define EDI_SDBX_DATA_PAGES_SIZE       PAGE_ALIGN(SZ_16K)
+
+#define EFI_SDBX_BASE_MEMSLOT          KVM_USER_MEM_SLOTS
+
+static void idmap_hpa_to_gpa(struct kvm *kvm, unsigned long sz, phys_addr_t pa)
+{
+       static int slot_nb = EFI_SDBX_BASE_MEMSLOT;
+       struct kvm_userspace_memory_region mem = {
+               .slot                   = slot_nb,
+               .memory_size            = sz,
+               .guest_phys_addr        = pa,
+       };
+
+       kvm_set_memory_region(kvm, &mem);
+
+       slot_nb++;
+}
+
+/*
+ * GUEST'S VIRTUAL MEMORY MAPPING
+ *
+ *         0x0 +------+
+ *             | Code |  The code and data pages can be accessed from the
+ *   PAGE_SIZE +------+  virtual low memory. The code page is the first page of
+ *             | Data |  VM and the data pages follow starting from the 2nd page
+ *      ...    +------+
+ *             |  //  |
+ *  Higher mem +------+
+ *             | EFI2 |  The rest of the memory is still dedicated to EFI. The
+ *             +------+  mapping is identical to the virtual mapping used by the
+ *             |  //  |  host, so the kernel's EFI arch specific code should
+ *             +------+  already have configured EFI for this mapping using a
+ *             | EFI1 |  call to SetVirtualAddressMap (SVAM).
+ *             +------+
+ *             |  //  |
+ *             +------+
+ *
+ * The above stage1 is achieved by extending, mapping and using efi_mm in the VM
+ */
+
+#define EFI_SDBX_CODE_PAGE_GVA         0x0
+#define EFI_SDBX_EXCEPTION_GVA         EFI_SDBX_CODE_PAGE_GVA
+#define EFI_SDBX_WRAPPER_GVA           (efi_sandbox_wrapper-efi_sandbox_excpt)
+#define EFI_SDBX_VECTORS_GVA           (efi_sandbox_vectors-efi_sandbox_excpt)
+
+#define EFI_SDBX_DATA_PAGE_GVA         PAGE_SIZE
+#define EFI_SDBX_STACK_POINTER_GVA     (PAGE_SIZE + EDI_SDBX_DATA_PAGES_SIZE)
+
+static void map_ptes_to_guest(struct kvm *kvm, pmd_t *pmd)
+{
+       pte_t *pte = pte_offset_kernel(pmd, 0UL);
+
+       idmap_hpa_to_gpa(kvm, PTRS_PER_PTE * sizeof(pte), virt_to_phys(pte));
+}
+
+static void map_pmds_to_guest(struct kvm *kvm, pud_t *pud)
+{
+       pmd_t *pmd = pmd_offset(pud, 0UL);
+       unsigned int i;
+
+       idmap_hpa_to_gpa(kvm, PTRS_PER_PTE * sizeof(pmd), virt_to_phys(pmd));
+       for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
+               if (!pmd_none(*pmd) && !pmd_sect(*pmd) && !pmd_bad(*pmd))
+                       map_ptes_to_guest(kvm, pmd);
+       }
+}
+
+static void map_puds_to_guest(struct kvm *kvm, pgd_t *pgd)
+{
+       pud_t *pud = pud_offset(pgd, 0UL);
+       unsigned int i;
+
+       idmap_hpa_to_gpa(kvm, PTRS_PER_PTE * sizeof(pud), virt_to_phys(pud));
+       for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
+               if (!pud_none(*pud) && !pud_sect(*pud) && !pud_bad(*pud))
+                       map_pmds_to_guest(kvm, pud);
+       }
+}
+
+static void map_pgds_to_guest(struct kvm *kvm, struct mm_struct *mm)
+{
+       pgd_t *pgd = pgd_offset(mm, 0UL);
+       unsigned int i;
+
+       idmap_hpa_to_gpa(kvm, PTRS_PER_PTE * sizeof(pgd), virt_to_phys(pgd));
+       for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
+               if (!pgd_none(*pgd) && !pgd_bad(*pgd))
+                       map_puds_to_guest(kvm, pgd);
+       }
+}
+
+/*
+ * RUNTIME SERVICE EXECUTION AND RETURN
+ *
+ * When the kernel or a module needs access to an EFI Runtime Service, the arch
+ * agnostic part of EFI enters "arch_efi_call_virt" which resolves in a call to
+ * one of the various efi_sandbox_* external wrappers at the end of this file.
+ *
+ * No two runtime services are ever executed@the same time thanks to the
+ * efi_runtime_lock semaphore, hence we don't have to worry about interlocking
+ * accesses to the VCPU.
+ *
+ * However, those external wrappers need to wait for the end of the execution of
+ * the runtime service in the VM. This is achieved thanks to the internal
+ * wrapper "efi_sandbox_wrapper" which issues an HVC when done.
+ *
+ * The HVC is caught by efi_sandbox_exit which, if appropriate, finishes the
+ * execution of kvm_arch_vcpu_ioctl_run. Therefore, the VM is only running when
+ * needed.
+ *
+ * EFI return values are written in x0 according to the ARM calling convention.
+ * However, since the VM is left using a hypercall, x0 contains the function
+ * ID according to the ARM SMCCC, so the Runtime Service's ret value is to be
+ * found in the x1 register.
+ */
+
+#define efi_sandbox_call_iwrapper(func)                                               \
+({                                                                            \
+       vcpu_set_reg(sandbox_vcpu, 10, (unsigned long int)efi.systab);         \
+       vcpu_set_reg(sandbox_vcpu, 11, offsetof(efi_runtime_services_t, func));\
+       *vcpu_pc(sandbox_vcpu) = EFI_SDBX_WRAPPER_GVA;                         \
+                                                                              \
+       if (!vcpu_load(sandbox_vcpu)) {                                        \
+               kvm_arch_vcpu_ioctl_run(sandbox_vcpu, sandbox_vcpu->run);      \
+               vcpu_put(sandbox_vcpu);                                        \
+       }                                                                      \
+                                                                              \
+       vcpu_get_reg(sandbox_vcpu, 1);                                         \
+})
+
+inline bool efi_sandbox_is_exit(struct kvm_vcpu *vcpu)
+{
+       unsigned long fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+       return fn == SMCCC_FN_EFI_SANDBOX_RET;
+}
+
+/*
+ * If we receive a SMCCC_FN_EFI_SANDBOX_RET from our own sandbox, we can stop
+ * the current kvm_arch_vcpu_ioctl_run cleanly by returning 0. Otherwise we
+ * propagate an error code.
+ */
+int efi_sandbox_exit(struct kvm_vcpu *origin_vcpu)
+{
+       if (origin_vcpu == sandbox_vcpu)
+               return 0;
+
+       return -EINVAL;
+}
+
+/*
+ * RUNTIME SERVICE ARGUMENTS PASSING
+ *
+ * The Runtime Services expect arguments to be passed in their registers using
+ * the usual ARM calling convention. Simple arguments such as integer values can
+ * just be serialized into the VCPU from the host. However, some of the Services
+ * expect pointers to buffers or data structures to access or return complex
+ * data. Those buffers are copied into the data pages defined above before
+ * executing the function and then copied back for host's usage. This avoids
+ * having to map kernel's pages to the guest.
+ */
+
+#define efi_sandbox_set_arg(arg_num, val)                                     \
+       vcpu_set_reg(sandbox_vcpu, arg_num, (unsigned long int)val)
+
+#define efi_sandbox_push_arg_ptr(arg_num, val, arg_size, offset)              \
+({                                                                            \
+       if (val) {                                                             \
+               phys_addr_t gva = EFI_SDBX_DATA_PAGE_GVA + offset;             \
+               memcpy(efi_data_pages + offset, val, (size_t)arg_size);        \
+               vcpu_set_reg(sandbox_vcpu, arg_num, gva);                      \
+               offset += arg_size;                                            \
+       }                                                                      \
+})
+
+#define efi_sandbox_pop_arg_ptr(val, arg_size, offset)                        \
+({                                                                            \
+       if (val) {                                                             \
+               offset -= arg_size;                                            \
+               memcpy(val, efi_data_pages + offset, arg_size);                \
+       }                                                                      \
+})
+
+/*
+ * Boot-time initialization
+ */
+
+void __init efi_arm_sandbox_init(struct mm_struct *efi_mm)
+{
+       efi_memory_desc_t *md;
+       struct kvm *kvm;
+       struct kvm_vcpu_init init;
+       phys_addr_t efi_code_page_pa, efi_data_pages_pa;
+
+       /* Create and configure the sandboxing context */
+       kvm = kvm_create_internal_vm(0);
+       kvm_vm_create_vcpu(kvm, 0);
+       sandbox_vcpu = kvm_get_vcpu_by_id(kvm, 0);
+       kvm_vcpu_preferred_target(&init);
+       kvm_arm_vcpu_init(sandbox_vcpu, &init);
+
+       vcpu_sys_reg(sandbox_vcpu, TTBR0_EL1) = virt_to_phys(efi_mm->pgd);
+       vcpu_sys_reg(sandbox_vcpu, TCR_EL1) = EFI_SANDBOX_TCR;
+       vcpu_sys_reg(sandbox_vcpu, SCTLR_EL1) = EFI_SANDBOX_SCTLR;
+       vcpu_sys_reg(sandbox_vcpu, VBAR_EL1) = EFI_SDBX_VECTORS_GVA;
+       vcpu_gp_regs(sandbox_vcpu)->sp_el1 = EFI_SDBX_STACK_POINTER_GVA;
+
+       /* Create the physical memory mapping (stage2 translation) */
+       efi_code_page_pa = __pa_symbol(efi_sandbox_excpt);
+       idmap_hpa_to_gpa(kvm, PAGE_SIZE, efi_code_page_pa);
+
+       efi_data_pages = kmalloc(EDI_SDBX_DATA_PAGES_SIZE, GFP_KERNEL);
+       efi_data_pages_pa = virt_to_phys(efi_data_pages);
+       idmap_hpa_to_gpa(kvm, EDI_SDBX_DATA_PAGES_SIZE, efi_data_pages_pa);
+
+       for_each_efi_memory_desc(md) {
+               phys_addr_t phys = md->phys_addr;
+               size_t size = md->num_pages << EFI_PAGE_SHIFT;
+
+               if (md->attribute & EFI_MEMORY_RUNTIME)
+                       idmap_hpa_to_gpa(kvm, size, phys);
+       }
+
+       /* Create the virtual memory mapping (stage1 translation) */
+       create_pgd_mapping(efi_mm, efi_code_page_pa, EFI_SDBX_CODE_PAGE_GVA,
+                          PAGE_SIZE, PAGE_KERNEL_EXEC, true);
+
+       create_pgd_mapping(efi_mm, efi_data_pages_pa, EFI_SDBX_DATA_PAGE_GVA,
+                          EDI_SDBX_DATA_PAGES_SIZE, PAGE_KERNEL, true);
+
+       map_pgds_to_guest(kvm, efi_mm);
+}
+
+/*
+ * Runtime Services External Wrappers
+ */
+
+efi_status_t efi_sandbox_get_time(efi_time_t *tm,
+                                 efi_time_cap_t *tc)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, tm, sizeof(efi_time_t), offset);
+       efi_sandbox_push_arg_ptr(1, tc, sizeof(efi_time_cap_t), offset);
+
+       ret = efi_sandbox_call_iwrapper(get_time);
+
+       efi_sandbox_pop_arg_ptr(tc, sizeof(efi_time_cap_t), offset);
+       efi_sandbox_pop_arg_ptr(tm, sizeof(efi_time_t), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_set_time(efi_time_t *tm)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, tm, sizeof(efi_time_t), offset);
+
+       ret = efi_sandbox_call_iwrapper(set_time);
+
+       efi_sandbox_pop_arg_ptr(tm, sizeof(efi_time_t), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_get_wakeup_time(efi_bool_t *enabled,
+                                        efi_bool_t *pending,
+                                        efi_time_t *tm)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, enabled, sizeof(efi_bool_t), offset);
+       efi_sandbox_push_arg_ptr(1, pending, sizeof(efi_bool_t), offset);
+       efi_sandbox_push_arg_ptr(2, tm, sizeof(efi_time_t), offset);
+
+       ret = efi_sandbox_call_iwrapper(get_wakeup_time);
+
+       efi_sandbox_pop_arg_ptr(tm, sizeof(efi_time_t), offset);
+       efi_sandbox_pop_arg_ptr(pending, sizeof(efi_bool_t), offset);
+       efi_sandbox_pop_arg_ptr(enabled, sizeof(efi_bool_t), offset);
+
+       return ret;
+
+}
+
+efi_status_t efi_sandbox_set_wakeup_time(efi_bool_t enabled,
+                                        efi_time_t *tm)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_set_arg(0, enabled);
+       efi_sandbox_push_arg_ptr(1, tm, sizeof(efi_time_t), offset);
+
+       ret = efi_sandbox_call_iwrapper(set_wakeup_time);
+
+       efi_sandbox_pop_arg_ptr(tm, sizeof(efi_time_t), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_get_variable(efi_char16_t *name,
+                                     efi_guid_t *vendor,
+                                     u32 *attr,
+                                     unsigned long *data_size,
+                                     void *data)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, name, 1024 * sizeof(efi_char16_t), offset);
+       efi_sandbox_push_arg_ptr(1, vendor, sizeof(efi_guid_t), offset);
+       efi_sandbox_push_arg_ptr(2, attr, sizeof(u32), offset);
+       efi_sandbox_push_arg_ptr(3, data_size, sizeof(unsigned long), offset);
+       efi_sandbox_push_arg_ptr(4, data, *data_size, offset);
+
+       ret = efi_sandbox_call_iwrapper(get_variable);
+
+       efi_sandbox_pop_arg_ptr(data, *data_size, offset);
+       efi_sandbox_pop_arg_ptr(data_size, sizeof(unsigned long), offset);
+       efi_sandbox_pop_arg_ptr(attr, sizeof(u32), offset);
+       efi_sandbox_pop_arg_ptr(vendor, sizeof(efi_guid_t), offset);
+       efi_sandbox_pop_arg_ptr(name, 1024 * sizeof(efi_char16_t), offset);
+
+       return ret;
+}
+
+
+efi_status_t efi_sandbox_get_next_variable(unsigned long *name_size,
+                                          efi_char16_t *name,
+                                          efi_guid_t *vendor)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, name_size, sizeof(unsigned long), offset);
+       efi_sandbox_push_arg_ptr(1, name, 1024 * sizeof(efi_char16_t), offset);
+       efi_sandbox_push_arg_ptr(2, vendor, sizeof(efi_guid_t), offset);
+
+       ret = efi_sandbox_call_iwrapper(get_next_variable);
+
+       efi_sandbox_pop_arg_ptr(vendor, sizeof(efi_guid_t), offset);
+       efi_sandbox_pop_arg_ptr(name, 1024 * sizeof(efi_char16_t), offset);
+       efi_sandbox_pop_arg_ptr(name_size, sizeof(unsigned long), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_set_variable(efi_char16_t *name,
+                                     efi_guid_t *vendor,
+                                     u32 attr,
+                                     unsigned long data_size,
+                                     void *data)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, name, 1024 * sizeof(efi_char16_t), offset);
+       efi_sandbox_push_arg_ptr(1, vendor, sizeof(efi_guid_t), offset);
+       efi_sandbox_set_arg(2, attr);
+       efi_sandbox_set_arg(3, data_size);
+       efi_sandbox_push_arg_ptr(4, data, data_size, offset);
+
+       ret = efi_sandbox_call_iwrapper(set_variable);
+
+       efi_sandbox_pop_arg_ptr(data, data_size, offset);
+       efi_sandbox_pop_arg_ptr(vendor, sizeof(efi_guid_t), offset);
+       efi_sandbox_pop_arg_ptr(name, 1024 * sizeof(efi_char16_t), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_query_variable_info(u32 attr,
+                                            u64 *storage_space,
+                                            u64 *remaining_space,
+                                            u64 *max_variable_size)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(1, storage_space, sizeof(u64), offset);
+       efi_sandbox_push_arg_ptr(2, remaining_space, sizeof(u64), offset);
+       efi_sandbox_push_arg_ptr(3, max_variable_size, sizeof(u64), offset);
+
+       ret = efi_sandbox_call_iwrapper(query_variable_info);
+
+       efi_sandbox_pop_arg_ptr(max_variable_size, sizeof(u64), offset);
+       efi_sandbox_pop_arg_ptr(remaining_space, sizeof(u64), offset);
+       efi_sandbox_pop_arg_ptr(storage_space, sizeof(u64), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_get_next_high_mono_count(u32 *count)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, count, sizeof(u32), offset);
+
+       ret = efi_sandbox_call_iwrapper(get_next_high_mono_count);
+
+       efi_sandbox_pop_arg_ptr(count, sizeof(u32), offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_reset_system(int reset_type,
+                                     efi_status_t status,
+                                     unsigned long data_size,
+                                     efi_char16_t *data)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_set_arg(0, reset_type);
+       efi_sandbox_set_arg(1, status);
+       efi_sandbox_set_arg(2, data_size);
+       efi_sandbox_push_arg_ptr(3, data, data_size, offset);
+
+       ret = efi_sandbox_call_iwrapper(reset_system);
+
+       efi_sandbox_pop_arg_ptr(data, data_size, offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_update_capsule(efi_capsule_header_t **capsules,
+                                       unsigned long count,
+                                       unsigned long sg_list)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, capsules, sizeof(efi_capsule_header_t *),
+                                offset);
+       efi_sandbox_set_arg(1, count);
+       efi_sandbox_set_arg(2, sg_list);
+
+       ret = efi_sandbox_call_iwrapper(update_capsule);
+
+       efi_sandbox_pop_arg_ptr(capsules, sizeof(efi_capsule_header_t *),
+                               offset);
+
+       return ret;
+}
+
+efi_status_t efi_sandbox_query_capsule_caps(efi_capsule_header_t **capsules,
+                                           unsigned long count,
+                                           u64 *max_size,
+                                           int *reset_type)
+{
+       unsigned long offset = 0;
+       efi_status_t ret;
+
+       efi_sandbox_push_arg_ptr(0, capsules, sizeof(efi_capsule_header_t *),
+                                offset);
+       efi_sandbox_set_arg(1, count);
+       efi_sandbox_push_arg_ptr(2, max_size, sizeof(u64), offset);
+       efi_sandbox_push_arg_ptr(3, reset_type, sizeof(int), offset);
+
+       ret = efi_sandbox_call_iwrapper(query_capsule_caps);
+
+       efi_sandbox_pop_arg_ptr(reset_type, sizeof(int), offset);
+       efi_sandbox_pop_arg_ptr(max_size, sizeof(u64), offset);
+       efi_sandbox_pop_arg_ptr(capsules, sizeof(efi_capsule_header_t *),
+                               offset);
+
+       return ret;
+}
diff --git a/include/linux/smccc_fn.h b/include/linux/smccc_fn.h
index f08145d..d5fe672 100644
--- a/include/linux/smccc_fn.h
+++ b/include/linux/smccc_fn.h
@@ -47,4 +47,7 @@
 #define SMCCC64_VDR_HYP_FN_BASE                0xc6000000
 #define SMCCC64_VDR_HYP_FN(n)          (SMCCC64_VDR_HYP_FN_BASE + (n))

+/* EFI Sandboxing services */
+#define SMCCC_FN_EFI_SANDBOX_RET       SMCCC64_VDR_HYP_FN(0)
+
 #endif /* __LINUX_SMCCC_FN_H */
--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
