From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Oct 2013 18:31:29 -0700
Subject: [RFC PATCH 2/5] arm: mm: add new memory mapping types
In-Reply-To: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1381282292-25251-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Larry Bassel <lbassel@codeaurora.org>

Add mapping types similar to MT_MEMORY, except
that they are RW, RX or RO.

Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/mach/map.h |    3 +++
 arch/arm/mm/mmu.c               |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2fe141f..322f1d8 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -34,6 +34,9 @@ struct map_desc {
 #define MT_MEMORY_ITCM		13
 #define MT_MEMORY_SO		14
 #define MT_MEMORY_DMA_READY	15
+#define MT_MEMORY_R		16
+#define MT_MEMORY_RW		17
+#define MT_MEMORY_RX		18
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 53cdbd3..d846334 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -291,6 +291,21 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_R] = {
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_XN,
+		.domain    = DOMAIN_KERNEL,
+	},
+	[MT_MEMORY_RW] = {
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_XN,
+		.domain    = DOMAIN_KERNEL,
+	},
+	[MT_MEMORY_RX] = {
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT,
+		.domain    = DOMAIN_KERNEL,
+	},
 	[MT_ROM] = {
 		.prot_sect = PMD_TYPE_SECT,
 		.domain    = DOMAIN_KERNEL,
@@ -468,6 +483,8 @@ static void __init build_mem_type_table(void)
 		 * from SVC mode and no access from userspace.
 		 */
 		mem_types[MT_ROM].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
+		mem_types[MT_MEMORY_RX].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
+		mem_types[MT_MEMORY_R].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif
@@ -545,6 +562,9 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_DMA_READY].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
+	mem_types[MT_MEMORY_R].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY_RW].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY_RX].prot_sect |= ecc_mask | cp->pmd;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
 
 	switch (cp->pmd) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
