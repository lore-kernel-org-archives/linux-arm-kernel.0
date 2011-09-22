From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 11:10:24 +0100
Subject: [PATCH] clk: provide prepare/unprepare functions
Message-ID: <20110922101024.GK17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed previously, there's the need on some platforms to run some
parts of clk_enable() in contexts which can schedule.  The solution
which was agreed upon was to provide clk_prepare() and clk_unprepare()
to contain this parts, while clk_enable() and clk_disable() perform
the atomic part.

This patch provides a common definition for clk_prepare() and
clk_unprepare() in linux/clk.h, and provides an upgrade path for
existing implementation and drivers: drivers can start using
clk_prepare() and clk_unprepare() once this patch is merged without
having to wait for platform support.  Platforms can then start to
provide these additional functions.

Eventually, HAVE_CLK_PREPARE will be removed from the kernel, and
everyone will have to provide these new APIs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/clk.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1d37f42..c7eb17d 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -11,6 +11,8 @@
 #ifndef __LINUX_CLK_H
 #define __LINUX_CLK_H
 
+#include <linux/kernel.h>
+
 struct device;
 
 /*
@@ -41,11 +43,29 @@ struct clk;
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_prepare - prepare a clock source
+ * @clk: clock source
+ *
+ * This prepares the clock source for use.
+ */
+#ifdef CONFIG_HAVE_CLK_PREPARE
+int clk_prepare(struct clk *clk);
+#else
+static inline int clk_prepare(struct clk *clk)
+{
+	might_sleep();
+	return 0;
+}
+#endif
+
+/**
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
  *
  * If the clock can not be enabled/disabled, this should return success.
  *
+ * May be called from atomic contexts.
+ *
  * Returns success (0) or negative errno.
  */
 int clk_enable(struct clk *clk);
@@ -57,6 +77,8 @@ int clk_enable(struct clk *clk);
  * Inform the system that a clock source is no longer required by
  * a driver and may be shut down.
  *
+ * May be called from atomic contexts.
+ *
  * Implementation detail: if the clock source is shared between
  * multiple drivers, clk_enable() calls must be balanced by the
  * same number of clk_disable() calls for the clock source to be
@@ -64,6 +86,21 @@ int clk_enable(struct clk *clk);
  */
 void clk_disable(struct clk *clk);
 
+/**
+ * clk_unprepare - undo preparation of a clock source
+ * @clk: clock source
+ *
+ * This prepares the clock source for use.
+ */
+#ifdef CONFIG_HAVE_CLK_PREPARE
+void clk_unprepare(struct clk *clk);
+#else
+static inline void clk_unprepare(struct clk *clk)
+{
+	might_sleep();
+}
+#endif
+
 /**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
