From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Dec 2017 17:39:18 +0000
Subject: [PATCH v3 11/19] KVM: arm/arm64: Demote HYP VA range display to being
 a debug feature
In-Reply-To: <20171218173926.16911-1-marc.zyngier@arm.com>
References: <20171218173926.16911-1-marc.zyngier@arm.com>
Message-ID: <20171218173926.16911-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Displaying the HYP VA information is slightly counterproductive when
using VA randomization. Turn it into a debug feature only, and adjust
the last displayed value to reflect the top of RAM instead of ~0.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index b4b69c2d1012..84d09f1a44d4 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1760,9 +1760,10 @@ int kvm_mmu_init(void)
 	 */
 	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
 
-	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
-	kvm_info("HYP VA range: %lx:%lx\n",
-		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
+	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
+	kvm_debug("HYP VA range: %lx:%lx\n",
+		  kern_hyp_va(PAGE_OFFSET),
+		  kern_hyp_va((unsigned long)high_memory - 1));
 
 	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
 	    hyp_idmap_start <  kern_hyp_va(~0UL) &&
-- 
2.14.2
