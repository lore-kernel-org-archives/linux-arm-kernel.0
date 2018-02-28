From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:25 +0800
Subject: [PATCH 03/29] arm64: mm: Allocate ASIDs in pairs
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-4-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 0c8ea531b774 upstream.

In preparation for separate kernel/user ASIDs, allocate them in pairs
for each mm_struct. The bottom bit distinguishes the two: if it is set,
then the ASID will map only userspace.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no MMCF_AARCH32 in arch/arm64/include/asm/mmu.h
---
 arch/arm64/include/asm/mmu.h |  2 ++
 arch/arm64/mm/context.c      | 25 +++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce0..49924e5 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#define USER_ASID_FLAG	(UL(1) << 48)
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index efcf1f7..f00f5ee 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -39,7 +39,16 @@ static cpumask_t tlb_flush_pending;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION >> 1)
+#define asid2idx(asid)		(((asid) & ~ASID_MASK) >> 1)
+#define idx2asid(idx)		(((idx) << 1) & ~ASID_MASK)
+#else
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION)
+#define asid2idx(asid)		((asid) & ~ASID_MASK)
+#define idx2asid(idx)		asid2idx(idx)
+#endif
 
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -104,7 +113,7 @@ static void flush_context(unsigned int cpu)
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid & ~ASID_MASK, asid_map);
+		__set_bit(asid2idx(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -159,16 +168,16 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		asid &= ~ASID_MASK;
-		if (!__test_and_set_bit(asid, asid_map))
+		if (!__test_and_set_bit(asid2idx(asid), asid_map))
 			return newasid;
 	}
 
 	/*
 	 * Allocate a free ASID. If we can't find one, take a note of the
-	 * currently active ASIDs and mark the TLBs as requiring flushes.
-	 * We always count from ASID #1, as we use ASID #0 when setting a
-	 * reserved TTBR0 for the init_mm.
+	 * currently active ASIDs and mark the TLBs as requiring flushes.  We
+	 * always count from ASID #2 (index 1), as we use ASID #0 when setting
+	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
+	 * pairs.
 	 */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
 	if (asid != NUM_USER_ASIDS)
@@ -185,7 +194,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return asid | generation;
+	return idx2asid(asid) | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
-- 
2.7.4
