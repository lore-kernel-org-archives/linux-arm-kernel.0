From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:49 +0200
Subject: [PATCH v3 12/18] usb: phy: Probe phy devices on demand
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-13-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a phy through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/usb/phy/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 98f75d2842b7..a357681362f5 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <linux/usb/phy.h>
 
@@ -196,6 +197,8 @@ struct  usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 		goto err0;
 	}
 
+	of_platform_probe(node);
+
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __of_usb_find_phy(node);
-- 
2.4.3
