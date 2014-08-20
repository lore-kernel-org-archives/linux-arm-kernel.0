From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 20 Aug 2014 08:26:49 +0200
Subject: [PATCH] mfd: max77686: make interrupts support optional
Message-ID: <1408516009-22106-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6f1c1e71d93 ("mfd: max77686: Convert to use regmap_irq") broke
support for boards, which provide no irq for MAX 77686 PMIC. In such
case, not all functions of PMIC are available, but the driver still
should at least handle voltage regulators instead of failing to init.
This patch restores previous behavior.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Hello,

This patch fixes booting issues with recently merged support for
Exynos4412 based Odroid X2/U3 boards. See
http://www.spinics.net/lists/linux-samsung-soc/msg35773.html
thread for more details.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/mfd/max77686.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 86e552348db4..525718c448c8 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -314,22 +314,26 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
-	ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
-				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				  IRQF_SHARED, 0, irq_chip,
-				  &max77686->irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
-		goto err_unregister_i2c;
-	}
+	if (max77686->irq) {
+		ret = regmap_add_irq_chip(max77686->regmap, max77686->irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+					  IRQF_SHARED, 0, irq_chip,
+					  &max77686->irq_data);
+		if (ret) {
+			dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n",
+				 ret);
+			goto err_unregister_i2c;
+		}
 
-	ret = regmap_add_irq_chip(*rtc_regmap, max77686->irq,
-				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				  IRQF_SHARED, 0, rtc_irq_chip,
-				  &max77686->rtc_irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n", ret);
-		goto err_del_irqc;
+		ret = regmap_add_irq_chip(*rtc_regmap, max77686->irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
+					  IRQF_SHARED, 0, rtc_irq_chip,
+					  &max77686->rtc_irq_data);
+		if (ret) {
+			dev_err(&i2c->dev, "failed to add RTC irq chip: %d\n",
+				ret);
+			goto err_del_irqc;
+		}
 	}
 
 	ret = mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, NULL);
@@ -341,9 +345,11 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 	return 0;
 
 err_del_rtc_irqc:
-	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
+	if (max77686->irq)
+		regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
 err_del_irqc:
-	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
+	if (max77686->irq)
+		regmap_del_irq_chip(max77686->irq, max77686->irq_data);
 err_unregister_i2c:
 	if (max77686->type == TYPE_MAX77686)
 		i2c_unregister_device(max77686->rtc);
@@ -357,8 +363,10 @@ static int max77686_i2c_remove(struct i2c_client *i2c)
 
 	mfd_remove_devices(max77686->dev);
 
-	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
-	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
+	if (max77686->irq)
+		regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
+	if (max77686->irq)
+		regmap_del_irq_chip(max77686->irq, max77686->irq_data);
 
 	if (max77686->type == TYPE_MAX77686)
 		i2c_unregister_device(max77686->rtc);
-- 
1.9.2
