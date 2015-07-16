From: msalter@redhat.com (Mark Salter)
Date: Thu, 16 Jul 2015 13:58:53 -0400
Subject: [PATCH] arm64: remove dead code
Message-ID: <1437069533-22103-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68234df4ea79 ("arm64: kill flush_cache_all()") removed
soft_reset() from the kernel. This was the only caller of
setup_mm_for_reboot(), so remove that also.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/mmu.h |  1 -
 arch/arm64/mm/mmu.c          | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 79fcfb0..0302087 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -28,7 +28,6 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id & 0xffff)
 
 extern void paging_init(void);
-extern void setup_mm_for_reboot(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a4ede4e..63012fe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -461,17 +461,6 @@ void __init paging_init(void)
 }
 
 /*
- * Enable the identity mapping to allow the MMU disabling.
- */
-void setup_mm_for_reboot(void)
-{
-	cpu_set_reserved_ttbr0();
-	flush_tlb_all();
-	cpu_set_idmap_tcr_t0sz();
-	cpu_switch_mm(idmap_pg_dir, &init_mm);
-}
-
-/*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
 int kern_addr_valid(unsigned long addr)
-- 
2.4.3
