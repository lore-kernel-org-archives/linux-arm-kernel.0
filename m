From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:35 +0100
Subject: [PATCH v4 07/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the arm64 specific MMU backend:
- HYP/kernel VA offset
- S2 4/64kB definitions
- S2 page table populating and flushing
- icache cleaning

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 135 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 arch/arm64/include/asm/kvm_mmu.h

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
new file mode 100644
index 0000000..efe609c
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ARM64_KVM_MMU_H__
+#define __ARM64_KVM_MMU_H__
+
+#include <asm/page.h>
+#include <asm/memory.h>
+
+/*
+ * As we only have the TTBR0_EL2 register, we cannot express
+ * "negative" addresses. This makes it impossible to directly share
+ * mappings with the kernel.
+ *
+ * Instead, give the HYP mode its own VA region at a fixed offset from
+ * the kernel by just masking the top bits (which are all ones for a
+ * kernel address).
+ */
+#define HYP_PAGE_OFFSET_SHIFT	VA_BITS
+#define HYP_PAGE_OFFSET_MASK	((UL(1) << HYP_PAGE_OFFSET_SHIFT) - 1)
+#define HYP_PAGE_OFFSET		(PAGE_OFFSET & HYP_PAGE_OFFSET_MASK)
+
+/*
+ * Our virtual mapping for the idmap-ed MMU-enable code. Must be
+ * shared across all the page-tables. Conveniently, we use the last
+ * possible page, where no kernel mapping will ever exist.
+ */
+#define TRAMPOLINE_VA		(HYP_PAGE_OFFSET_MASK & PAGE_MASK)
+
+#ifdef __ASSEMBLY__
+
+/*
+ * Convert a kernel VA into a HYP VA.
+ * reg: VA to be converted.
+ */
+.macro kern_hyp_va	reg
+	and	\reg, \reg, #HYP_PAGE_OFFSET_MASK
+.endm
+
+#else
+
+#include <asm/cachetype.h>
+#include <asm/cacheflush.h>
+
+#define KERN_TO_HYP(kva)	((unsigned long)kva - PAGE_OFFSET + HYP_PAGE_OFFSET)
+
+/*
+ * Align KVM with the kernel's view of physical memory. Should be
+ * 40bit IPA, with PGD being 8kB aligned in the 4KB page configuration.
+ */
+#define KVM_PHYS_SHIFT	PHYS_MASK_SHIFT
+#define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
+#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
+
+/* Make sure we get the right size, and thus the right alignment */
+#define PTRS_PER_S2_PGD (1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
+#define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
+
+int create_hyp_mappings(void *from, void *to);
+int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
+void free_boot_hyp_pgd(void);
+void free_hyp_pgds(void);
+
+int kvm_alloc_stage2_pgd(struct kvm *kvm);
+void kvm_free_stage2_pgd(struct kvm *kvm);
+int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
+			  phys_addr_t pa, unsigned long size);
+
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
+
+void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
+
+phys_addr_t kvm_mmu_get_httbr(void);
+phys_addr_t kvm_mmu_get_boot_httbr(void);
+phys_addr_t kvm_get_idmap_vector(void);
+int kvm_mmu_init(void);
+void kvm_clear_hyp_idmap(void);
+
+#define	kvm_set_pte(ptep, pte)		set_pte(ptep, pte)
+
+static inline bool kvm_is_write_fault(unsigned long esr)
+{
+	unsigned long esr_ec = esr >> ESR_EL2_EC_SHIFT;
+
+	if (esr_ec == ESR_EL2_EC_IABT)
+		return false;
+
+	if ((esr & ESR_EL2_ISV) && !(esr & ESR_EL2_WNR))
+		return false;
+
+	return true;
+}
+
+static inline void kvm_clean_dcache_area(void *addr, size_t size) {}
+static inline void kvm_clean_pgd(pgd_t *pgd) {}
+static inline void kvm_clean_pmd_entry(pmd_t *pmd) {}
+static inline void kvm_clean_pte(pte_t *pte) {}
+static inline void kvm_clean_pte_entry(pte_t *pte) {}
+
+static inline void kvm_set_s2pte_writable(pte_t *pte)
+{
+	pte_val(*pte) |= PTE_S2_RDWR;
+}
+
+struct kvm;
+
+static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+{
+	if (!icache_is_aliasing()) {		/* PIPT */
+		unsigned long hva = gfn_to_hva(kvm, gfn);
+		flush_icache_range(hva, hva + PAGE_SIZE);
+	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
+		/* any kind of VIPT cache */
+		__flush_icache_all();
+	}
+}
+
+#define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ARM64_KVM_MMU_H__ */
-- 
1.8.2.3
