From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Dec 2012 09:49:28 +0800
Subject: [PATCH] ARM: decompressor: include CONFIG_DEBUG_LL_INCLUDE rather
 than mach/debug-macro.S
Message-ID: <1355104168-30581-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 91a9fec (ARM: move debug macros to common location) moves
arch/arm/kernel/debug.S and arch/arm/kernel/head.S to
CONFIG_DEBUG_LL_INCLUDE, but leaves arch/arm/boot/compressed/head.S
still with mach/debug-macro.S.  This causes the following build error
on platforms that moved to new DEBUG_LL inclusion mechanism, when
arch/arm/boot/compressed/head.S is compiled with DEBUG turned on.

  AS      arch/arm/boot/compressed/head.o
arch/arm/boot/compressed/head.S:49:30: fatal error: mach/debug-macro.S: No such file or directory
compilation terminated.

Fix the problem by replacing mach/debug-macro.S inclusion with
CONFIG_DEBUG_LL_INCLUDE one.

Reported-by: Steev Klimaszewski <steev@genesi-usa.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org
---
 arch/arm/boot/compressed/head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 49ca86e..fe4d9c3 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -44,7 +44,7 @@
 
 #else
 
-#include <mach/debug-macro.S>
+#include CONFIG_DEBUG_LL_INCLUDE
 
 		.macro	writeb,	ch, rb
 		senduart \ch, \rb
-- 
1.7.9.5
