From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 15:01:09 +0100
Subject: [PATCH v2 01/25] nvmem: add new config option
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181113140133.17385-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add nvmem support for MTD. TI DaVinci is the first platform
that will be using it, but only in non-DT mode. In order not to
introduce any new interface to supporting of which we would have to
commit - add a new config option that tells nvmem not to use the DT
node of the parent device.

This way we won't be creating nvmem devices corresponding with MTD
partitions defined in device tree. By default MTD will set this new
field to true.

Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
able to remove this option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 3 ++-
 include/linux/nvmem-provider.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..ac7971e8154e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -604,7 +604,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->priv = config->priv;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->dev.of_node = config->dev->of_node;
+	if (!config->no_of_node)
+		nvmem->dev.of_node = config->dev->of_node;
 
 	if (config->id == -1 && config->name) {
 		dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1e3283c2af77..e53545e9852b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -30,6 +30,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * @ncells:	Number of elements in cells.
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
+ * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -53,6 +54,7 @@ struct nvmem_config {
 	int			ncells;
 	bool			read_only;
 	bool			root_only;
+	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.19.1
