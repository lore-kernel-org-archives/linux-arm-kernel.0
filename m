From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 16:00:09 +0300
Subject: [PATCH 08/10] drm: tilcdc: use of_get_i2c_adapter_by_node interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360409-9508-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

Prior to this change i2c_put_adapter() is misused, which may lead
to an overflow over zero of I2C bus driver user counter.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 354c47c..4dc78c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -348,15 +348,13 @@ static int tfp410_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	tfp410_mod->i2c = of_find_i2c_adapter_by_node(i2c_node);
+	tfp410_mod->i2c = of_get_i2c_adapter_by_node(i2c_node);
+	of_node_put(i2c_node);
 	if (!tfp410_mod->i2c) {
 		dev_err(&pdev->dev, "could not get i2c\n");
-		of_node_put(i2c_node);
 		goto fail;
 	}
 
-	of_node_put(i2c_node);
-
 	tfp410_mod->gpio = of_get_named_gpio_flags(node, "powerdn-gpio",
 			0, NULL);
 	if (IS_ERR_VALUE(tfp410_mod->gpio)) {
-- 
2.1.4
