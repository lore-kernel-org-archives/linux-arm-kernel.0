From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu,  3 Aug 2017 11:03:58 -0700
Subject: [PATCH v2] arm64: avoid overflow in VA_START and PAGE_OFFSET
In-Reply-To: <CAKwvOdk1A-wvuNDaLokYu1oNPUV-ab24=NzdL5Sbh6QcV_vDMQ@mail.gmail.com>
References: <CAKwvOdk1A-wvuNDaLokYu1oNPUV-ab24=NzdL5Sbh6QcV_vDMQ@mail.gmail.com>
Message-ID: <20170803180400.119270-1-ndesaulniers@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bitmask used to define these values produces overflow, as seen by
this compiler warning:

arch/arm64/kernel/head.S:47:8: warning:
      integer overflow in preprocessor expression
  #elif (PAGE_OFFSET & 0x1fffff) != 0
         ^~~~~~~~~~~
arch/arm64/include/asm/memory.h:52:46: note:
      expanded from macro 'PAGE_OFFSET'
  #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS -
1))
                                      ~~~~~~~~~~~~~~~~~~  ^

It would be preferrable to use GENMASK_ULL() instead, but it's not set
up to be used from assembly (the UL() macro token pastes UL suffixes
when not included in assembly sources).

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Suggested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/include/asm/memory.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 32f82723338a..ef39dcb9ca6a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -64,8 +64,10 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
-#define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
+#define VA_START		(UL(0xffffffffffffffff) - \
+	(UL(1) << VA_BITS) + 1)
+#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
+	(UL(1) << (VA_BITS - 1)) + 1)
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
