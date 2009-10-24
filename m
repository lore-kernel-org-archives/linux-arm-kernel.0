From: rabin@rab.in (Rabin Vincent)
Date: Sat, 24 Oct 2009 14:29:42 +0530
Subject: [PATCH] Use REV and REV16 for byte swapping on ARMv6+
Message-ID: <1256374782-5803-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv6 introduced the REV and REV16 instructions that reverse bytes in
words and halfwords.  Use them for the arch-specific implementation of
the byte swapping helpers on ARMv6+.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/swab.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/swab.h b/arch/arm/include/asm/swab.h
index ca2bf2f..9997ad2 100644
--- a/arch/arm/include/asm/swab.h
+++ b/arch/arm/include/asm/swab.h
@@ -22,6 +22,24 @@
 #  define __SWAB_64_THRU_32__
 #endif
 
+#if defined(__KERNEL__) && __LINUX_ARM_ARCH__ >= 6
+
+static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
+{
+	__asm__ ("rev16 %0, %1" : "=r" (x) : "r" (x));
+	return x;
+}
+#define __arch_swab16 __arch_swab16
+
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
+{
+	__asm__ ("rev %0, %1" : "=r" (x) : "r" (x));
+	return x;
+}
+#define __arch_swab32 __arch_swab32
+
+#else
+
 static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	__u32 t;
@@ -48,3 +66,4 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 
 #endif
 
+#endif
-- 
1.6.5
