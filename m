From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 29 Aug 2018 10:10:48 +0800
Subject: [PATCH v2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
Message-ID: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
never return NULL value;
But still need ignore the error of -ENODEV, for more information, please
refer to:
[0] https://lkml.org/lkml/2018/4/19/88
[1] https://patchwork.kernel.org/patch/10160181/

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
V2: keep the -ENODEV check
---
 drivers/usb/core/phy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767..e3cc743 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 				   struct list_head *list)
 {
 	struct usb_phy_roothub *roothub_entry;
-	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	struct phy *phy;
 
-	if (IS_ERR_OR_NULL(phy)) {
-		if (!phy || PTR_ERR(phy) == -ENODEV)
-			return 0;
-		else
-			return PTR_ERR(phy);
-	}
+	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	if (IS_ERR(phy))
+		return (PTR_ERR(phy) == -ENODEV) ? 0 : PTR_ERR(phy);
 
 	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
 	if (!roothub_entry)
-- 
1.9.1
