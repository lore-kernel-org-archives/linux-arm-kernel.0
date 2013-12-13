From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 19:05:44 +0000
Subject: [RFC PATCH 4/6] arm: mm: Compute pgprot values for huge page sections
In-Reply-To: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
References: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1386961546-10061-5-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The short descriptors memory code stores separate software and hardware
ptes. All the pgprot values that vmas inherit and all the pte
manipulation functions operate in terms of software ptes. The actual
hardware bits are then controlled by the pte setter functions.

For short descriptor transparent huge pages we can't really store
separate copies of the huge pages without fundamentally changing the pmd
traversing code. So one strategy is to work directly with the hardware
bits.

This patch adds code to compute the appropriate memory description bits
for an MT_MEMORY section and translates the executable, writable and
PROT_NONE information from the software pgprot to give us a hardware
pgprot that can be manipulated directly by the HugeTLB and THP code.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/mm/mmu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 580ef2d..476a668 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -338,6 +338,45 @@ const struct mem_type *get_mem_type(unsigned int type)
 EXPORT_SYMBOL(get_mem_type);
 
 /*
+ * If the system supports huge pages and we are running with short descriptors,
+ * then compute the pgprot values for a huge page. We do not need to do this
+ * with LPAE as there is no software/hardware bit distinction for ptes.
+ *
+ * We are only interested in:
+ * 1) The memory type: huge pages are user pages so a section of type
+ *    MT_MEMORY. This is used to create new huge ptes/thps.
+ *
+ * 2) XN, PROT_NONE, WRITE. These are set/unset through protection changes
+ *    by pte_modify or pmd_modify and are used to make new ptes/thps.
+ *
+ * The other bits: dirty, young, splitting are not modified by pte_modify
+ * or pmd_modify nor are they used to create new ptes or pmds thus they are not
+ * considered here.
+ */
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+static pgprot_t _hugepgprotval;
+
+pgprot_t get_huge_pgprot(pgprot_t newprot)
+{
+	pte_t inprot = __pte(pgprot_val(newprot));
+	pmd_t pmdret = __pmd(pgprot_val(_hugepgprotval));
+
+	if (!pte_exec(inprot))
+		pmdret = pmd_mknexec(pmdret);
+
+	if (pte_write(inprot))
+		pmdret = pmd_mkwrite(pmdret);
+
+	if (!pte_protnone(inprot))
+		pmdret = pmd_rmprotnone(pmdret);
+
+	return __pgprot(pmd_val(pmdret));
+}
+EXPORT_SYMBOL(get_huge_pgprot);
+#endif
+
+
+/*
  * Adjust the PMD section entries according to the CPU in use.
  */
 static void __init build_mem_type_table(void)
@@ -568,6 +607,19 @@ static void __init build_mem_type_table(void)
 		if (t->prot_sect)
 			t->prot_sect |= PMD_DOMAIN(t->domain);
 	}
+
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+	/*
+	 * we assume all huge pages are user pages and that hardware access
+	 * flag updates are disabled (which is the case for short descriptors).
+	 */
+	pgprot_val(_hugepgprotval) = mem_types[MT_MEMORY].prot_sect
+					| PMD_SECT_AP_READ | PMD_SECT_nG;
+
+	pgprot_val(_hugepgprotval) &= ~(PMD_SECT_AP_WRITE | PMD_SECT_XN
+					| PMD_TYPE_SECT);
+#endif
+
 }
 
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
-- 
1.8.1.4
