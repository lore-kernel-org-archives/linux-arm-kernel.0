From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 27 Sep 2012 23:02:32 +0100
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
Message-ID: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are building for a LE platform, and we haven't overriden the
MMIO ops, then we can optimize the mem*io operations using the
standard string functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/io.h |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 815c669..ed0577e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -23,6 +23,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <asm/memory.h>
@@ -249,9 +250,33 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writesw(p,d,l)		__raw_writesw(p,d,l)
 #define writesl(p,d,l)		__raw_writesl(p,d,l)
 
+#ifndef __ARMBE__
+static inline void memset_io(volatile void __iomem *dst, unsigned c,
+	size_t count)
+{
+	memset((void __force *)dst, c, count);
+}
+#define memset_io(dst,c,count) memset_io(dst,c,count)
+
+static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
+	size_t count)
+{
+	memcpy(to, (const void __force *)from, count);
+}
+#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
+
+static inline void memcpy_toio(volatile void __iomem *to, const void *from,
+	size_t count)
+{
+	memcpy((void __force *)to, from, count);
+}
+#define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
+
+#else
 #define memset_io(c,v,l)	_memset_io(c,(v),(l))
 #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),c,(l))
 #define memcpy_toio(c,a,l)	_memcpy_toio(c,(a),(l))
+#endif
 
 #endif	/* readl */
 
-- 
1.7.4.4
