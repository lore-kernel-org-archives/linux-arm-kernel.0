From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 31 Aug 2018 17:55:09 +0800
Subject: [PATCH] usb: core: phy: clean up return value check about
 devm_of_phy_get_by_index()
Message-ID: <258d57f5c8559c5fd3ba6d1ac1dcc5463737da2e.1535709096.git.chunfeng.yun@mediatek.com>
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
V4: modify the patch subject suggested by Johan
V3: abandon the ternary operator suggested by Johan
V2: keep the -ENODEV check
---

 drivers/usb/core/phy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767..38b2c77 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -23,10 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 				   struct list_head *list)
 {
 	struct usb_phy_roothub *roothub_entry;
-	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	struct phy *phy;
 
-	if (IS_ERR_OR_NULL(phy)) {
-		if (!phy || PTR_ERR(phy) == -ENODEV)
+	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
+	if (IS_ERR(phy)) {
+		if (PTR_ERR(phy) == -ENODEV)
 			return 0;
 		else
 			return PTR_ERR(phy);
-- 
1.9.1
