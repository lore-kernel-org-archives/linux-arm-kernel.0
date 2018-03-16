From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:43 +0100
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface to
 use in-band negotiation
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-3-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY mode 10GKR can use in-band negotiation. This patches allows this
mode to be used with MLO_AN_INBAND in phylink.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/phylink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 51a011a349fe..7224b005f0dd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -768,7 +768,8 @@ int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 	/* Fixed links and 802.3z are handled without needing a PHY */
 	if (pl->link_an_mode == MLO_AN_FIXED ||
 	    (pl->link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	     (phy_interface_mode_is_8023z(pl->link_interface) ||
+	      pl->link_interface == PHY_INTERFACE_MODE_10GKR)))
 		return 0;
 
 	phy_node = of_parse_phandle(dn, "phy-handle", 0);
-- 
2.14.3
