From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Wed, 18 Nov 2009 14:25:27 -0800
Subject: [PATCH] BCMRING: use generic io access macros
Message-ID: <20091118222527.GB11579@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch to cleanup the mach/io.h, using the new generic io access
macros.

From: Leo Chen <leochen@broadcom.com>
Date: Wed, 18 Nov 2009 14:20:47 -0800
Subject: [PATCH] bcmring: use generic io macros defined in asm/io.h

removed old macro definition for io access, using the generic macros
defined in asm/io.h

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/include/mach/io.h |   35 +++++-------------------------
 1 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-bcmring/include/mach/io.h b/arch/arm/mach-bcmring/include/mach/io.h
index 4db0eff..dae5e9b 100644
--- a/arch/arm/mach-bcmring/include/mach/io.h
+++ b/arch/arm/mach-bcmring/include/mach/io.h
@@ -23,34 +23,11 @@
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-#define __io(a)         ((void __iomem *)HW_IO_PHYS_TO_VIRT(a))
-
-/* Do not enable mem_pci for a big endian arm architecture or unexpected byteswaps will */
-/* happen in readw/writew etc. */
-
-#define readb(c)        __raw_readb(c)
-#define readw(c)        __raw_readw(c)
-#define readl(c)        __raw_readl(c)
-#define readb_relaxed(addr) readb(addr)
-#define readw_relaxed(addr) readw(addr)
-#define readl_relaxed(addr) readl(addr)
-
-#define readsb(p, d, l)   __raw_readsb(p, d, l)
-#define readsw(p, d, l)   __raw_readsw(p, d, l)
-#define readsl(p, d, l)   __raw_readsl(p, d, l)
-
-#define writeb(v, c)     __raw_writeb(v, c)
-#define writew(v, c)     __raw_writew(v, c)
-#define writel(v, c)     __raw_writel(v, c)
-
-#define writesb(p, d, l)  __raw_writesb(p, d, l)
-#define writesw(p, d, l)  __raw_writesw(p, d, l)
-#define writesl(p, d, l)  __raw_writesl(p, d, l)
-
-#define memset_io(c, v, l)    _memset_io((c), (v), (l))
-#define memcpy_fromio(a, c, l)    _memcpy_fromio((a), (c), (l))
-#define memcpy_toio(c, a, l)  _memcpy_toio((c), (a), (l))
-
-#define eth_io_copy_and_sum(s, c, l, b) eth_copy_and_sum((s), (c), (l), (b))
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
 
 #endif
-- 
1.6.0.6

-- 

Leo Hao Chen

------------------------
Life is short, run long.
