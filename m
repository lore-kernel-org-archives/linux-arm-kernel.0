From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 29 Jul 2016 17:33:54 -0700
Subject: [PATCH net-next 01/10] drivers: net: xgene: Fix kbuild warning
In-Reply-To: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
References: <1469838843-19943-1-git-send-email-isubramanian@apm.com>
Message-ID: <1469838843-19943-2-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following kbuild warning, when ACPI was not enabled.

>> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:878:23: warning: 'phy_dev' may be used uninitialized in this function [-Wmaybe-uninitialized]
     phy_dev->advertising = phy_dev->supported;

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
index 7714b7d..b6bc6fa 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -776,15 +776,11 @@ int xgene_enet_phy_connect(struct net_device *ndev)
 			netdev_err(ndev, "Could not connect to PHY\n");
 			return -ENODEV;
 		}
-
-		pdata->phy_dev = phy_dev;
 	} else {
 #ifdef CONFIG_ACPI
 		struct acpi_device *adev = acpi_phy_find_device(dev);
 		if (adev)
-			pdata->phy_dev =  adev->driver_data;
-
-		phy_dev = pdata->phy_dev;
+			phy_dev =  adev->driver_data;
 
 		if (!phy_dev ||
 		    phy_connect_direct(ndev, phy_dev, &xgene_enet_adjust_link,
@@ -795,6 +791,7 @@ int xgene_enet_phy_connect(struct net_device *ndev)
 #endif
 	}
 
+	pdata->phy_dev = phy_dev;
 	pdata->phy_speed = SPEED_UNKNOWN;
 	phy_dev->supported &= ~SUPPORTED_10baseT_Half &
 			      ~SUPPORTED_100baseT_Half &
-- 
1.9.1
