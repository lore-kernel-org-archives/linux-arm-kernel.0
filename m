From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 16 May 2017 10:34:55 +0100
Subject: [PATCH v3 2/2] kvm: arm/arm64: Fix use after free of stage2 page table
In-Reply-To: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
References: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1494927295-29369-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We yield the kvm->mmu_lock occassionaly while performing an operation
(e.g, unmap or permission changes) on a large area of stage2 mappings.
However this could possibly cause another thread to clear and free up
the stage2 page tables while we were waiting for regaining the lock and
thus the original thread could end up in accessing memory that was
freed. This patch fixes the problem by making sure that the stage2
pagetable is still valid after we regain the lock. The fact that
mmu_notifer->release() could be called twice (via __mmu_notifier_release
and mmu_notifier_unregsister) enhances the possibility of hitting
this race where there are two threads trying to unmap the entire guest
shadow pages.

While at it, cleanup the redudant checks around cond_resched_lock in
stage2_wp_range(), as cond_resched_lock already does the same checks.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Radim Kr?m?? <rkrcmar@redhat.com>
Cc: andreyknvl at google.com
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 704e35f..a2d6324 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -295,6 +295,13 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
 	assert_spin_locked(&kvm->mmu_lock);
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
 	do {
+		/*
+		 * Make sure the page table is still active, as another thread
+		 * could have possibly freed the page table, while we released
+		 * the lock.
+		 */
+		if (!READ_ONCE(kvm->arch.pgd))
+			break;
 		next = stage2_pgd_addr_end(addr, end);
 		if (!stage2_pgd_none(*pgd))
 			unmap_stage2_puds(kvm, pgd, addr, next);
@@ -1170,11 +1177,13 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 		 * large. Otherwise, we may see kernel panics with
 		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCKUP_DETECTOR,
 		 * CONFIG_LOCKDEP. Additionally, holding the lock too long
-		 * will also starve other vCPUs.
+		 * will also starve other vCPUs. We have to also make sure
+		 * that the page tables are not freed while we released
+		 * the lock.
 		 */
-		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
-			cond_resched_lock(&kvm->mmu_lock);
-
+		cond_resched_lock(&kvm->mmu_lock);
+		if (!READ_ONCE(kvm->arch.pgd))
+			break;
 		next = stage2_pgd_addr_end(addr, end);
 		if (stage2_pgd_present(*pgd))
 			stage2_wp_puds(pgd, addr, next);
-- 
2.7.4
