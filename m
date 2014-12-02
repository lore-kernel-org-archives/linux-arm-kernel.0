From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 02 Dec 2014 18:03:40 +0530
Subject: [PATCH] mfd: max77686: Fix parent of rtc device
Message-ID: <1417523620-4311-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc have different i2c client than power(pmic) block. So rtc device should
sit under its own i2c client in device hierarchy, which reflects in sysfs also.
This patch modifies code to register rtc cell with rtc->dev as parent.

Without this patch :
driver         max77686-pmic  modalias       power          uevent
max77686-clk   max77686-rtc   name           subsystem

After applying patch :
driver/        modalias       power/         uevent
max77686-rtc/  name           subsystem/

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---

Or Can we follow another (exhaustive but more cleaner) approach, which will
be more like code refactoring and cleanup rather than only fix:
Since rtc uses i2c client, which gets created using i2c_new_dummy() and is not
shared by any other cell of max77686. So we can covert rtc platform driver
itself to i2c client driver. It will also allow to expilicitly describe
max77686-rtc in DT which we can't do now.
It can be applicable to some other existing and new mfd pmic drivers.
Any suggestion/comments ?

---
 drivers/mfd/max77686.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 929795e..22c0948 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -39,10 +39,13 @@
 
 static const struct mfd_cell max77686_devs[] = {
 	{ .name = "max77686-pmic", },
-	{ .name = "max77686-rtc", },
 	{ .name = "max77686-clk", },
 };
 
+static const struct mfd_cell max77686_rtc_dev[] = {
+	{ .name = "max77686-rtc", },
+};
+
 static const struct mfd_cell max77802_devs[] = {
 	{ .name = "max77802-pmic", },
 	{ .name = "max77802-clk", },
@@ -332,14 +335,27 @@ static int max77686_i2c_probe(struct i2c_client *i2c,
 		goto err_del_irqc;
 	}
 
+	if (max77686->type == TYPE_MAX77686) {
+		ret = mfd_add_devices(&max77686->rtc->dev, -1, max77686_rtc_dev,
+			1, NULL, 0, NULL);
+		if (ret < 0) {
+			dev_err(&max77686->rtc->dev,
+				"failed to add RTC device %d\n", ret);
+			goto err_del_rtc_irqc;
+		}
+	}
+
 	ret = mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
-		goto err_del_rtc_irqc;
+		goto err_del_rtc_dev;
 	}
 
 	return 0;
 
+err_del_rtc_dev:
+	if (max77686->type == TYPE_MAX77686)
+		mfd_remove_devices(&max77686->rtc->dev);
 err_del_rtc_irqc:
 	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
 err_del_irqc:
@@ -356,6 +372,8 @@ static int max77686_i2c_remove(struct i2c_client *i2c)
 	struct max77686_dev *max77686 = i2c_get_clientdata(i2c);
 
 	mfd_remove_devices(max77686->dev);
+	if (max77686->type == TYPE_MAX77686)
+		mfd_remove_devices(&max77686->rtc->dev);
 
 	regmap_del_irq_chip(max77686->irq, max77686->rtc_irq_data);
 	regmap_del_irq_chip(max77686->irq, max77686->irq_data);
-- 
1.7.0.4
