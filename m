From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:14:28 +0800
Subject: [PATCH 3/3] arm64: add a new macro for the pgd table descriptor
In-Reply-To: <1464574468-22700-1-git-send-email-shijie.huang@arm.com>
References: <1464574468-22700-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464574468-22700-3-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new macro for the pgd table descriptor to define the "Table"
type, and use it to replace the numerical constant in the pgd_bad().

This patch makes the code more legible.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 5 +++++
 arch/arm64/include/asm/pgtable.h       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 54e2fbf..f648c28 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -113,6 +113,11 @@
 /*
  * Hardware page table definitions.
  *
+ * Level 0 descriptor (PGD).
+ */
+#define PGD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
+
+/*
  * Level 1 descriptor (PUD).
  */
 #define PUD_TYPE_TABLE		(_AT(pudval_t, 3) << 0)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 46472a9..bfa0092 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -453,7 +453,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
 
 #define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
+#define pgd_bad(pgd)		(!(pgd_val(pgd) & PGD_TABLE_BIT))
 #define pgd_present(pgd)	(pgd_val(pgd))
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
-- 
2.5.5
