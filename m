From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  2 Aug 2017 15:51:59 -0700
Subject: [PATCH 2/2] arm64: Define PAGE_OFFSET using GENMASK_ULL
In-Reply-To: <20170802225159.159536-1-mka@chromium.org>
References: <20170802225159.159536-1-mka@chromium.org>
Message-ID: <20170802225159.159536-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As is the definition causes an integer overflow, which is expected,
however clang raises the following warning:

arch/arm64/kernel/head.S:47:8: warning:
      integer overflow in preprocessor expression
  #elif (PAGE_OFFSET & 0x1fffff) != 0
         ^~~~~~~~~~~
arch/arm64/include/asm/memory.h:52:46: note:
      expanded from macro 'PAGE_OFFSET'
  #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS - 1))
                                      ~~~~~~~~~~~~~~~~~~  ^  ~~~~~~~~~~~~~

Use GENMASK_ULL() instead of shifting explicitly, the macro takes care
of avoiding the overflow.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 32f82723338a..732d4eed8edd 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -65,7 +65,7 @@
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
+#define PAGE_OFFSET		GENMASK_ULL(BITS_PER_LONG_LONG - 1, VA_BITS - 1)
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
