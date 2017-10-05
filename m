From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 5 Oct 2017 11:50:23 +0800
Subject: [PATCH v2 2/4] clk: mediatek: add the option for determining PLL
 source clock
In-Reply-To: <cover.1507174799.git.sean.wang@mediatek.com>
References: <cover.1507174799.git.sean.wang@mediatek.com>
Message-ID: <b90d46284cb527d1412352606912f5e8d18b3e53.1507174799.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Zhong <chen.zhong@mediatek.com>

Since the previous setup always sets the PLL using crystal 26MHz, this
doesn't always happen in every MediaTek platform. So the patch added
flexibility for assigning extra member for determining the PLL source
clock.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h | 1 +
 drivers/clk/mediatek/clk-pll.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f5d6b70..210ce8e8 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -216,6 +216,7 @@ struct mtk_pll_data {
 	uint32_t pcw_reg;
 	int pcw_shift;
 	const struct mtk_pll_div_table *div_table;
+	const char *parent_name;
 };
 
 void mtk_clk_register_plls(struct device_node *node,
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index a409142..7598477 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -303,7 +303,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
 	init.ops = &mtk_pll_ops;
-	init.parent_names = &parent_name;
+	if (data->parent_name)
+		init.parent_names = &data->parent_name;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 
 	clk = clk_register(NULL, &pll->hw);
-- 
2.7.4
