From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Jul 2016 16:23:41 -0400 (EDT)
Subject: [PATCH] sanity_check_meminfo(): avoid overflow on vmalloc_limit
Message-ID: <alpine.LFD.2.20.1607271618520.17623@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


To limit the amount of mapped low memory, we determine a physical address
boundary based on the start of the vmalloc area using __pa().
Strictly speaking, the vmalloc area location is arbitrary and does not
necessarily corresponds to a valid physical address. For example, if

	PAGE_OFFSET = 0x80000000
	PHYS_OFFSET = 0x90000000
	vmalloc_min = 0xf0000000

then __pa(vmalloc_min) overflows and returns a wrapped 0 when phys_addr_t
is a 32-bit type. Then the code that follows determines that the entire
physical memory is above that boundary and no low memory gets mapped at
all:

|[...]
|Machine model: Freescale i.MX51 NA04 Board
|Ignoring RAM at 0x90000000-0xb0000000 (!CONFIG_HIGHMEM)
|Consider using a HIGHMEM enabled kernel.

To avoid this problem let's make vmalloc_limit a 64-bit value all the
time and determine that boundary explicitly without using __pa().

Reported-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 62f4d01941..12774c8e77 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1155,10 +1155,19 @@ void __init sanity_check_meminfo(void)
 {
 	phys_addr_t memblock_limit = 0;
 	int highmem = 0;
-	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
+	u64 vmalloc_limit;
 	struct memblock_region *reg;
 	bool should_use_highmem = false;
 
+	/*
+	 * Let's use our own (unoptimized) equivalent of __pa() that is
+	 * not affected by wrap-arounds when sizeof(phys_addr_t) == 4.
+	 * The result is used as the upper bound on physical memory address
+	 * and may itself be outside the valid range for which phys_addr_t
+	 * and therefore __pa() is defined.
+	 */
+	vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
+
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
@@ -1183,10 +1192,11 @@ void __init sanity_check_meminfo(void)
 			if (reg->size > size_limit) {
 				phys_addr_t overlap_size = reg->size - size_limit;
 
-				pr_notice("Truncating RAM at %pa-%pa to -%pa",
-					  &block_start, &block_end, &vmalloc_limit);
-				memblock_remove(vmalloc_limit, overlap_size);
+				pr_notice("Truncating RAM at %pa-%pa",
+					  &block_start, &block_end);
 				block_end = vmalloc_limit;
+				pr_cont(" to -%pa", &block_end);
+				memblock_remove(vmalloc_limit, overlap_size);
 				should_use_highmem = true;
 			}
 		}
