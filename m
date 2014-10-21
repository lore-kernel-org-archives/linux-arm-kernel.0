From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue, 21 Oct 2014 10:48:34 +0900
Subject: [PATCH] ARM: mm: fix discard_old_kernel_data
Message-ID: <1413856114-3538-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L1_CACHE_BYTES could be larger value than real L1 cache line size.
In that case, discard_old_kernel_data function would omit to invalidate 
last bytes as much as L1_CACHE_BYTES - real cache line size.

So fix end address to "to + PAGE_SIZE -1". The bottom bits
of the address is LINELEN. that is ignored by mcrr.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/mm/copypage-v6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index b9bcc9d..7042334 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -62,7 +62,7 @@ static void discard_old_kernel_data(void *kto)
 	__asm__("mcrr	p15, 0, %1, %0, c6	@ 0xec401f06"
 	   :
 	   : "r" (kto),
-	     "r" ((unsigned long)kto + PAGE_SIZE - L1_CACHE_BYTES)
+	     "r" ((unsigned long)kto + PAGE_SIZE - 1)
 	   : "cc");
 }
 
-- 
1.9.1
