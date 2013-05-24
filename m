From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 May 2013 12:31:26 +0100
Subject: [PATCH v2 3/4] ARM: cacheflush: don't round address range up to
 nearest page
In-Reply-To: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
References: <1369395087-30972-1-git-send-email-will.deacon@arm.com>
Message-ID: <1369395087-30972-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flush_cache_user_range macro takes a pair of addresses describing
the start and end of the virtual address range to flush. Due to an
accidental oversight when flush_cache_range_user was introduced, the
address range was rounded up so that the start and end addresses were
page-aligned.

For historical reference, the interesting commits in history.git are:

10eacf1775e1 ("[ARM] Clean up ARM cache handling interfaces (part 1)")
71432e79b76b ("[ARM] Add flush_cache_user_page() for sys_cacheflush()")

This patch removes the alignment code, reducing the amount of flushing
required for ranges that are not an exact multiple of PAGE_SIZE.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cacheflush.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bff7138..39c3faa 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -268,8 +268,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(start,end) \
-	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
+#define flush_cache_user_range(s,e)	__cpuc_coherent_user_range(s,e)
 
 /*
  * Perform necessary cache operations to ensure that data previously
-- 
1.8.2.2
