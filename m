From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:11 +0200
Subject: [PATCH 07/21] of/platform: Ensure device registration on lookup
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a platform device from its device node, ensure that the
device has been registered before doing the actual search.

This increases the chances of the device having been probed by that
time, reducing deferred probes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index cc5d808..af2bc75 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -46,6 +46,8 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
+	of_platform_device_ensure(np);
+
 	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
 	return dev ? to_platform_device(dev) : NULL;
 }
-- 
2.4.1
