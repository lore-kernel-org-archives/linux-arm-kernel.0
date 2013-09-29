From: eranpublic@yahoo.com (Eran Ben-Avi)
Date: Sun, 29 Sep 2013 09:51:53 -0700 (PDT)
Subject: [PATCH] ARM: l2x0: protect outer_cache_fns.sync pointer
 assignment with OUTER_CACHE_SYNC
In-Reply-To: <20130926131207.GA3467@darko.cambridge.arm.com>
References: <1379861550.88310.YahooMailNeo@web161601.mail.bf1.yahoo.com>
 <20130926131207.GA3467@darko.cambridge.arm.com>
Message-ID: <1380473513.19674.YahooMailNeo@web161602.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, Sep 26, 2013 at 4:13 PM, Catalin Marinas wrote:

> Since outer_cache.sync is conditionally defined, the patch makes sense.
> Alternatively, we could leave the .sync member always defined and just
> have a conditionally defined l2x0_cache_sync (NULL when
> !OUTER_CACHE_SYNC).
Fully agree.
Here is updated patch:


[PATCH] ARM: l2x0: define l2x0_cache_sync according to OUTER_CACHE_SYNC selection

??? Always define outer_cache_fns sync member and conditionally assign
??? l2x0_cache_sync depends on OUTER_CACHE_SYNC selection state.

Signed-off-by: Eran Ben-Avi <benavi@marvell.com>
---
?arch/arm/include/asm/outercache.h |??? 2 --
?arch/arm/mm/cache-l2x0.c????????? |??? 4 ++++
?2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index f94784f..697317c 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -30,9 +30,7 @@ struct outer_cache_fns {
???? void (*flush_all)(void);
???? void (*inv_all)(void);
???? void (*disable)(void);
-#ifdef CONFIG_OUTER_CACHE_SYNC
???? void (*sync)(void);
-#endif
???? void (*set_debug)(unsigned long);
???? void (*resume)(void);
?};
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 447da6f..5f3a0ca 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -128,6 +128,7 @@ static inline void l2x0_flush_line(unsigned long addr)
?}
?#endif
?
+#ifdef CONFIG_OUTER_CACHE_SYNC
?static void l2x0_cache_sync(void)
?{
???? unsigned long flags;
@@ -136,6 +137,9 @@ static void l2x0_cache_sync(void)
???? cache_sync();
???? raw_spin_unlock_irqrestore(&l2x0_lock, flags);
?}
+#else
+#define l2x0_cache_sync??? NULL
+#endif
?
?static void __l2x0_flush_all(void)
?{
-- 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel 
