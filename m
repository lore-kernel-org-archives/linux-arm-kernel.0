From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jan 2016 09:54:09 +0100
Subject: [PATCH] arm64: mm: use correct mapping granularity under DEBUG_RODATA
Message-ID: <1453971249-4407-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cherry picked from commit 4fee9f364b9b99f76732f2a6fd6df679a237fa74)

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

Fixes: da141706aea5 ("arm64: add better page protections to arm64")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ard.biesheuvel: add #define of SWAPPER_BLOCK_SIZE for -stable version]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5b8b664422d3..3b85ced2668a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -300,6 +300,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 }
 
 #ifdef CONFIG_DEBUG_RODATA
+#define SWAPPER_BLOCK_SIZE	(PAGE_SHIFT == 12 ? SECTION_SIZE : PAGE_SIZE)
 static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 {
 	/*
@@ -307,8 +308,8 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
 	 * for now. This will get more fine grained later once all memory
 	 * is mapped
 	 */
-	unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
-	unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+	unsigned long kernel_x_start = round_down(__pa(_stext), SWAPPER_BLOCK_SIZE);
+	unsigned long kernel_x_end = round_up(__pa(__init_end), SWAPPER_BLOCK_SIZE);
 
 	if (end < kernel_x_start) {
 		create_mapping(start, __phys_to_virt(start),
@@ -396,18 +397,18 @@ void __init fixup_executable(void)
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
2.5.0
