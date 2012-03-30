From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Mar 2012 13:29:47 +0100
Subject: [PATCH] ARM: Do not map the vectors page as write-through on UP
 systems
Message-ID: <1333110587-12879-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vectors page has been traditionally mapped as WT on UP systems but
this creates a mismatched alias with the directly mapped RAM that is
using WB attributes. On newer processors like Cortex-A15 this has
implications on the data/instructions coherency at the point of
unification (usually L2).

This patch removes such restriction.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 94c5a0c..21c20e3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -415,12 +415,6 @@ static void __init build_mem_type_table(void)
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
 
 	/*
-	 * Only use write-through for non-SMP systems
-	 */
-	if (!is_smp() && cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
-		vecs_pgprot = cache_policies[CPOLICY_WRITETHROUGH].pte;
-
-	/*
 	 * Enable CPU-specific coherency if supported.
 	 * (Only available on XSC3 at the moment.)
 	 */
