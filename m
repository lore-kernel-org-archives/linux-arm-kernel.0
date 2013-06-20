From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:26 +0100
Subject: [PATCH v2 12/12] ARM: cacheflush: use -ishst dsb variant for ensuring
 flush completion
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-13-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_cache_vmap contains a dsb to ensure that any cacheflushing
operations to flush out newly written ptes have completed.

This patch adds the -ishst option to the dsb, since that is all that is
required for completing cacheflushing in the inner-shareable domain.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bff7138..38defc4 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -354,7 +354,7 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 		 * set_pte_at() called from vmap_pte_range() does not
 		 * have a DSB after cleaning the cache line.
 		 */
-		dsb();
+		dsb(ishst);
 }
 
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
-- 
1.8.2.2
