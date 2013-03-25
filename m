From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:17:38 +0000
Subject: [PATCH v2 4/5] ARM: mm: remove broken condition check for v4 flushing
In-Reply-To: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
References: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235459-17672-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point having a conditional cache flush if we don't know the
state of the condition beforehand.

This patch makes the cacheflush in v4_flush_user_cache_range
unconditional.

signed-off-by: will deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-v4.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-v4.S b/arch/arm/mm/cache-v4.S
index 43e5d77..a7ba68f 100644
--- a/arch/arm/mm/cache-v4.S
+++ b/arch/arm/mm/cache-v4.S
@@ -58,7 +58,7 @@ ENTRY(v4_flush_kern_cache_all)
 ENTRY(v4_flush_user_cache_range)
 #ifdef CONFIG_CPU_CP15
 	mov	ip, #0
-	mcreq	p15, 0, ip, c7, c7, 0		@ flush ID cache
+	mcr	p15, 0, ip, c7, c7, 0		@ flush ID cache
 	mov	pc, lr
 #else
 	/* FALLTHROUGH */
-- 
1.8.0
