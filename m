From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:19 +0000
Subject: [PATCH v3 10/20] ARM: LPAE: Change setup_mm_for_reboot() to work with
	LPAE
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-11-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function was assuming that there are only two levels of page
tables. The patch changes looping over the PMD entries to make it
compatible with LPAE.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/mmu.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0ce781f..e238340 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1098,13 +1098,16 @@ void setup_mm_for_reboot(char mode)
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		base_pmdval |= PMD_BIT4;
 
-	for (i = 0; i < FIRST_USER_PGD_NR + USER_PTRS_PER_PGD; i++, pgd++) {
+	for (i = 0; i < TASK_SIZE >> PMD_SHIFT; i++) {
 		unsigned long pmdval = (i << PMD_SHIFT) | base_pmdval;
 		pmd_t *pmd;
+		unsigned long addr = i << PMD_SHIFT;
 
-		pmd = pmd_off(pgd, i << PMD_SHIFT);
+		pmd = pmd_off(pgd + pgd_index(addr), addr);
 		pmd[0] = __pmd(pmdval);
+#ifndef CONFIG_ARM_LPAE
 		pmd[1] = __pmd(pmdval + (1 << (PMD_SHIFT - 1)));
+#endif
 		flush_pmd_entry(pmd);
 	}
 
