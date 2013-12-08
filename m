From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  8 Dec 2013 15:40:30 +0100
Subject: [PATCH v1 5/6] net: phy: suspend unused PHYs on mdio_bus in
 late_initcall
In-Reply-To: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1386171888-28190-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386513631-11284-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since phy_attach ensures PHYs are resumed, we can now suspend all
PHYs that have no attached netdev after initcalls.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changelog:
RFCv2->v1:
- simplify phydev reference (Suggested by Sergei Shtylyov)

Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/phy/mdio_bus.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 5617876..9ccf9c6 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -320,6 +320,29 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
 		(phydev->phy_id & phydrv->phy_id_mask));
 }
 
+static int mdio_bus_suspend_unused(struct device *busdev, void *data)
+{
+	struct mii_bus *bus = to_mii_bus(busdev);
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if (!bus->phy_map[i])
+			continue;
+
+		if (!bus->phy_map[i]->attached_dev)
+			phy_suspend(bus->phy_map[i]);
+	}
+
+	return 0;
+}
+
+static int mdio_bus_class_suspend_unused(void)
+{
+	return class_for_each_device(&mdio_bus_class, NULL, NULL,
+				     mdio_bus_suspend_unused);
+}
+late_initcall_sync(mdio_bus_class_suspend_unused);
+
 #ifdef CONFIG_PM
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
-- 
1.8.4.rc3
