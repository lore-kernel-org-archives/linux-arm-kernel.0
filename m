From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Feb 2017 14:59:11 +0000
Subject: [PATCH 13/25] arm/arm64: KVM: Get rid of KVM_MEMSLOT_INCOHERENT
In-Reply-To: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
References: <1486652363-7696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1486652363-7696-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM_MEMSLOT_INCOHERENT is not used anymore, as we've killed its
only use in the arm/arm64 MMU code. Let's remove the last artifacts.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c       | 9 ---------
 include/linux/kvm_host.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 5cc35080..962616f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -1876,15 +1876,6 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			    unsigned long npages)
 {
-	/*
-	 * Readonly memslots are not incoherent with the caches by definition,
-	 * but in practice, they are used mostly to emulate ROMs or NOR flashes
-	 * that the guest may consider devices and hence map as uncached.
-	 * To prevent incoherency issues in these cases, tag all readonly
-	 * regions as incoherent.
-	 */
-	if (slot->flags & KVM_MEM_READONLY)
-		slot->flags |= KVM_MEMSLOT_INCOHERENT;
 	return 0;
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1c5190d..cda457b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -45,7 +45,6 @@
  * include/linux/kvm_h.
  */
 #define KVM_MEMSLOT_INVALID	(1UL << 16)
-#define KVM_MEMSLOT_INCOHERENT	(1UL << 17)
 
 /* Two fragments for cross MMIO pages. */
 #define KVM_MAX_MMIO_FRAGMENTS	2
-- 
2.1.4
