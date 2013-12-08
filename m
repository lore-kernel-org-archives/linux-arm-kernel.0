From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  8 Dec 2013 15:40:29 +0100
Subject: [PATCH v1 4/6] net: phy: resume/suspend PHYs on attach/detach
In-Reply-To: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1386171888-28190-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386513631-11284-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ensures PHYs are resumed on attach and suspended on detach.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6f0e9e4..3903f44 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -570,6 +570,8 @@ static int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	if (err)
 		phy_detach(phydev);
 
+	phy_resume(phydev);
+
 	return err;
 }
 
@@ -615,6 +617,7 @@ void phy_detach(struct phy_device *phydev)
 {
 	phydev->attached_dev->phydev = NULL;
 	phydev->attached_dev = NULL;
+	phy_suspend(phydev);
 
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
-- 
1.8.4.rc3
