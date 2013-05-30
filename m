From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Thu, 30 May 2013 19:46:00 +0800
Subject: [PATCH v2] ARM: map_init_section flushes incorrect pmd
In-Reply-To: <CANutaR_ZHWdXQrZNBN91K==n3taMKBptmyU0+8DT1RzBStNCyA@mail.gmail.com>
References: <CANutaR_ZHWdXQrZNBN91K==n3taMKBptmyU0+8DT1RzBStNCyA@mail.gmail.com>
Message-ID: <1369914361-4237-1-git-send-email-ratbert.chuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug was introduced in commit e651eab0.
Some v4/v5 platforms failed to boot due to this.

Signed-off-by: Po-Yu Chuang <ratbert.chuang@gmail.com>
---
v2:
prefix underscores to map_init_section to emphasize that it should never be
called by some random function.

 arch/arm/mm/mmu.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..4d409e6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -616,10 +616,12 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
 
-static void __init map_init_section(pmd_t *pmd, unsigned long addr,
+static void __init __map_init_section(pmd_t *pmd, unsigned long addr,
 			unsigned long end, phys_addr_t phys,
 			const struct mem_type *type)
 {
+	pmd_t *p = pmd;
+
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * In classic MMU format, puds and pmds are folded in to
@@ -638,7 +640,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
 		phys += SECTION_SIZE;
 	} while (pmd++, addr += SECTION_SIZE, addr != end);
 
-	flush_pmd_entry(pmd);
+	flush_pmd_entry(p);
 }
 
 static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
@@ -661,7 +663,7 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 		 */
 		if (type->prot_sect &&
 				((addr | next | phys) & ~SECTION_MASK) == 0) {
-			map_init_section(pmd, addr, next, phys, type);
+			__map_init_section(pmd, addr, next, phys, type);
 		} else {
 			alloc_init_pte(pmd, addr, next,
 						__phys_to_pfn(phys), type);
-- 
1.7.9.5
