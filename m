From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:38 +0100
Subject: [PATCH 06/12] mfd: tps65910: Rid data size incompatibility warn when
 building for 64bit
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extinguishes:

../drivers/mfd/tps65910.c: In function ?tps65910_parse_dt?:
../drivers/mfd/tps65910.c:404:14:
	warning: cast from pointer to integer of different size

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps65910.c       | 10 +++++-----
 include/linux/mfd/tps65910.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index f9e42ea..f243e75 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -387,7 +387,7 @@ static const struct of_device_id tps65910_of_match[] = {
 MODULE_DEVICE_TABLE(of, tps65910_of_match);
 
 static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
-						int *chip_id)
+						unsigned long *chip_id)
 {
 	struct device_node *np = client->dev.of_node;
 	struct tps65910_board *board_info;
@@ -401,7 +401,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 		return NULL;
 	}
 
-	*chip_id  = (int)match->data;
+	*chip_id  = (unsigned long)match->data;
 
 	board_info = devm_kzalloc(&client->dev, sizeof(*board_info),
 			GFP_KERNEL);
@@ -431,7 +431,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 #else
 static inline
 struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
-					 int *chip_id)
+					 unsigned long *chip_id)
 {
 	return NULL;
 }
@@ -453,14 +453,14 @@ static void tps65910_power_off(void)
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c,
-					const struct i2c_device_id *id)
+			      const struct i2c_device_id *id)
 {
 	struct tps65910 *tps65910;
 	struct tps65910_board *pmic_plat_data;
 	struct tps65910_board *of_pmic_plat_data = NULL;
 	struct tps65910_platform_data *init_data;
+	unsigned long chip_id = id->driver_data;
 	int ret = 0;
-	int chip_id = id->driver_data;
 
 	pmic_plat_data = dev_get_platdata(&i2c->dev);
 
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 16c2335..6483a6f 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -892,7 +892,7 @@ struct tps65910 {
 	struct device *dev;
 	struct i2c_client *i2c_client;
 	struct regmap *regmap;
-	unsigned int id;
+	unsigned long id;
 
 	/* Client devices */
 	struct tps65910_pmic *pmic;
-- 
1.8.3.2
