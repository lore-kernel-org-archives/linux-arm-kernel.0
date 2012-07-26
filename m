From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jul 2012 17:01:08 +0100
Subject: [PATCH 2/2] ARM: mm: use 5 bits for swapfile type encoding
In-Reply-To: <1343318468-10412-1-git-send-email-will.deacon@arm.com>
References: <1343318468-10412-1-git-send-email-will.deacon@arm.com>
Message-ID: <1343318468-10412-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Page migration encodes the pfn in the offset field of a swp_entry_t.
For LPAE, we support physical addresses of up to 36 bits (due to
sparsemem limitations with the size of page flags), requiring 24 bits
to represent a pfn. A further 3 bits are used to encode a swp_entry into
a pte, leaving 5 bits for the type field. Furthermore, the core code
defines MAX_SWAPFILES_SHIFT as 5, so the additional type bit does not
get used.

This patch reduces the width of the type field to 5 bits, allowing us
to create up to 31 swapfiles of 64GB each.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index d88f9f0..41dc31f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -253,13 +253,13 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  *
  *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *   <--------------- offset --------------------> <- type --> 0 0 0
+ *   <--------------- offset ----------------------> < type -> 0 0 0
  *
- * This gives us up to 63 swap files and 32GB per swap file.  Note that
+ * This gives us up to 31 swap files and 64GB per swap file.  Note that
  * the offset field is always non-zero.
  */
 #define __SWP_TYPE_SHIFT	3
-#define __SWP_TYPE_BITS		6
+#define __SWP_TYPE_BITS		5
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
 #define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
 
-- 
1.7.4.1
