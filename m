From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:00:55 -0800
Subject: [PATCH v3 03/22] nvmem: Introduce devm_nvmem_(un)register()
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-4-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce devm_nvmem_register()/devm_nvmem_unregister() to make
.remove() unnecessary in trivial drivers.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/core.c           | 57 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 17 +++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 57cbeacfbeb2..1f387a2d915f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -551,6 +551,63 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
+static void devm_nvmem_release(struct device *dev, void *res)
+{
+	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+}
+
+/**
+ * devm_nvmem_register() - Register a managed nvmem device for given nvmem_config.
+ * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
+ *
+ * @config: nvmem device configuration with which nvmem device is created.
+ *
+ * Return: Will be an ERR_PTR() on error or a valid pointer to nvmem_device
+ * on success.
+ */
+struct nvmem_device *devm_nvmem_register(struct device *dev,
+					 const struct nvmem_config *config)
+{
+	struct nvmem_device **ptr, *nvmem;
+
+	ptr = devres_alloc(devm_nvmem_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	nvmem = nvmem_register(config);
+
+	if (!IS_ERR(nvmem)) {
+		*ptr = nvmem;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return nvmem;
+}
+EXPORT_SYMBOL_GPL(devm_nvmem_register);
+
+static int devm_nvmem_match(struct device *dev, void *res, void *data)
+{
+	struct nvmem_device **r = res;
+
+	return *r == data;
+}
+
+/**
+ * devm_nvmem_unregister() - Unregister previously registered managed nvmem device
+ *
+ * @nvmem: Pointer to previously registered nvmem device.
+ *
+ * Return: Will be an negative on error or a zero on success.
+ */
+int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
+{
+	return devres_release(dev, devm_nvmem_release, devm_nvmem_match, nvmem);
+}
+EXPORT_SYMBOL(devm_nvmem_unregister);
+
+
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 					       struct nvmem_cell **cellp,
 					       const char *cell_id)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 4889a6c62a81..7f2f610c6eea 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -72,6 +72,11 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+struct nvmem_device *devm_nvmem_register(struct device *dev,
+					 const struct nvmem_config *cfg);
+
+int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -84,5 +89,17 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
 	return -ENOSYS;
 }
 
+static inline struct nvmem_device *
+devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
+{
+	return nvmem_register(c);
+}
+
+static inline int
+devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
+{
+	return nvmem_unregister(nvmem);
+}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.14.3
