From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Feb 2014 16:22:33 +0100
Subject: [RFC PATCH 1/3] regmap: Separate regmap dev initialization
In-Reply-To: <cover.1392045742.git.michal.simek@xilinx.com>
References: <cover.1392045742.git.michal.simek@xilinx.com>
Message-ID: <5998a942a3dbfb2ef965d000168cbd7007315630.1392045742.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create special function regmap_attach_dev
which can be called separately out of regmap_init.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/base/regmap/regmap.c | 41 ++++++++++++++++++++++++++++-------------
 include/linux/regmap.h       |  2 ++
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b897c1a..c766f5f 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -380,6 +380,28 @@ static void regmap_range_exit(struct regmap *map)
 	kfree(map->selector_work_buf);
 }

+int regmap_attach_dev(struct device *dev, struct regmap *map,
+		      const struct regmap_config *config)
+{
+	struct regmap **m;
+
+	map->dev = dev;
+
+	regmap_debugfs_init(map, config->name);
+
+	/* Add a devres resource for dev_get_regmap() */
+	m = devres_alloc(dev_get_regmap_release, sizeof(*m), GFP_KERNEL);
+	if (!m) {
+		regmap_debugfs_exit(map);
+		return -ENOMEM;
+	}
+	*m = map;
+	devres_add(dev, m);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regmap_attach_dev);
+
 /**
  * regmap_init(): Initialise register map
  *
@@ -397,7 +419,7 @@ struct regmap *regmap_init(struct device *dev,
 			   void *bus_context,
 			   const struct regmap_config *config)
 {
-	struct regmap *map, **m;
+	struct regmap *map;
 	int ret = -EINVAL;
 	enum regmap_endian reg_endian, val_endian;
 	int i, j;
@@ -734,25 +756,18 @@ skip_format_initialization:
 		}
 	}

-	regmap_debugfs_init(map, config->name);
-
 	ret = regcache_init(map, config);
 	if (ret != 0)
 		goto err_range;

-	/* Add a devres resource for dev_get_regmap() */
-	m = devres_alloc(dev_get_regmap_release, sizeof(*m), GFP_KERNEL);
-	if (!m) {
-		ret = -ENOMEM;
-		goto err_debugfs;
-	}
-	*m = map;
-	devres_add(dev, m);
+	if (dev)
+		ret = regmap_attach_dev(dev, map, config);
+		if (ret != 0)
+			goto err_regcache;

 	return map;

-err_debugfs:
-	regmap_debugfs_exit(map);
+err_regcache:
 	regcache_exit(map);
 err_range:
 	regmap_range_exit(map);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4149f1a..fa4d079 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -317,6 +317,8 @@ struct regmap *regmap_init(struct device *dev,
 			   const struct regmap_bus *bus,
 			   void *bus_context,
 			   const struct regmap_config *config);
+int regmap_attach_dev(struct device *dev, struct regmap *map,
+				 const struct regmap_config *config);
 struct regmap *regmap_init_i2c(struct i2c_client *i2c,
 			       const struct regmap_config *config);
 struct regmap *regmap_init_spi(struct spi_device *dev,
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/2f6b4e20/attachment.sig>
