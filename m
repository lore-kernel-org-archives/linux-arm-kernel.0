From: M.Mann@arkona-technologies.de (Matthias Mann)
Date: Sat, 07 Dec 2013 17:05:00 +0100
Subject: [PATCH v2] ARM: asm: add readq/writeq methods
Message-ID: <52A3472C.4010203@arkona-technologies.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
PCIe as a single transfer.

Signed-off-by: Matthias Mann <m.mann@arkona-technologies.de>
---
v2: Changed assembler according to comments from M?ns Rullg?rd
    Check for ARM architecture support and added preprocessor guards as
    requested by Russel King
---
 arch/arm/include/asm/io.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3c597c2..89d4ecd 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -112,6 +112,36 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return val;
 }
 
+#if __LINUX_ARM_ARCH__ >= 5
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 val;
+#if __LITTLE_ENDIAN
+	asm volatile("ldrd %Q1, %R1, %0"
+		     : "+Q" (*(volatile u64 __force *)addr),
+		       "=r" (val));
+#else
+	asm volatile("ldrd %R1, %Q1, %0"
+		     : "+Q" (*(volatile u64 __force *)addr),
+		       "=r" (val));
+#endif
+	return val;
+}
+
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+#if __LITTLE_ENDIAN
+	asm volatile("strd %Q1, %R1, %0"
+		     : "+Q" (*(volatile u64 __force *)addr)
+		     : "r" (val));
+#else
+	asm volatile("strd %R1, %Q1, %0"
+		     : "+Q" (*(volatile u64 __force *)addr)
+		     : "r" (val));
+#endif
+}
+#endif	/* __LINUX_ARM_ARCH__ >= 5 */
+
 /*
  * Architecture ioremap implementation.
  */
@@ -320,6 +350,23 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 
 #endif	/* readl */
 
+#if __LINUX_ARM_ARCH__ >= 5
+
+#ifndef readq
+#define readq_relaxed(c) ({ u64 __r = le64_to_cpu((__force __le64) \
+					__raw_readq(c)); __r; })
+
+#define readq(c)	({ u64 __v = readq_relaxed(c); __iormb(); __v; })
+#endif	/* readq */
+
+#ifndef writeq
+#define writeq_relaxed(v,c)	__raw_writeq((__force u64) cpu_to_le64(v),c)
+
+#define writeq(v,c)	({ __iowmb(); writeq_relaxed(v,c); })
+#endif	/* writeq */
+
+#endif	/* __LINUX_ARM_ARCH__ >= 5 */
+
 /*
  * ioremap and friends.
  *
-- 
1.8.3.2
