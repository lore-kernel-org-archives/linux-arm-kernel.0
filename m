From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Jul 2013 17:15:05 +0800
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
Message-ID: <1374830110-30685-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the system suspends to LP1, the clock of the CPU would be switched to
CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
needs to restore the clock of CPU after LP1 resume.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index f74ed19..b0e745a 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/syscore_ops.h>
 #include <linux/clk/tegra.h>
 
 #include "clk.h"
@@ -2332,6 +2333,33 @@ void tegra114_clock_deassert_dfll_dvco_reset(void)
 }
 EXPORT_SYMBOL(tegra114_clock_deassert_dfll_dvco_reset);
 
+#ifdef CONFIG_PM_SLEEP
+static u32 clk_rst_suspend[2];
+
+static int tegra114_clk_suspend(void)
+{
+	u32 *ctx = clk_rst_suspend;
+
+	*ctx++ = readl_relaxed(clk_base + CCLKG_BURST_POLICY);
+	*ctx++ = readl_relaxed(clk_base + CCLKG_BURST_POLICY + 4);
+
+	return 0;
+}
+
+static void tegra114_clk_resume(void)
+{
+	u32 *ctx = clk_rst_suspend;
+
+	writel_relaxed(*ctx++, clk_base + CCLKG_BURST_POLICY);
+	writel_relaxed(*ctx++, clk_base + CCLKG_BURST_POLICY + 4);
+}
+
+static struct syscore_ops tegra114_clk_syscore_ops = {
+	.suspend = tegra114_clk_suspend,
+	.resume = tegra114_clk_resume,
+};
+#endif
+
 static void __init tegra114_clock_init(struct device_node *np)
 {
 	struct device_node *node;
@@ -2384,5 +2412,9 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_clk_apply_init_table = tegra114_clock_apply_init_table;
 
 	tegra_cpu_car_ops = &tegra114_cpu_car_ops;
+
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&tegra114_clk_syscore_ops);
+#endif
 }
 CLK_OF_DECLARE(tegra114, "nvidia,tegra114-car", tegra114_clock_init);
-- 
1.8.3.4
