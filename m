From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:37 +0100
Subject: [PATCH 05/12] mfd: arizona: Rid data size incompatibility warn when
 building for 64bit
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extinguishes:

../drivers/mfd/arizona-core.c: In function ?arizona_of_get_type?:
../drivers/mfd/arizona-core.c:505:10:
	warning: cast from pointer to integer of different size

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/arizona-core.c | 4 ++--
 drivers/mfd/arizona-i2c.c  | 5 +++--
 drivers/mfd/arizona-spi.c  | 3 ++-
 drivers/mfd/arizona.h      | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index b4f22e7..e9c3563 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -497,12 +497,12 @@ const struct dev_pm_ops arizona_pm_ops = {
 EXPORT_SYMBOL_GPL(arizona_pm_ops);
 
 #ifdef CONFIG_OF
-int arizona_of_get_type(struct device *dev)
+unsigned long arizona_of_get_type(struct device *dev)
 {
 	const struct of_device_id *id = of_match_device(arizona_of_match, dev);
 
 	if (id)
-		return (int)id->data;
+		return (unsigned long)id->data;
 	else
 		return 0;
 }
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index beccb79..9d4156f 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -24,11 +24,12 @@
 #include "arizona.h"
 
 static int arizona_i2c_probe(struct i2c_client *i2c,
-					  const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config;
-	int ret, type;
+	unsigned long type;
+	int ret;
 
 	if (i2c->dev.of_node)
 		type = arizona_of_get_type(&i2c->dev);
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 1ca554b..5145d78 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -28,7 +28,8 @@ static int arizona_spi_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config;
-	int ret, type;
+	unsigned long type;
+	int ret;
 
 	if (spi->dev.of_node)
 		type = arizona_of_get_type(&spi->dev);
diff --git a/drivers/mfd/arizona.h b/drivers/mfd/arizona.h
index b4cef77..2951498 100644
--- a/drivers/mfd/arizona.h
+++ b/drivers/mfd/arizona.h
@@ -46,9 +46,9 @@ int arizona_irq_init(struct arizona *arizona);
 int arizona_irq_exit(struct arizona *arizona);
 
 #ifdef CONFIG_OF
-int arizona_of_get_type(struct device *dev);
+unsigned long arizona_of_get_type(struct device *dev);
 #else
-static inline int arizona_of_get_type(struct device *dev)
+static inline unsigned long arizona_of_get_type(struct device *dev)
 {
 	return 0;
 }
-- 
1.8.3.2
