From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 21 Aug 2016 14:16:37 +0200
Subject: [PATCH v3 5/7] phy-sun4i-usb: Warn when external vbus is detected
In-Reply-To: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471781799-10457-5-git-send-email-hdegoede@redhat.com>
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
2.7.4
