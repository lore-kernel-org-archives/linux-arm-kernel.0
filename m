From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Nov 2013 14:37:42 -0500
Subject: [PATCH 2/6] ARM: kvm: Use virt_to_idmap instead of virt_to_phys for
 idmap mappings
In-Reply-To: <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
References: <y>
 <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1384457866-16135-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM initialisation fails on architectures implementing virt_to_idmap() because
virt_to_phys() on such architectures won't fetch you the correct idmap page.

So update the KVM ARM code to use the virt_to_idmap() to fix the issue.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kvm/mmu.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b0de86b..3bd652f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -747,9 +747,9 @@ int kvm_mmu_init(void)
 {
 	int err;
 
-	hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
-	hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
-	hyp_idmap_vector = virt_to_phys(__kvm_hyp_init);
+	hyp_idmap_start = virt_to_idmap(__hyp_idmap_text_start);
+	hyp_idmap_end = virt_to_idmap(__hyp_idmap_text_end);
+	hyp_idmap_vector = virt_to_idmap(__kvm_hyp_init);
 
 	if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
 		/*
@@ -775,8 +775,7 @@ int kvm_mmu_init(void)
 		 * caches off at that point.
 		 */
 		kvm_flush_dcache_to_poc(init_bounce_page, len);
-
-		phys_base = virt_to_phys(init_bounce_page);
+		phys_base = virt_to_idmap(init_bounce_page);
 		hyp_idmap_vector += phys_base - hyp_idmap_start;
 		hyp_idmap_start = phys_base;
 		hyp_idmap_end = phys_base + len;
-- 
1.7.9.5
