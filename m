From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:06 +0800
Subject: [PATCH v3 5/8] regmap: rsb: Add support for Reduced Serial Bus (RSB)
 based regmaps
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <1439958009-14056-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/base/regmap/Kconfig      |   6 +-
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-rsb.c | 121 +++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           |  36 ++++++++++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-rsb.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index db9d00c36a3e..afb41994c51e 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -3,7 +3,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_RSB || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	select IRQ_DOMAIN if REGMAP_IRQ
@@ -24,6 +24,10 @@ config REGMAP_SPMI
 	tristate
 	depends on SPMI
 
+config REGMAP_RSB
+	tristate
+	depends on RSB
+
 config REGMAP_MMIO
 	tristate
 
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 609e4c84f485..dad32b3903d4 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_REGMAP_AC97) += regmap-ac97.o
 obj-$(CONFIG_REGMAP_I2C) += regmap-i2c.o
 obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
+obj-$(CONFIG_REGMAP_RSB) += regmap-rsb.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
diff --git a/drivers/base/regmap/regmap-rsb.c b/drivers/base/regmap/regmap-rsb.c
new file mode 100644
index 000000000000..e82aa980abe1
--- /dev/null
+++ b/drivers/base/regmap/regmap-rsb.c
@@ -0,0 +1,121 @@
+/*
+ * Register map access API - RSB support
+ *
+ * Copyright 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on regmap-i2c.c
+ *
+ * Copyright 2011 Wolfson Microelectronics plc
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/regmap.h>
+#include <linux/rsb.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+struct rsb_context {
+	struct rsb_device *rsb;
+	int size;
+};
+
+static int regmap_rsb_reg_read(void *context, unsigned int reg,
+			       unsigned int *val)
+{
+	struct rsb_context *ctx = context;
+	struct rsb_device *rsb = ctx->rsb;
+
+	if (reg > 0xff)
+		return -EINVAL;
+
+	return rsb_register_read(rsb, reg, val, ctx->size);
+}
+
+static int regmap_rsb_reg_write(void *context, unsigned int reg,
+				unsigned int val)
+{
+	struct rsb_context *ctx = context;
+	struct rsb_device *rsb = ctx->rsb;
+
+	return rsb_register_write(rsb, reg, val, ctx->size);
+}
+
+static void regmap_rsb_free_context(void *context)
+{
+	struct rsb_context *ctx = context;
+
+	kfree(ctx);
+}
+
+static struct regmap_bus regmap_rsb = {
+	.reg_write = regmap_rsb_reg_write,
+	.reg_read = regmap_rsb_reg_read,
+	.free_context = regmap_rsb_free_context,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static struct rsb_context *regmap_rsb_init_context(struct rsb_device *rsb,
+					const struct regmap_config *config)
+{
+	struct rsb_context *ctx;
+
+	switch (config->val_bits) {
+	case 8:
+	case 16:
+	case 32:
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->rsb = rsb;
+	ctx->size = config->val_bits / 8;
+
+	return ctx;
+}
+
+struct regmap *__regmap_init_rsb(struct rsb_device *rsb,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
+{
+	struct rsb_context *ctx = regmap_rsb_init_context(rsb, config);
+
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __regmap_init(&rsb->dev, &regmap_rsb, ctx, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_rsb);
+
+struct regmap *__devm_regmap_init_rsb(struct rsb_device *rsb,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
+{
+	struct rsb_context *ctx = regmap_rsb_init_context(rsb, config);
+
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __devm_regmap_init(&rsb->dev, &regmap_rsb, ctx, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_rsb);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 17178317bcec..df94574b1d37 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -25,6 +25,7 @@ struct i2c_client;
 struct irq_domain;
 struct spi_device;
 struct spmi_device;
+struct rsb_device;
 struct regmap;
 struct regmap_range_cfg;
 struct regmap_field;
@@ -377,6 +378,10 @@ struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
 				  const struct regmap_config *config,
 				  struct lock_class_key *lock_key,
 				  const char *lock_name);
+struct regmap *__regmap_init_rsb(struct rsb_device *rsb,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 
 struct regmap *__devm_regmap_init(struct device *dev,
 				  const struct regmap_bus *bus,
@@ -410,6 +415,10 @@ struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
 				       const struct regmap_config *config,
 				       struct lock_class_key *lock_key,
 				       const char *lock_name);
+struct regmap *__devm_regmap_init_rsb(struct rsb_device *rsb,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
 
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
@@ -544,6 +553,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
 /**
+ * regmap_init_rsb(): Initialise register map
+ *
+ * @rsb: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_rsb(rsb, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_rsb, #config,		\
+				rsb, config)
+
+/**
  * devm_regmap_init(): Initialise managed register map
  *
  * @dev: Device that will be interacted with
@@ -658,6 +680,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_ac97, #config,	\
 				ac97, config)
 
+/**
+ * devm_regmap_init_rsb(): Initialise managed register map
+ *
+ * @rsb: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_rsb(rsb, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_rsb, #config,	\
+				rsb, config)
+
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
2.5.0
