From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 18 Dec 2012 10:30:59 +0800
Subject: [PATCH V3 3/5] ARM: tegra20: clocks: add CPU low-power function into
 tegra_cpu_car_ops
In-Reply-To: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
Message-ID: <1355797861-12759-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
functions were used for CPU powered-down state maintenance.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* refine the code sequence in "tegra20_cpu_rail_off_ready"
---
 arch/arm/mach-tegra/tegra20_clocks.c |   99 ++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index 4eb6bc8..1780268 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -159,6 +159,31 @@
 #define CPU_CLOCK(cpu)	(0x1 << (8 + cpu))
 #define CPU_RESET(cpu)	(0x1111ul << (cpu))
 
+#define CLK_RESET_CCLK_BURST	0x20
+#define CLK_RESET_CCLK_DIVIDER  0x24
+#define CLK_RESET_PLLX_BASE	0xe0
+#define CLK_RESET_PLLX_MISC	0xe4
+
+#define CLK_RESET_SOURCE_CSITE	0x1d4
+
+#define CLK_RESET_CCLK_BURST_POLICY_SHIFT	28
+#define CLK_RESET_CCLK_RUN_POLICY_SHIFT		4
+#define CLK_RESET_CCLK_IDLE_POLICY_SHIFT	0
+#define CLK_RESET_CCLK_IDLE_POLICY		1
+#define CLK_RESET_CCLK_RUN_POLICY		2
+#define CLK_RESET_CCLK_BURST_POLICY_PLLX	8
+
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
 static void __iomem *reg_clk_base = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
 static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
 
@@ -1609,12 +1634,86 @@ static void tegra20_disable_cpu_clock(u32 cpu)
 	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static bool tegra20_cpu_rail_off_ready(void)
+{
+	unsigned int cpu_rst_status;
+
+	cpu_rst_status = readl(reg_clk_base +
+			       TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
+
+	return !!(cpu_rst_status & 0x2);
+}
+
+static void tegra20_cpu_clock_suspend(void)
+{
+	/* switch coresite to clk_m, save off original source */
+	tegra20_cpu_clk_sctx.clk_csite_src =
+				readl(reg_clk_base + CLK_RESET_SOURCE_CSITE);
+	writel(3<<30, reg_clk_base + CLK_RESET_SOURCE_CSITE);
+
+	tegra20_cpu_clk_sctx.cpu_burst =
+				readl(reg_clk_base + CLK_RESET_CCLK_BURST);
+	tegra20_cpu_clk_sctx.pllx_base =
+				readl(reg_clk_base + CLK_RESET_PLLX_BASE);
+	tegra20_cpu_clk_sctx.pllx_misc =
+				readl(reg_clk_base + CLK_RESET_PLLX_MISC);
+	tegra20_cpu_clk_sctx.cclk_divider =
+				readl(reg_clk_base + CLK_RESET_CCLK_DIVIDER);
+}
+
+static void tegra20_cpu_clock_resume(void)
+{
+	unsigned int reg, policy;
+
+	/* Is CPU complex already running on PLLX? */
+	reg = readl(reg_clk_base + CLK_RESET_CCLK_BURST);
+	policy = (reg >> CLK_RESET_CCLK_BURST_POLICY_SHIFT) & 0xF;
+
+	if (policy == CLK_RESET_CCLK_IDLE_POLICY)
+		reg = (reg >> CLK_RESET_CCLK_IDLE_POLICY_SHIFT) & 0xF;
+	else if (policy == CLK_RESET_CCLK_RUN_POLICY)
+		reg = (reg >> CLK_RESET_CCLK_RUN_POLICY_SHIFT) & 0xF;
+	else
+		BUG();
+
+	if (reg != CLK_RESET_CCLK_BURST_POLICY_PLLX) {
+		/* restore PLLX settings if CPU is on different PLL */
+		writel(tegra20_cpu_clk_sctx.pllx_misc,
+					reg_clk_base + CLK_RESET_PLLX_MISC);
+		writel(tegra20_cpu_clk_sctx.pllx_base,
+					reg_clk_base + CLK_RESET_PLLX_BASE);
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
+					reg_clk_base + CLK_RESET_CCLK_DIVIDER);
+	writel(tegra20_cpu_clk_sctx.cpu_burst,
+					reg_clk_base + CLK_RESET_CCLK_BURST);
+
+	writel(tegra20_cpu_clk_sctx.clk_csite_src,
+					reg_clk_base + CLK_RESET_SOURCE_CSITE);
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
 
 void __init tegra20_cpu_car_ops_init(void)
-- 
1.7.0.4
