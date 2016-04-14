From: geoff@infradead.org (Geoff Levand)
Date: Thu, 14 Apr 2016 21:21:37 +0000
Subject: [PATCH v16 16/20] arm64: limit memory regions based on DT property,
 usable-memory
In-Reply-To: <cover.1460668521.git.geoff@infradead.org>
References: <cover.1460668521.git.geoff@infradead.org>
Message-ID: <9001c7d079ccc488b19579d6896993ac60087a9b.1460668521.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Crash dump kernel will be run with a limited range of memory as System
RAM.

On arm64, we will use a device-tree property under /chosen,
   linux,usable-memory = <BASE SIZE>
in order for primary kernel either on uefi or non-uefi (device tree only)
system to hand over the information about usable memory region to crash
dump kernel. This property will supercede entries in uefi memory map table
and "memory" nodes in a device tree.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/mm/init.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3589d78..cfdc7c4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -224,10 +224,48 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static int __init early_init_dt_scan_usablemem(unsigned long node,
+		const char *uname, int depth, void *data)
+{
+	struct memblock_region *usablemem = (struct memblock_region *)data;
+	const __be32 *reg;
+	int len;
+
+	usablemem->size = 0;
+
+	if (depth != 1 || strcmp(uname, "chosen") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &len);
+	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
+		return 1;
+
+	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+	return 1;
+}
+
+static void __init fdt_enforce_memory_region(void)
+{
+	struct memblock_region reg;
+
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+
+	if (reg.size) {
+		memblock_remove(0, PAGE_ALIGN(reg.base));
+		memblock_remove(round_down(reg.base + reg.size, PAGE_SIZE),
+				ULLONG_MAX);
+	}
+}
+
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
+	/* Handle linux,usable-memory property */
+	fdt_enforce_memory_region();
+
 	/*
 	 * Ensure that the linear region takes up exactly half of the kernel
 	 * virtual address space. This way, we can distinguish a linear address
-- 
2.5.0
