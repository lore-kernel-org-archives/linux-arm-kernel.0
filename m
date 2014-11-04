From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:41 +0900
Subject: [PATCH 1/7] ARM: shmobile: Remove shmobile_clk_workaround()
 implementation
In-Reply-To: <cover.1415059146.git.horms+renesas@verge.net.au>
References: <cover.1415059146.git.horms+renesas@verge.net.au>
Message-ID: <b6c461d2791ce738bf14fc796e65b9a00072de96.1415059146.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The function isn't used or needed anymore, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile |  2 +-
 arch/arm/mach-shmobile/clock.c  | 32 +++-----------------------------
 arch/arm/mach-shmobile/clock.h  | 14 --------------
 3 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e20f278..dcb38d5 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -19,8 +19,8 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
 # Clock objects
-obj-y				+= clock.o
 ifndef CONFIG_COMMON_CLK
+obj-y				+= clock.o
 obj-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index 1f81ad7..34f056f 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
@@ -15,36 +15,12 @@
  * GNU General Public License for more details.
  *
  */
+
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-
-#ifdef CONFIG_COMMON_CLK
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include "clock.h"
-
-void __init shmobile_clk_workaround(const struct clk_name *clks,
-				    int nr_clks, bool enable)
-{
-	const struct clk_name *clkn;
-	struct clk *clk;
-	unsigned int i;
-
-	for (i = 0; i < nr_clks; ++i) {
-		clkn = clks + i;
-		clk = clk_get(NULL, clkn->clk);
-		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, clkn->con_id, clkn->dev_id);
-			if (enable)
-				clk_prepare_enable(clk);
-			clk_put(clk);
-		}
-	}
-}
-
-#else /* CONFIG_COMMON_CLK */
 #include <linux/sh_clk.h>
-#include <linux/export.h>
+
 #include "clock.h"
 #include "common.h"
 
@@ -80,5 +56,3 @@ void __clk_put(struct clk *clk)
 {
 }
 EXPORT_SYMBOL(__clk_put);
-
-#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/mach-shmobile/clock.h b/arch/arm/mach-shmobile/clock.h
index 31b6417..cf3552e 100644
--- a/arch/arm/mach-shmobile/clock.h
+++ b/arch/arm/mach-shmobile/clock.h
@@ -1,19 +1,6 @@
 #ifndef CLOCK_H
 #define CLOCK_H
 
-#ifdef CONFIG_COMMON_CLK
-/* temporary clock configuration helper for platform devices */
-
-struct clk_name {
-	const char *clk;
-	const char *con_id;
-	const char *dev_id;
-};
-
-void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
-			     bool enable);
-
-#else /* CONFIG_COMMON_CLK */
 /* legacy clock implementation */
 
 struct clk;
@@ -52,5 +39,4 @@ do {			\
 	(p)->div = d;	\
 } while (0)
 
-#endif /* CONFIG_COMMON_CLK */
 #endif
-- 
2.1.1
