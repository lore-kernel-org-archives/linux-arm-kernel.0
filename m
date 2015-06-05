From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu,  4 Jun 2015 18:58:36 -0700
Subject: [PATCH 1/3] ARM: Add default SPARSEMEM settings
In-Reply-To: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1433469518-8472-2-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Cernekee <cernekee@gmail.com>

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

But Arnd says in that rpc and sa1100 will never have to use the
default since they cannot be part of a multiplatform kernel, and that
is unlikely to change.

Several platforms need MAX_PHYSMEM_BITS >= 36 so we'll pick that as the
minimum.  Anything higher and we'll fail the SECTIONS_WIDTH + NODES_WIDTH +
ZONES_WIDTH test in <linux/mm.h>.

Some analysis from Russell King at
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/298957.html:

  I think this is fine in as far as it goes - this means we end up with
  256 entries in the mem_section array which means it occupies one page,
  which I think is acceptable overhead.

  The other thing to be aware of here is the obvious:

  #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
  #error Allocator MAX_ORDER exceeds SECTION_SIZE
  #endif

  Which means that with 28 bits of section, that's a maximum allocator
  order of 16.  We appear to allow FORCE_MAX_ZONEORDER to be set up to
  64 in the case of shmobile, which doesn't seem like a sensible upper
  limit - and certainly isn't when sparsemem is enabled.

  Given this, I think that FORCE_MAX_ZONEORDER's help, and the
  dependencies probably could do with some improvement to make the
  issues more transparent.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
[gregory.0xf0: added notes from Arnd and Russell]
Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/include/asm/sparsemem.h | 7 ++++---
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
1.9.1
