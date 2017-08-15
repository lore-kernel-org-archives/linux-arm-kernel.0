From: miles.chen@mediatek.com (Miles Chen)
Date: Tue, 15 Aug 2017 17:09:26 +0800
Subject: [RFC/PATCH v2] arm64: define MODULES_VADDR by module_alloc_base
Message-ID: <1502788166-25730-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the kernel ASLR, the module virtual address is moved to
[module_alloc_base, module_alloc_base + MODULES_VSIZE).
However, the MODULES_VADDR is still defined as a constant and functions
like is_vmalloc_or_module_addr() and dump function will not able to
use correct module range information.

Use module_alloc_base to define MODULES_VADDR. I tested the patch under
three different conditions:
1.CONFIG_RANDOMIZE_BASE=y, seed=0, CONFIG_KASAN=n
2.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333, CONFIG_KASAN=n
3.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333, CONFIG_KASAN=y

test log:

1.CONFIG_RANDOMIZE_BASE=y, seed=0, CONFIG_KASAN=n

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000550000 - 0xffffff8008550000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbebfff0000   (   250 GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008550000   (  4928 KB)
[    0.000000]     .rodata : 0xffffff8008550000 - 0xffffff80086a0000   (  1344 KB)
[    0.000000]       .init : 0xffffff80086a0000 - 0xffffff8008a30000   (  3648 KB)
[    0.000000]       .data : 0xffffff8008a30000 - 0xffffff8008ab9200   (   549 KB)
[    0.000000]        .bss : 0xffffff8008ab9200 - 0xffffff8008b0b238   (   329 KB)
[    0.000000]     fixed   : 0xffffffbefe7fd000 - 0xffffffbefec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbefee00000 - 0xffffffbeffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffffffbf00000000 - 0xffffffc000000000   (     4 GB maximum)
[    0.000000]               0xffffffbf00000000 - 0xffffffbf02000000   (    32 MB actual)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc080000000   (  2048 MB)

\# cat kernel_page_tables
---[ Modules start ]---
---[ Modules end ]---
---[ vmalloc() Area ]---
0xffffff8008000000-0xffffff8008010000          64K PTE       RW NX SHD AF
0xffffff8008015000-0xffffff8008016000           4K PTE       RW NX SHD AF
0xffffff8008020000-0xffffff8008030000          64K PTE       RW NX SHD AF
0xffffff8008031000-0xffffff8008071000         256K PTE       RW NX SHD AF
0xffffff8008080000-0xffffff8008200000        1536K PTE       ro x  SHD AF
0xffffff8008200000-0xffffff8008400000           2M PMD       ro x  SHD AF
0xffffff8008400000-0xffffff8008550000        1344K PTE       ro x  SHD AF
0xffffff8008550000-0xffffff80086a0000        1344K PTE       ro NX SHD AF
0xffffff8008a30000-0xffffff8008b10000         896K PTE       RW NX SHD AF
0xffffff8008b10000-0xffffff8008b11000           4K PTE       RW NX SHD AF
0xffffff8008bcb000-0xffffff8008bce000          12K PTE       RW NX SHD AF
0xffffffbebffd8000-0xffffffbebffdb000          12K PTE       RW NX SHD AF
---[ vmalloc() End ]---
---[ Fixmap start ]---
0xffffffbefe800000-0xffffffbefea00000           2M PMD       ro NX SHD AF
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmemmap start ]---
0xffffffbf00000000-0xffffffbf02000000          32M PMD       RW NX SHD AF
---[ vmemmap end ]---
---[ Linear Mapping ]---
0xffffffc000000000-0xffffffc000080000         512K PTE       RW NX SHD AF
0xffffffc000080000-0xffffffc000200000        1536K PTE       ro NX SHD AF
0xffffffc000200000-0xffffffc000600000           4M PMD       ro NX SHD AF
0xffffffc000600000-0xffffffc0006a0000         640K PTE       ro NX SHD AF
0xffffffc0006a0000-0xffffffc000800000        1408K PTE       RW NX SHD AF
0xffffffc000800000-0xffffffc002000000          24M PMD       RW NX SHD AF
0xffffffc002000000-0xffffffc040000000         992M PMD       RW NX SHD AF
0xffffffc040000000-0xffffffc080000000           1G PGD       RW NX SHD AF

2.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333, CONFIG_KASAN=n

[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffffa5a4cbc000 - 0xffffffa5accbc000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbebfff0000   (   250 GB)
[    0.000000]       .text : 0xffffff902b280000 - 0xffffff902b750000   (  4928 KB)
[    0.000000]     .rodata : 0xffffff902b750000 - 0xffffff902b8a0000   (  1344 KB)
[    0.000000]       .init : 0xffffff902b8a0000 - 0xffffff902bc30000   (  3648 KB)
[    0.000000]       .data : 0xffffff902bc30000 - 0xffffff902bcb9200   (   549 KB)
[    0.000000]        .bss : 0xffffff902bcb9200 - 0xffffff902bd0b238   (   329 KB)
[    0.000000]     fixed   : 0xffffffbefe7fd000 - 0xffffffbefec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbefee00000 - 0xffffffbeffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffffffbf00000000 - 0xffffffc000000000   (     4 GB maximum)
[    0.000000]               0xffffffbf22000000 - 0xffffffbf24000000   (    32 MB actual)
[    0.000000]     memory  : 0xffffffc880000000 - 0xffffffc900000000   (  2048 MB)

\# cat kernel_page_tables
---[ vmalloc() Area ]---
0xffffff8008000000-0xffffff8008010000          64K PTE       RW NX SHD AF
0xffffff8008015000-0xffffff8008016000           4K PTE       RW NX SHD AF
0xffffff8008020000-0xffffff8008030000          64K PTE       RW NX SHD AF
0xffffff8008031000-0xffffff8008071000         256K PTE       RW NX SHD AF
0xffffff800813e000-0xffffff8008141000          12K PTE       RW NX SHD AF
0xffffff902b280000-0xffffff902b400000        1536K PTE       ro x  SHD AF
0xffffff902b400000-0xffffff902b600000           2M PMD       ro x  SHD AF
0xffffff902b600000-0xffffff902b750000        1344K PTE       ro x  SHD AF
0xffffff902b750000-0xffffff902b8a0000        1344K PTE       ro NX SHD AF
0xffffff902bc30000-0xffffff902bd10000         896K PTE       RW NX SHD AF
0xffffff902bd10000-0xffffff902bd11000           4K PTE       RW NX SHD AF
0xffffffbebffd8000-0xffffffbebffdb000          12K PTE       RW NX SHD AF
---[ vmalloc() End ]---
---[ Fixmap start ]---
0xffffffbefe800000-0xffffffbefea00000           2M PMD       ro NX SHD AF
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmemmap start ]---
0xffffffbf22000000-0xffffffbf24000000          32M PMD       RW NX SHD AF
---[ vmemmap end ]---
---[ Linear Mapping ]---
0xffffffc880000000-0xffffffc880080000         512K PTE       RW NX SHD AF
0xffffffc880080000-0xffffffc880200000        1536K PTE       ro NX SHD AF
0xffffffc880200000-0xffffffc880600000           4M PMD       ro NX SHD AF
0xffffffc880600000-0xffffffc8806a0000         640K PTE       ro NX SHD AF
0xffffffc8806a0000-0xffffffc880800000        1408K PTE       RW NX SHD AF
0xffffffc880800000-0xffffffc882000000          24M PMD       RW NX SHD AF
0xffffffc882000000-0xffffffc8c0000000         992M PMD       RW NX SHD AF
0xffffffc8c0000000-0xffffffc900000000           1G PGD       RW NX SHD AF

3.CONFIG_RANDOMIZE_BASE=y, seed=0x2304909023333333, CONFIG_KASAN=y

[    0.000000] Virtual kernel memory layout:
[    0.000000]     kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 GB)
[    0.000000]     modules : 0xffffff9000560000 - 0xffffff9008560000   (   128 MB)
[    0.000000]     vmalloc : 0xffffff9008560000 - 0xffffffbebfff0000   (   186 GB)
[    0.000000]       .text : 0xffffffa02b280000 - 0xffffffa02b760000   (  4992 KB)
[    0.000000]     .rodata : 0xffffffa02b760000 - 0xffffffa02b8b0000   (  1344 KB)
[    0.000000]       .init : 0xffffffa02b8b0000 - 0xffffffa02bc40000   (  3648 KB)
[    0.000000]       .data : 0xffffffa02bc40000 - 0xffffffa02bcc9a00   (   551 KB)
[    0.000000]        .bss : 0xffffffa02bcc9a00 - 0xffffffa02c5342b8   (  8619 KB)
[    0.000000]     fixed   : 0xffffffbefe7fd000 - 0xffffffbefec00000   (  4108 KB)
[    0.000000]     PCI I/O : 0xffffffbefee00000 - 0xffffffbeffe00000   (    16 MB)
[    0.000000]     vmemmap : 0xffffffbf00000000 - 0xffffffc000000000   (     4 GB maximum)
[    0.000000]               0xffffffbf22000000 - 0xffffffbf24000000   (    32 MB actual)
[    0.000000]     memory  : 0xffffffc880000000 - 0xffffffc900000000   (  2048 MB)

\# cat kernel_page_tables
---[ Kasan shadow start ]---
0xffffff8000000000-0xffffff82000ac000     8389296K PTE       ro NX SHD AF
0xffffff82010ac000-0xffffff8405600000     8459600K PTE       ro NX SHD AF
0xffffff8405600000-0xffffff8405a00000           4M PMD       RW NX SHD AF
0xffffff8405a00000-0xffffff8800000000       16294M PTE       ro NX SHD AF
0xffffff8910000000-0xffffff8920000000         256M PMD       RW NX SHD AF
---[ Kasan shadow end ]---
---[ Modules start ]---
---[ Modules end ]---
---[ vmalloc() Area ]---
0xffffff9008560000-0xffffff9008570000          64K PTE       RW NX SHD AF
0xffffff9008575000-0xffffff9008576000           4K PTE       RW NX SHD AF
0xffffff9008580000-0xffffff9008590000          64K PTE       RW NX SHD AF
0xffffff9008591000-0xffffff90085d1000         256K PTE       RW NX SHD AF
0xffffff900869a000-0xffffff900869d000          12K PTE       RW NX SHD AF
0xffffffa02b280000-0xffffffa02b400000        1536K PTE       ro x  SHD AF
0xffffffa02b400000-0xffffffa02b600000           2M PMD       ro x  SHD AF
0xffffffa02b600000-0xffffffa02b760000        1408K PTE       ro x  SHD AF
0xffffffa02b760000-0xffffffa02b8b0000        1344K PTE       ro NX SHD AF
0xffffffa02bc40000-0xffffffa02be00000        1792K PTE       RW NX SHD AF
0xffffffa02be00000-0xffffffa02c400000           6M PMD       RW NX SHD AF
0xffffffa02c400000-0xffffffa02c530000        1216K PTE       RW NX SHD AF
0xffffffa02c530000-0xffffffa02c53a000          40K PTE       RW NX SHD AF
0xffffffbebffd7000-0xffffffbebffda000          12K PTE       RW NX SHD AF
---[ vmalloc() End ]---
---[ Fixmap start ]---
0xffffffbefe800000-0xffffffbefea00000           2M PMD       ro NX SHD AF
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmemmap start ]---
0xffffffbf22000000-0xffffffbf24000000          32M PMD       RW NX SHD AF
---[ vmemmap end ]---
---[ Linear Mapping ]---
0xffffffc880000000-0xffffffc880080000         512K PTE       RW NX SHD AF
0xffffffc880080000-0xffffffc880200000        1536K PTE       ro NX SHD AF
0xffffffc880200000-0xffffffc880600000           4M PMD       ro NX SHD AF
0xffffffc880600000-0xffffffc8806b0000         704K PTE       ro NX SHD AF
0xffffffc8806b0000-0xffffffc880800000        1344K PTE       RW NX SHD AF
0xffffffc880800000-0xffffffc882000000          24M PMD       RW NX SHD AF
0xffffffc882000000-0xffffffc8c0000000         992M PMD       RW NX SHD AF
0xffffffc8c0000000-0xffffffc900000000           1G PGD       RW NX SHD AF

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/include/asm/memory.h  | 12 +++++++--
 arch/arm64/include/asm/module.h  |  6 -----
 arch/arm64/include/asm/pgtable.h |  4 +++
 arch/arm64/mm/dump.c             | 53 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index ef39dcb..41b885c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -68,9 +68,11 @@
 	(UL(1) << VA_BITS) + 1)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
 	(UL(1) << (VA_BITS - 1)) + 1)
-#define KIMAGE_VADDR		(MODULES_END)
+#define KIMAGE_VADDR		(STATIC_MODULES_END)
+#define STATIC_MODULES_END	(STATIC_MODULES_VADDR + MODULES_VSIZE)
+#define STATIC_MODULES_VADDR	(VA_START + KASAN_SHADOW_SIZE)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
-#define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
+#define MODULES_VADDR		((unsigned long)module_alloc_base)
 #define MODULES_VSIZE		(SZ_128M)
 #define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
@@ -138,6 +140,12 @@
 #include <linux/bitops.h>
 #include <linux/mmdebug.h>
 
+#ifdef CONFIG_RANDOMIZE_BASE
+extern u64 module_alloc_base;
+#else
+#define module_alloc_base	((u64)_etext - MODULES_VSIZE)
+#endif
+
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 19bd976..fdf0db4 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -39,10 +39,4 @@ struct mod_arch_specific {
 u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
-#ifdef CONFIG_RANDOMIZE_BASE
-extern u64 module_alloc_base;
-#else
-#define module_alloc_base	((u64)_etext - MODULES_VSIZE)
-#endif
-
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6eae342..6e309aa 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -30,7 +30,11 @@
  * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space
  *	and fixed mappings
  */
+#ifdef CONFIG_KASAN
 #define VMALLOC_START		(MODULES_END)
+#else
+#define VMALLOC_START		(STATIC_MODULES_END)
+#endif
 #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index ca74a2a..f077ee3 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -29,15 +29,36 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
 
-static const struct addr_marker address_markers[] = {
+enum marker {
+#ifdef CONFIG_KASAN
+	E_KASAN_SHADOW_START,
+	E_KASAN_SHADOW_END,
+#endif
+	E_MODULES_VADDR,
+	E_MODULES_END,
+	E_VMALLOC_START,
+	E_VMALLOC_END,
+	E_FIXADDR_START,
+	E_FIXADDR_TOP,
+	E_PCI_IO_START,
+	E_PCI_IO_END,
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	E_VMEMMAP_START,
+	E_VMEMMAP_END,
+#endif
+	E_PAGE_OFFSET,
+	E_NR_MARKER,
+};
+
+static struct addr_marker address_markers[] = {
 #ifdef CONFIG_KASAN
 	{ KASAN_SHADOW_START,		"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
-	{ MODULES_VADDR,		"Modules start" },
-	{ MODULES_END,			"Modules end" },
-	{ VMALLOC_START,		"vmalloc() Area" },
-	{ VMALLOC_END,			"vmalloc() End" },
+	{ -1,				"Modules start" },
+	{ -1,				"Modules end" },
+	{ -1,				"vmalloc() Area" },
+	{ -1,				"vmalloc() End" },
 	{ FIXADDR_START,		"Fixmap start" },
 	{ FIXADDR_TOP,			"Fixmap end" },
 	{ PCI_IO_START,			"PCI I/O start" },
@@ -362,10 +383,32 @@ void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
 	note_page(&st, 0, 0, 0);
 }
 
+static void fixup_markers(void)
+{
+	int i;
+
+	address_markers[E_MODULES_VADDR].start_address = MODULES_VADDR;
+	address_markers[E_MODULES_END].start_address = MODULES_END;
+	address_markers[E_VMALLOC_START].start_address = VMALLOC_START;
+	address_markers[E_VMALLOC_END].start_address = VMALLOC_END;
+
+	if (MODULES_VADDR < VMALLOC_START) {
+		address_markers[E_MODULES_END].start_address =
+			(MODULES_END < VMALLOC_START) ?
+			MODULES_END : VMALLOC_START;
+	} else {
+		/* modules is contained in vamlloc area, don't show them */
+		for (i = E_MODULES_VADDR; i <= E_NR_MARKER - 2; i++)
+			address_markers[i] = address_markers[i + 2];
+	}
+}
+
 static void ptdump_initialize(void)
 {
 	unsigned i, j;
 
+	fixup_markers();
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		if (pg_level[i].bits)
 			for (j = 0; j < pg_level[i].num; j++)
-- 
1.9.1
