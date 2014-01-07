From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  7 Jan 2014 18:57:31 +0100
Subject: [PATCH v2 1/2] phy-core: phy_get: Leave error logging to the caller
In-Reply-To: <1389117452-3272-1-git-send-email-hdegoede@redhat.com>
References: <1389117452-3272-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1389117452-3272-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In various cases errors may be expected, ie probe-deferral or a call to
phy_get from a driver where the use of a phy is optional.

Rather then adding all sort of complicated checks for this, and/or adding
special functions like devm_phy_get_optional, simply don't log an error,
and let deciding if get_phy returning an error really should result in a
dev_err up to the caller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 58e0e97..86a248b 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -371,17 +371,11 @@ struct phy *phy_get(struct device *dev, const char *string)
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
 	}
+	if (IS_ERR(phy))
+		return phy;
 
 	if (!try_module_get(phy->ops->owner))
 		return ERR_PTR(-EPROBE_DEFER);
-- 
1.8.4.2
