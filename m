From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:16:50 +0000
Subject: [PATCH] ARM: mm: use phys_addr_t for physical address when populating
 pud
Message-ID: <1361805410-8664-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating our initial mappings, we call alloc_init_pud, which
simply defers to alloc_init_section for mappings at the pmd level.

However, the physical address passed to alloc_init_pud is potentially
truncated to unsigned long, which could cause problems on systems making
use of LPAE.

This patch fixes the function prototype to use phys_addr_t.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e95a996..754c37f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -634,7 +634,7 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-	unsigned long end, unsigned long phys, const struct mem_type *type)
+	unsigned long end, phys_addr_t phys, const struct mem_type *type)
 {
 	pud_t *pud = pud_offset(pgd, addr);
 	unsigned long next;
-- 
1.8.0
