From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Dec 2013 18:26:01 +0000
Subject: [PATCH 1/3] ARM: mm: don't bother with reserved ttbr0 when running
 with LPAE
Message-ID: <1386872763-14845-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new ASID allocation algorithm, active ASIDs at the time of a
rollover event will be marked as reserved, so active mm_structs can
continue to operate with the same ASID as before. This in turn means
that we don't need to worry about allocating a new ASID to an mm that
is currently active (installed in TTBR0).

Since updating the pgd and ASID is atomic on LPAE systems (by virtue of
the two being fields in the same hardware register), we can dispose of
the reserved TTBR0 and rely on whatever tables we currently have live.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 84e6f772e204..3ad0fdaa5cc1 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -78,20 +78,21 @@ void a15_erratum_get_cpumask(int this_cpu, struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_ARM_LPAE
-static void cpu_set_reserved_ttbr0(void)
-{
-	/*
-	 * Set TTBR0 to swapper_pg_dir which contains only global entries. The
-	 * ASID is set to 0.
-	 */
-	cpu_set_ttbr(0, __pa(swapper_pg_dir));
-	isb();
-}
+/*
+ * With LPAE, the ASID and page tables are updated atomicly, so there is
+ * no need for a reserved set of tables (the active ASID tracking prevents
+ * any issues across a rollover).
+ */
+#define cpu_set_reserved_ttbr0()
 #else
 static void cpu_set_reserved_ttbr0(void)
 {
 	u32 ttb;
-	/* Copy TTBR1 into TTBR0 */
+	/*
+	 * Copy TTBR1 into TTBR0.
+	 * This points at swapper_pg_dir, which contains only global
+	 * entries so any speculative walks are perfectly safe.
+	 */
 	asm volatile(
 	"	mrc	p15, 0, %0, c2, c0, 1		@ read TTBR1\n"
 	"	mcr	p15, 0, %0, c2, c0, 0		@ set TTBR0\n"
-- 
1.8.2.2
