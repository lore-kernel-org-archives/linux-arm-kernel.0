From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 11:18:14 +0100
Subject: [PATCH] arm64: mm: use correct mapping granularity under DEBUG_RODATA
Message-ID: <1447669094-31076-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a 64k pages kernel that is built with CONFIG_DEBUG_RODATA
and resides at an offset that is not a multiple of 512 MB, the rounding
that occurs in __map_memblock() and fixup_executable() results in
incorrect regions being mapped.

The following snippet from /sys/kernel/debug/kernel_page_tables shows
how, when the kernel is loaded 2 MB above the base of DRAM at 0x40000000,
the first 2 MB of memory (which may be inaccessible from non-secure EL1
or just reserved by the firmware) is inadvertently mapped into the end of
the module region.

  ---[ Modules start ]---
  0xfffffdffffe00000-0xfffffe0000000000     2M RW NX ... UXN MEM/NORMAL
  ---[ Modules end ]---
  ---[ Kernel Mapping ]---
  0xfffffe0000000000-0xfffffe0000090000   576K RW NX ... UXN MEM/NORMAL
  0xfffffe0000090000-0xfffffe0000200000  1472K ro x  ... UXN MEM/NORMAL
  0xfffffe0000200000-0xfffffe0000800000     6M ro x  ... UXN MEM/NORMAL
  0xfffffe0000800000-0xfffffe0000810000    64K ro x  ... UXN MEM/NORMAL
  0xfffffe0000810000-0xfffffe0000a00000  1984K RW NX ... UXN MEM/NORMAL
  0xfffffe0000a00000-0xfffffe00ffe00000  4084M RW NX ... UXN MEM/NORMAL

The same issue is likely to occur on 16k pages kernels whose load
address is not a multiple of 32 MB (i.e., SECTION_SIZE). So round to
SWAPPER_BLOCK_SIZE instead of SECTION_SIZE.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e3f563c81c48..32ddd893da9a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -362,8 +362,8 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 	 * for now. This will get more fine grained later once all memory
 	 * is mapped
 	 */
-	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
-	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+	unsigned long kernel_x_start = round_down(__pa(_stext), SWAPPER_BLOCK_SIZE);
+	unsigned long kernel_x_end = round_up(__pa(__init_end), SWAPPER_BLOCK_SIZE);
 
 	if (end < kernel_x_start) {
 		create_mapping(start, __phys_to_virt(start),
@@ -451,18 +451,18 @@ static void __init fixup_executable(void)
 {
 #ifdef CONFIG_DEBUG_RODATA
 	/* now that we are actually fully mapped, make the start/end more fine grained */
-	if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
+	if (!IS_ALIGNED((unsigned long)_stext, SWAPPER_BLOCK_SIZE)) {
 		unsigned long aligned_start = round_down(__pa(_stext),
-							SECTION_SIZE);
+							 SWAPPER_BLOCK_SIZE);
 
 		create_mapping(aligned_start, __phys_to_virt(aligned_start),
 				__pa(_stext) - aligned_start,
 				PAGE_KERNEL);
 	}
 
-	if (!IS_ALIGNED((unsigned long)__init_end, SECTION_SIZE)) {
+	if (!IS_ALIGNED((unsigned long)__init_end, SWAPPER_BLOCK_SIZE)) {
 		unsigned long aligned_end = round_up(__pa(__init_end),
-							SECTION_SIZE);
+							  SWAPPER_BLOCK_SIZE);
 		create_mapping(__pa(__init_end), (unsigned long)__init_end,
 				aligned_end - __pa(__init_end),
 				PAGE_KERNEL);
-- 
1.9.1
