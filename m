From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed,  2 Oct 2013 12:57:22 +0200
Subject: [PATCH 3/3] net: mv643xx_eth: fix missing device_node for port devices
In-Reply-To: <1380711442-24735-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1380711442-24735-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1380711442-24735-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-based mv643xx_eth probes and creates platform_devices for the
port devices on its own. To allow fixups for ports based on the
device_node, we need to set .of_node of the corresponding device
with the correct node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 2364707..2c210ec 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2533,6 +2533,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	if (!ppdev)
 		return -ENOMEM;
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	ppdev->dev.of_node = pnp;
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)
-- 
1.7.10.4
