From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 07 Jan 2017 11:28:36 +0000
Subject: [PATCH RFC 4/4] net: mvmdio: disable interrupt if resource size is
 too small
In-Reply-To: <20170107112656.GL14217@n2100.armlinux.org.uk>
References: <20170107112656.GL14217@n2100.armlinux.org.uk>
Message-ID: <E1cPpAq-0005uQ-1T@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the MDIO interrupt, falling back to polled mode, if the resource
size does not allow us to access the interrupt registers.  All current
DT bindings use a size of 0x84, which allows access, but verifying it is
good practice.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 6ea5caddca62..614dfde657fe 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -221,6 +221,12 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		clk_prepare_enable(dev->clk);
 
 	dev->err_interrupt = platform_get_irq(pdev, 0);
+	if (dev->err_interrupt > 0 &&
+	    resource_size(r) < MVMDIO_ERR_INT_MASK + 4) {
+		dev_err(&pdev->dev,
+			"disabling interrupt, resource size is too small\n");
+		dev->err_interrupt = 0;
+	}
 	if (dev->err_interrupt > 0) {
 		ret = devm_request_irq(&pdev->dev, dev->err_interrupt,
 					orion_mdio_err_irq,
-- 
2.7.4
