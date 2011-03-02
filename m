From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Mar 2011 18:34:48 +0100
Subject: [PATCH 2/3] ARM: S5PV210: Add clock entries for MIPI DPHY control
In-Reply-To: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1299087289-29926-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock entries allow control of enable state of MIPI-DSIM
and MIPI-CSIS PHYs from respective drivers without a need
for any callbacks in driver's platform data.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c                   |   27 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |    2 +-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 2d59949..c77d6f2 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -185,6 +185,23 @@ static int s5pv210_clk_mask1_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLK_SRC_MASK1, clk, enable);
 }
 
+static int s5pv210_mipi_dphy_ctrl(struct clk *clk, int enable)
+{
+	u32 reset = clk->ctrlbit;
+	u32 reg = __raw_readl(S5PV210_MIPI_DPHY_CTRL);
+
+	reg = enable ? (reg | reset) : (reg & ~reset);
+	__raw_writel(reg, S5PV210_MIPI_DPHY_CTRL);
+
+	if (enable)
+		reg |= 0x1;
+	else if (!(reg & 0x6 & ~reset))
+		reg &= ~0x1;
+
+	__raw_writel(reg, S5PV210_MIPI_DPHY_CTRL);
+	return 0;
+}
+
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
 	.id		= -1,
@@ -531,6 +548,16 @@ static struct clk init_clocks[] = {
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "csis_dphy",
+		.id		= -1,
+		.enable		= s5pv210_mipi_dphy_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "dsim_dphy",
+		.id		= -1,
+		.enable		= s5pv210_mipi_dphy_ctrl,
+		.ctrlbit	= (1 << 2),
 	},
 };
 
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 4c45b74..31ab0c7 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -161,7 +161,7 @@
 #define S5P_MDNIE_SEL		S5P_CLKREG(0x7008)
 #define S5P_MIPI_PHY_CON0	S5P_CLKREG(0x7200)
 #define S5P_MIPI_PHY_CON1	S5P_CLKREG(0x7204)
-#define S5P_MIPI_DPHY_CONTROL	S5P_CLKREG(0xE814)
+#define S5PV210_MIPI_DPHY_CTRL	S5P_CLKREG(0xE814)
 
 #define S5P_IDLE_CFG_TL_MASK	(3 << 30)
 #define S5P_IDLE_CFG_TM_MASK	(3 << 28)
-- 
1.7.4.1
