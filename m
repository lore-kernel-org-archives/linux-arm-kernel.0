From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:28 +0200
Subject: [PATCH 7/9] usb: phy: am335x: setup the gen_phy function pointers
 _before_ adding the phy
In-Reply-To: <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure all parameters are correctly set up before registering the
PHY with the USB framework.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/phy/phy-am335x.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index 91c71ab..6522fa7 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -56,11 +56,12 @@ static int am335x_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	am_phy->usb_phy_gen.phy.init = am335x_init;
+	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
+
 	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
 	if (ret)
 		return ret;
-	am_phy->usb_phy_gen.phy.init = am335x_init;
-	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
 
 	platform_set_drvdata(pdev, am_phy);
 	device_init_wakeup(dev, true);
-- 
1.7.10.4
