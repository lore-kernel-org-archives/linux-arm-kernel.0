From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:35:57 +0100
Subject: [RESEND PATCH 3/4] ARM: mm: introduce L_PTE_VALID for page table
 entries
In-Reply-To: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
References: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488158-3399-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For long-descriptor translation table formats, the ARMv7 architecture
defines the last two bits of the second- and third-level descriptors to
be:

	x0b	- Invalid
	01b	- Block (second-level), Reserved (third-level)
	11b	- Table (second-level), Page (third-level)

This allows us to define L_PTE_PRESENT as (3 << 0) and use this value to
create ptes directly. However, when determining whether a given pte
value is present in the low-level page table accessors, we only need to
check the least significant bit of the descriptor, allowing us to write
faulting, present entries which are required for PROT_NONE mappings.

This patch introduces L_PTE_VALID, which can be used to test whether a
pte should fault, and updates the low-level page table accessors
accordingly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    1 +
 arch/arm/include/asm/pgtable-3level.h |    3 ++-
 arch/arm/include/asm/pgtable.h        |    4 +---
 arch/arm/mm/proc-v7-2level.S          |    2 +-
 arch/arm/mm/proc-v7-3level.S          |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 2317a71..c44a1ec 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -115,6 +115,7 @@
  * The PTE table pointer refers to the hardware entries; the "Linux"
  * entries are stored 1024 bytes below.
  */
+#define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
 #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index b249035..e32311a 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -67,7 +67,8 @@
  * These bits overlap with the hardware bits but the naming is preserved for
  * consistency with the classic page table format.
  */
-#define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Valid */
+#define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
+#define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
 #define L_PTE_FILE		(_AT(pteval_t, 1) << 2)		/* only when !PRESENT */
 #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 08c1231..ccf34b6 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -203,9 +203,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
 #define pte_special(pte)	(0)
 
-#define pte_present_user(pte) \
-	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) == \
-	 (L_PTE_PRESENT | L_PTE_USER))
+#define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
 
 #if __LINUX_ARM_ARCH__ < 6
 static inline void __sync_icache_dcache(pte_t pteval)
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index e37600b..e755e9f 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -100,7 +100,7 @@ ENTRY(cpu_v7_set_pte_ext)
 	orrne	r3, r3, #PTE_EXT_XN
 
 	tst	r1, #L_PTE_YOUNG
-	tstne	r1, #L_PTE_PRESENT
+	tstne	r1, #L_PTE_VALID
 	moveq	r3, #0
 
  ARM(	str	r3, [r0, #2048]! )
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 8de0f1d..d23d067 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -65,7 +65,7 @@ ENDPROC(cpu_v7_switch_mm)
  */
 ENTRY(cpu_v7_set_pte_ext)
 #ifdef CONFIG_MMU
-	tst	r2, #L_PTE_PRESENT
+	tst	r2, #L_PTE_VALID
 	beq	1f
 	tst	r3, #1 << (55 - 32)		@ L_PTE_DIRTY
 	orreq	r2, #L_PTE_RDONLY
-- 
1.7.4.1
