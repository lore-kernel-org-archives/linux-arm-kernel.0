From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 08:20:02 -0700
Subject: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
Message-ID: <mailman.221.1283444403.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SMP and UP macros for cacheflush. Note that __flush_icache_all
currently won't work properly on ARMv7 SMP if support for ARMv6 is
compiled in.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/cacheflush.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 4656a24..09a893e 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,6 +16,7 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
+#include <asm/smp_plat.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -372,8 +373,10 @@ static inline void __flush_icache_all(void)
 	extern void v6_icache_inval_all(void);
 	v6_icache_inval_all();
 #elif defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ >= 7
-	asm("mcr	p15, 0, %0, c7, c1, 0	@ invalidate I-cache inner shareable\n"
-	    :
+	asm(								\
+	SMP(mcr	p15, 0, %0, c7, c1, 0	@ inv I-cache inner shareable)	\
+	UP(mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache)		\
+	    :								\
 	    : "r" (0));
 #else
 	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
-- 
1.7.1
