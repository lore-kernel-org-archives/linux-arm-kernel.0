From: labbott@fedoraproject.org (Laura Abbott)
Date: Mon, 25 Jan 2016 08:52:13 -0800
Subject: [RFC][PATCH 2/4] arm64: Add option to force mapping with PAGE_SIZE
 pages
In-Reply-To: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
References: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1453740735-17898-3-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under some circumstances (e.g. debugging) it may be useful to have all
kernel memory mapped using PAGE_SIZE pages. Add an option for this.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 arch/arm64/Kconfig  | 11 +++++++++++
 arch/arm64/mm/mmu.c | 10 +++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ffa3c54..faf7eac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -504,6 +504,17 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
+config FORCE_PAGES
+	bool "Force all memory mappings to be PAGE_SIZE"
+	help
+	  For performance reasons, kernel memory may be mapped with
+	  page table entries larger than the expected PAGE_SIZE. This results
+	  in better TLB performance but prevents adjustment of page table
+	  attributes at runtime. Say Y here to have all kernel memory mapped
+	  with PAGE_SIZE entries.
+
+	  If unsure, say N.
+
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2d6e7cf..450d38a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -181,7 +181,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	do {
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
-		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
+		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
+		      (!IS_ENABLED(CONFIG_FORCE_PAGES) || !pgtable_alloc)) {
 			pmd_t old_pmd =*pmd;
 			set_pmd(pmd, __pmd(phys |
 					   pgprot_val(mk_sect_prot(prot))));
@@ -208,8 +209,11 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 }
 
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
-			unsigned long phys)
+			unsigned long phys, phys_addr_t (*pgtable_alloc)(void))
 {
+	if (pgtable_alloc && IS_ENABLED(CONFIG_FORCE_PAGES))
+		return false;
+
 	if (PAGE_SHIFT != 12)
 		return false;
 
@@ -241,7 +245,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (use_1G_block(addr, next, phys)) {
+		if (use_1G_block(addr, next, phys, pgtable_alloc)) {
 			pud_t old_pud = *pud;
 			set_pud(pud, __pud(phys |
 					   pgprot_val(mk_sect_prot(prot))));
-- 
2.5.0
