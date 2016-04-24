From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sun, 24 Apr 2016 20:28:05 +0100
Subject: [PATCH 01/12] nvmem: core: remove regmap dependency
In-Reply-To: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1461526096-29584-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nvmem uses regmap_raw_read/write apis to read/write data from providers,
regmap raw apis stopped working with recent kernels which removed raw
accessors on mmio bus. This resulted in broken nvmem for providers
which are based on regmap mmio bus. This issue can be fixed temporarly
by moving to other regmap apis, but we might hit same issue in future.
Moving to interfaces based on read/write callbacks from providers would
be more robust.

This patch removes regmap dependency from nvmem and introduces
read/write callbacks from the providers.

Without this patch nvmem providers like qfprom based on regmap mmio
bus would not work.

Reported-by: Rajendra Nayak <rjendra@qti.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig          |  1 -
 drivers/nvmem/core.c           | 67 +++++++++++++++++++++++++-----------------
 include/linux/nvmem-provider.h | 10 +++++++
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ca52952..36f4f4b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -1,6 +1,5 @@
 menuconfig NVMEM
 	tristate "NVMEM Support"
-	select REGMAP
 	help
 	  Support for NVMEM(Non Volatile Memory) devices like EEPROM, EFUSES...
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0de3d87..bb4ea12 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -23,12 +23,10 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
-#include <linux/regmap.h>
 #include <linux/slab.h>
 
 struct nvmem_device {
 	const char		*name;
-	struct regmap		*regmap;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -41,6 +39,9 @@ struct nvmem_device {
 	int			flags;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	void *priv;
 };
 
 #define FLAG_COMPAT		BIT(0)
@@ -66,6 +67,23 @@ static struct lock_class_key eeprom_lock_key;
 #endif
 
 #define to_nvmem_device(d) container_of(d, struct nvmem_device, dev)
+static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			  void *val, size_t bytes)
+{
+	if (nvmem->reg_read)
+		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
+
+	return -EINVAL;
+}
+
+static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	if (nvmem->reg_write)
+		return nvmem->reg_write(nvmem->priv, offset, val, bytes);
+
+	return -EINVAL;
+}
 
 static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 				    struct bin_attribute *attr,
@@ -93,7 +111,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
-	rc = regmap_raw_read(nvmem->regmap, pos, buf, count);
+	rc = nvmem_reg_read(nvmem, pos, buf, count);
 
 	if (IS_ERR_VALUE(rc))
 		return rc;
@@ -127,7 +145,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 
 	count = round_down(count, nvmem->word_size);
 
-	rc = regmap_raw_write(nvmem->regmap, pos, buf, count);
+	rc = nvmem_reg_write(nvmem, pos, buf, count);
 
 	if (IS_ERR_VALUE(rc))
 		return rc;
@@ -421,18 +439,11 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 {
 	struct nvmem_device *nvmem;
 	struct device_node *np;
-	struct regmap *rm;
 	int rval;
 
 	if (!config->dev)
 		return ERR_PTR(-EINVAL);
 
-	rm = dev_get_regmap(config->dev, NULL);
-	if (!rm) {
-		dev_err(config->dev, "Regmap not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	nvmem = kzalloc(sizeof(*nvmem), GFP_KERNEL);
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
@@ -444,14 +455,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	nvmem->id = rval;
-	nvmem->regmap = rm;
 	nvmem->owner = config->owner;
-	nvmem->stride = regmap_get_reg_stride(rm);
-	nvmem->word_size = regmap_get_val_bytes(rm);
-	nvmem->size = regmap_get_max_register(rm) + nvmem->stride;
+	nvmem->stride = config->stride;
+	nvmem->word_size = config->word_size;
+	nvmem->size = config->size;
 	nvmem->dev.type = &nvmem_provider_type;
 	nvmem->dev.bus = &nvmem_bus_type;
 	nvmem->dev.parent = config->dev;
+	nvmem->priv = config->priv;
+	nvmem->reg_read = config->reg_read;
+	nvmem->reg_write = config->reg_write;
 	np = config->dev->of_node;
 	nvmem->dev.of_node = np;
 	dev_set_name(&nvmem->dev, "%s%d",
@@ -948,7 +961,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 {
 	int rc;
 
-	rc = regmap_raw_read(nvmem->regmap, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_read(nvmem, cell->offset, buf, cell->bytes);
 
 	if (IS_ERR_VALUE(rc))
 		return rc;
@@ -977,7 +990,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 	u8 *buf;
 	int rc;
 
-	if (!nvmem || !nvmem->regmap)
+	if (!nvmem)
 		return ERR_PTR(-EINVAL);
 
 	buf = kzalloc(cell->bytes, GFP_KERNEL);
@@ -1014,7 +1027,7 @@ static inline void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 		*b <<= bit_offset;
 
 		/* setup the first byte with lsb bits from nvmem */
-		rc = regmap_raw_read(nvmem->regmap, cell->offset, &v, 1);
+		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
 		*b++ |= GENMASK(bit_offset - 1, 0) & v;
 
 		/* setup rest of the byte if any */
@@ -1031,7 +1044,7 @@ static inline void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 	/* if it's not end on byte boundary */
 	if ((nbits + bit_offset) % BITS_PER_BYTE) {
 		/* setup the last byte with msb bits from nvmem */
-		rc = regmap_raw_read(nvmem->regmap,
+		rc = nvmem_reg_read(nvmem,
 				    cell->offset + cell->bytes - 1, &v, 1);
 		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
 
@@ -1054,7 +1067,7 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 	struct nvmem_device *nvmem = cell->nvmem;
 	int rc;
 
-	if (!nvmem || !nvmem->regmap || nvmem->read_only ||
+	if (!nvmem || nvmem->read_only ||
 	    (cell->bit_offset == 0 && len != cell->bytes))
 		return -EINVAL;
 
@@ -1064,7 +1077,7 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 			return PTR_ERR(buf);
 	}
 
-	rc = regmap_raw_write(nvmem->regmap, cell->offset, buf, cell->bytes);
+	rc = nvmem_reg_write(nvmem, cell->offset, buf, cell->bytes);
 
 	/* free the tmp buffer */
 	if (cell->bit_offset || cell->nbits)
@@ -1094,7 +1107,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	int rc;
 	ssize_t len;
 
-	if (!nvmem || !nvmem->regmap)
+	if (!nvmem)
 		return -EINVAL;
 
 	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
@@ -1124,7 +1137,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 	struct nvmem_cell cell;
 	int rc;
 
-	if (!nvmem || !nvmem->regmap)
+	if (!nvmem)
 		return -EINVAL;
 
 	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
@@ -1152,10 +1165,10 @@ int nvmem_device_read(struct nvmem_device *nvmem,
 {
 	int rc;
 
-	if (!nvmem || !nvmem->regmap)
+	if (!nvmem)
 		return -EINVAL;
 
-	rc = regmap_raw_read(nvmem->regmap, offset, buf, bytes);
+	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
 
 	if (IS_ERR_VALUE(rc))
 		return rc;
@@ -1180,10 +1193,10 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	int rc;
 
-	if (!nvmem || !nvmem->regmap)
+	if (!nvmem)
 		return -EINVAL;
 
-	rc = regmap_raw_write(nvmem->regmap, offset, buf, bytes);
+	rc = nvmem_reg_write(nvmem, offset, buf, bytes);
 
 	if (IS_ERR_VALUE(rc))
 		return rc;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index a4fcc90..cd93416 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,6 +14,10 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
+				void *val, size_t bytes);
+typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
+				 void *val, size_t bytes);
 
 struct nvmem_config {
 	struct device		*dev;
@@ -24,6 +28,12 @@ struct nvmem_config {
 	int			ncells;
 	bool			read_only;
 	bool			root_only;
+	nvmem_reg_read_t	reg_read;
+	nvmem_reg_write_t	reg_write;
+	int	size;
+	int	word_size;
+	int	stride;
+	void	*priv;
 	/* To be only used by old driver/misc/eeprom drivers */
 	bool			compat;
 	struct device		*base_dev;
-- 
2.5.0
