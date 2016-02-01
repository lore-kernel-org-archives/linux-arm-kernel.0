From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 14:09:38 +0100
Subject: [PATCH v5sub2 8/8] arm64: kaslr: randomize the linear region
In-Reply-To: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454332178-4414-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When KASLR is enabled (CONFIG_RANDOMIZE_BASE=y), and entropy has been
provided by the bootloader, randomize the placement of RAM inside the
linear region if sufficient space is available. For instance, on a 4KB
granule/3 levels kernel, the linear region is 256 GB in size, and we can
choose any 1 GB aligned offset that is far enough from the top of the
address space to fit the distance between the start of the lowest memblock
and the top of the highest memblock.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/kaslr.c |  4 ++++
 arch/arm64/mm/init.c      | 22 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b0bf628ba51f..c96f63670537 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 
 u32 __read_mostly module_load_offset;
+u16 __initdata memstart_offset_seed;
 
 static __init u64 get_kaslr_seed(void *fdt)
 {
@@ -135,5 +136,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	module_range = MODULES_VSIZE - (u64)(_etext - _stext);
 	module_load_offset = ((module_range * (u16)seed) >> 16) & PAGE_MASK;
 
+	/* use the top 16 bits to randomize the linear region */
+	memstart_offset_seed = seed >> 48;
+
 	return offset;
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e8e853a1024c..01fdb3d04bba 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -215,6 +215,23 @@ void __init arm64_memblock_init(void)
 	if (memblock_end_of_DRAM() > linear_region_size)
 		memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);
 
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern u16 memstart_offset_seed;
+		u64 range = linear_region_size -
+			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+
+		/*
+		 * If the size of the linear region exceeds, by a sufficient
+		 * margin, the size of the region that the available physical
+		 * memory spans, randomize the linear region as well.
+		 */
+		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
+			range = range / ARM64_MEMSTART_ALIGN + 1;
+			memstart_addr -= ARM64_MEMSTART_ALIGN *
+					 ((range * memstart_offset_seed) >> 16);
+		}
+	}
+
 	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
 		u64 kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
 		u64 kend = PAGE_ALIGN(__pa(_end));
@@ -399,12 +416,13 @@ void __init mem_init(void)
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 		  MLG((unsigned long)vmemmap,
 		      (unsigned long)vmemmap + VMEMMAP_SIZE),
-		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
+		  MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
 		      (unsigned long)virt_to_page(high_memory)),
 #endif
 		  MLK(FIXADDR_START, FIXADDR_TOP),
 		  MLM(PCI_IO_START, PCI_IO_END),
-		  MLM(PAGE_OFFSET, (unsigned long)high_memory));
+		  MLM(__phys_to_virt(memblock_start_of_DRAM()),
+		      (unsigned long)high_memory));
 
 #undef MLK
 #undef MLM
-- 
2.5.0
