From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:16 +0000
Subject: [PATCH 22/29] ARM: KVM: fix address validation for HYP mappings
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-23-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__create_hyp_mappings() performs some kind of address validation before
creating the mapping, by verifying that the start address is above
PAGE_OFFSET.

This check is not completely correct for kernel memory (the upper
boundary has to be checked as well so we do not end up with highmem
pages), and wrong for IO mappings (the mapping must exist in the vmalloc
region).

Fix this by using the proper predicates (virt_addr_valid and
is_vmalloc_addr), which also work correctly on ARM64 (where the vmalloc
region is below PAGE_OFFSET).

Also change the BUG_ON() into a less agressive error return.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index ead6b16..ec14269 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -200,8 +200,13 @@ static int __create_hyp_mappings(void *from, void *to, unsigned long *pfn_base)
 	unsigned long addr, next;
 	int err = 0;
 
-	BUG_ON(start > end);
-	if (start < PAGE_OFFSET)
+	if (start >= end)
+		return -EINVAL;
+	/* Check for a valid kernel memory mapping */
+	if (!pfn_base && (!virt_addr_valid(from) || !virt_addr_valid(to - 1)))
+		return -EINVAL;
+	/* Check for a valid kernel IO mapping */
+	if (pfn_base && (!is_vmalloc_addr(from) || !is_vmalloc_addr(to - 1)))
 		return -EINVAL;
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
-- 
1.7.12.4
