From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu,  1 Dec 2016 09:04:50 -0800
Subject: [PATCH v4 1/3] lib: add bitrev8x4()
In-Reply-To: <cover.1480551148.git.stillcompiling@gmail.com>
References: <cover.1480551148.git.stillcompiling@gmail.com>
Message-ID: <bc92eb1507448731163ae67fc888668d327f9168.1480551148.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to reverse bytes within a 32 bit word.
This function is more efficient than using the 8 bit version when
iterating over an array

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---

Looking for an ACK from Russell King on this patch (or at least 
the arm specific implementation)

 arch/arm/include/asm/bitrev.h |  5 +++++
 include/linux/bitrev.h        | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/include/asm/bitrev.h b/arch/arm/include/asm/bitrev.h
index ec291c3..6d2e9ca 100644
--- a/arch/arm/include/asm/bitrev.h
+++ b/arch/arm/include/asm/bitrev.h
@@ -17,4 +17,9 @@ static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
 	return __arch_bitrev32((u32)x) >> 24;
 }
 
+static __always_inline __attribute_const__ u32 __arch_bitrev8x4(u32 x)
+{
+	__asm__ ("rbit %0, %1; rev %0, %0" : "=r" (x) : "r" (x));
+}
+
 #endif
diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index fb790b8..b1cfa1a 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -9,6 +9,7 @@
 #define __bitrev32 __arch_bitrev32
 #define __bitrev16 __arch_bitrev16
 #define __bitrev8 __arch_bitrev8
+#define __bitrev8x4 __arch_bitrev8x4
 
 #else
 extern u8 const byte_rev_table[256];
@@ -27,6 +28,14 @@ static inline u32 __bitrev32(u32 x)
 	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
 }
 
+static inline u32 __bitrev8x4(u32 x)
+{
+	return(__bitrev8(x & 0xff) |
+	       (__bitrev8((x >> 8)  & 0xff) << 8) |
+	       (__bitrev8((x >> 16)  & 0xff) << 16) |
+	       (__bitrev8((x >> 24)  & 0xff) << 24));
+}
+
 #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
 
 #define __constant_bitrev32(x)	\
@@ -50,6 +59,15 @@ static inline u32 __bitrev32(u32 x)
 	__x;								\
 })
 
+#define __constant_bitrev8x4(x) \
+({			\
+	u32 __x = x;	\
+	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
+	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
+	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
+	__x;								\
+})
+
 #define __constant_bitrev8(x)	\
 ({					\
 	u8 __x = x;			\
@@ -75,6 +93,14 @@ static inline u32 __bitrev32(u32 x)
 	__bitrev16(__x);				\
  })
 
+#define bitrev8x4(x) \
+({			\
+	u32 __x = x;	\
+	__builtin_constant_p(__x) ?	\
+	__constant_bitrev8x4(__x) :			\
+	__bitrev8x4(__x);				\
+})
+
 #define bitrev8(x) \
 ({			\
 	u8 __x = x;	\
-- 
2.9.3
