From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:20 +0000
Subject: [PATCH v3 11/20] ARM: LPAE: Remove the FIRST_USER_PGD_NR and
	USER_PTRS_PER_PGD definitions
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-12-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros were only used in setup_mm_for_reboot and get_pgd_slow.
Both have been modified to no longer use these definitions. One of the
reasons is the different meaning that PGD has with the 2-level and
3-level page tables.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    3 ---
 arch/arm/include/asm/pgtable-3level.h |    3 ---
 arch/arm/mm/pgd.c                     |    2 +-
 3 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 4e21166..a0548b6 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -92,9 +92,6 @@
  */
 #define FIRST_USER_ADDRESS	PAGE_SIZE
 
-#define FIRST_USER_PGD_NR	1
-#define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
-
 /*
  * section address mask and size definitions.
  */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 5b1482d..381b04b 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -58,9 +58,6 @@
  */
 #define FIRST_USER_ADDRESS	PAGE_SIZE
 
-#define FIRST_USER_PGD_NR	1
-#define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
-
 /*
  * section address mask and size definitions.
  */
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index e7c149b..09238fa 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -25,7 +25,7 @@
 #else
 #define alloc_pgd()	(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
 #define free_pgd(pgd)	free_pages((unsigned long)pgd, 2)
-#define FIRST_KERNEL_PGD_NR	(FIRST_USER_PGD_NR + USER_PTRS_PER_PGD)
+#define FIRST_KERNEL_PGD_NR	(TASK_SIZE >> PGDIR_SHIFT)
 #endif
 
 /*
