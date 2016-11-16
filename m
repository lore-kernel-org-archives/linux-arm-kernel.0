From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 16 Nov 2016 17:31:30 +0000
Subject: [PATCH 1/2] bus: vexpress-config: fix device reference leak
Message-ID: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Johan Hovold <johan@kernel.org>

Make sure to drop the reference to the parent device taken by
class_find_device() after populating the bus.

Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to regmap")
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bus/vexpress-config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Hi ARM-SoC team,

I am not sure if these couple of patches can be considered as fixes for
v4.9. I will leave that to you guys.

Can you pick these couple of patches directly either for v4.9 or v4.10 ?
I am trying to avoid single patch pull requests here. Let me know if
you prefer PR instead.

Regards,
Sudeep

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
2.7.4
