From: johan@kernel.org (Johan Hovold)
Date: Tue,  1 Nov 2016 11:43:37 +0100
Subject: [PATCH] bus: vexpress-config: fix device reference leak
Message-ID: <1477997017-29103-1-git-send-email-johan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to drop the reference to the parent device taken by
class_find_device() after populating the bus.

Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to regmap")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bus/vexpress-config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 9efdf1de4035..493e7b9fc813 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -171,6 +171,7 @@ static int vexpress_config_populate(struct device_node *node)
 {
 	struct device_node *bridge;
 	struct device *parent;
+	int ret;
 
 	bridge = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
 	if (!bridge)
@@ -182,7 +183,11 @@ static int vexpress_config_populate(struct device_node *node)
 	if (WARN_ON(!parent))
 		return -ENODEV;
 
-	return of_platform_populate(node, NULL, NULL, parent);
+	ret = of_platform_populate(node, NULL, NULL, parent);
+
+	put_device(parent);
+
+	return ret;
 }
 
 static int __init vexpress_config_init(void)
-- 
2.7.3
