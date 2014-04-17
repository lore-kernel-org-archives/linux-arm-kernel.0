From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:38 +0900
Subject: [PATCH 2/8] ARM: shmobile: Introduce shmobile_clk_workaround()
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <25f5550f5a4b18fd77a2e719ba63cb34931ab66a.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce a new clock workaround function used by DT reference
code on the mach-shmobile subarchitecture. The new function
shmobile_clk_workaround() is used to configure clkdev to
allow DT and platform devices to coexist. It is possible for
the DT reference board code to also request enabling of the clock
in case the driver does not implement clock control.

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: Removed trailing blank line]
Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile             |  2 +-
 arch/arm/mach-shmobile/clock.c              | 28 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/clock.h | 16 ++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 4caffc9..c12a1c5 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -21,8 +21,8 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
 # Clock objects
-ifndef CONFIG_COMMON_CLK
 obj-y				+= clock.o
+ifndef CONFIG_COMMON_CLK
 obj-$(CONFIG_ARCH_SH7372)	+= clock-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= clock-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= clock-r8a73a4.o
diff --git a/arch/arm/mach-shmobile/clock.c b/arch/arm/mach-shmobile/clock.c
index ad7df62..e7232a0 100644
--- a/arch/arm/mach-shmobile/clock.c
+++ b/arch/arm/mach-shmobile/clock.c
@@ -21,6 +21,32 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <mach/clock.h>
+
+void __init shmobile_clk_workaround(const struct clk_name *clks,
+				    int nr_clks, bool enable)
+{
+	const struct clk_name *clkn;
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < nr_clks; ++i) {
+		clkn = clks + i;
+		clk = clk_get(NULL, clkn->clk);
+		if (!IS_ERR(clk)) {
+			clk_register_clkdev(clk, clkn->con_id, clkn->dev_id);
+			if (enable)
+				clk_prepare_enable(clk);
+			clk_put(clk);
+		}
+	}
+}
+
+#else /* CONFIG_COMMON_CLK */
 #include <linux/sh_clk.h>
 #include <linux/export.h>
 #include <mach/clock.h>
@@ -58,3 +84,5 @@ void __clk_put(struct clk *clk)
 {
 }
 EXPORT_SYMBOL(__clk_put);
+
+#endif /* CONFIG_COMMON_CLK */
diff --git a/arch/arm/mach-shmobile/include/mach/clock.h b/arch/arm/mach-shmobile/include/mach/clock.h
index 03e5607..9a93cf9 100644
--- a/arch/arm/mach-shmobile/include/mach/clock.h
+++ b/arch/arm/mach-shmobile/include/mach/clock.h
@@ -1,6 +1,21 @@
 #ifndef CLOCK_H
 #define CLOCK_H
 
+#ifdef CONFIG_COMMON_CLK
+/* temporary clock configuration helper for platform devices */
+
+struct clk_name {
+	const char *clk;
+	const char *con_id;
+	const char *dev_id;
+};
+
+void shmobile_clk_workaround(const struct clk_name *clks, int nr_clks,
+			     bool enable);
+
+#else /* CONFIG_COMMON_CLK */
+/* legacy clock implementation */
+
 unsigned long shmobile_fixed_ratio_clk_recalc(struct clk *clk);
 extern struct sh_clk_ops shmobile_fixed_ratio_clk_ops;
 
@@ -36,4 +51,5 @@ do {			\
 	(p)->div = d;	\
 } while (0)
 
+#endif /* CONFIG_COMMON_CLK */
 #endif
-- 
1.8.4
