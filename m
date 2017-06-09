From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri,  9 Jun 2017 15:39:38 -0700
Subject: [PATCH v13 5/6] lib: add bitrev8x4()
In-Reply-To: <03e591707dc72f4c2b5e63a1272060956294ea51.1497047816.git.stillcompiling@gmail.com>
References: <03e591707dc72f4c2b5e63a1272060956294ea51.1497047816.git.stillcompiling@gmail.com>
Message-ID: <74028f801ba1d69e44b21d0f6d3d6ea8352fde4a.1497047816.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to reverse bytes within a 32 bit word.
Operate on a u32 rather than individual bytes.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/bitrev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index fb790b8449c1..b97be27e5a85 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -29,6 +29,8 @@ static inline u32 __bitrev32(u32 x)
 
 #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
 
+#define __bitrev8x4(x)	(__bitrev32(swab32(x)))
+
 #define __constant_bitrev32(x)	\
 ({					\
 	u32 __x = x;			\
@@ -50,6 +52,15 @@ static inline u32 __bitrev32(u32 x)
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
@@ -75,6 +86,14 @@ static inline u32 __bitrev32(u32 x)
 	__bitrev16(__x);				\
  })
 
+#define bitrev8x4(x) \
+({			\
+	u32 __x = x;	\
+	__builtin_constant_p(__x) ?	\
+	__constant_bitrev8x4(__x) :			\
+	__bitrev8x4(__x);				\
+ })
+
 #define bitrev8(x) \
 ({			\
 	u8 __x = x;	\
-- 
2.11.0
