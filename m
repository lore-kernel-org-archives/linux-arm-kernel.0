From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jan 2017 17:49:56 +0900
Subject: [PATCH v30 02/11] arm64: limit memory regions based on DT property,
 usable-memory-range
In-Reply-To: <20170124084638.3770-1-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
Message-ID: <20170124085004.3892-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crash dump kernel utilizes only a subset of available memory as System RAM.
On arm64 kdump, This memory range is advertized to crash dump kernel via
a device-tree property under /chosen,
   linux,usable-memory-range = <BASE SIZE>

Crash dump kernel reads this property at boot time and calls
memblock_cap_memory_range() to limit usable memory ranges which are
described as entries in UEFI memory map table or "memory" nodes in
a device tree blob.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Geoff Levand <geoff@infradead.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/init.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 380ebe705093..6cddb566eb21 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -187,10 +187,45 @@ static int __init early_mem(char *p)
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
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
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
+	if (reg.size)
+		memblock_cap_memory_range(reg.base, reg.size);
+}
+
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
+	/* Handle linux,usable-memory-range property */
+	fdt_enforce_memory_region();
+
 	/*
 	 * Ensure that the linear region takes up exactly half of the kernel
 	 * virtual address space. This way, we can distinguish a linear address
-- 
2.11.0
