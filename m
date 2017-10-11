From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:22 +0800
Subject: [PATCH 06/11] change memory_is_poisoned_16 for aligned error
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-7-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Because arm instruction set don't support access the address which is
 not aligned, so must change memory_is_poisoned_16 for arm.

Cc:  Andrey Ryabinin <a.ryabinin@samsung.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 mm/kasan/kasan.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 12749da..e0e152b 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -149,6 +149,25 @@ static __always_inline bool memory_is_poisoned_2_4_8(unsigned long addr,
 	return memory_is_poisoned_1(addr + size - 1);
 }
 
+#ifdef CONFIG_ARM
+static __always_inline bool memory_is_poisoned_16(unsigned long addr)
+{
+	u8 *shadow_addr = (u8 *)kasan_mem_to_shadow((void *)addr);
+
+	if (unlikely(shadow_addr[0] || shadow_addr[1])) return true;
+	else {
+		/*
+		 * If two shadow bytes covers 16-byte access, we don't
+		 * need to do anything more. Otherwise, test the last
+		 * shadow byte.
+		 */
+		if (likely(IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
+			return false;
+		return memory_is_poisoned_1(addr + 15);
+	}
+}
+
+#else
 static __always_inline bool memory_is_poisoned_16(unsigned long addr)
 {
 	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
@@ -159,6 +178,7 @@ static __always_inline bool memory_is_poisoned_16(unsigned long addr)
 
 	return *shadow_addr;
 }
+#endif
 
 static __always_inline unsigned long bytes_is_nonzero(const u8 *start,
 					size_t size)
-- 
2.9.0
