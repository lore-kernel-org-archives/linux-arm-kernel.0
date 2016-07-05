From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:59:20 +0530
Subject: [PATCH v3 1/2] clk: samsung: cpu: Prepare for addition for Exynos7
 CPU clocks
In-Reply-To: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
References: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1467750561-13957-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 has the same CPU clock registers layout as that present
in Exynos5433 except for the bits in the MUX_STAT* registers.
Add a new CLK_CPU_HAS_MODIFIED_MUX_STAT flag to handle this change.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c | 10 ++++++++--
 drivers/clk/samsung/clk-cpu.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 8bf7e80..d40d740 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -322,7 +322,10 @@ static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	/* select the alternate parent */
 	mux_reg = readl(base + E5433_MUX_SEL2);
 	writel(mux_reg | 1, base + E5433_MUX_SEL2);
-	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 2);
+	if (cpuclk->flags & CLK_CPU_HAS_MODIFIED_MUX_STAT)
+		wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 1);
+	else
+		wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 2);
 
 	/* alternate parent is active now. set the dividers */
 	writel(div0, base + E5433_DIV_CPU0);
@@ -348,7 +351,10 @@ static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	/* select apll as the alternate parent */
 	mux_reg = readl(base + E5433_MUX_SEL2);
 	writel(mux_reg & ~1, base + E5433_MUX_SEL2);
-	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 1);
+	if (cpuclk->flags & CLK_CPU_HAS_MODIFIED_MUX_STAT)
+		wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 0);
+	else
+		wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 1);
 
 	exynos5433_set_safe_div(base, div, div_mask);
 	spin_unlock_irqrestore(cpuclk->lock, flags);
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index d4b6b51..b4d9a4b 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -63,6 +63,8 @@ struct exynos_cpuclk {
 #define CLK_CPU_NEEDS_DEBUG_ALT_DIV	(1 << 1)
 /* The CPU clock registers have Exynos5433-compatible layout */
 #define CLK_CPU_HAS_E5433_REGS_LAYOUT	(1 << 2)
+/* Exynos5433-compatible layout with different MUX_STAT register bits */
+#define CLK_CPU_HAS_MODIFIED_MUX_STAT	(1 << 3)
 };
 
 extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
-- 
1.9.1
