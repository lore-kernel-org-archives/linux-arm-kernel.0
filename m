From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 23 Feb 2013 18:57:46 +0100
Subject: [PATCH] i2c: s3c2410: check for NULL pinctrl handle
In-Reply-To: <201302231855.47560.heiko@sntech.de>
References: <201302231855.47560.heiko@sntech.de>
Message-ID: <201302231857.46445.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pinctrl is not built the fallback functions fail silently
and emit either 0 error codes or NULL pinctrl handles.

Therefore it's needed to also check for this NULL-handle when
falling back to parsing the i2c gpios from devicetree.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/i2c/busses/i2c-s3c2410.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index f6b880b..e58337f 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1060,7 +1060,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 
 	if (i2c->pdata->cfg_gpio) {
 		i2c->pdata->cfg_gpio(to_platform_device(i2c->dev));
-	} else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c)) {
+	} else if ((!i2c->pctrl || IS_ERR(i2c->pctrl)) &&
+		   s3c24xx_i2c_parse_dt_gpio(i2c)) {
 		return -EINVAL;
 	}
 
-- 
1.7.2.3
