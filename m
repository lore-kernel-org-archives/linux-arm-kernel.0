From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 18:16:50 +0000
Subject: [PATCH v2 1/3] arm/arm64: KVM: Allow handle_hva_to_gpa to return a
 value
In-Reply-To: <1426184212-29333-1-git-send-email-marc.zyngier@arm.com>
References: <1426184212-29333-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426184212-29333-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, handle_hva_to_gpa was never required to return a value.
As we prepare to age pages at Stage-2, we need to be able to
return a value from the iterator (kvm_test_age_hva).

Adapt the code to handle this situation. No semantic change.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3e6859b..ffa06e0 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1377,15 +1377,16 @@ out_unlock:
 	return ret;
 }
 
-static void handle_hva_to_gpa(struct kvm *kvm,
-			      unsigned long start,
-			      unsigned long end,
-			      void (*handler)(struct kvm *kvm,
-					      gpa_t gpa, void *data),
-			      void *data)
+static int handle_hva_to_gpa(struct kvm *kvm,
+			     unsigned long start,
+			     unsigned long end,
+			     int (*handler)(struct kvm *kvm,
+					    gpa_t gpa, void *data),
+			     void *data)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	int ret = 0;
 
 	slots = kvm_memslots(kvm);
 
@@ -1409,14 +1410,17 @@ static void handle_hva_to_gpa(struct kvm *kvm,
 
 		for (; gfn < gfn_end; ++gfn) {
 			gpa_t gpa = gfn << PAGE_SHIFT;
-			handler(kvm, gpa, data);
+			ret |= handler(kvm, gpa, data);
 		}
 	}
+
+	return ret;
 }
 
-static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
+static int kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	unmap_stage2_range(kvm, gpa, PAGE_SIZE);
+	return 0;
 }
 
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
@@ -1442,7 +1446,7 @@ int kvm_unmap_hva_range(struct kvm *kvm,
 	return 0;
 }
 
-static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
+static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	pte_t *pte = (pte_t *)data;
 
@@ -1454,6 +1458,7 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)
 	 * through this calling path.
 	 */
 	stage2_set_pte(kvm, NULL, gpa, pte, 0);
+	return 0;
 }
 
 
-- 
2.1.4
