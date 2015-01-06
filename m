From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:45:07 +0100
Subject: [PATCH 1/4] usb: phy: Fix deferred probing
In-Reply-To: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420559110-8043-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
failure") actually broke the deferred probing mechanism, since it now returns
EPROBE_DEFER only when the try_module_get call fails, but not when the phy
lookup does.

All the other similar functions seem to return ENODEV when try_module_get
fails, and the error code of either __usb_find_phy or __of_usb_find_phy
otherwise.

In order to have a consistent behaviour, and a meaningful EPROBE_DEFER, always
return EPROBE_DEFER when __(of_)usb_find_phy fails to look up the requested
phy, that will be propagated by the caller, and ENODEV if try_module_get fails.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/usb/phy/phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index b4066a001ba0..353c686498d4 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -34,7 +34,7 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
 		return phy;
 	}
 
-	return ERR_PTR(-ENODEV);
+	return ERR_PTR(-EPROBE_DEFER);
 }
 
 static struct usb_phy *__usb_find_phy_dev(struct device *dev,
@@ -66,7 +66,7 @@ static struct usb_phy *__of_usb_find_phy(struct device_node *node)
 		return phy;
 	}
 
-	return ERR_PTR(-ENODEV);
+	return ERR_PTR(-EPROBE_DEFER);
 }
 
 static void devm_usb_phy_release(struct device *dev, void *res)
@@ -192,7 +192,7 @@ struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 	phy = __of_usb_find_phy(node);
 	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
 		if (!IS_ERR(phy))
-			phy = ERR_PTR(-EPROBE_DEFER);
+			phy = ERR_PTR(-ENODEV);
 
 		devres_free(ptr);
 		goto err1;
-- 
2.2.1
