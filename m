From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 16:25:57 +0100
Subject: [PATCH v7 07/13] usb: chipidea: fix phy handling
In-Reply-To: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1415978763-27345-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic platform device for CI drivers is probed by calling
ci_hdrc_probe. This is not the same device as the one for the specific
driver, so the of_node isn't the one we're looking into.

This result in not being able to probe the phys. Since all CI driver are
retrieving their phys in the specific code, this didn't impact any of
them yet.

Fixes it using the right of node pointer, by using dev->parent instead
of dev in phy get functions.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/usb/chipidea/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index ba0ac2723098..36318c85ad65 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -654,8 +654,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	} else if (ci->platdata->usb_phy) {
 		ci->usb_phy = ci->platdata->usb_phy;
 	} else {
-		ci->phy = devm_phy_get(dev, "usb-phy");
-		ci->usb_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		ci->phy = devm_phy_get(dev->parent, "usb-phy");
+		ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
 
 		/* if both generic PHY and USB PHY layers aren't enabled */
 		if (PTR_ERR(ci->phy) == -ENOSYS &&
-- 
2.1.0
