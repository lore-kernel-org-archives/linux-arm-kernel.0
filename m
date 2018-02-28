From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 15:27:22 +0100
Subject: [PATCH 1/2] hwrng: omap - Remove useless test before
 clk_disable_unprepare
In-Reply-To: <20180228142723.11562-1-gregory.clement@bootlin.com>
References: <20180228142723.11562-1-gregory.clement@bootlin.com>
Message-ID: <20180228142723.11562-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/char/hw_random/omap-rng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 74d11ae6abe9..159d4a1347b8 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -499,8 +499,7 @@ static int omap_rng_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 err_ioremap:
 	dev_err(dev, "initialization failed.\n");
 	return ret;
@@ -517,8 +516,7 @@ static int omap_rng_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
-- 
2.16.1
