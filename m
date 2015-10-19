From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 19 Oct 2015 13:22:55 -0700
Subject: [PATCH] fpga: zynq-fpga: Fix unbalanced clock handling
Message-ID: <1445286175-1640-1-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the unbalanced clock handling, where
a failed probe would leave the clock with a prepare count of -1.

Reported-by: Josh Cartwright <joshc@ni.com>
Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/fpga/zynq-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 103303c..617d382 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -487,7 +487,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 				&zynq_fpga_ops, priv);
 	if (err) {
 		dev_err(dev, "unable to register FPGA manager");
-		clk_disable_unprepare(priv->clk);
+		clk_unprepare(priv->clk);
 		return err;
 	}
 
@@ -502,7 +502,7 @@ static int zynq_fpga_remove(struct platform_device *pdev)
 
 	priv = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(priv->clk);
+	clk_unprepare(priv->clk);
 
 	return 0;
 }
-- 
2.6.1
