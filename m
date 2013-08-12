From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Aug 2013 17:40:02 +0800
Subject: [PATCH V3 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
References: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
Message-ID: <1376300407-14750-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the system suspends to LP1, the CPU clock source is switched to
CLK_M (12MHz Oscillator) during suspend/resume flow. The CPU clock
source is controlled by the CCLKG_BURST_POLICY register, and hence this
register must be restored during LP1 resume.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* move the CCLKG burst policy resume code to tegra_cpu_car_ops
V2:
* update the commit message
---
 drivers/clk/tegra/clk-tegra114.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index f74ed19..806d803 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -293,6 +293,8 @@
 #ifdef CONFIG_PM_SLEEP
 static struct cpu_clk_suspend_context {
 	u32 clk_csite_src;
+	u32 cclkg_burst;
+	u32 cclkg_divider;
 } tegra114_cpu_clk_sctx;
 #endif
 
@@ -2155,12 +2157,22 @@ static void tegra114_cpu_clock_suspend(void)
 	tegra114_cpu_clk_sctx.clk_csite_src =
 				readl(clk_base + CLK_SOURCE_CSITE);
 	writel(3 << 30, clk_base + CLK_SOURCE_CSITE);
+
+	tegra114_cpu_clk_sctx.cclkg_burst =
+				readl(clk_base + CCLKG_BURST_POLICY);
+	tegra114_cpu_clk_sctx.cclkg_divider =
+				readl(clk_base + CCLKG_BURST_POLICY + 4);
 }
 
 static void tegra114_cpu_clock_resume(void)
 {
 	writel(tegra114_cpu_clk_sctx.clk_csite_src,
 					clk_base + CLK_SOURCE_CSITE);
+
+	writel(tegra114_cpu_clk_sctx.cclkg_burst,
+					clk_base + CCLKG_BURST_POLICY);
+	writel(tegra114_cpu_clk_sctx.cclkg_divider,
+					clk_base + CCLKG_BURST_POLICY + 4);
 }
 #endif
 
-- 
1.8.3.4
