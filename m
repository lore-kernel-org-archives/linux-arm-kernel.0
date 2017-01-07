From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 07 Jan 2017 11:28:20 +0000
Subject: [PATCH RFC 1/4] net: mvmdio: disable interrupts in driver failure path
In-Reply-To: <20170107112656.GL14217@n2100.armlinux.org.uk>
References: <20170107112656.GL14217@n2100.armlinux.org.uk>
Message-ID: <E1cPpAa-0005u5-LW@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the mvmdio driver has an interrupt, it enables the "done" interrupt
after requesting its interrupt handler.  However, probe failure results
in the interrupt being left enabled.  Disable it on the failure path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index a0d1b084ecec..7aea0beca56e 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -251,6 +251,8 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	return 0;
 
 out_mdio:
+	if (dev->err_interrupt > 0)
+		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 	if (!IS_ERR(dev->clk))
 		clk_disable_unprepare(dev->clk);
 	return ret;
-- 
2.7.4
