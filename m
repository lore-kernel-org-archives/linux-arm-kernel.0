From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:38 +0100
Subject: [PATCH 2/7] clk: mvebu: move clk-cpu compatible strings into the
 clk-cpu driver
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the clk-core and clk-gating drivers define their compatible
string in their own .c file and provide an initialization function to
register the clock types. clk-cpu was not doing the same: it was
defining its compatible string directly in clk.c, and calling
of_clk_init() from here.

For consistency reasons, this patch moves the clk-cpu compatible
string in clk-cpu.c, and implements a proper mvebu_cpu_clk_init()
function like the other two clock drivers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/clk-cpu.c |   15 +++++++++++++++
 drivers/clk/mvebu/clk-cpu.h |    6 +++++-
 drivers/clk/mvebu/clk.c     |   14 +-------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 1df027a..3d7c9f1 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -153,3 +153,18 @@ bail_out:
 	kfree(clks);
 	kfree(cpuclk);
 }
+
+static const __initconst struct of_device_id clk_cpu_match[] = {
+	{
+		.compatible = "marvell,armada-xp-cpu-clockctrl",
+		.data = of_cpu_clk_setup,
+	},
+	{
+		/* sentinel */
+	},
+};
+
+void __init mvebu_cpu_clk_init(void)
+{
+	of_clk_init(clk_cpu_match);
+}
diff --git a/drivers/clk/mvebu/clk-cpu.h b/drivers/clk/mvebu/clk-cpu.h
index e208336..08e2aff 100644
--- a/drivers/clk/mvebu/clk-cpu.h
+++ b/drivers/clk/mvebu/clk-cpu.h
@@ -13,6 +13,10 @@
 #ifndef __MVEBU_CLK_CPU_H
 #define __MVEBU_CLK_CPU_H
 
-void __init of_cpu_clk_setup(struct device_node *node);
+#ifdef CONFIG_MVEBU_CLK_CPU
+void __init mvebu_cpu_clk_init(void);
+#else
+static inline void mvebu_cpu_clk_init(void) {}
+#endif
 
 #endif
diff --git a/drivers/clk/mvebu/clk.c b/drivers/clk/mvebu/clk.c
index 3f0e43e..e3bc036 100644
--- a/drivers/clk/mvebu/clk.c
+++ b/drivers/clk/mvebu/clk.c
@@ -19,21 +19,9 @@
 #include "clk-cpu.h"
 #include "clk-gating-ctrl.h"
 
-static const __initconst struct of_device_id clk_match[] = {
-#ifdef CONFIG_MVEBU_CLK_CPU
-	{
-		.compatible = "marvell,armada-xp-cpu-clockctrl",
-		.data = of_cpu_clk_setup,
-	},
-#endif
-	{
-		/* sentinel */
-	}
-};
-
 void __init mvebu_clocks_init(void)
 {
 	mvebu_core_clk_init();
 	mvebu_clk_gating_init();
-	of_clk_init(clk_match);
+	mvebu_cpu_clk_init();
 }
-- 
1.7.9.5
