From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 18 Jan 2017 21:31:19 +0900
Subject: [PATCH] clk: uniphier: continue probing even if some clocks fail to
 register
Message-ID: <1484742679-8373-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not let the entire probe function fail even if some clocks fail
to register.  Let's continue with succeeded clocks.  This will give
the system more chances to boot and allow us to investigate the
cause of the failure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 0007218..2cf3863 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -90,11 +90,8 @@ static int uniphier_clk_probe(struct platform_device *pdev)
 
 		dev_dbg(dev, "register %s (index=%d)\n", p->name, p->idx);
 		hw = uniphier_clk_register(dev, regmap, p);
-		if (IS_ERR(hw)) {
-			dev_err(dev, "failed to register %s (error %ld)\n",
-				p->name, PTR_ERR(hw));
-			return PTR_ERR(hw);
-		}
+		if (WARN(IS_ERR(hw), "failed to register %s", p->name))
+			continue;
 
 		if (p->idx >= 0)
 			hw_data->hws[p->idx] = hw;
-- 
2.7.4
