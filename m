From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 16 Dec 2016 15:17:51 -0800
Subject: [PATCH v6 2/5] lib: implement __arch_bitrev8x4()
In-Reply-To: <cover.1481918884.git.stillcompiling@gmail.com>
References: <cover.1481918884.git.stillcompiling@gmail.com>
Message-ID: <6c1c052d3c1d0c02a791aaaf8e114360ab1cb4e7.1481918884.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement faster bitrev8x4() for arm, arm64 and mips, all the platforms
with CONFIG_HAVE_ARCH_BITREVERSE.
ARM platforms just need a byteswap added to the existing __arch_bitrev32()
Amusingly, the mips implementation is exactly the opposite, requiring
removal of the byteswap from its __arch_bitrev32()

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/include/asm/bitrev.h   | 6 ++++++
 arch/arm64/include/asm/bitrev.h | 6 ++++++
 arch/mips/include/asm/bitrev.h  | 6 ++++++
 include/linux/bitrev.h          | 1 +
 4 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/bitrev.h b/arch/arm/include/asm/bitrev.h
index ec291c3..9482f78 100644
--- a/arch/arm/include/asm/bitrev.h
+++ b/arch/arm/include/asm/bitrev.h
@@ -17,4 +17,10 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
 	return __arch_bitrev32((u32)x) >> 24;
 }
 
+static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
+{
+	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
+	return x;
+}
+
 #endif
diff --git a/arch/arm64/include/asm/bitrev.h b/arch/arm64/include/asm/bitrev.h
index a5a0c36..1801078 100644
--- a/arch/arm64/include/asm/bitrev.h
+++ b/arch/arm64/include/asm/bitrev.h
@@ -16,4 +16,10 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
 	return __arch_bitrev32((u32)x) >> 24;
 }
 
+static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
+{
+	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
+	return x;
+}
+
 #endif
diff --git a/arch/mips/include/asm/bitrev.h b/arch/mips/include/asm/bitrev.h
index bc739a4..9ac6439 100644
--- a/arch/mips/include/asm/bitrev.h
+++ b/arch/mips/include/asm/bitrev.h
@@ -27,4 +27,10 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
 	return ret;
 }
 
+static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
+{
+	u32 ret;
+	asm("bitswap    %0, %1" : "=r"(ret) : "r"(x));
+	return ret;
+}
 #endif /* __MIPS_ASM_BITREV_H__ */
diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index 868dcb6..b1cfa1a 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -9,6 +9,7 @@
 #define __bitrev32 __arch_bitrev32
 #define __bitrev16 __arch_bitrev16
 #define __bitrev8 __arch_bitrev8
+#define __bitrev8x4 __arch_bitrev8x4
 
 #else
 extern u8 const byte_rev_table[256];
-- 
2.9.3
