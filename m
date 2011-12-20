From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:43 +0800
Subject: [PATCH 12/12] arm/mxs: select HAVE_CLK_PREPARE for clock
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clk_prepare/clk_unprepare for mxs clock api by
renaming the existing non-atomic clk_enable/clk_disable to
clk_prepare/clk_unprepare and adding a pair of dummy
clk_enable/clk_disable.  Then with selecting HAVE_CLK_PREPARE for
mxs clock, we can fix the mutex locking warning that has been
reported for a few times.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/mach-mxs/clock.c |   31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 776d76b..dc46163 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -442,6 +442,7 @@ config ARCH_MXS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select HAVE_CLK_PREPARE
 	help
 	  Support for Freescale MXS-based family of processors
 
diff --git a/arch/arm/mach-mxs/clock.c b/arch/arm/mach-mxs/clock.c
index 755eec0..97a6f4a 100644
--- a/arch/arm/mach-mxs/clock.c
+++ b/arch/arm/mach-mxs/clock.c
@@ -74,10 +74,15 @@ static int __clk_enable(struct clk *clk)
 	return 0;
 }
 
-/* This function increments the reference count on the clock and enables the
- * clock if not already enabled. The parent clock tree is recursively enabled
+/*
+ * The clk_enable/clk_disable could be called by drivers in atomic context,
+ * so they should not really hold mutex.  Instead, clk_prepare/clk_unprepare
+ * can hold a mutex, as the pair will only be called in non-atomic context.
+ * Before migrating to common clk framework, we can have __clk_enable and
+ * __clk_disable called in clk_prepare/clk_unprepare with mutex held and
+ * leave clk_enable/clk_disable as the dummy functions.
  */
-int clk_enable(struct clk *clk)
+int clk_prepare(struct clk *clk)
 {
 	int ret = 0;
 
@@ -90,13 +95,9 @@ int clk_enable(struct clk *clk)
 
 	return ret;
 }
-EXPORT_SYMBOL(clk_enable);
+EXPORT_SYMBOL(clk_prepare);
 
-/* This function decrements the reference count on the clock and disables
- * the clock when reference count is 0. The parent clock tree is
- * recursively disabled
- */
-void clk_disable(struct clk *clk)
+void clk_unprepare(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
 		return;
@@ -105,6 +106,18 @@ void clk_disable(struct clk *clk)
 	__clk_disable(clk);
 	mutex_unlock(&clocks_mutex);
 }
+EXPORT_SYMBOL(clk_unprepare);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	/* nothing to do */
+}
 EXPORT_SYMBOL(clk_disable);
 
 /* Retrieve the *current* clock rate. If the clock itself
-- 
1.7.4.1
