From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 27 Mar 2017 18:59:05 +0800
Subject: [PATCH] net: mvneta: set rx mode during resume if interface is running
Message-ID: <20170327105905.1404-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found a bug by:

0. boot and start dhcp client
1. echo mem > /sys/power/state
2. resume back immediately
3. don't touch dhcp client to renew the lease
4. ping the gateway. No acks

Usually, after step2, the DHCP lease isn't expired, so in theory we
should resume all back. But in fact, it doesn't. It turns out
the rx mode isn't resumed correctly. This patch fixes it by adding
mvneta_set_rx_mode(dev) in the resume hook if interface is running.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index aebbc5399a06..cc126204dc4d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4449,8 +4449,11 @@ static int mvneta_resume(struct device *device)
 		mvneta_fixed_link_update(pp, dev->phydev);
 
 	netif_device_attach(dev);
-	if (netif_running(dev))
+	if (netif_running(dev)) {
 		mvneta_open(dev);
+		mvneta_set_rx_mode(dev);
+	}
+
 	return 0;
 }
 #endif
-- 
2.11.0
