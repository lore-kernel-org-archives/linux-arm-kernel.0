From: jcliang@chromium.org (Ricky Liang)
Date: Mon, 18 May 2015 22:00:26 +0800
Subject: [PATCH v3] clk: mediatek: Initialize clk_init_data
Message-ID: <1431957632-2182-1-git-send-email-jcliang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable init (struct clk_init_data) is allocated on the stack.
We weren't initializing the .flags field, so it contains random junk,
which can cause all kinds of interesting issues when the flags are
parsed by clk_register.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
---
 drivers/clk/mediatek/clk-gate.c | 2 +-
 drivers/clk/mediatek/clk-pll.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 9d77ee3..5702036 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -109,7 +109,7 @@ struct clk *mtk_clk_register_gate(
 {
 	struct mtk_clk_gate *cg;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	cg = kzalloc(sizeof(*cg), GFP_KERNEL);
 	if (!cg)
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 66154ca..44409e9 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -268,7 +268,7 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 		void __iomem *base)
 {
 	struct mtk_clk_pll *pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	const char *parent_name = "clk26m";
 
-- 
2.1.2
