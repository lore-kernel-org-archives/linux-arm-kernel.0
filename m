From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 09:13:07 +0200
Subject: [PATCH 09/10] arm64: allow kernel Image to be loaded anywhere in
 physical memory
In-Reply-To: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1431328388-3051-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This relaxes the kernel Image placement requirements, so that it
may be placed at any 2 MB aligned offset in physical memory.

This is accomplished by ignoring PHYS_OFFSET when installing
memblocks, and accounting for the apparent virtual offset of
the kernel Image (in addition to the 64 MB that it is moved
below PAGE_OFFSET). As a result, virtual address references
below PAGE_OFFSET are correctly mapped onto physical references
into the kernel Image regardless of where it sits in memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 20 +++++++++---------
 arch/arm64/mm/init.c            | 47 +++++++++++++++++++++++++++++++++++++----
 arch/arm64/mm/mmu.c             | 22 ++++++++++++++++---
 3 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 53f18e13d51c..7bd9feedb6f9 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -113,16 +113,16 @@ Header notes:
   depending on selected features, and is effectively unbound.
 
 The Image must be placed text_offset bytes from a 2MB aligned base
-address near the start of usable system RAM and called there. Memory
-below that base address is currently unusable by Linux, and therefore it
-is strongly recommended that this location is the start of system RAM.
-At least image_size bytes from the start of the image must be free for
-use by the kernel.
-
-Any memory described to the kernel (even that below the 2MB aligned base
-address) which is not marked as reserved from the kernel e.g. with a
-memreserve region in the device tree) will be considered as available to
-the kernel.
+address anywhere in usable system RAM and called there. At least
+image_size bytes from the start of the image must be free for use
+by the kernel.
+NOTE: versions prior to v4.2 cannot make use of memory below the
+physical offset of the Image so it is recommended that the Image be
+placed as close as possible to the start of system RAM.
+
+Any memory described to the kernel which is not marked as reserved from
+the kernel (e.g., with a memreserve region in the device tree) will be
+considered as available to the kernel.
 
 Before jumping into the kernel, the following conditions must be met:
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3909a5fe7d7c..4ee01ebc4029 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 
+#include <asm/boot.h>
 #include <asm/fixmap.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -157,6 +158,45 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static void enforce_memory_limit(void)
+{
+	const phys_addr_t kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
+	u64 to_remove = memblock_phys_mem_size() - memory_limit;
+	phys_addr_t max_addr = 0;
+	struct memblock_region *r;
+
+	if (memory_limit == (phys_addr_t)ULLONG_MAX)
+		return;
+
+	/*
+	 * The kernel may be high up in physical memory, so try to apply the
+	 * limit below the kernel first, and only let the generic handling
+	 * take over if it turns out we haven't clipped enough memory yet.
+	 */
+	for_each_memblock(memory, r) {
+		if (r->base + r->size > kbase) {
+			u64 rem = min(to_remove, kbase - r->base);
+
+			max_addr = r->base + rem;
+			to_remove -= rem;
+			break;
+		}
+		if (to_remove <= r->size) {
+			max_addr = r->base + to_remove;
+			to_remove = 0;
+			break;
+		}
+		to_remove -= r->size;
+	}
+
+	/* truncate both memory and reserved regions */
+	memblock_remove_range(&memblock.memory, 0, max_addr);
+	memblock_remove_range(&memblock.reserved, 0, max_addr);
+
+	if (to_remove)
+		memblock_enforce_memory_limit(memory_limit);
+}
+
 void __init arm64_memblock_init(void)
 {
 	/*
@@ -164,12 +204,11 @@ void __init arm64_memblock_init(void)
 	 * with the linear mapping.
 	 */
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
-	u64 dram_base = memstart_addr - KIMAGE_OFFSET;
 
-	memblock_remove(0, dram_base);
-	memblock_remove(dram_base + linear_region_size, ULLONG_MAX);
+	memblock_remove(round_down(memblock_start_of_DRAM(), SZ_1G) +
+			linear_region_size, ULLONG_MAX);
 
-	memblock_enforce_memory_limit(memory_limit);
+	enforce_memory_limit();
 
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9c94c8c78da7..7e3e6af9b55c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -432,11 +432,27 @@ static void __init bootstrap_linear_mapping(unsigned long va_offset)
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
+	u64 new_memstart_addr;
+	u64 new_va_offset;
 
-	bootstrap_linear_mapping(KIMAGE_OFFSET);
+	/*
+	 * Select a suitable value for the base of physical memory.
+	 * This should be equal to or below the lowest usable physical
+	 * memory address, and aligned to PUD/PMD size so that we can map
+	 * it efficiently.
+	 */
+	new_memstart_addr = round_down(memblock_start_of_DRAM(), SZ_1G);
+
+	/*
+	 * Calculate the offset between the kernel text mapping that exists
+	 * outside of the linear mapping, and its mapping in the linear region.
+	 */
+	new_va_offset = memstart_addr - new_memstart_addr;
+
+	bootstrap_linear_mapping(new_va_offset);
 
-	kernel_va_offset = KIMAGE_OFFSET;
-	memstart_addr -= KIMAGE_OFFSET;
+	kernel_va_offset = new_va_offset;
+	memstart_addr = new_memstart_addr;
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
-- 
1.9.1
