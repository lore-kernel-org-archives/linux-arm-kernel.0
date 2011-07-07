From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 14:44:05 +0100
Subject: [PATCH] ARM: xscale: Always build the kernel in multi cache model mode
Message-ID: <1310046245-10518-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xscale defines an alternate set of cache functions including a
workaround which is required for certain processor revisions.

If a single cache model kernel is built, cache maintenance
operations may be statically resolved to the wrong functions,
resulting in incorrect cache maintenance for those processor
revisions which require the workaround.

This patch unconditionally defines MULTI_CACHE for xscale, so that
the correct cache functions will get called at runtime (as already
done for feroceon).

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/glue-cache.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 7e30874..51bb184 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -82,11 +82,7 @@
 #endif
 
 #if defined(CONFIG_CPU_XSCALE)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE xscale
-# endif
+# define MULTI_CACHE 1
 #endif
 
 #if defined(CONFIG_CPU_XSC3)
-- 
1.7.4.1
