From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Dec 2011 22:48:18 +0100
Subject: [PATCH] ARM: drop unused parameter from flush_cache_user_range
Message-ID: <1323985698-6371-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vma isn't used and flush_cache_user_range isn't a standard macro that
is used on several archs with the same prototype. In fact only unicore32
has a macro with the same name (with an identical implementation and no
in-tree users).

This is a part of a patch proposed by Dima Zavin (with Message-id:
1272439931-12795-1-git-send-email-dima at android.com) that didn't get
accepted.

Cc: Dima Zavin <dima@android.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/cacheflush.h |    2 +-
 arch/arm/kernel/traps.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..1252a26 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -249,7 +249,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
+#define flush_cache_user_range(start,end) \
 	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 99a5727..f363ad9 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -488,7 +488,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 		if (end > vma->vm_end)
 			end = vma->vm_end;
 
-		flush_cache_user_range(vma, start, end);
+		flush_cache_user_range(start, end);
 	}
 	up_read(&mm->mmap_sem);
 }
-- 
1.7.7.2
