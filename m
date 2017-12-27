From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 14:59:37 -0800
Subject: [PATCH 01/20] nvmem: core: Allow specifying device name verbatim
In-Reply-To: <20171227225956.14442-1-andrew.smirnov@gmail.com>
References: <20171227225956.14442-1-andrew.smirnov@gmail.com>
Message-ID: <20171227225956.14442-2-andrew.smirnov@gmail.com>
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
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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
-- 
2.14.3
