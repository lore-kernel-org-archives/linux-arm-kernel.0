From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:37 +0000
Subject: [PATCH 09/19] Revert "arm64: remove dead code"
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <81d9f2f035e6ae0e1a121f3eddeaef915d761e2d.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.

Add back the setup_mm_for_reboot() needed for kexec.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/mm/mmu.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 990124a..6326d11 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,6 +29,7 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
 extern void paging_init(void);
+extern void setup_mm_for_reboot(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 873e363..afcf1ee 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -466,6 +466,17 @@ void __init paging_init(void)
 }
 
 /*
+ * Enable the identity mapping to allow the MMU disabling.
+ */
+void setup_mm_for_reboot(void)
+{
+	cpu_set_reserved_ttbr0();
+	flush_tlb_all();
+	cpu_set_idmap_tcr_t0sz();
+	cpu_switch_mm(idmap_pg_dir, &init_mm);
+}
+
+/*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
 int kern_addr_valid(unsigned long addr)
-- 
2.5.0
