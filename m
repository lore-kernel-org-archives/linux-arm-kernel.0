From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Tue, 28 May 2013 18:48:20 +0800
Subject: [PATCH] ARM: map_init_section flushes incorrect pmd
Message-ID: <1369738100-11152-1-git-send-email-ratbert.chuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug was introduced in commit e651eab0.
Some v4/v5 platforms failed to boot due to this.

Signed-off-by: Po-Yu Chuang <ratbert.chuang@gmail.com>
---
 arch/arm/mm/mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..19a43f8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -620,6 +620,8 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
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
-- 
1.7.9.5
