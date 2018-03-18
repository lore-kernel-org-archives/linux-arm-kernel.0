From: liuwenliang@huawei.com (Abbott Liu)
Date: Sun, 18 Mar 2018 20:53:36 +0800
Subject: [PATCH 1/7] 2 1-byte checks more safer for memory_is_poisoned_16
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
Message-ID: <20180318125342.4278-2-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because in some architecture(eg. arm) instruction set, non-aligned
access support is not very well, so 2 1-byte checks is more
safer than 1 2-byte check. The impact on performance is small
because 16-byte accesses are not too common.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 mm/kasan/kasan.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index e13d911..104839a 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -151,13 +151,20 @@ static __always_inline bool memory_is_poisoned_2_4_8(unsigned long addr,
 
 static __always_inline bool memory_is_poisoned_16(unsigned long addr)
 {
-	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
-
-	/* Unaligned 16-bytes access maps into 3 shadow bytes. */
-	if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
-		return *shadow_addr || memory_is_poisoned_1(addr + 15);
+	u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
 
-	return *shadow_addr;
+	if (unlikely(shadow_addr[0] || shadow_addr[1])) {
+		return true;
+	} else if (likely(IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE))) {
+		/*
+		 * If two shadow bytes covers 16-byte access, we don't
+		 * need to do anything more. Otherwise, test the last
+		 * shadow byte.
+		 */
+		return false;
+	} else {
+		return memory_is_poisoned_1(addr + 15);
+	}
 }
 
 static __always_inline unsigned long bytes_is_nonzero(const u8 *start,
-- 
2.9.0
