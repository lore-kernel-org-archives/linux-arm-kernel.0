From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 11:24:14 +0100
Subject: [PATCH 1/3] drm/armada: fix compare_of() for LCD controllers
In-Reply-To: <20180710102344.GH17271@n2100.armlinux.org.uk>
References: <20180710102344.GH17271@n2100.armlinux.org.uk>
Message-ID: <E1fcpoc-0003Yt-07@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT node passed for LCD controllers is the "port" node within the
parent device.  Detect this and compare the parent node.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index d1705d298a39..217f0590fd61 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -205,7 +205,10 @@ static void armada_drm_unbind(struct device *dev)
 
 static int compare_of(struct device *dev, void *data)
 {
-	return dev->of_node == data;
+	struct device_node *np = data;
+	if (of_node_cmp(np->name, "port") == 0)
+		np = np->parent;
+	return dev->of_node == np;
 }
 
 static int compare_dev_name(struct device *dev, void *data)
-- 
2.7.4
