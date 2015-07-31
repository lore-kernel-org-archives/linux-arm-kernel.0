From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 10:01:41 +0200
Subject: [PATCH 2/3] phy-sun4i-sub: Move vbus-detect helper functions up in
 the file
In-Reply-To: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
References: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438329702-10365-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move vbus-detect helper functions up in the file, just moving some code
around, no functional changes what so ever.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index d514a9b..ddb9fd2 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -294,6 +294,30 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 	return 0;
 }
 
+static int sun4i_usb_phy0_get_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	if (data->vbus_det_gpio)
+		return gpiod_get_value_cansleep(data->vbus_det_gpio);
+
+	if (data->vbus_power_supply) {
+		union power_supply_propval val;
+		int r;
+
+		r = power_supply_get_property(data->vbus_power_supply,
+					      POWER_SUPPLY_PROP_PRESENT, &val);
+		if (r == 0)
+			return val.intval;
+	}
+
+	/* Fallback: report vbus as high */
+	return 1;
+}
+
+static bool sun4i_usb_phy0_have_vbus_det(struct sun4i_usb_phy_data *data)
+{
+	return data->vbus_det_gpio || data->vbus_power_supply;
+}
+
 static int sun4i_usb_phy_power_on(struct phy *_phy)
 {
 	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
@@ -357,30 +381,6 @@ static struct phy_ops sun4i_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int sun4i_usb_phy0_get_vbus_det(struct sun4i_usb_phy_data *data)
-{
-	if (data->vbus_det_gpio)
-		return gpiod_get_value_cansleep(data->vbus_det_gpio);
-
-	if (data->vbus_power_supply) {
-		union power_supply_propval val;
-		int r;
-
-		r = power_supply_get_property(data->vbus_power_supply,
-					      POWER_SUPPLY_PROP_PRESENT, &val);
-		if (r == 0)
-			return val.intval;
-	}
-
-	/* Fallback: report vbus as high */
-	return 1;
-}
-
-static bool sun4i_usb_phy0_have_vbus_det(struct sun4i_usb_phy_data *data)
-{
-	return data->vbus_det_gpio || data->vbus_power_supply;
-}
-
 static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 {
 	struct sun4i_usb_phy_data *data =
-- 
2.4.3
