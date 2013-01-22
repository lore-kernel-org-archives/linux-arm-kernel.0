From: yizhang@marvell.com (Yi Zhang)
Date: Tue, 22 Jan 2013 10:43:45 +0800
Subject: [PATCH] mfd: remove redundant devm_* for 88pm80x PMIC
Message-ID: <1358822625-5948-1-git-send-email-yizhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_* functions are device managed and make error handling
and code simpler; it also fix error exit paths

Signed-off-by: Yi Zhang <yizhang@marvell.com>
---
 drivers/mfd/88pm800.c       |   10 +++-------
 drivers/mfd/88pm805.c       |    4 ++--
 drivers/mfd/88pm80x.c       |   22 ++++------------------
 include/linux/mfd/88pm80x.h |    2 +-
 4 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 391e23e..582bda5 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -531,7 +531,7 @@ static int pm800_probe(struct i2c_client *client,
 	ret = device_800_init(chip, pdata);
 	if (ret) {
 		dev_err(chip->dev, "%s id 0x%x failed!\n", __func__, chip->id);
-		goto err_800_init;
+		goto err_subchip_alloc;
 	}
 
 	ret = pm800_pages_init(chip);
@@ -546,10 +546,8 @@ static int pm800_probe(struct i2c_client *client,
 err_page_init:
 	mfd_remove_devices(chip->dev);
 	device_irq_exit_800(chip);
-err_800_init:
-	devm_kfree(&client->dev, subchip);
 err_subchip_alloc:
-	pm80x_deinit(client);
+	pm80x_deinit();
 out_init:
 	return ret;
 }
@@ -562,9 +560,7 @@ static int pm800_remove(struct i2c_client *client)
 	device_irq_exit_800(chip);
 
 	pm800_pages_exit(chip);
-	devm_kfree(&client->dev, chip->subchip);
-
-	pm80x_deinit(client);
+	pm80x_deinit();
 
 	return 0;
 }
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index e671230..65d7ac0 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -257,7 +257,7 @@ static int pm805_probe(struct i2c_client *client,
 		pdata->plat_config(chip, pdata);
 
 err_805_init:
-	pm80x_deinit(client);
+	pm80x_deinit();
 out_init:
 	return ret;
 }
@@ -269,7 +269,7 @@ static int pm805_remove(struct i2c_client *client)
 	mfd_remove_devices(chip->dev);
 	device_irq_exit_805(chip);
 
-	pm80x_deinit(client);
+	pm80x_deinit();
 
 	return 0;
 }
diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index 1adb355..f736a46 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -48,14 +48,12 @@ int pm80x_init(struct i2c_client *client,
 		ret = PTR_ERR(map);
 		dev_err(&client->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err_regmap_init;
+		return ret;
 	}
 
 	chip->id = id->driver_data;
-	if (chip->id < CHIP_PM800 || chip->id > CHIP_PM805) {
-		ret = -EINVAL;
-		goto err_chip_id;
-	}
+	if (chip->id < CHIP_PM800 || chip->id > CHIP_PM805)
+		return -EINVAL;
 
 	chip->client = client;
 	chip->regmap = map;
@@ -82,19 +80,11 @@ int pm80x_init(struct i2c_client *client,
 	}
 
 	return 0;
-
-err_chip_id:
-	regmap_exit(map);
-err_regmap_init:
-	devm_kfree(&client->dev, chip);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(pm80x_init);
 
-int pm80x_deinit(struct i2c_client *client)
+int pm80x_deinit(void)
 {
-	struct pm80x_chip *chip = i2c_get_clientdata(client);
-
 	/*
 	 * workaround: clear the dependency between pm800 and pm805.
 	 * would remove it after HW chip fixes the issue.
@@ -103,10 +93,6 @@ int pm80x_deinit(struct i2c_client *client)
 		g_pm80x_chip->companion = NULL;
 	else
 		g_pm80x_chip = NULL;
-
-	regmap_exit(chip->regmap);
-	devm_kfree(&client->dev, chip);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pm80x_deinit);
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 478672e..e94537b 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -365,5 +365,5 @@ static inline int pm80x_dev_resume(struct device *dev)
 
 extern int pm80x_init(struct i2c_client *client,
 		      const struct i2c_device_id *id);
-extern int pm80x_deinit(struct i2c_client *client);
+extern int pm80x_deinit(void);
 #endif /* __LINUX_MFD_88PM80X_H */
-- 
1.7.0.4
