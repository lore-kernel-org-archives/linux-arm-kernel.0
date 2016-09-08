From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  8 Sep 2016 11:02:20 +0100
Subject: [PATCH] arm64/io: Allow I/O writes to use {W,X}ZR
Message-ID: <56d8dac83c2b8167d8fc730075e255bbf9490bc1.1473328940.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When zeroing an I/O location, the current accessors are forced to
allocate a temporary register to store the zero for the write. By
tweaking the assembly constraints, we can allow the compiler to use
the zero register directly in such cases, and save some juggling.
Compiling a representative kernel configuration with GCC 6 shows
that 2.3KB worth of code can be wasted just on that!

  text     data    bss      dec      hex     filename
 13316776 3248256 18176769 34741801 2121e29 vmlinux.o.new
 13319140 3248256 18176769 34744165 2122765 vmlinux.o.old

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9b6e408cfa51..aff77237f9fa 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -40,25 +40,25 @@
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
-	asm volatile("strb %w0, [%1]" : : "r" (val), "r" (addr));
+	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_writew __raw_writew
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
-	asm volatile("strh %w0, [%1]" : : "r" (val), "r" (addr));
+	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-	asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
+	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_writeq __raw_writeq
 static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
 {
-	asm volatile("str %0, [%1]" : : "r" (val), "r" (addr));
+	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
 #define __raw_readb __raw_readb
-- 
2.8.1.dirty
