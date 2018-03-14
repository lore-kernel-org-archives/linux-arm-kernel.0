From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 16:50:41 +0000
Subject: [PATCH v6 18/26] arm64: KVM: Move vector offsetting from hyp-init.S
 to kvm_get_hyp_vector
In-Reply-To: <20180314165049.30105-1-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
Message-ID: <20180314165049.30105-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently provide the hyp-init code with a kernel VA, and expect
it to turn it into a HYP va by itself. As we're about to provide
the hypervisor with mappings that are not necessarily in the memory
range, let's move the kern_hyp_va macro to kvm_get_hyp_vector.

No functionnal change.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 ++-
 arch/arm64/kvm/hyp-init.S        | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a5e0fc900de8..bfb81e73da06 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -374,6 +374,7 @@ static inline void *kvm_get_hyp_vector(void)
 			vect = lm_alias(vect);
 	}
 
+	vect = kern_hyp_va(vect);
 	return vect;
 }
 
@@ -387,7 +388,7 @@ static inline int kvm_map_vectors(void)
 #else
 static inline void *kvm_get_hyp_vector(void)
 {
-	return kvm_ksym_ref(__kvm_hyp_vector);
+	return kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
 }
 
 static inline int kvm_map_vectors(void)
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 5aa9ccf6db99..6fd91b31a131 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -117,7 +117,6 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	/* Set the stack and new vectors */
 	kern_hyp_va	x1
 	mov	sp, x1
-	kern_hyp_va	x2
 	msr	vbar_el2, x2
 
 	/* copy tpidr_el1 into tpidr_el2 for use by HYP */
-- 
2.14.2
