From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 29 Jan 2013 16:24:04 +0100
Subject: [PATCH 1/5] net: mvmdio: unmap base register address at driver removal
In-Reply-To: <1359473048-26551-1-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
Message-ID: <1359473048-26551-2-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the driver remove callback to unmap the base register address and
not leak this mapping after the driver has been removed.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/net/ethernet/marvell/mvmdio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 74f1c15..be5c690 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -200,9 +200,12 @@ static int orion_mdio_probe(struct platform_device *pdev)
 static int orion_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
+	struct orion_mdio_dev *dev = bus->priv;
+
 	mdiobus_unregister(bus);
 	kfree(bus->irq);
 	mdiobus_free(bus);
+	iounmap(dev->smireg);
 	return 0;
 }
 
-- 
1.7.10.4
