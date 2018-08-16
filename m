From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 16 Aug 2018 20:41:48 +0200
Subject: [PATCH 4.4 01/13] x86/mm: Disable ioremap free page handling on
 x86-PAE
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
References: <20180816171628.554317013@linuxfoundation.org>
Message-ID: <20180816171628.612166526@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit f967db0b9ed44ec3057a28f3b28efc51df51b835 upstream.

ioremap() supports pmd mappings on x86-PAE.  However, kernel's pmd
tables are not shared among processes on x86-PAE.  Therefore, any
update to sync'd pmd entries need re-syncing.  Freeing a pte page
also leads to a vmalloc fault and hits the BUG_ON in vmalloc_sync_one().

Disable free page handling on x86-PAE.  pud_free_pmd_page() and
pmd_free_pte_page() simply return 0 if a given pud/pmd entry is present.
This assures that ioremap() does not update sync'd pmd entries at the
cost of falling back to pte mappings.

Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Reported-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: mhocko at suse.com
Cc: akpm at linux-foundation.org
Cc: hpa at zytor.com
Cc: cpandya at codeaurora.org
Cc: linux-mm at kvack.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: stable at vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20180627141348.21777-2-toshi.kani at hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/pgtable.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -676,6 +676,7 @@ int pmd_clear_huge(pmd_t *pmd)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
@@ -723,4 +724,22 @@ int pmd_free_pte_page(pmd_t *pmd)
 
 	return 1;
 }
+
+#else /* !CONFIG_X86_64 */
+
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+/*
+ * Disable free page handling on x86-PAE. This assures that ioremap()
+ * does not update sync'd pmd entries. See vmalloc_sync_one().
+ */
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
+
+#endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
