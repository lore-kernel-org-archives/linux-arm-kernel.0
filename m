From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Jun 2013 17:22:22 +0100
Subject: [PATCH] arm: fix pmd flushing in map_init_section
Message-ID: <1371226942-3189-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In e651eab0af: "ARM: 7677/1: LPAE: Fix mapping in alloc_init_section for
unaligned addresses", the pmd flushing was broken when split out to
map_init_section. At the end of the final iteration of the while loop,
pmd will point at the pmd_t immediately after the pmds we updated, and
thus flush_pmd_entry(pmd) won't flush the newly modified pmds. This has
been observed to prevent an 11MPCore system from booting.

This patch fixes this by remembering the address of the first pmd we
update and using this as the argument to flush_pmd_entry.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: R Sricharan <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: stable at vger.kernel.org
---
 arch/arm/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..22bc0ff 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -620,6 +620,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
 			unsigned long end, phys_addr_t phys,
 			const struct mem_type *type)
 {
+	pmd_t *p = pmd;
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * In classic MMU format, puds and pmds are folded in to
@@ -638,7 +639,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
 		phys += SECTION_SIZE;
 	} while (pmd++, addr += SECTION_SIZE, addr != end);
 
-	flush_pmd_entry(pmd);
+	flush_pmd_entry(p);
 }
 
 static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
-- 
1.8.1.1
