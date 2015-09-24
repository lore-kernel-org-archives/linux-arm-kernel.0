From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 24 Sep 2015 20:36:23 +0100
Subject: [PATCH RESEND v3 7/9] phy: fixed-phy: properly validate phy in
 fixed_phy_update_state()
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
Message-ID: <E1ZfCJb-0004Rx-G8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Validate that the phy_device passed into fixed_phy_update_state() is a
fixed-phy device before walking the list of phys for a fixed phy at the
same address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/phy/fixed_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index fb1299c6326e..e23bf5b90e17 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -220,7 +220,7 @@ int fixed_phy_update_state(struct phy_device *phydev,
 	struct fixed_mdio_bus *fmb = &platform_fmb;
 	struct fixed_phy *fp;
 
-	if (!phydev || !phydev->bus)
+	if (!phydev || phydev->bus != fmb->mii_bus)
 		return -EINVAL;
 
 	list_for_each_entry(fp, &fmb->phys, node) {
-- 
2.1.0
