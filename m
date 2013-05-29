From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 29 May 2013 21:32:44 +0200
Subject: [PATCH v5 02/13] net: mv643xx_eth: use managed devm_ioremap for port
 registers
In-Reply-To: <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1369855975-21489-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of managed devm_ioremap and remove corresponding iounmap.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org       
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 2480a2f..19964e9 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2470,7 +2470,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	if (msp == NULL)
 		return -ENOMEM;
 
-	msp->base = ioremap(res->start, resource_size(res));
+	msp->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (msp->base == NULL)
 		return -ENOMEM;
 
@@ -2498,7 +2498,6 @@ static int mv643xx_eth_shared_remove(struct platform_device *pdev)
 {
 	struct mv643xx_eth_shared_private *msp = platform_get_drvdata(pdev);
 
-	iounmap(msp->base);
 	if (!IS_ERR(msp->clk))
 		clk_disable_unprepare(msp->clk);
 
-- 
1.7.10.4
