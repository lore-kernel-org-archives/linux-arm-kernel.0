From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 20 Aug 2014 11:13:35 +0200
Subject: [PATCH v2 1/2] KVM: Introduce gfn_to_hva_memslot_prot
Message-ID: <1408526016-4696-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support read-only memory regions on arm and arm64, we have a need to
resolve a gfn to an hva given a pointer to a memslot to avoid looping
through the memslots twice and to reuse the hva error checking of
gfn_to_hva_prot(), add a new gfn_to_hva_memslot_prot() function and
refactor gfn_to_hva_prot() to use this function.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changelog[v2]:
 - Fix typo in patch title

 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a4c33b3..85875e0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -528,6 +528,8 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn);
 unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn);
 unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable);
 unsigned long gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn);
+unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
+				      bool *writable);
 void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 void kvm_set_page_accessed(struct page *page);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 33712fb..36b887d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1075,9 +1075,9 @@ EXPORT_SYMBOL_GPL(gfn_to_hva);
  * If writable is set to false, the hva returned by this function is only
  * allowed to be read.
  */
-unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
+unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
+				      gfn_t gfn, bool *writable)
 {
-	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 	unsigned long hva = __gfn_to_hva_many(slot, gfn, NULL, false);
 
 	if (!kvm_is_error_hva(hva) && writable)
@@ -1086,6 +1086,13 @@ unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
 	return hva;
 }
 
+unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+
+	return gfn_to_hva_memslot_prot(slot, gfn, writable);
+}
+
 static int kvm_read_hva(void *data, void __user *hva, int len)
 {
 	return __copy_from_user(data, hva, len);
-- 
2.0.0
