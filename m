From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  7 Oct 2015 12:01:04 +0100
Subject: [PATCH v2 3/3] nvmem: core: add sysfs file mode flag in nvmem_config
In-Reply-To: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444215664-10921-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mode variable to nvmem_config structure which will allow
providers to specify the permissions for the sysfs binary file.
This mode is applied on top of root-only access permissions set by
the core.

Having this flag would give more flexibility to providers to decide
which permissions to set on the sysfs binary file entry.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 1 +
 include/linux/nvmem-provider.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 737fa75..4b6f219 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -315,6 +315,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem->read_only)
 		nvmem->bin.attr.mode |= S_IWUSR;
 
+	nvmem->bin.attr.mode |= config->mode;
 	nvmem->bin.size = nvmem->size;
 	device_initialize(&nvmem->dev);
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0b68caf..3f22caa 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -23,6 +23,7 @@ struct nvmem_config {
 	const struct nvmem_cell_info	*cells;
 	int			ncells;
 	bool			read_only;
+	umode_t			mode;  /* visibility in sysfs */
 };
 
 #if IS_ENABLED(CONFIG_NVMEM)
-- 
1.9.1
