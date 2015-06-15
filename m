From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 15 Jun 2015 04:37:00 +0000
Subject: [PATCH] phy: phy-mxs-usb: suspend to RAM causes NULL pointer
 dereference
Message-ID: <1434343020-29604-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Triggering suspend to RAM via sysfs on a i.MX28 causes a NULL pointer
dereference. This patch avoids the oops in mxs_phy_get_vbus_status()
by aborting since there is no syscon available.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: efdbd3a5d6e ("usb: phy: mxs: do not set PWD.RXPWD1PT1 for low speed connection")
CC: <stable@vger.kernel.org> # 4.0
Acked-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8f7cb06..3fcc048 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -217,6 +217,9 @@ static bool mxs_phy_get_vbus_status(struct mxs_phy *mxs_phy)
 {
 	unsigned int vbus_value;
 
+	if (!mxs_phy->regmap_anatop)
+		return false;
+
 	if (mxs_phy->port_id == 0)
 		regmap_read(mxs_phy->regmap_anatop,
 			ANADIG_USB1_VBUS_DET_STAT,
-- 
1.7.9.5
