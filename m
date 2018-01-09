From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  9 Jan 2018 19:04:02 +0000
Subject: [PATCH v1 07/16] kvm: arm/arm64: Remove spurious WARN_ON
In-Reply-To: <20180109190414.4017-1-suzuki.poulose@arm.com>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
Message-ID: <20180109190414.4017-8-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a 4-level page table pgd entry can be empty, unlike a 3-level
page table. Remove the spurious WARN_ON() in stage_get_pud().

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e6548c85c495..78253fe00fc4 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -870,7 +870,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	pud_t *pud;
 
 	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
-	if (WARN_ON(stage2_pgd_none(*pgd))) {
+	if (stage2_pgd_none(*pgd)) {
 		if (!cache)
 			return NULL;
 		pud = mmu_memory_cache_alloc(cache);
-- 
2.13.6
