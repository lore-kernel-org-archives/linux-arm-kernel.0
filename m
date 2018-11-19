From: andreyknvl@google.com (Andrey Konovalov)
Date: Mon, 19 Nov 2018 18:26:22 +0100
Subject: [PATCH v11 06/24] kasan, arm64: adjust shadow size for tag-based mode
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
Message-ID: <8122d5bedc46bb3655d576c922db3d722a231bf0.1542648335.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tag-based KASAN uses 1 shadow byte for 16 bytes of kernel memory, so it
requires 1/16th of the kernel virtual address space for the shadow memory.

This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when the tag-based KASAN
mode is enabled.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Makefile             | 11 ++++++++++-
 arch/arm64/include/asm/memory.h |  7 +++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..99e7d08c6083 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -91,10 +91,19 @@ else
 TEXT_OFFSET := 0x00080000
 endif
 
+ifeq ($(CONFIG_KASAN_SW_TAGS), y)
+KASAN_SHADOW_SCALE_SHIFT := 4
+else
+KASAN_SHADOW_SCALE_SHIFT := 3
+endif
+
+KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
+
 # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
 # in 32-bit arithmetic
-KASAN_SHADOW_SCALE_SHIFT := 3
 KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
 	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
 	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..05fbc7ffcd31 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -74,12 +74,11 @@
 #define KERNEL_END        _end
 
 /*
- * KASAN requires 1/8th of the kernel virtual address space for the shadow
- * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
+ * address space for the shadow region respectively. They can bloat the stack
+ * significantly, so double the (minimum) stack size when they are in use.
  */
 #ifdef CONFIG_KASAN
-#define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_THREAD_SHIFT	1
 #else
-- 
2.19.1.1215.g8438c0b245-goog
