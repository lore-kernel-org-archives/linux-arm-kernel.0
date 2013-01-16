From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 16 Jan 2013 16:10:48 +0800
Subject: [PATCH V4 3/5] clk: tegra20: Implementing CPU low-power function for
 tegra_cpu_car_ops
Message-ID: <1358323848-30382-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing suspend, resume and rail_off_ready API for tegra_cpu_car_ops. These
functions were used for CPU powered-down state maintenance.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* rebased on Tegra-ccf-rework-v4
V3:
* no change
V2:
* refine the code sequence in "tegra20_cpu_rail_off_ready"
---
 drivers/clk/tegra/clk-tegra20.c | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 9383b85..cb6971d 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/tegra.h>
+#include <linux/delay.h>
 
 #include "clk.h"
 
@@ -104,6 +105,13 @@
 #define SUPER_SCLK_DIVIDER 0x2c
 #define CLK_SYSTEM_RATE 0x30
 
+#define CCLK_BURST_POLICY_SHIFT	28
+#define CCLK_RUN_POLICY_SHIFT	4
+#define CCLK_IDLE_POLICY_SHIFT	0
+#define CCLK_IDLE_POLICY	1
+#define CCLK_RUN_POLICY		2
+#define CCLK_BURST_POLICY_PLLX	8
+
 #define CLK_SOURCE_I2S1 0x100
 #define CLK_SOURCE_I2S2 0x104
 #define CLK_SOURCE_SPDIF_OUT 0x108
@@ -169,6 +177,17 @@
 #define CPU_CLOCK(cpu)	(0x1 << (8 + cpu))
 #define CPU_RESET(cpu)	(0x1111ul << (cpu))
 
+#ifdef CONFIG_PM_SLEEP
+static struct cpu_clk_suspend_context {
+	u32 pllx_misc;
+	u32 pllx_base;
+
+	u32 cpu_burst;
+	u32 clk_csite_src;
+	u32 cclk_divider;
+} tegra20_cpu_clk_sctx;
+#endif
+
 static int periph_clk_enb_refcnt[CLK_OUT_ENB_NUM * 32];
 
 static void __iomem *clk_base;
@@ -1121,12 +1140,86 @@ static void tegra20_disable_cpu_clock(u32 cpu)
 	       clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static bool tegra20_cpu_rail_off_ready(void)
+{
+	unsigned int cpu_rst_status;
+
+	cpu_rst_status = readl(clk_base +
+			       TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
+
+	return !!(cpu_rst_status & 0x2);
+}
+
+static void tegra20_cpu_clock_suspend(void)
+{
+	/* switch coresite to clk_m, save off original source */
+	tegra20_cpu_clk_sctx.clk_csite_src =
+				readl(clk_base + CLK_SOURCE_CSITE);
+	writel(3<<30, clk_base + CLK_SOURCE_CSITE);
+
+	tegra20_cpu_clk_sctx.cpu_burst =
+				readl(clk_base + CCLK_BURST_POLICY);
+	tegra20_cpu_clk_sctx.pllx_base =
+				readl(clk_base + PLLX_BASE);
+	tegra20_cpu_clk_sctx.pllx_misc =
+				readl(clk_base + PLLX_MISC);
+	tegra20_cpu_clk_sctx.cclk_divider =
+				readl(clk_base + SUPER_CCLK_DIVIDER);
+}
+
+static void tegra20_cpu_clock_resume(void)
+{
+	unsigned int reg, policy;
+
+	/* Is CPU complex already running on PLLX? */
+	reg = readl(clk_base + CCLK_BURST_POLICY);
+	policy = (reg >> CCLK_BURST_POLICY_SHIFT) & 0xF;
+
+	if (policy == CCLK_IDLE_POLICY)
+		reg = (reg >> CCLK_IDLE_POLICY_SHIFT) & 0xF;
+	else if (policy == CCLK_RUN_POLICY)
+		reg = (reg >> CCLK_RUN_POLICY_SHIFT) & 0xF;
+	else
+		BUG();
+
+	if (reg != CCLK_BURST_POLICY_PLLX) {
+		/* restore PLLX settings if CPU is on different PLL */
+		writel(tegra20_cpu_clk_sctx.pllx_misc,
+					clk_base + PLLX_MISC);
+		writel(tegra20_cpu_clk_sctx.pllx_base,
+					clk_base + PLLX_BASE);
+
+		/* wait for PLL stabilization if PLLX was enabled */
+		if (tegra20_cpu_clk_sctx.pllx_base & (1 << 30))
+			udelay(300);
+	}
+
+	/*
+	 * Restore original burst policy setting for calls resulting from CPU
+	 * LP2 in idle or system suspend.
+	 */
+	writel(tegra20_cpu_clk_sctx.cclk_divider,
+					clk_base + SUPER_CCLK_DIVIDER);
+	writel(tegra20_cpu_clk_sctx.cpu_burst,
+					clk_base + CCLK_BURST_POLICY);
+
+	writel(tegra20_cpu_clk_sctx.clk_csite_src,
+					clk_base + CLK_SOURCE_CSITE);
+}
+#endif
+
 static struct tegra_cpu_car_ops tegra20_cpu_car_ops = {
 	.wait_for_reset	= tegra20_wait_cpu_in_reset,
 	.put_in_reset	= tegra20_put_cpu_in_reset,
 	.out_of_reset	= tegra20_cpu_out_of_reset,
 	.enable_clock	= tegra20_enable_cpu_clock,
 	.disable_clock	= tegra20_disable_cpu_clock,
+#ifdef CONFIG_PM_SLEEP
+	.rail_off_ready = tegra20_cpu_rail_off_ready,
+	.suspend	= tegra20_cpu_clock_suspend,
+	.resume		= tegra20_cpu_clock_resume,
+#endif
 };
 
 static __initdata struct tegra_clk_init_table init_table[] = {
-- 
1.8.0.3
