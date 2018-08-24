From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:39 +0100
Subject: [RFC PATCH 04/11] arm64: tlb: Justify non-leaf invalidation in
 flush_tlb_range()
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment to explain why we can't get away with last-level
invalidation in flush_tlb_range()

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index e257f8655b84..ddbf1718669d 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -182,6 +182,10 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
+	/*
+	 * We cannot use leaf-only invalidation here, since we may be invalidating
+	 * table entries as part of collapsing hugepages or moving page tables.
+	 */
 	__flush_tlb_range(vma, start, end, false);
 }
 
-- 
2.1.4
