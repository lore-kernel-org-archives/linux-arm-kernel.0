From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 22 Jun 2018 14:33:06 +0800
Subject: [PATCH 2/2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
In-Reply-To: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
Message-ID: <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
    never return NULL value;
2. devm_of_phy_get_by_index() should not fail for a valid index

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/phy.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767..0f972e1 100644
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
+		return PTR_ERR(phy);
 
 	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
 	if (!roothub_entry)
-- 
1.9.1
