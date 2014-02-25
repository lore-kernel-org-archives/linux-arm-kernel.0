From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 25 Feb 2014 11:38:53 +0000
Subject: [PATCH V2 2/3] arm64: mm: Add double logical invert to pte accessors
In-Reply-To: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1393328334-27285-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Page table entries on ARM64 are 64 bits, and some pte functions such as
pte_dirty return a bitwise-and of a flag with the pte value. If the
flag to be tested resides in the upper 32 bits of the pte, then we run
into the danger of the result being dropped if downcast.

For example:
	gather_stats(page, md, pte_dirty(*pte), 1);
where pte_dirty(*pte) is downcast to an int.

This patch adds a double logical invert to all the pte_ accessors to
ensure predictable downcasting.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changes in V2: drop the pte_isset macro, just add the !!
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b524dcd..aa3917c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -136,11 +136,11 @@ extern struct page *empty_zero_page;
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
-#define pte_present(pte)	(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE))
-#define pte_dirty(pte)		(pte_val(pte) & PTE_DIRTY)
-#define pte_young(pte)		(pte_val(pte) & PTE_AF)
-#define pte_special(pte)	(pte_val(pte) & PTE_SPECIAL)
-#define pte_write(pte)		(pte_val(pte) & PTE_WRITE)
+#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
+#define pte_dirty(pte)		(!!(pte_val(pte) & PTE_DIRTY))
+#define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
+#define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
+#define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
 #define pte_exec(pte)		(!(pte_val(pte) & PTE_UXN))
 
 #define pte_valid_user(pte) \
-- 
1.8.1.4
