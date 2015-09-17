From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:06 +0200
Subject: [PATCH v5 12/23] i2c: core: Probe i2c adapters and devices on demand
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-13-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up an i2c adapter or device through its OF node, probe it
if it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e3c2f2..02da3acbbd35 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1413,6 +1413,8 @@ struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_client *client;
 
+	of_device_probe(node);
+
 	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
@@ -1431,6 +1433,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_adapter *adapter;
 
+	of_device_probe(node);
+
 	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
-- 
2.4.3
