From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Tue, 18 Nov 2014 19:48:27 +0400
Subject: [PATCH] ARM: fix overflow of vmalloc_limit in sanity_check_meminfo
Message-ID: <20141118164827.9686.68369.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vmalloc_limit easily overflows if CONFIG_VMSPLIT_1G=y and CONFIG_ARM_LPAE=n,
in this case whole memory turns into "highmem" and system cannot boot.
For example if PHYS_OFFSET=0x80000000 and PAGE_OFFSET=0x40000000 then
vmalloc_limit should be 0x1_2F800000, but value does not fit into variable.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm/mm/mmu.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..9d2cdda 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1075,10 +1075,14 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
 void __init sanity_check_meminfo(void)
 {
 	phys_addr_t memblock_limit = 0;
+	phys_addr_t vmalloc_limit = -1;
 	int highmem = 0;
-	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
 	struct memblock_region *reg;
 
+	if ((unsigned long)vmalloc_min - PAGE_OFFSET <
+			vmalloc_limit - PHYS_OFFSET)
+		vmalloc_limit = __pa(vmalloc_min - 1) + 1;
+
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
 		phys_addr_t block_end = reg->base + reg->size;
