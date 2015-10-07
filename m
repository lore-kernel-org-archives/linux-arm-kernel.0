From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  7 Oct 2015 12:00:47 +0100
Subject: [PATCH v2 1/3] nvmem: core: make default user binary file root-access
 only
In-Reply-To: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As required by many providers like at24/at25/mxs-ocotp/qfprom and may be
other providers would want to allow root-only to read the nvmem content.
So making the defaults to be root-only access would address the request
and also provide flexibility to providers to specify there own permissions
on top of the root-only using the perm flag in nvmem_config.
Making this dynamic did cut down lot of static binary attributes in the
code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 52 +++++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6fd4e5a..0a70e31 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -31,6 +31,7 @@ struct nvmem_device {
 	struct regmap		*regmap;
 	struct module		*owner;
 	struct device		dev;
+	struct bin_attribute	bin;
 	int			stride;
 	int			word_size;
 	int			ncells;
@@ -109,52 +110,15 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 }
 
 /* default read/write permissions */
-static struct bin_attribute bin_attr_rw_nvmem = {
+static struct bin_attribute bin_attr_template = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= S_IRUSR,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
 };
 
-static struct bin_attribute *nvmem_bin_rw_attributes[] = {
-	&bin_attr_rw_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_rw_group = {
-	.bin_attrs	= nvmem_bin_rw_attributes,
-};
-
-static const struct attribute_group *nvmem_rw_dev_groups[] = {
-	&nvmem_bin_rw_group,
-	NULL,
-};
-
-/* read only permission */
-static struct bin_attribute bin_attr_ro_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= S_IRUGO,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-static struct bin_attribute *nvmem_bin_ro_attributes[] = {
-	&bin_attr_ro_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_ro_group = {
-	.bin_attrs	= nvmem_bin_ro_attributes,
-};
-
-static const struct attribute_group *nvmem_ro_dev_groups[] = {
-	&nvmem_bin_ro_group,
-	NULL,
-};
-
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
@@ -346,9 +310,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	nvmem->read_only = of_property_read_bool(np, "read-only") |
 			   config->read_only;
+	nvmem->bin = bin_attr_template;
 
-	nvmem->dev.groups = nvmem->read_only ? nvmem_ro_dev_groups :
-					       nvmem_rw_dev_groups;
+	if (!nvmem->read_only)
+		nvmem->bin.attr.mode |= S_IWUSR;
 
 	device_initialize(&nvmem->dev);
 
@@ -361,6 +326,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
+	rval = device_create_bin_file(&nvmem->dev, &nvmem->bin);
+	if (rval)
+		dev_err(&nvmem->dev, "Failed to create nvmem binary file\n");
+
 	if (config->cells)
 		nvmem_add_cells(nvmem, config);
 
@@ -385,6 +354,7 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 	mutex_unlock(&nvmem_mutex);
 
 	nvmem_device_remove_all_cells(nvmem);
+	device_remove_bin_file(&nvmem->dev, &nvmem->bin);
 	device_del(&nvmem->dev);
 
 	return 0;
-- 
1.9.1
