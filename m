From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 27 Oct 2014 09:38:59 -0600
Subject: [PATCH v3] ARM: supplementing IO accessors with 64 bit capability
Message-ID: <1414424339-23834-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Some drivers on ARMv7 need 64 bit read and writes.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
Change for v3:
 - Bumped architecture version from 5 to 6

 arch/arm/include/asm/io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1805674..b755776 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -118,6 +118,24 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return val;
 }
 
+#if __LINUX_ARM_ARCH__ >= 6
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+	asm volatile("strd %1, %0"
+		     : "+Qo" (*(volatile u64 __force *)addr)
+		     : "r" (val));
+}
+
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 val;
+	asm volatile("ldrd %1, %0"
+		     : "+Qo" (*(volatile u64 __force *)addr),
+		       "=r" (val));
+	return val;
+}
+#endif
+
 /*
  * Architecture ioremap implementation.
  */
@@ -306,10 +324,17 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 					__raw_readw(c)); __r; })
 #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
 					__raw_readl(c)); __r; })
+#if __LINUX_ARM_ARCH__ >= 6
+#define readq_relaxed(c) ({ u64 __r = le64_to_cpu((__force __le64) \
+					__raw_readq(c)); __r; })
+#endif
 
 #define writeb_relaxed(v,c)	__raw_writeb(v,c)
 #define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
 #define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
+#if __LINUX_ARM_ARCH__ >= 6
+#define writeq_relaxed(v,c)	__raw_writeq((__force u64) cpu_to_le64(v),c)
+#endif
 
 #define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
 #define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-- 
1.9.1
