From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Apr 2015 17:34:23 +0200
Subject: [PATCH v4 12/13] arm64: allow kernel Image to be loaded anywhere in
 physical memory
In-Reply-To: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429112064-19952-13-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This relaxes the kernel Image placement requirements, so that it
may be placed at any 2 MB aligned offset in physical memory.

This is accomplished by ignoring PHYS_OFFSET when installing
memblocks, and accounting for the apparent virtual offset of
the kernel Image (in addition to the 64 MB that is is moved
below PAGE_OFFSET). As a result, virtual address references
below PAGE_OFFSET are correctly mapped onto physical references
into the kernel Image regardless of where it sits in memory.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/arm64/booting.txt | 20 ++++++++++----------
 arch/arm64/mm/Makefile          |  1 +
 arch/arm64/mm/init.c            | 38 +++++++++++++++++++++++++++++++++++---
 arch/arm64/mm/mmu.c             | 24 ++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 15 deletions(-)

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
 
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 9d84feb41a16..49e90bab4d57 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
 
 CFLAGS_mmu.o			:= -I$(srctree)/scripts/dtc/libfdt/
+CFLAGS_init.o			:= -DTEXT_OFFSET=$(TEXT_OFFSET)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0e7d9a2aad39..98a009885229 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -157,6 +157,38 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static void enforce_memory_limit(void)
+{
+	const phys_addr_t kstart = __pa(_text) - TEXT_OFFSET;
+	const phys_addr_t kend = round_up(__pa(_end), SZ_2M);
+	const u64 ksize = kend - kstart;
+	struct memblock_region *reg;
+
+	if (likely(memory_limit == (phys_addr_t)ULLONG_MAX))
+		return;
+
+	if (WARN(memory_limit < ksize, "mem= limit is unreasonably low"))
+		return;
+
+	/*
+	 * We have to make sure that the kernel image is still covered by
+	 * memblock after we apply the memory limit, even if the kernel image
+	 * is high up in physical memory. So if the kernel image becomes
+	 * inaccessible after the limit is applied, we will lower the limit
+	 * so that it compensates for the kernel image and reapply it. That way,
+	 * we can add back the kernel image region and still honor the limit.
+	 */
+	memblock_enforce_memory_limit(memory_limit);
+
+	for_each_memblock(memory, reg)
+		if (reg->base <= kstart && reg->base + reg->size >= kend)
+			/* kernel image still accessible -> we're done */
+			return;
+
+	memblock_enforce_memory_limit(memory_limit - ksize);
+	memblock_add(kstart, ksize);
+}
+
 void __init arm64_memblock_init(void)
 {
 	/*
@@ -165,10 +197,10 @@ void __init arm64_memblock_init(void)
 	 */
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
-	memblock_remove(0, memstart_addr);
-	memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
+	memblock_remove(round_down(memblock_start_of_DRAM(), SZ_1G) +
+			linear_region_size, ULLONG_MAX);
 
-	memblock_enforce_memory_limit(memory_limit);
+	enforce_memory_limit();
 
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c07ba8bdd8ed..1487824c5896 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -409,10 +409,30 @@ static void __init bootstrap_linear_mapping(unsigned long va_offset)
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
+	u64 new_memstart_addr = memblock_start_of_DRAM();
+	u64 new_va_offset;
 
-	bootstrap_linear_mapping(KIMAGE_OFFSET);
+	/*
+	 * Select a suitable value for the base of physical memory.
+	 * This should be below the lowest usable physical memory
+	 * address, and aligned to PUD/PMD size so that we can map
+	 * it efficiently.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
+		new_memstart_addr &= PMD_MASK;
+	else
+		new_memstart_addr &= PUD_MASK;
+
+	/*
+	 * Calculate the offset between the kernel text mapping that exists
+	 * outside of the linear mapping, and its mapping in the linear region.
+	 */
+	new_va_offset = memstart_addr - new_memstart_addr + phys_offset_bias;
+
+	bootstrap_linear_mapping(new_va_offset);
 
-	kernel_va_offset = KIMAGE_OFFSET;
+	memstart_addr = new_memstart_addr;
+	kernel_va_offset = new_va_offset;
 	phys_offset_bias = 0;
 
 	/* map all the memory banks */
-- 
1.8.3.2
