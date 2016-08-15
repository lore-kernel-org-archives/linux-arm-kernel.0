From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Aug 2016 21:21:30 +0200
Subject: [PATCH v2 5/7] phy-sun4i-usb: Warn when external vbus is detected
In-Reply-To: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471288892-21702-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warn when external vbus is detected when we're trying to enable our
own vbus.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index d369081..c17b099 100644
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
2.7.4
