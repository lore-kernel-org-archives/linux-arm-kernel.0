From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 4 Jul 2014 20:37:53 +0530
Subject: [RFC PATCH 1/2] phy: core: Fix of_phy_provider_lookup to return PHY
 provider for sub node
In-Reply-To: <1404486474-28312-1-git-send-email-kishon@ti.com>
References: <1404486474-28312-1-git-send-email-kishon@ti.com>
Message-ID: <1404486474-28312-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed of_phy_provider_lookup to return 'phy_provider' if _of_phy_get
passes the node pointer of the sub-node of phy provider node. This is
needed when phy provider implements multiple PHYs and each PHY is
modelled as the sub-node of PHY provider device node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index c64a2f3..a4a1f783 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -86,10 +86,18 @@ static struct phy *phy_lookup(struct device *device, const char *port)
 static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
 {
 	struct phy_provider *phy_provider;
+	struct device_node *child;
 
 	list_for_each_entry(phy_provider, &phy_provider_list, list) {
-		if (phy_provider->dev->of_node == node)
+		if (phy_provider->dev->of_node != node) {
+			for_each_child_of_node(phy_provider->dev->of_node,
+				child) {
+				if (child == node)
+					return phy_provider;
+			}
+		} else {
 			return phy_provider;
+		}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);
-- 
1.7.9.5
