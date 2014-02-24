From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 24 Feb 2014 15:33:25 +0000
Subject: [RFC PATCH 2/2] arm64: Introduce pte_isset(pte,flag)
In-Reply-To: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
References: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1393256005-2206-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Page table entries on ARM64 are 64 bits, and some pte functions such as
pte_dirty return a bitwise-and of a flag with the pte value. If the
flag to be tested resides in the upper 32 bits of the pte, then we run
into the danger of the result being dropped if downcast.

For example:
        gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

This patch introduces a new macro pte_isset which performs the bitwise
and, then performs a double logical invert to ensure predictable
downcasting.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b524dcd..5130dd8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -133,15 +133,16 @@ extern struct page *empty_zero_page;
 #define pte_unmap(pte)			do { } while (0)
 #define pte_unmap_nested(pte)		do { } while (0)
 
+#define pte_isset(pte, val)	(!!(pte_val(pte) & (val)))
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
-#define pte_present(pte)	(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE))
-#define pte_dirty(pte)		(pte_val(pte) & PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & PTE_AF)
-#define pte_special(pte)	(pte_val(pte) & PTE_SPECIAL)
-#define pte_write(pte)		(pte_val(pte) & PTE_WRITE)
-#define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
+#define pte_present(pte)	(pte_isset((pte), (PTE_VALID | PTE_PROT_NONE)))
+#define pte_dirty(pte)		(pte_isset((pte), PTE_DIRTY))
+#define pte_young(pte)		(pte_isset((pte), PTE_AF))
+#define pte_special(pte)	(pte_isset((pte), PTE_SPECIAL))
+#define pte_write(pte)		(pte_isset((pte), PTE_WRITE))
+#define pte_exec(pte)		(!(pte_isset((pte), PTE_UXN)))
 
 #define pte_valid_user(pte) \
 	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
-- 
1.8.1.4
