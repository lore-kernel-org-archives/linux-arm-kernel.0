From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 3 Apr 2018 15:15:54 +0800
Subject: [PATCH v1 4/7] soc: mediatek: reuse regmap_read_poll_timeout helpers
In-Reply-To: <cover.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
Message-ID: <2f84f7695ea3223b8626a8369aa4ae5e0d03fdce.1522736996.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Reuse the common helpers regmap_read_poll_timeout provided by Linux core
instead of an open-coded handling.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-infracfg.c | 45 +++++++++----------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 8c310de..b849aa5 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/iopoll.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
@@ -37,7 +38,6 @@
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update)
 {
-	unsigned long expired;
 	u32 val;
 	int ret;
 
@@ -47,22 +47,11 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 	else
 		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
 
-	expired = jiffies + HZ;
+	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
+				       val, (val & mask) == mask, 10,
+				       jiffies_to_usecs(HZ));
 
-	while (1) {
-		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
-		if (ret)
-			return ret;
-
-		if ((val & mask) == mask)
-			break;
-
-		cpu_relax();
-		if (time_after(jiffies, expired))
-			return -EIO;
-	}
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -80,30 +69,16 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update)
 {
-	unsigned long expired;
 	int ret;
+	u32 val;
 
 	if (reg_update)
 		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
 	else
 		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
 
-	expired = jiffies + HZ;
-
-	while (1) {
-		u32 val;
-
-		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
-		if (ret)
-			return ret;
-
-		if (!(val & mask))
-			break;
-
-		cpu_relax();
-		if (time_after(jiffies, expired))
-			return -EIO;
-	}
-
-	return 0;
+	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
+				       val, !(val & mask), 10,
+				       jiffies_to_usecs(HZ));
+	return ret;
 }
-- 
2.7.4
