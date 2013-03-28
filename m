From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 12:30:05 +0000
Subject: [PATCH] clocksource: Fix build in non-OF case
Message-ID: <1364473805-773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4d10f054 (clocksource: make CLOCKSOURCE_OF_DECLARE type safe)
made CLOCKSOURCE_OF_DECLARE reference the function pointer in both the
OF and non-OF cases. In the non-OF case this is likely to introduce
build failures as users may reasonably conditionally compile the OF
specific code, either the macro ought to be used within CONFIG_OF and
not have a !CONFIG_OF case or the macro ought not to reference its
arguments in that case.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

The commit above is in -next.

 include/linux/clocksource.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index ac33184..b84a2f3 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -344,11 +344,7 @@ extern void clocksource_of_init(void);
 		     .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
 #else
 static inline void clocksource_of_init(void) {}
-#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)			\
-	static const struct of_device_id __clksrc_of_table_##name	\
-		__unused __section(__clksrc_of_table)			\
-		 = { .compatible = compat,				\
-		     .data = (fn == (clocksource_of_init_fn)NULL) ? fn : fn }
+#define CLOCKSOURCE_OF_DECLARE(name, compat, fn)
 #endif
 
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
1.7.10.4
