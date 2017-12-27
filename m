From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 14:59:38 -0800
Subject: [PATCH 02/20] nvmem: Introduce devm_nvmem_(un)register()
In-Reply-To: <20171227225956.14442-1-andrew.smirnov@gmail.com>
References: <20171227225956.14442-1-andrew.smirnov@gmail.com>
Message-ID: <20171227225956.14442-3-andrew.smirnov@gmail.com>
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
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/core.c           | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 17 +++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 57cbeacfbeb2..84f07ba1f36d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -551,6 +551,47 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
+static void devm_nvmem_release(struct device *dev, void *res)
+{
+	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+}
+
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
index 497706f5adca..493f2f529f00 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -47,6 +47,11 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+struct nvmem_device *devm_nvmem_register(struct device *dev,
+					 const struct nvmem_config *cfg);
+
+int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -59,5 +64,17 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
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
