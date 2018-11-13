From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Tue, 13 Nov 2018 14:01:36 +0200
Subject: [PATCH v4 6/8] clk: clk-twl6040: Free of_provider at remove
In-Reply-To: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <c7d4076e0786e233d0aec41e8d14702267688d1b.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 25dfe050ae9f..e9da09453eb2 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+			of_clk_hw_simple_get, &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
