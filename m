From: ddaney.cavm@gmail.com (David Daney)
Date: Fri,  8 Apr 2016 15:50:26 -0700
Subject: [PATCH v16 4/6] arm64: Move unflatten_device_tree() call earlier.
In-Reply-To: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>
References: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1460155828-8690-5-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

In order to extract NUMA information from the device tree, we need to
have the tree in its unflattened form.

Move the call to bootmem_init() in the tail of paging_init() into
setup_arch, and adjust header files so that its declaration is
visible.

Move the unflatten_device_tree() call between the calls to
paging_init() and bootmem_init().  Follow on patches add NUMA handling
to bootmem_init().

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/kernel/setup.c    | 13 +++++++++----
 arch/arm64/mm/mm.h           |  1 -
 arch/arm64/mm/mmu.c          |  2 --
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 990124a..97b1d8f 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,6 +29,7 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
 extern void paging_init(void);
+extern void bootmem_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9dc6776..9bd237e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -327,6 +327,12 @@ void __init setup_arch(char **cmdline_p)
 	acpi_boot_table_init();
 
 	paging_init();
+
+	if (acpi_disabled)
+		unflatten_device_tree();
+
+	bootmem_init();
+
 	relocate_initrd();
 
 	kasan_init();
@@ -335,12 +341,11 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	if (acpi_disabled) {
-		unflatten_device_tree();
+	if (acpi_disabled)
 		psci_dt_init();
-	} else {
+	else
 		psci_acpi_init();
-	}
+
 	xen_early_init();
 
 	cpu_read_bootcpu_ops();
diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
index ef47d99..71fe989 100644
--- a/arch/arm64/mm/mm.h
+++ b/arch/arm64/mm/mm.h
@@ -1,3 +1,2 @@
-extern void __init bootmem_init(void);
 
 void fixup_init(void);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f3e5c74..267903b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -564,8 +564,6 @@ void __init paging_init(void)
 	 */
 	memblock_free(__pa(swapper_pg_dir) + PAGE_SIZE,
 		      SWAPPER_DIR_SIZE - PAGE_SIZE);
-
-	bootmem_init();
 }
 
 /*
-- 
1.8.3.1
