From: steve.capper@arm.com (Steve Capper)
Date: Mon, 18 Dec 2017 21:47:34 +0000
Subject: [PATCH V2 5/7] arm64: dump: Make kernel page table dumper dynamic
 again
In-Reply-To: <20171218214736.13761-1-steve.capper@arm.com>
References: <20171218214736.13761-1-steve.capper@arm.com>
Message-ID: <20171218214736.13761-6-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel page table dumper assumes that the placement of VA regions is
constant and determined at compile time. As we are about to introduce
variable VA logic, we need to be able to determine certain regions at
boot time.

This patch adds logic to the kernel page table dumper s.t. these regions
can be computed at boot time.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/mm/dump.c | 58 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index d1814b247d4b..4a3e71046cb2 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -29,23 +29,45 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
 
-static const struct addr_marker address_markers[] = {
-	{ PAGE_OFFSET,			"Linear Mapping start" },
-	{ VA_START,			"Linear Mapping end" },
+
+enum address_markers_idx {
+	PAGE_OFFSET_NR = 0,
+	VA_START_NR,
+#ifdef CONFIG_KASAN
+	KASAN_START_NR,
+	KASAN_END_NR,
+#endif
+	MODULES_START_NR,
+	MODULES_END_NR,
+	VMALLOC_START_NR,
+	VMALLOC_END_NR,
+	FIXADDR_START_NR,
+	FIXADDR_END_NR,
+	PCI_START_NR,
+	PCI_END_NR,
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMEMMAP_START_NR,
+#endif
+	END_NR
+};
+
+static struct addr_marker address_markers[] = {
+	{ 0 /* PAGE_OFFSET */,		"Linear Mapping start" },
+	{ 0 /* VA_START */,		"Linear Mapping end" },
 #ifdef CONFIG_KASAN
-	{ KASAN_SHADOW_START,		"Kasan shadow start" },
+	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
 #endif
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() Area" },
-	{ VMALLOC_END,			"vmalloc() End" },
-	{ FIXADDR_START,		"Fixmap start" },
-	{ FIXADDR_TOP,			"Fixmap end" },
-	{ PCI_IO_START,			"PCI I/O start" },
-	{ PCI_IO_END,			"PCI I/O end" },
+	{ 0 /* VMALLOC_END */,		"vmalloc() End" },
+	{ 0 /* FIXADDR_START */,	"Fixmap start" },
+	{ 0 /* FIXADDR_TOP */,		"Fixmap end" },
+	{ 0 /* PCI_IO_START */,		"PCI I/O start" },
+	{ 0 /* PCI_IO_END */,		"PCI I/O end" },
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	{ VMEMMAP_START,		"vmemmap" },
+	{ 0 /* VMEMMAP_START */,	"vmemmap" },
 #endif
 	{ -1,				NULL },
 };
@@ -375,7 +397,6 @@ static void ptdump_initialize(void)
 static struct ptdump_info kernel_ptdump_info = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
-	.base_addr	= PAGE_OFFSET,
 };
 
 void ptdump_check_wx(void)
@@ -401,6 +422,21 @@ void ptdump_check_wx(void)
 static int ptdump_init(void)
 {
 	ptdump_initialize();
+	kernel_ptdump_info.base_addr = PAGE_OFFSET;
+	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
+	address_markers[VA_START_NR].start_address = VA_START;
+#ifdef CONFIG_KASAN
+	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
+#endif
+	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
+	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
+	address_markers[FIXADDR_END_NR].start_address = FIXADDR_TOP;
+	address_markers[PCI_START_NR].start_address = PCI_IO_START;
+	address_markers[PCI_END_NR].start_address = PCI_IO_END;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	address_markers[VMEMMAP_START_NR].start_address = VMEMMAP_START;
+#endif
+
 	return ptdump_debugfs_register(&kernel_ptdump_info,
 					"kernel_page_tables");
 }
-- 
2.11.0
