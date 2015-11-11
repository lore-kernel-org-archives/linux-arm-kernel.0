From: chris.brandt@renesas.com (Chris Brandt)
Date: Wed, 11 Nov 2015 09:31:09 -0500
Subject: [PATCH] ARM: xip: Fix module loading
Message-ID: <1447252269-22864-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For an XIP kernel, RAM start at _sdata instead of _stext. This fixes an
issue where when you load a module, vmalloc would return virtual memory
that the MMU has incorrectly mapped to non-RAM physical addresses.
This fix is similar to what is already done in arm_memblock_init().

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/mm/mmu.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index dd5a56b..d60cb8c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1383,7 +1383,11 @@ static void __init kmap_init(void)
 static void __init map_lowmem(void)
 {
 	struct memblock_region *reg;
+#ifdef CONFIG_XIP_KERNEL
+	phys_addr_t kernel_x_start = round_down(__pa(_sdata), SECTION_SIZE);
+#else
 	phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
+#endif
 	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
 
 	/* Map all the lowmem memory banks. */
-- 
1.7.9.5
