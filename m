From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Mar 2018 17:48:40 +0100
Subject: [PATCH 1/3] crypto: inside-secure - fix clock management
In-Reply-To: <20180313164842.20042-1-gregory.clement@bootlin.com>
References: <20180313164842.20042-1-gregory.clement@bootlin.com>
Message-ID: <20180313164842.20042-2-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this driver the clock is got but never put when the driver is removed
or if there is an error in the probe.

Using the managed version of clk_get() allows to let the kernel take care
of it.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto
engine driver")
cc: stable at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 384b4ceb37f0..09adeaa0da6b 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -881,7 +881,7 @@ static int safexcel_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
-	priv->clk = of_clk_get(dev->of_node, 0);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(priv->clk)) {
 		ret = clk_prepare_enable(priv->clk);
 		if (ret) {
-- 
2.16.1
