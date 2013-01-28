From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:07 +0200
Subject: [PATCH 06/30] usb: phy: nop: use new PHY API to register PHY
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We would need to support multiple PHYs of the same type
so use the new PHY API usb_add_phy_dev() to register the PHY.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/otg/nop-usb-xceiv.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 3060ed0..ac027a1 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -197,12 +197,13 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 	nop->phy.init		= nop_init;
 	nop->phy.shutdown	= nop_shutdown;
 	nop->phy.state		= OTG_STATE_UNDEFINED;
+	nop->phy.type		= type;
 
 	nop->phy.otg->phy		= &nop->phy;
 	nop->phy.otg->set_host		= nop_set_host;
 	nop->phy.otg->set_peripheral	= nop_set_peripheral;
 
-	err = usb_add_phy(&nop->phy, type);
+	err = usb_add_phy_dev(&nop->phy);
 	if (err) {
 		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
 			err);
-- 
1.7.4.1
