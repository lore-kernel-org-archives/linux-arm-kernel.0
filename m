From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 29 Sep 2015 11:10:45 +0200
Subject: [PATCH v7 07/20] regulator: core: Probe regulators on demand
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1443517859-30376-8-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a regulator through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Mark Brown <broonie@kernel.org>
---


 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7a85ac9e32c5..ee75199c2cfa 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -26,6 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
@@ -1340,6 +1341,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
+			of_device_probe(node);
 			list_for_each_entry(r, &regulator_list, list)
 				if (r->dev.parent &&
 					node == r->dev.of_node)
-- 
2.4.3
