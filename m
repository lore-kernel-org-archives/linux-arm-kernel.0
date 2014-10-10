From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 09 Oct 2014 19:34:05 -0700
Subject: [PATCH 1/3] arm64: ARMv8 headers changes for dirty page logging
In-Reply-To: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
References: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <1412908447-28247-2-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces header updates for ARMv8 dirty page logging.

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/include/asm/kvm_asm.h       |  1 +
 arch/arm64/include/asm/kvm_host.h      |  1 +
 arch/arm64/include/asm/kvm_mmu.h       | 20 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9fcd54b..bb1a870 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -101,6 +101,7 @@ extern char __kvm_hyp_code_end[];
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 92242ce..5714706 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -180,6 +180,7 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
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
index 955e8c5..21771f6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -87,6 +87,7 @@
 #define PTE_S2_RDONLY		(_AT(pteval_t, 1) << 6)   /* HAP[2:1] */
 #define PTE_S2_RDWR		(_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
 
+#define PMD_S2_RDONLY		(_AT(pmdval_t, 1) << 6)   /* HAP[2:1] */
 #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
 
 /*
-- 
1.9.1
