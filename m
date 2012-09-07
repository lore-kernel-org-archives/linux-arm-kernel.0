From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  7 Sep 2012 14:43:47 +0200
Subject: [PATCH v4 5/6] misc: sram: Add optional clock
In-Reply-To: <1347021828-23034-1-git-send-email-p.zabel@pengutronix.de>
References: <1347021828-23034-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1347021828-23034-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms the SRAM needs a clock to be enabled explicitly.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/misc/sram.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 7a363f2..0cc2e75 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -21,6 +21,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -29,6 +31,7 @@
 
 struct sram_dev {
 	struct gen_pool *pool;
+	struct clk *clk;
 };
 
 static int __devinit sram_probe(struct platform_device *pdev)
@@ -53,6 +56,10 @@ static int __devinit sram_probe(struct platform_device *pdev)
 	if (!sram)
 		return -ENOMEM;
 
+	sram->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(sram->clk))
+		clk_prepare_enable(sram->clk);
+
 	sram->pool = gen_pool_create(PAGE_SHIFT, -1);
 	if (!sram->pool)
 		return -ENOMEM;
@@ -80,6 +87,9 @@ static int __devexit sram_remove(struct platform_device *pdev)
 
 	gen_pool_destroy(sram->pool);
 
+	if (!IS_ERR(sram->clk))
+		clk_disable_unprepare(sram->clk);
+
 	return 0;
 }
 
-- 
1.7.10.4
