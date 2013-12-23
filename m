From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 23 Dec 2013 16:23:37 +0000
Subject: [RFC 05/18] driver core: Do not WARN when devres list is not empty at
 probe time
In-Reply-To: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1387815830-8794-6-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regmap_init() adds the initialised map to the device resources,
which can be then obtained in the driver->probe function in a
generic way with dev_reg_regmap(), which makes it independent
from underlying hardware interface. This is useful when
platform_devices are not simply memory mapped but must use
custom way of accessing the registers.

Unfortunately the device core WARNs in a situation when probed
devices has a non-empty resources list. This patch simply
removes this check and doesn't seem to have any side effects.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0605176..07b8419 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -269,7 +269,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
-	WARN_ON(!list_empty(&dev->devres_head));
 
 	dev->driver = drv;
 
-- 
1.8.3.2
