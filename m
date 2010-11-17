From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 17:28:54 +0000
Subject: [PATCH 2/5] ARM: pgtable: directly pass pgd/pmd/pte to their error
	functions
In-Reply-To: <20101117172717.GF5308@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
Message-ID: <E1PIloU-0007qY-T8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than passing the pte value to __pte_error, pass the raw pte_t
cookie instead.  Do the same for pmd and pgd functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/pgtable.h |   12 ++++++------
 arch/arm/kernel/traps.c        |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index d9f1bfa..f54d2fe 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -116,13 +116,13 @@
 #define LIBRARY_TEXT_START	0x0c000000
 
 #ifndef __ASSEMBLY__
-extern void __pte_error(const char *file, int line, unsigned long val);
-extern void __pmd_error(const char *file, int line, unsigned long val);
-extern void __pgd_error(const char *file, int line, unsigned long val);
+extern void __pte_error(const char *file, int line, pte_t);
+extern void __pmd_error(const char *file, int line, pmd_t);
+extern void __pgd_error(const char *file, int line, pgd_t);
 
-#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
-#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
-#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
+#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte)
+#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd)
+#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd)
 #endif /* !__ASSEMBLY__ */
 
 #define PMD_SIZE		(1UL << PMD_SHIFT)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 446aee9..354cd4c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -708,19 +708,19 @@ void __readwrite_bug(const char *fn)
 }
 EXPORT_SYMBOL(__readwrite_bug);
 
-void __pte_error(const char *file, int line, unsigned long val)
+void __pte_error(const char *file, int line, pte_t pte)
 {
-	printk("%s:%d: bad pte %08lx.\n", file, line, val);
+	printk("%s:%d: bad pte %08lx.\n", file, line, pte_val(pte));
 }
 
-void __pmd_error(const char *file, int line, unsigned long val)
+void __pmd_error(const char *file, int line, pmd_t pmd)
 {
-	printk("%s:%d: bad pmd %08lx.\n", file, line, val);
+	printk("%s:%d: bad pmd %08lx.\n", file, line, pmd_val(pmd));
 }
 
-void __pgd_error(const char *file, int line, unsigned long val)
+void __pgd_error(const char *file, int line, pgd_t pgd)
 {
-	printk("%s:%d: bad pgd %08lx.\n", file, line, val);
+	printk("%s:%d: bad pgd %08lx.\n", file, line, pgd_val(pgd));
 }
 
 asmlinkage void __div0(void)
-- 
1.6.2.5
