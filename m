From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:20 +0200
Subject: [PATCH 16/21] usb: phy: Probe phy devices on demand
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-17-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a phy through its DT node, ensure that the corresponding
device has been registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/usb/phy/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index d1cd6b5..7084f21 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -192,6 +193,8 @@ struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 		goto err0;
 	}
 
+	of_platform_device_ensure(node);
+
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __of_usb_find_phy(node);
-- 
2.4.1
