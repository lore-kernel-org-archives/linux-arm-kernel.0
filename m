From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Nov 2015 18:53:33 +0900
Subject: [PATCH 1/4] i2c: uniphier: error out if clock rate is zero
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448877216-32286-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This input clock is used to generate the sampling clock for I2C bus.
If the clock rate is zero, there is something wrong with the clock
driver.  Bail out with the appropriate error message in such a case.
It would make it easier to find the root cause of failure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index e3c3861..2b2c20b 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -342,6 +342,10 @@ static int uniphier_i2c_clk_init(struct device *dev,
 		return ret;
 
 	clk_rate = clk_get_rate(priv->clk);
+	if (!clk_rate) {
+		dev_err(dev, "input clock rate should not be zero\n");
+		return -EINVAL;
+	}
 
 	uniphier_i2c_reset(priv, true);
 
@@ -388,7 +392,7 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 
 	ret = uniphier_i2c_clk_init(dev, priv);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = devm_request_irq(dev, irq, uniphier_i2c_interrupt, 0, pdev->name,
 			       priv);
-- 
1.9.1
