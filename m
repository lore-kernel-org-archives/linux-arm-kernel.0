From: geoff@infradead.org (Geoff Levand)
Date: Fri, 04 Mar 2016 23:51:15 +0000
Subject: [PATCH v14 16/20] arm64: limit memory regions based on DT property,
 usable-memory
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <a9498b31faab23d9c0db1e03ab09bcc27a5c4a95.1457135058.git.geoff@infradead.org>
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
 arch/arm64/mm/init.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ff5e01a..f46e33b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -215,8 +215,45 @@ static int __init early_mem(char *p)
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
+	fdt_enforce_memory_region();
+
 	memblock_enforce_memory_limit(memory_limit);
 
 	/*
-- 
2.5.0
