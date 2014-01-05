From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  6 Jan 2014 00:06:28 +0100
Subject: [PATCH 1/2] phy-core: Don't print an error on probe deferral or nodata
Message-ID: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing an error on probe-deferral clearly is not the right thing to do.
While at it I've also silenced the error in case of -ENODATA, so that
devm_phy_get can be used to get an optional phy without causing errors to
be printed. Alternatively a new devm_phy_get_optional method could be
added for this.

While at it also factor the error handling out of the if ... else ..., as it
is identical in both branches.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 58e0e97..d7b992e 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -371,16 +371,14 @@ struct phy *phy_get(struct device *dev, const char *string)
 		index = of_property_match_string(dev->of_node, "phy-names",
 			string);
 		phy = of_phy_get(dev, index);
-		if (IS_ERR(phy)) {
-			dev_err(dev, "unable to find phy\n");
-			return phy;
-		}
 	} else {
 		phy = phy_lookup(dev, string);
-		if (IS_ERR(phy)) {
-			dev_err(dev, "unable to find phy\n");
-			return phy;
-		}
+	}
+	if (IS_ERR(phy)) {
+		int err = PTR_ERR(phy);
+		if (err != -EPROBE_DEFER && err != -ENODATA)
+			dev_err(dev, "unable to get phy\n");
+		return phy;
 	}
 
 	if (!try_module_get(phy->ops->owner))
-- 
1.8.4.2
