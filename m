From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed,  3 Jan 2018 12:00:54 -0800
Subject: [PATCH v3 02/22] nvmem: core: Allow specifying device name verbatim
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <20180103200114.23922-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to allow avoid having nvmem core append a numeric suffix to
the end of the name by passing config->id of -1.

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
 drivers/nvmem/core.c           | 11 ++++++++---
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5a5cefd12153..57cbeacfbeb2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -475,9 +475,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->reg_write = config->reg_write;
 	np = config->dev->of_node;
 	nvmem->dev.of_node = np;
-	dev_set_name(&nvmem->dev, "%s%d",
-		     config->name ? : "nvmem",
-		     config->name ? config->id : nvmem->id);
+
+	if (config->id == -1 && config->name) {
+		dev_set_name(&nvmem->dev, "%s", config->name);
+	} else {
+		dev_set_name(&nvmem->dev, "%s%d",
+			     config->name ? : "nvmem",
+			     config->name ? config->id : nvmem->id);
+	}
 
 	nvmem->read_only = of_property_read_bool(np, "read-only") |
 			   config->read_only;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 27e599222ec1..4889a6c62a81 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -43,6 +43,9 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
  * generated with ida_simple_get() and provided id field is ignored.
+ *
+ * Note: Specifying name and setting id to -1 implies a unique device
+ * whose name is provided as-is (kept unaltered).
  */
 struct nvmem_config {
 	struct device		*dev;
-- 
2.14.3
