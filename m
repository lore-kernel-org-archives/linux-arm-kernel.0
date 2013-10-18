From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 18 Oct 2013 16:45:04 +0300
Subject: [PATCH v4 7/7] clk: tegra124: add suspend/resume function for
 tegra_cpu_car_ops
In-Reply-To: <1382103904-6398-1-git-send-email-pdeschrijver@nvidia.com>
References: <1382103904-6398-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1382103904-6398-8-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

Adding suspend/resume function for tegra_cpu_car_ops. We only save and
restore the setting of the clock of CoreSight. Other clocks still need
to be taken care by clock driver.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 700755e..266e80b 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -28,6 +28,7 @@
 #include "clk.h"
 #include "clk-id.h"
 
+#define CLK_SOURCE_CSITE 0x1d4
 #define CLK_SOURCE_EMC 0x19c
 #define CLK_SOURCE_XUSB_SS_SRC 0x610
 
@@ -117,6 +118,12 @@
 /* Tegra CPU clock and reset control regs */
 #define CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
 
+#ifdef CONFIG_PM_SLEEP
+static struct cpu_clk_suspend_context {
+	u32 clk_csite_src;
+} tegra124_cpu_clk_sctx;
+#endif
+
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
@@ -1309,9 +1316,29 @@ static void tegra124_disable_cpu_clock(u32 cpu)
 	/* flow controller would take care in the power sequence. */
 }
 
+#ifdef CONFIG_PM_SLEEP
+static void tegra124_cpu_clock_suspend(void)
+{
+	/* switch coresite to clk_m, save off original source */
+	tegra124_cpu_clk_sctx.clk_csite_src =
+				readl(clk_base + CLK_SOURCE_CSITE);
+	writel(3 << 30, clk_base + CLK_SOURCE_CSITE);
+}
+
+static void tegra124_cpu_clock_resume(void)
+{
+	writel(tegra124_cpu_clk_sctx.clk_csite_src,
+				clk_base + CLK_SOURCE_CSITE);
+}
+#endif
+
 static struct tegra_cpu_car_ops tegra124_cpu_car_ops = {
 	.wait_for_reset	= tegra124_wait_cpu_in_reset,
 	.disable_clock	= tegra124_disable_cpu_clock,
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= tegra124_cpu_clock_suspend,
+	.resume		= tegra124_cpu_clock_resume,
+#endif
 };
 
 static const struct of_device_id pmc_match[] __initconst = {
-- 
1.7.7.rc0.72.g4b5ea.dirty
