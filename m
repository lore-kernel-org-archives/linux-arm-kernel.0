From: steve.capper@arm.com (Steve Capper)
Date: Thu, 18 Oct 2012 17:15:37 +0100
Subject: [RFC PATCH 1/6] ARM: mm: correct pte_same behaviour for LPAE.
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Message-ID: <1350576942-25299-2-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
that are written to a page table but not for ptes created with mk_pte.

This can cause some comparison tests made by pte_same to fail spuriously and
lead to other problems.

To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
present before running the comparison.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    5 +++++
 arch/arm/include/asm/pgtable-3level.h |    5 +++++
 arch/arm/include/asm/pgtable.h        |   23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 2317a71..662a00e 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -125,6 +125,11 @@
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
 
 /*
+ * for 2 levels of paging we don't mask off any bits when comparing present ptes
+ */
+#define L_PTE_CMP_MASKOFF	0
+
+/*
  * These are the memory types, defined to be compatible with
  * pre-ARMv6 CPUs cacheable and bufferable bits:   XXCB
  */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index b249035..0eaeb55 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -84,6 +84,11 @@
 #define L_PTE_DIRTY_HIGH	(1 << (55 - 32))
 
 /*
+ * we need to mask off PTE_EXT_NG when comparing present ptes.
+ */
+#define L_PTE_CMP_MASKOFF      PTE_EXT_NG
+
+/*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
  */
 #define L_PTE_MT_UNCACHED	(_AT(pteval_t, 0) << 2)	/* strongly ordered */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 08c1231..c35bf46 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -248,6 +248,29 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 }
 
 /*
+ * For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
+ * that are written to a page table but not for ptes created with mk_pte.
+ *
+ * This can cause some comparison tests made by pte_same to fail spuriously and
+ * lead to other problems.
+ *
+ * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
+ * present before running the comparison.
+ */
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+       pteval_t vala = pte_val(pte_a), valb = pte_val(pte_b);
+       if (pte_present(pte_a))
+               vala &= ~L_PTE_CMP_MASKOFF;
+
+       if (pte_present(pte_b))
+               valb &= ~L_PTE_CMP_MASKOFF;
+
+       return vala == valb;
+}
+
+/*
  * Encode and decode a swap entry.  Swap entries are stored in the Linux
  * page tables as follows:
  *
-- 
1.7.9.5
