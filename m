From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  9 Aug 2018 21:20:58 +0200
Subject: [PATCH v5 06/18] khwasan,
 arm64: untag virt address in __kimg_to_phys and _virt_addr_is_linear
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
Message-ID: <3e8180bbbc82be79412be86316c5b7ea6470b7dc.1533842385.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
(which is used by virt_addr_valid) assume that the top byte of the address
is 0xff, which isn't always the case with KHWASAN enabled.

The solution is to reset the tag in those macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6d084431b7f7..e9e054dfb1fc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,6 +92,13 @@
 #define KASAN_THREAD_SHIFT	0
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
+#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
+						KASAN_TAG_SHIFTED(tag))
+#define KASAN_RESET_TAG(addr)		KASAN_SET_TAG(addr, 0xff)
+#endif
+
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
@@ -225,7 +232,12 @@ static inline unsigned long kaslr_offset(void)
 #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
 
 #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+
+#ifdef CONFIG_KASAN_HW
+#define __kimg_to_phys(addr)	(KASAN_RESET_TAG(addr) - kimage_voffset)
+#else
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
+#endif
 
 #define __virt_to_phys_nodebug(x) ({					\
 	phys_addr_t __x = (phys_addr_t)(x);				\
@@ -301,7 +313,13 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define _virt_addr_is_linear(kaddr)	(KASAN_RESET_TAG((u64)(kaddr)) >= \
+						PAGE_OFFSET)
+#else
 #define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
+#endif
+
 #define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
 					 _virt_addr_valid(kaddr))
 
-- 
2.18.0.597.ga71716f1ad-goog
