From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 29 Sep 2010 22:13:16 +0530
Subject: [PATCH] ARM: mmu: Fix MT_MEMORY and MT_MEMORY_NONCACHED pte flags
Message-ID: <1285778596-12560-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit f1a2481c0 sets up the default flags for MT_MEMORY and
MT_MEMORY_NONCACHED memory types. L_PTE_USER flag is wrongly
set as default for these entries so remove it. Also adding
the 'L_PTE_WRITE' flag so that these pages become read-write
instead of just being read-only

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6a3a2d0..e8ed9dc 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -248,7 +248,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_EXEC,
+				L_PTE_WRITE | L_PTE_EXEC,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
@@ -259,7 +259,7 @@ static struct mem_type mem_types[] = {
 	},
 	[MT_MEMORY_NONCACHED] = {
 		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
-				L_PTE_USER | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
+				L_PTE_WRITE | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
 		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
-- 
1.6.0.4
