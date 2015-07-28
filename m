From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:41 +0200
Subject: [PATCH v2 10/22] regulator: core: Probe regulators on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a regulator through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 65a3f28d452c..568f095df351 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1336,6 +1336,7 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (dev && dev->of_node) {
 		node = of_get_regulator(dev, supply);
 		if (node) {
+			fwnode_ensure_device(&node->fwnode);
 			mutex_lock(&regulator_list_mutex);
 			list_for_each_entry(r, &regulator_list, list)
 				if (r->dev.parent &&
-- 
2.4.3
