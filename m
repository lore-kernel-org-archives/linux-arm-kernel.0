From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Mar 2012 16:22:59 +0800
Subject: [PATCH 2/2] ARM: imx6q: change pll1 rate when change arm_clk rate
In-Reply-To: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
References: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1331713379-8437-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arm_clk's own get_rate/set_rate/round_rate functions.

set_rate steps:
 - reparent pll1_sw_clk to pll2_pfd_400m or osc_clk
 - disable pll1_sys
 - set pll1_sys rate
 - enable pll1_sys
 - reparent pll1_sw_clk back to pll1_sys

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |   76 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 3d5dc56..e601f52 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1782,7 +1782,6 @@ DEF_NG_CLK(periph2_pre_clk,	&pll2_bus);
 DEF_NG_CLK(periph2_clk,		&periph2_pre_clk);
 DEF_NG_CLK(axi_clk,		&periph_clk);
 DEF_NG_CLK(emi_clk,		&axi_clk);
-DEF_NG_CLK(arm_clk,		&pll1_sw_clk);
 DEF_NG_CLK(ahb_clk,		&periph_clk);
 DEF_NG_CLK(ipg_clk,		&ahb_clk);
 DEF_NG_CLK(ipg_perclk,		&ipg_clk);
@@ -1873,6 +1872,81 @@ DEF_CLK(emi_slow_clk,	  CCGR6, CG5,  &axi_clk,	  NULL);
 DEF_CLK(vdo_axi_clk,	  CCGR6, CG6,  &axi_clk,	  NULL);
 DEF_CLK(vpu_clk,	  CCGR6, CG7,  &axi_clk,	  NULL);
 
+static unsigned long arm_clk_get_rate(struct clk *clk)
+{
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+	u32 reg, div;
+
+	reg = readl_relaxed(CACRR);
+	div = (reg & BM_CACRR_ARM_PODF) >> BP_CACRR_ARM_PODF;
+
+	return parent_rate / (div + 1);
+}
+static int arm_clk_bestdiv(unsigned long rate, unsigned long *prate)
+{
+	u32 i, maxdiv, bestdiv = 0;
+	unsigned long parent_rate, best = 0, now;
+
+	*prate = 0;
+	maxdiv = (BM_CACRR_ARM_PODF >> BP_CACRR_ARM_PODF) + 1;
+	for (i = 1; i <= maxdiv; i++) {
+		int div;
+		parent_rate = clk_round_rate(&pll1_sys, rate * i);
+		div = parent_rate / rate;
+		div = div > maxdiv ? maxdiv : div;
+		div = div < 1 ? 1 : div;
+		now = parent_rate / div;
+
+		if (now <= rate && now >= best) {
+			bestdiv = div;
+			best = now;
+			*prate = parent_rate;
+			if (now == rate)
+				break;
+		}
+	}
+	return bestdiv;
+}
+
+static int arm_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div;
+	unsigned long parent_rate;
+	div = arm_clk_bestdiv(rate, &parent_rate);
+
+	if (pll2_pfd_400m.usecount > 0)
+		pll1_sw_clk.set_parent(&pll1_sw_clk, &pll2_pfd_400m);
+	else
+		pll1_sw_clk.set_parent(&pll1_sw_clk, &osc_clk);
+	pll1_sys.disable(&pll1_sys);
+	pll1_sys.set_rate(&pll1_sys, parent_rate);
+	pll1_sys.enable(&pll1_sys);
+	pll1_sw_clk.set_parent(&pll1_sw_clk, &pll1_sys);
+
+	reg = readl_relaxed(CACRR);
+	reg &= ~BM_CACRR_ARM_PODF;
+	reg |= (div - 1) << BP_CACRR_ARM_PODF;
+	writel_relaxed(reg, CACRR);
+
+	return 0;
+}
+
+static unsigned long arm_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long div, parent_rate;
+
+	div = arm_clk_bestdiv(rate, &parent_rate);
+	return parent_rate / div;
+}
+
+static struct clk arm_clk = {
+	.get_rate	= arm_clk_get_rate,
+	.set_rate	= arm_clk_set_rate,
+	.round_rate	= arm_clk_round_rate,
+	.set_parent	= _clk_set_parent,
+	.parent		= &pll1_sw_clk,
+};
+
 static int pcie_clk_enable(struct clk *clk)
 {
 	u32 val;
-- 
1.7.5.4
