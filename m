From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jan 2018 14:38:11 +0100
Subject: [PATCH 1/3] soc: brcmstb: Do not leak OF node reference
Message-ID: <20180112133813.3716-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The reference to the OF node should be dropped when no longer needed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/bcm/brcmstb/common.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 4fe1cb73b39a..816a0f55a9ea 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -70,19 +70,25 @@ static int __init brcmstb_soc_device_early_init(void)
 {
 	struct device_node *sun_top_ctrl;
 	void __iomem *sun_top_ctrl_base;
+	int err = 0;
 
 	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
 	if (!sun_top_ctrl)
 		return -ENODEV;
 
 	sun_top_ctrl_base = of_iomap(sun_top_ctrl, 0);
-	if (!sun_top_ctrl_base)
-		return -ENODEV;
+	if (!sun_top_ctrl_base) {
+		err = -ENODEV;
+		goto put_node;
+	}
 
 	family_id = readl(sun_top_ctrl_base);
 	product_id = readl(sun_top_ctrl_base + 0x4);
 	iounmap(sun_top_ctrl_base);
-	return 0;
+
+put_node:
+	of_node_put(sun_top_ctrl);
+	return err;
 }
 early_initcall(brcmstb_soc_device_early_init);
 
@@ -96,6 +102,8 @@ static int __init brcmstb_soc_device_init(void)
 	if (!sun_top_ctrl)
 		return -ENODEV;
 
+	of_node_put(sun_top_ctrl);
+
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
-- 
2.15.1
