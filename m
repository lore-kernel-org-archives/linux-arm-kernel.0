From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 07 Jan 2017 11:28:25 +0000
Subject: [PATCH RFC 2/4] net: mvmdio: fix interrupt disable in remove path
In-Reply-To: <20170107112656.GL14217@n2100.armlinux.org.uk>
References: <20170107112656.GL14217@n2100.armlinux.org.uk>
Message-ID: <E1cPpAf-0005uC-P0@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pre-existing write to disable interrupts on the remove path happens
whether we have an interrupt or not.  While this may seem to be a good
idea, this driver is re-used in many different implementations, some
where the binding only specifies four bytes of register space.  This
access causes us to access registers outside of the binding.

Make it conditional on the interrupt being present, which is the same
condition used when enabling the interrupt in the first place.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 7aea0beca56e..6ea5caddca62 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -263,7 +263,8 @@ static int orion_mdio_remove(struct platform_device *pdev)
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct orion_mdio_dev *dev = bus->priv;
 
-	writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
+	if (dev->err_interrupt > 0)
+		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 	mdiobus_unregister(bus);
 	if (!IS_ERR(dev->clk))
 		clk_disable_unprepare(dev->clk);
-- 
2.7.4
