From: M.Mann@arkona-technologies.de (Matthias Mann)
Date: Sat, 07 Dec 2013 15:11:20 +0100
Subject: [PATCH] ARM: asm: add readq/writeq methods
Message-ID: <52A32C88.9010000@arkona-technologies.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
PCIe as a single transfer.

Signed-off-by: Matthias Mann <m.mann@arkona-technologies.de>
---
This patch creates checkpatch warnings, but I used the style used for the
existing functions.
It is based on branch next/soc of the arm-soc tree.

 arch/arm/include/asm/io.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3c597c2..0a8d015 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -94,6 +94,13 @@ static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 		     : "r" (val));
 }
 
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+	asm volatile("strd %1, %0"
+		     : "+Qo" (*(volatile u64 __force *)addr)
+		     : "r" (val));
+}
+
 static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
@@ -112,6 +119,15 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return val;
 }
 
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 val;
+	asm volatile("ldrd %1, %0"
+		     : "+Qo" (*(volatile u64 __force *)addr),
+		       "=r" (val));
+	return val;
+}
+
 /*
  * Architecture ioremap implementation.
  */
@@ -293,18 +309,23 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 					__raw_readw(c)); __r; })
 #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
 					__raw_readl(c)); __r; })
+#define readq_relaxed(c) ({ u64 __r = le64_to_cpu((__force __le64) \
+					__raw_readq(c)); __r; })
 
 #define writeb_relaxed(v,c)	__raw_writeb(v,c)
 #define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
 #define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
+#define writeq_relaxed(v,c)	__raw_writeq((__force u64) cpu_to_le64(v),c)
 
 #define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
 #define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
 #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(); __v; })
 
 #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
 #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
 #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
+#define writeq(v,c)		({ __iowmb(); writeq_relaxed(v,c); })
 
 #define readsb(p,d,l)		__raw_readsb(p,d,l)
 #define readsw(p,d,l)		__raw_readsw(p,d,l)
-- 
1.8.3.2
