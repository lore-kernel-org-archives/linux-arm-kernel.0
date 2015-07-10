From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 16:39:33 +0800
Subject: [PATCH v3 2/3] clk: mediatek: Fix calculation of PLL rate settings
In-Reply-To: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436517574-17895-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid u32 overflow when calculate post divider setting, and
increase the max post divider setting from 3 (/8) to 4 (/16).

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 68af518..0e3f4ef 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -144,9 +144,9 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 	if (freq > pll->data->fmax)
 		freq = pll->data->fmax;
 
-	for (val = 0; val < 4; val++) {
+	for (val = 0; val < 5; val++) {
 		*postdiv = 1 << val;
-		if (freq * *postdiv >= fmin)
+		if ((u64)freq * *postdiv >= fmin)
 			break;
 	}
 
-- 
1.8.1.1.dirty
