From: m.smarduch@samsung.com (m.smarduch at samsung.com)
Date: Sat, 15 Nov 2014 00:19:08 -0800
Subject: [PATCH v2 1/3] KVM: arm64: ARMv8 header changes for page logging
In-Reply-To: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
References: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1416039550-28125-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mario Smarduch <m.smarduch@samsung.com>

This patch adds arm64 helpers to write protect pmds/ptes and retrieve 
permissions while logging dirty pages. Also adds prototype to write protect 
a memory slot and adds a pmd define to check for read-only pmds.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/include/asm/kvm_asm.h       |  1 +
 arch/arm64/include/asm/kvm_host.h      |  1 +
 arch/arm64/include/asm/kvm_mmu.h       | 20 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4838421..4f7310f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -126,6 +126,7 @@ extern char __kvm_hyp_vector[];
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e10c45a..7548dbc 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -196,6 +196,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
 struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
 
 u64 kvm_call_hyp(void *hypfn, ...);
+void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		int exception_index);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 8e138c7..8b0ffe3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -121,6 +121,26 @@ static inline void kvm_set_s2pmd_writable(pmd_t *pmd)
 	pmd_val(*pmd) |= PMD_S2_RDWR;
 }
 
+static inline void kvm_set_s2pte_readonly(pte_t *pte)
+{
+	pte_val(*pte) = (pte_val(*pte) & ~PTE_S2_RDWR) | PTE_S2_RDONLY;
+}
+
+static inline bool kvm_s2pte_readonly(pte_t *pte)
+{
+	return (pte_val(*pte) & PTE_S2_RDWR) == PTE_S2_RDONLY;
+}
+
+static inline void kvm_set_s2pmd_readonly(pmd_t *pmd)
+{
+	pmd_val(*pmd) = (pmd_val(*pmd) & ~PMD_S2_RDWR) | PMD_S2_RDONLY;
+}
+
+static inline bool kvm_s2pmd_readonly(pmd_t *pmd)
+{
+	return (pmd_val(*pmd) & PMD_S2_RDWR) == PMD_S2_RDONLY;
+}
+
 #define kvm_pgd_addr_end(addr, end)	pgd_addr_end(addr, end)
 #define kvm_pud_addr_end(addr, end)	pud_addr_end(addr, end)
 #define kvm_pmd_addr_end(addr, end)	pmd_addr_end(addr, end)
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 88174e0..5f930cc 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -119,6 +119,7 @@
 #define PTE_S2_RDONLY		(_AT(pteval_t, 1) << 6)   /* HAP[2:1] */
 #define PTE_S2_RDWR		(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
 
+#define PMD_S2_RDONLY		(_AT(pmdval_t, 1) << 6)   /* HAP[2:1] */
 #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 
 /*
-- 
1.9.1
