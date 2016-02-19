From: eric@anholt.net (Eric Anholt)
Date: Thu, 18 Feb 2016 17:12:55 -0800
Subject: [PATCH] i2c: bcm2835: Don't complain on -EPROBE_DEFER from getting
 our clock
Message-ID: <1455844375-15019-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes dmesg spam when we just need to wait a moment for the clock
driver to probe.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 818b051..d4f3239 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -253,7 +253,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 
 	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
-		dev_err(&pdev->dev, "Could not get clock\n");
+		if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get clock\n");
 		return PTR_ERR(i2c_dev->clk);
 	}
 
-- 
2.7.0
