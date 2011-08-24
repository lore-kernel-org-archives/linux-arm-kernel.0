From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 14:15:51 +0100
Subject: [PATCH 03/11] clk: Add fixed-rate clock
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1314191759-16941-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/Kconfig     |    4 ++++
 drivers/clk/Makefile    |    1 +
 drivers/clk/clk-fixed.c |   17 +++++++++++++++++
 include/linux/clk.h     |   14 ++++++++++++++
 4 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-fixed.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c53ed59..d8313d7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -8,3 +8,7 @@ config HAVE_MACH_CLKDEV
 
 config GENERIC_CLK
 	bool
+
+config GENERIC_CLK_FIXED
+	bool
+	depends on GENERIC_CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 570d5b9..9a3325a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -1,3 +1,4 @@
 
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_GENERIC_CLK)	+= clk.o
+obj-$(CONFIG_GENERIC_CLK_FIXED)	+= clk-fixed.o
diff --git a/drivers/clk/clk-fixed.c b/drivers/clk/clk-fixed.c
new file mode 100644
index 0000000..47a27f9
--- /dev/null
+++ b/drivers/clk/clk-fixed.c
@@ -0,0 +1,17 @@
+
+#include <linux/clk.h>
+#include <linux/module.h>
+
+#define to_clk_fixed(c) container_of(c, struct clk_hw_fixed, hw)
+
+static unsigned long clk_fixed_recalc_rate(struct clk_hw *hw)
+{
+	return to_clk_fixed(hw)->rate;
+}
+
+struct clk_hw_ops clk_fixed_ops = {
+	.recalc_rate = clk_fixed_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_fixed_ops);
+
+
diff --git a/include/linux/clk.h b/include/linux/clk.h
index e0969d2..fd62e86 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -110,6 +110,20 @@ int clk_prepare(struct clk *clk);
  */
 void clk_unprepare(struct clk *clk);
 
+/* Base clock implementations. Platform clock implementations can use these
+ * directly, or 'subclass' as approprate */
+
+#ifdef CONFIG_GENERIC_CLK_FIXED
+
+struct clk_hw_fixed {
+	struct clk_hw	hw;
+	unsigned long	rate;
+};
+
+extern struct clk_hw_ops clk_fixed_ops;
+
+#endif /* CONFIG_GENERIC_CLK_FIXED */
+
 #else /* !CONFIG_GENERIC_CLK */
 
 /*
-- 
1.7.5.4
