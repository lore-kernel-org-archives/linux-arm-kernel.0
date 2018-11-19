From: andreyknvl@google.com (Andrey Konovalov)
Date: Mon, 19 Nov 2018 18:26:27 +0100
Subject: [PATCH v11 11/24] kasan, arm64: untag address in _virt_addr_is_linear
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
Message-ID: <5cb565e6a6b17eceb6590a33d84208f725cf8dc2.1542648335.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt_addr_is_linear (which is used by virt_addr_valid) assumes that the
top byte of the address is 0xff, which isn't always the case with
tag-based KASAN.

This patch resets the tag in this macro.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index ae741827039c..ddad7df77027 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -322,9 +322,10 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
-#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
-#define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
-					 _virt_addr_valid(kaddr))
+#define _virt_addr_is_linear(kaddr)	\
+	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)
+#define virt_addr_valid(kaddr)		\
+	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
 #include <asm-generic/memory_model.h>
 
-- 
2.19.1.1215.g8438c0b245-goog
