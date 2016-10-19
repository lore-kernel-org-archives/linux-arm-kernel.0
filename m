From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Oct 2016 20:49:39 +0900
Subject: [PATCH] clk: uniphier: fix memory overrun bug
Message-ID: <1476877779-27854-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first loop of this "for" statement writes memory beyond the
allocated clk_hw_onecell_data.

It should be:
    for (clk_num--; clk_num >= 0; clk_num--)
            ...

Or more simply:
    while (--clk_num >= 0)
            ...

Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index f4e0f6b..84bc465 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -79,7 +79,7 @@ static int uniphier_clk_probe(struct platform_device *pdev)
 	hw_data->num = clk_num;
 
 	/* avoid returning NULL for unused idx */
-	for (; clk_num >= 0; clk_num--)
+	while (--clk_num >= 0)
 		hw_data->hws[clk_num] = ERR_PTR(-EINVAL);
 
 	for (p = data; p->name; p++) {
-- 
1.9.1
