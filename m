From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:01:42 +0200
Subject: [PATCH 3/3] phy-sun4i-usb: Only check vbus-det on power-on on boards
 with vbus-det
In-Reply-To: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
References: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438329702-10365-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

data->vbus_det is always 1 on boards without a (working) vbus-det, skip
the vbus_det test on such boards.

This fixes the sun4i usb phy code never turning on Vbus on such boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index ddb9fd2..12c5e4eb 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -328,7 +328,8 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 		return 0;
 
 	/* For phy0 only turn on Vbus if we don't have an ext. Vbus */
-	if (phy->index == 0 && data->vbus_det)
+	if (phy->index == 0 && sun4i_usb_phy0_have_vbus_det(data) &&
+				data->vbus_det)
 		return 0;
 
 	ret = regulator_enable(phy->vbus);
-- 
2.4.3
