From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Mar 2011 18:34:49 +0100
Subject: [PATCH 3/3] ARM: EXYNOS4: Add clock entries for MIPI DPHY control
In-Reply-To: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1299087289-29926-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock entries allow enable control of MIPI-DSIM and
MIPI-CSIS PHYs from respective drivers without a need for
any callbacks in driver's platform data.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/clock.c                 |   31 ++++++++++++++++++++++++-
 arch/arm/mach-exynos4/include/mach/regs-pmu.h |    2 +
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 72d53d5..6d64b06 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -23,6 +23,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/regs-pmu.h>
 
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
@@ -116,6 +117,24 @@ static int exynos4_clk_ip_perir_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP_PERIR, clk, enable);
 }
 
+static int exynos4_mipi_dphy_ctrl(struct clk *clk, int enable)
+{
+	u32 reset = clk->ctrlbit;
+	void __iomem *addr = S5PV310_MIPI_DPHY_CTRL(clk->id);
+	u32 reg = __raw_readl(addr);
+
+	reg = enable ? (reg | reset) : (reg & ~reset);
+	__raw_writel(reg, addr);
+
+	if (enable)
+		reg |= 0x1;
+	else if (!(reg & 0x6 & ~reset))
+		reg &= ~0x1;
+
+	__raw_writel(reg, addr);
+	return 0;
+}
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -623,7 +642,17 @@ static struct clk init_clocks[] = {
 		.id		= 5,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 5),
-	}
+	}, {
+		.name		= "csis_dphy",
+		.id		= 0,
+		.enable		= exynos4_mipi_dphy_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "csis_dphy",
+		.id		= 1,
+		.enable		= exynos4_mipi_dphy_ctrl,
+		.ctrlbit	= (1 << 1),
+	},
 };
 
 static struct clk *clkset_group_list[] = {
diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
index 2ddd617..dd3216f 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
@@ -27,4 +27,6 @@
 
 #define S5P_INT_LOCAL_PWR_EN		0x7
 
+#define S5PV310_MIPI_DPHY_CTRL(n)	S5P_PMUREG(0x0710 + (n) * 4)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.4.1
