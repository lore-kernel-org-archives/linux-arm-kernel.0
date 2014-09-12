From: cernekee@gmail.com (Kevin Cernekee)
Date: Thu, 11 Sep 2014 19:22:40 -0700
Subject: [PATCH 1/3] ARM: Add default SPARSEMEM settings
Message-ID: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can still override these settings via mach/memory.h, but let's provide
sensible defaults so that SPARSEMEM is available in the multiplatform
kernels.

Two platforms currently use SECTION_SIZE_BITS < 28, but are expected to
work with 28 (albeit slightly less efficiently if not all banks are
populated):

 - mach-rpc: uses 26 bits.  Based on mach/hardware.h it looks like this
   platform puts RAM@0x1000_0000 - 0x1fff_ffff, and I/O below
   0x1000_0000.

 - mach-sa1100: uses 27 bits.  mach/memory.h indicates that RAM occupies
   the entire range of 0xc000_0000 - 0xdfff_ffff.

Several platforms need MAX_PHYSMEM_BITS >= 36 so we'll pick that as the
minimum.  Anything higher and we'll fail the SECTIONS_WIDTH + NODES_WIDTH +
ZONES_WIDTH test in <linux/mm.h>.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/arm/include/asm/sparsemem.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/sparsemem.h b/arch/arm/include/asm/sparsemem.h
index 0009861..73e5e85 100644
--- a/arch/arm/include/asm/sparsemem.h
+++ b/arch/arm/include/asm/sparsemem.h
@@ -15,10 +15,11 @@
  * Eg, if you have 2 banks of up to 64MB at 0x80000000, 0x84000000,
  * then MAX_PHYSMEM_BITS is 32, SECTION_SIZE_BITS is 26.
  *
- * Define these in your mach/memory.h.
+ * These can be overridden in your mach/memory.h.
  */
-#if !defined(SECTION_SIZE_BITS) || !defined(MAX_PHYSMEM_BITS)
-#error Sparsemem is not supported on this platform
+#if !defined(MAX_PHYSMEM_BITS) || !defined(SECTION_SIZE_BITS)
+#define MAX_PHYSMEM_BITS	36
+#define SECTION_SIZE_BITS	28
 #endif
 
 #endif
-- 
1.7.9.5
