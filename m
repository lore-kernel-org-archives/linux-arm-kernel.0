From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 20 May 2016 07:23:16 +0000
Subject: [PATCH 1/2] clk: bcm2835: register clocks early
In-Reply-To: <1463728997-8241-1-git-send-email-kernel@martin.sperl.org>
References: <1463728997-8241-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463728997-8241-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Register the clocks early during the boot process,
so that special/critical clocks can get enabled early on
in the boot process avoiding the risk of disabling a clock,
pll_divider or pll when a claiming driver fails to install
propperly - maybe it needs to defer.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 085e521..6aaeab4 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1825,6 +1825,7 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	const struct bcm2835_clk_desc *desc;
 	const size_t asize = ARRAY_SIZE(clk_desc_array);
 	size_t i;
+	int err;
 
 	cprman = devm_kzalloc(dev,
 			      sizeof(*cprman) + asize * sizeof(*clks),
@@ -1855,8 +1856,15 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 			clks[i] = desc->clk_register(cprman, desc->data);
 	}
 
-	return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-				   &cprman->onecell);
+	err = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
+				  &cprman->onecell);
+	if (err)
+		return err;
+
+	/* note that we have registered all the clocks */
+	dev_dbg(dev, "registered %d clocks\n", asize);
+
+	return 0;
 }
 
 static const struct of_device_id bcm2835_clk_of_match[] = {
@@ -1873,7 +1881,11 @@ static struct platform_driver bcm2835_clk_driver = {
 	.probe          = bcm2835_clk_probe,
 };
 
-builtin_platform_driver(bcm2835_clk_driver);
+static int __init __bcm2835_clk_driver_init(void)
+{
+	return platform_driver_register(&bcm2835_clk_driver);
+}
+core_initcall(__bcm2835_clk_driver_init);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("BCM2835 clock driver");
-- 
2.1.4
