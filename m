From: jason.hui@linaro.org (Jason Liu)
Date: Fri,  5 Aug 2011 23:34:32 +0800
Subject: [PATCH] ARM: iMX5: Don't enable DPLL if it already enabled
Message-ID: <1312558472-30590-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the DPLL is already enabled, don't try to enable it again.
Since write to the DPLL control register will make the DPLL
reset and which will cause some issues when some child module
are sourced from this DPLL.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 7f20308..f7bf996 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -271,7 +271,11 @@ static int _clk_pll_enable(struct clk *clk)
 	int i = 0;
 
 	pllbase = _get_pll_base(clk);
-	reg = __raw_readl(pllbase + MXC_PLL_DP_CTL) | MXC_PLL_DP_CTL_UPEN;
+	reg = __raw_readl(pllbase + MXC_PLL_DP_CTL);
+	if (reg & MXC_PLL_DP_CTL_UPEN)
+		return 0;
+
+	reg |= MXC_PLL_DP_CTL_UPEN;
 	__raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
 
 	/* Wait for lock */
-- 
1.7.0.4
