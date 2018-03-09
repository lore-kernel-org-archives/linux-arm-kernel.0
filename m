From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:58 +0800
Subject: [PATCH 15/39] arm64: KVM: Use per-CPU vector when BP hardening is
 enabled
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-16-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6840bdd73d07 upstream

Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.
BTW, lts 4.4 has no feature ARM64_HAS_VIRT_HOST_EXTN, so no change for this.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   | 10 +++++++++
 arch/arm/kvm/arm.c               |  8 ++++++-
 arch/arm64/include/asm/kvm_mmu.h | 36 ++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 23d5cad56ddc..9b32b13a91ba 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -272,6 +272,16 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 				       pgd_t *merged_hyp_pgd,
 				       unsigned long hyp_idmap_start) { }
 
+static inline void *kvm_get_hyp_vector(void)
+{
+	return __kvm_hyp_vector;
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d7bef2144760..dc8b5943985c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -967,7 +967,7 @@ static void cpu_init_hyp_mode(void *dummy)
 	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
-	vector_ptr = (unsigned long)__kvm_hyp_vector;
+	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
 	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 
@@ -1065,6 +1065,12 @@ static int init_hyp_mode(void)
 		goto out_free_mappings;
 	}
 
+	err = kvm_map_vectors();
+	if (err) {
+		kvm_err("Cannot map vectors\n");
+		goto out_err;
+	}
+
 	/*
 	 * Map the Hyp stack pages
 	 */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 819b21a9851c..0b33258cd8ac 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -301,5 +301,41 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 	merged_hyp_pgd[idmap_idx] = __pgd(__pa(boot_hyp_pgd) | PMD_TYPE_TABLE);
 }
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#include <asm/mmu.h>
+
+static inline void *kvm_get_hyp_vector(void)
+{
+	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
+	void *vect = __kvm_hyp_vector;
+
+	if (data->fn) {
+		vect = __bp_harden_hyp_vecs_start +
+		       data->hyp_vectors_slot * SZ_2K;
+
+		vect = lm_alias(vect);
+	}
+
+	return vect;
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return create_hyp_mappings(__bp_harden_hyp_vecs_start,
+				   __bp_harden_hyp_vecs_end);
+}
+
+#else
+static inline void *kvm_get_hyp_vector(void)
+{
+	return __kvm_hyp_vector;
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
-- 
2.16.2.440.gc6284da
