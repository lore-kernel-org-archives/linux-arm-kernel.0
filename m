From: grant.likely@linaro.org (Grant Likely)
Date: Tue,  4 Nov 2014 10:45:20 +0000
Subject: [PATCH] of/platform: Move platform devices under /sys/devices/platform
Message-ID: <1415097920-30014-1-git-send-email-grant.likely@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the devices created by drivers/of/platform.c get created at
the root of /sys/devices. This goes against the typical pattern for
sysfs where the top level /sys/devices structure contains categories of
devices, and the structure of devices is placed below that. To fix this,
make the code in drivers/of/platform.c follow the drivers/base/platform.c
behaviour, and use &platform_bus as the default parent for all new
platform_devices and amba_devices.

This change has been discussed for a long time, but nobody has actually
acted on it. Userspace code that expects to find devices under a fixed
/sys/devices/... path will be affected. It isn't /supposed/ to do that,
but if anyone complains then I'll add a default-off workaround option to
put them back into the root.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3b64d0bf5bba..7c6771986c06 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -138,7 +138,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
-	dev->dev.parent = parent;
+	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
@@ -291,7 +291,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
-	dev->dev.parent = parent;
+	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
-- 
1.9.1
