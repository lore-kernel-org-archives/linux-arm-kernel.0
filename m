From: gking@nvidia.com (gking at nvidia.com)
Date: Wed, 28 Jul 2010 18:25:05 -0700
Subject: [PATCH] [ARM] highmem: fix SMP preemption bug in kmap_high_l1_vipt
Message-ID: <1280366705-21334-1-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Howe <ahowe@nvidia.com>

smp_processor_id() must not be called from a preemptible context (this
is checked by CONFIG_DEBUG_PREEMPT).  kmap_high_l1_vipt() was doing so.
This lead to a problem where the wrong per_cpu kmap_high_l1_vipt_depth
could be incremented, causing a BUG_ON(*depth <= 0); in
kunmap_high_l1_vipt().

The solution is to move the call to smp_processor_id() after the call
to preempt_disable().

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/mm/highmem.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 086816b..6ab2440 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -163,19 +163,22 @@ static DEFINE_PER_CPU(int, kmap_high_l1_vipt_depth);
 
 void *kmap_high_l1_vipt(struct page *page, pte_t *saved_pte)
 {
-	unsigned int idx, cpu = smp_processor_id();
-	int *depth = &per_cpu(kmap_high_l1_vipt_depth, cpu);
+	unsigned int idx, cpu;
+	int *depth;
 	unsigned long vaddr, flags;
 	pte_t pte, *ptep;
 
+	if (!in_interrupt())
+		preempt_disable();
+
+	cpu = smp_processor_id();
+	depth = &per_cpu(kmap_high_l1_vipt_depth, cpu);
+
 	idx = KM_L1_CACHE + KM_TYPE_NR * cpu;
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	ptep = TOP_PTE(vaddr);
 	pte = mk_pte(page, kmap_prot);
 
-	if (!in_interrupt())
-		preempt_disable();
-
 	raw_local_irq_save(flags);
 	(*depth)++;
 	if (pte_val(*ptep) == pte_val(pte)) {
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
