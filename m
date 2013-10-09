From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Oct 2013 18:31:31 -0700
Subject: [RFC PATCH 4/5] arm: mm: restrict kernel memory permissions if
 CONFIG_STRICT_MEMORY_RWX set
In-Reply-To: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1381282292-25251-5-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STRICT_MEMORY_RWX is set, make kernel text RX,
kernel data/stack RW and rodata RO so that writing
on kernel text, executing kernel data or stack, or
writing on or executing read-only data is prohibited.

Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/mmu.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d846334..91db2a0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1311,6 +1311,60 @@ static void __init kmap_init(void)
 #endif
 }
 
+struct custom_map {
+	unsigned long start;
+	unsigned long end;
+	unsigned int type;
+};
+
+struct custom_map __initdata custom_maps[] = {
+	{
+		.start	= _stext,
+		.end	= __start_rodata,
+		.type	= MT_MEMORY_RX,
+	},
+	{
+		.start	= __start_rodata,
+		.end	= __init_begin,
+		.type	= MT_MEMORY_R
+	},
+	{
+		.start	= __init_begin,
+		.end	= __arch_info_begin,
+		.type	= MT_MEMORY_RX,
+	}
+};
+
+static void __init map_custom_regions(void)
+{
+#ifdef CONFIG_STRICT_MEMORY_RWX
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(custom_maps); i++) {
+		struct map_desc map;
+		unsigned long addr;
+
+		if (!IS_ALIGNED(custom_maps[i].start, PMD_SIZE) ||
+		    !IS_ALIGNED(custom_maps[i].end, PMD_SIZE)) {
+			pr_err("BUG: section %x-%x not aligned to %x\n",
+				custom_maps[i].start, custom_maps[i].end,
+				PMD_SIZE);
+			continue;
+		}
+
+		for (addr = custom_maps[i].start;
+			addr < custom_maps[i].end; addr += PMD_SIZE)
+				pmd_clear(pmd_off_k(addr));
+
+		map.virtual = custom_maps[i].start;
+		map.pfn = __phys_to_pfn(__virt_to_phys(custom_maps[i].start));
+		map.length = custom_maps[i].end - custom_maps[i].start;
+		map.type = custom_maps[i].type;
+		create_mapping(&map);
+	}
+#endif
+}
+
 static void __init map_lowmem(void)
 {
 	struct memblock_region *reg;
@@ -1329,10 +1383,11 @@ static void __init map_lowmem(void)
 		map.pfn = __phys_to_pfn(start);
 		map.virtual = __phys_to_virt(start);
 		map.length = end - start;
-		map.type = MT_MEMORY;
+		map.type = MT_MEMORY_RW;
 
 		create_mapping(&map);
 	}
+	map_custom_regions();
 }
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
