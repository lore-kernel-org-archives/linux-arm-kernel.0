From: geoff@infradead.org (Geoff Levand)
Date: Mon, 14 Mar 2016 17:48:00 +0000
Subject: [PATCH v15 11/20] Revert "arm64: remove dead code"
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
Message-ID: <93705c3b4bec842a43fec252f185a0511805dc98.1457977402.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.

Add back the setup_mm_for_reboot() needed for kexec.
Rename setup_mm_for_reboot() to cpu_install_idmap() in preparation
for the pagetable rework series.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/mm/mmu.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 990124a..ce63a20 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,6 +29,7 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
 extern void paging_init(void);
+extern void cpu_install_idmap(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 58faeaa..e43d060 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -479,6 +479,17 @@ void __init paging_init(void)
 }
 
 /*
+ * Enable the identity mapping to allow the MMU disabling.
+ */
+void cpu_install_idmap(void)
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
