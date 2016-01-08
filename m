From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 8 Jan 2016 16:16:37 +0800
Subject: [PATCH] clk: mediatek: Allow changing PLL rate when it is off
Message-ID: <1452240997-35316-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some modules may need to change its clock rate before turn on it.
So changing PLL's rate when it is off should be allowed.
This patch removes PLL enabled check before set rate, so that
PLLs can set new frequency even if they are off.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 966cab1..8e31fae 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -91,9 +91,6 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
 	u32 con1, val;
-	int pll_en;
-
-	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
 	/* set postdiv */
 	val = readl(pll->pd_addr);
@@ -114,15 +111,13 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 
 	con1 = readl(pll->base_addr + REG_CON1);
 
-	if (pll_en)
-		con1 |= CON0_PCW_CHG;
+	con1 |= CON0_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
 	if (pll->tuner_addr)
 		writel(con1 + 1, pll->tuner_addr);
 
-	if (pll_en)
-		udelay(20);
+	udelay(20);
 }
 
 /*
-- 
1.9.1
