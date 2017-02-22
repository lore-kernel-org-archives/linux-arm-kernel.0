From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 22 Feb 2017 15:51:18 +0000
Subject: [RFC PATCH] arm: Fix cache inconsistency when using fixmap
Message-ID: <1487778678.18810.8.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cacheable memory mappings need to be marked as shareable otherwise the
CPU accessing fixmap memory may end up with local cachelines for that
memory, resulting in different CPUs in the system seeing different
values for the same memory location.

This issue was discovered when investigating failures in the ARM kprobe
tests. kprobes uses patch_text() to modify the kernel image, which
when CONFIG_DEBUG_RODATA is enabled makes use of fixmap to map the page
to be modified. As the shareable attribute wasn't being set in the PTE
entry for that page, a write to it wasn't being broadcast to other
caches in the system, which in the the case being investigated was
CPU's in the other cluster of a big.LITTLE system.

Fixes: a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
Cc: stable at vger.kernel.org # v4.3+

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

The fixmap changes in the original commit a5f4c561b3b1 look a bit iffy
to me, shouldn't it have have made use of PAGE_KERNEL or pgprot_kernel
or something like that to get PTE attributes suitable for the system
being run, rather than rolling it's own set of values?
That's why I'm marking this as an RFC, perhaps the correct fix is to
rework the code to use the defines from arch/arm/include/asm/pgtable.h

 arch/arm/include/asm/fixmap.h       | 2 +-
 arch/arm/probes/kprobes/test-core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 5c17d2dec777..26d4a4677cd7 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -41,7 +41,7 @@ static const enum fixed_addresses __end_of_fixed_addresses =
 
 #define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
 
-#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
+#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_SHARED | L_PTE_MT_WRITEBACK)
 #define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
 
 /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 94285203e9f7..cde2b4e9358a 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-#define VERBOSE 0 /* Set to '1' for more logging of test cases */
+#define VERBOSE 1 /* Set to '1' for more logging of test cases */
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define NORMAL_ISA "16"
-- 
2.11.0
