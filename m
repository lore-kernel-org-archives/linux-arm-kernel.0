From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 24 Jul 2009 02:44:02 +0200
Subject: [PATCH] pxaficp-ir - remove incorrect net_device_ops
Message-ID: <mailman.1.1251088724.2309.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes broken pxaficp-ir. The problem was in incorrect
net_device_ops being specified which prevented the driver from
operating. The symptoms were:
 - failing ifconfig for IrLAN, resulting in
	SIOCSIFFLAGS: Cannot assign requested address
 - irattach working for IrCOMM, but the port stayed disabled

Moreover this patch corrects missing sysfs device link.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/net/irda/pxaficp_ir.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index 4edbdbe..f5b7d83 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -820,9 +820,6 @@ static const struct net_device_ops pxa_irda_netdev_ops = {
 	.ndo_stop		= pxa_irda_stop,
 	.ndo_start_xmit		= pxa_irda_hard_xmit,
 	.ndo_do_ioctl		= pxa_irda_ioctl,
-	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
 };
 
 static int pxa_irda_probe(struct platform_device *pdev)
@@ -847,6 +844,7 @@ static int pxa_irda_probe(struct platform_device *pdev)
 	if (!dev)
 		goto err_mem_3;
 
+	SET_NETDEV_DEV(dev, &pdev->dev);
 	si = netdev_priv(dev);
 	si->dev = &pdev->dev;
 	si->pdata = pdev->dev.platform_data;
-- 
1.6.3.3
