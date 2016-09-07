From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  7 Sep 2016 22:20:41 +0200
Subject: [PATCH resend 5/5] phy-sun4i-usb: Warn when external vbus is detected
In-Reply-To: <20160907202041.17656-1-hdegoede@redhat.com>
References: <20160907202041.17656-1-hdegoede@redhat.com>
Message-ID: <20160907202041.17656-6-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warn when external vbus is detected when we're trying to enable our
own vbus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
Changes in v3:
-No changes
---
 drivers/phy/phy-sun4i-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index af42f8d..03f030b 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -390,8 +390,10 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 
 	/* For phy0 only turn on Vbus if we don't have an ext. Vbus */
 	if (phy->index == 0 && sun4i_usb_phy0_have_vbus_det(data) &&
-				data->vbus_det)
+				data->vbus_det) {
+		dev_warn(&_phy->dev, "External vbus detected, not enabling our own vbus\n");
 		return 0;
+	}
 
 	ret = regulator_enable(phy->vbus);
 	if (ret)
-- 
2.9.3
