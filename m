From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 16:39:32 +0800
Subject: [PATCH v3 1/3] clk: mediatek: Fix PLL registers setting flow
In-Reply-To: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436517574-17895-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Write postdiv and pcw settings at the same time for PLLs if postdiv
and pcw settings are on the same register.

This is need by PLLs such as MT8173 MMPLL and ARM*PLL.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 44409e9..68af518 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -90,20 +90,23 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
-	u32 con1, pd, val;
+	u32 con1, val;
 	int pll_en;
 
-	/* set postdiv */
-	pd = readl(pll->pd_addr);
-	pd &= ~(POSTDIV_MASK << pll->data->pd_shift);
-	pd |= (ffs(postdiv) - 1) << pll->data->pd_shift;
-	writel(pd, pll->pd_addr);
-
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
-	/* set pcw */
-	val = readl(pll->pcw_addr);
+	/* set postdiv */
+	val = readl(pll->pd_addr);
+	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
+	val |= (ffs(postdiv) - 1) << pll->data->pd_shift;
+
+	/* postdiv and pcw need to set at the same time if on same register */
+	if (pll->pd_addr != pll->pcw_addr) {
+		writel(val, pll->pd_addr);
+		val = readl(pll->pcw_addr);
+	}
 
+	/* set pcw */
 	val &= ~GENMASK(pll->data->pcw_shift + pll->data->pcwbits - 1,
 			pll->data->pcw_shift);
 	val |= pcw << pll->data->pcw_shift;
-- 
1.8.1.1.dirty
