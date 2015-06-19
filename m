From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Fri, 19 Jun 2015 15:55:51 +0200
Subject: [PATCH] arm: crypto: picoxcell: Update to the current clk API
Message-ID: <1434722151-4309-1-git-send-email-michael@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The picoXcell hardware crypto accelerator driver was using an
older version of the clk framework, and not (un)preparing the
clock before enabling/disabling it.  This change uses the handy
clk_prepare_enable function to interact with the current clk
framework correctly.

Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
---
 drivers/crypto/picoxcell_crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 5da5b98..c5a9e5d 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1754,15 +1754,15 @@ static int spacc_probe(struct platform_device *pdev)
 		return PTR_ERR(engine->clk);
 	}
 
-	if (clk_enable(engine->clk)) {
-		dev_info(&pdev->dev, "unable to enable clk\n");
+	if (clk_prepare_enable(engine->clk)) {
+		dev_info(&pdev->dev, "unable to prepare/enable clk\n");
 		clk_put(engine->clk);
 		return -EIO;
 	}
 
 	err = device_create_file(&pdev->dev, &dev_attr_stat_irq_thresh);
 	if (err) {
-		clk_disable(engine->clk);
+		clk_disable_unprepare(engine->clk);
 		clk_put(engine->clk);
 		return err;
 	}
@@ -1830,7 +1830,7 @@ static int spacc_remove(struct platform_device *pdev)
 		crypto_unregister_alg(&alg->alg);
 	}
 
-	clk_disable(engine->clk);
+	clk_disable_unprepare(engine->clk);
 	clk_put(engine->clk);
 
 	return 0;
-- 
2.1.4
