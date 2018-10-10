From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 10 Oct 2018 20:18:38 +0200
Subject: [PATCH v2] clk: mvebu: armada-37xx-tbg: Switch to clk_get and balance
 it in probe
Message-ID: <20181010181838.26923-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent clock is get only to have its name, and then the clock is no
more used, so we can safely free it using clk_put. Furthermore as between
the successful devm_clk_get() and the devm_clk_put() call we don't exit
the probe function in error so I can use non managed version of clk_get()
and clk_put().

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Changelog:
v1 -> v2

 - Use the non managed version of clk_get() and clk_put() (suggested
   by Stephen Boyd)
 - Modify the title and the commit log to reflect this change

drivers/clk/mvebu/armada-37xx-tbg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 71f30149e80e..ee272d4d8c24 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -96,12 +96,13 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	hw_tbg_data->num = NUM_TBG;
 	platform_set_drvdata(pdev, hw_tbg_data);
 
-	parent = devm_clk_get(dev, NULL);
+	parent = clk_get(dev, NULL);
 	if (IS_ERR(parent)) {
 		dev_err(dev, "Could get the clock parent\n");
 		return -EINVAL;
 	}
 	parent_name = __clk_get_name(parent);
+	clk_put(parent);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
-- 
2.19.1
