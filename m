From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Mar 2018 15:55:36 +0000
Subject: [PATCH v5 21/23] arm64: Make BP hardening slot counter available
In-Reply-To: <20180301155538.26860-1-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
Message-ID: <20180301155538.26860-22-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to need to allocate hardening slots from other parts
of the kernel (in order to support ARM64_HARDEN_EL2_VECTORS).

Turn the counter into an atomic_t and make it available to the
rest of the kernel. Also add BP_HARDEN_EL2_SLOTS as the number of
slots instead of the hardcoded 4...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/mmu.h   | 3 +++
 arch/arm64/kernel/bpi.S        | 3 ++-
 arch/arm64/kernel/cpu_errata.c | 9 ++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index a050d4f3615d..3baf010fe883 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -21,6 +21,8 @@
 #define USER_ASID_FLAG	(UL(1) << USER_ASID_BIT)
 #define TTBR_ASID_MASK	(UL(0xffff) << 48)
 
+#define BP_HARDEN_EL2_SLOTS 4
+
 #ifndef __ASSEMBLY__
 
 typedef struct {
@@ -51,6 +53,7 @@ struct bp_hardening_data {
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 extern char __bp_harden_hyp_vecs_start[], __bp_harden_hyp_vecs_end[];
+extern atomic_t arm64_el2_vector_last_slot;
 
 DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
index e8d997788ad0..8d62d5ce2812 100644
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -20,6 +20,7 @@
 #include <linux/arm-smccc.h>
 
 #include <asm/alternative.h>
+#include <asm/mmu.h>
 #include <asm/kvm_mmu.h>
 
 .macro hyp_ventry offset
@@ -62,7 +63,7 @@ alternative_endif
 
 	.align	11
 ENTRY(__bp_harden_hyp_vecs_start)
-	.rept 4
+	.rept BP_HARDEN_EL2_SLOTS
 	generate_vectors
 	.endr
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 52f15cd896e1..8cf6b60a085a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -60,6 +60,8 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 	return 0;
 }
 
+atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -90,7 +92,6 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
 				      const char *hyp_vecs_end)
 {
-	static int last_slot = -1;
 	static DEFINE_SPINLOCK(bp_lock);
 	int cpu, slot = -1;
 
@@ -103,10 +104,8 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 	}
 
 	if (slot == -1) {
-		last_slot++;
-		BUG_ON(((__bp_harden_hyp_vecs_end - __bp_harden_hyp_vecs_start)
-			/ SZ_2K) <= last_slot);
-		slot = last_slot;
+		slot = atomic_inc_return(&arm64_el2_vector_last_slot);
+		BUG_ON(slot >= BP_HARDEN_EL2_SLOTS);
 		__copy_hyp_vect_bpi(slot, hyp_vecs_start, hyp_vecs_end);
 	}
 
-- 
2.14.2
