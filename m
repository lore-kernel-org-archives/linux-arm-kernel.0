From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 17 Nov 2015 13:56:48 +0800
Subject: [RESEND] phy: core: Get a refcount to phy in
 devm_of_phy_get_by_index()
Message-ID: <1447739808-29472-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On driver detach, devm_phy_release() will put a refcount to
the phy, so gets a refconut to it before return.

Change-Id: I56fe428bf945f19c38d56245978c8ca17340eb2c
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fc48fac..8c7f27d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -636,8 +636,9 @@ EXPORT_SYMBOL_GPL(devm_of_phy_get);
  * @np: node containing the phy
  * @index: index of the phy
  *
- * Gets the phy using _of_phy_get(), and associates a device with it using
- * devres. On driver detach, release function is invoked on the devres data,
+ * Gets the phy using _of_phy_get(), then gets a refcount to it,
+ * and associates a device with it using devres. On driver detach,
+ * release function is invoked on the devres data,
  * then, devres data is freed.
  *
  */
@@ -651,13 +652,21 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	phy = _of_phy_get(np, index);
-	if (!IS_ERR(phy)) {
-		*ptr = phy;
-		devres_add(dev, ptr);
-	} else {
+	if (IS_ERR(phy)) {
 		devres_free(ptr);
+		return phy;
 	}
 
+	if (!try_module_get(phy->ops->owner)) {
+		devres_free(ptr);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	get_device(&phy->dev);
+
+	*ptr = phy;
+	devres_add(dev, ptr);
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
-- 
1.8.1.1.dirty
