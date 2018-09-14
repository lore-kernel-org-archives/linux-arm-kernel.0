From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 14 Sep 2018 17:34:21 +0200
Subject: [PATCH] clk: mvebu: armada-37xx-tbg: Balance devm_clk_get in probe
Message-ID: <20180914153421.7090-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent clock is get only to have its name, and then the clock is no
more used, so we can safely free it using devm_clk_put.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-tbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 71f30149e80e..caaa91a41683 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -102,6 +102,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	parent_name = __clk_get_name(parent);
+	devm_clk_put(dev, parent);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
-- 
2.18.0
