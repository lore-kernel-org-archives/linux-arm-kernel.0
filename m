From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 21 May 2014 07:47:50 -0700
Subject: [PATCH 1/2] ARM: imx: unset pllv3 BYPASS and POWER sequentially
In-Reply-To: <1400683671-19132-1-git-send-email-jiada_wang@mentor.com>
References: <1400683671-19132-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1400683671-19132-2-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Currently, POWER and BYPASS bits are set up in a single write to pllv3
register. With commit 43c9b9e8a4c6 ("ARM: imx: set up pllv3 POWER and
BYPASS sequentially") this has been changed in the prepare() function.
Do the same for the unprepare().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/mach-imx/clk-pllv3.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 6136405..36f2396 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -98,6 +98,8 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
 
 	val = readl_relaxed(pll->base);
 	val |= BM_PLL_BYPASS;
+	writel_relaxed(val, pll->base);
+
 	if (pll->powerup_set)
 		val &= ~BM_PLL_POWER;
 	else
-- 
1.7.9.5
