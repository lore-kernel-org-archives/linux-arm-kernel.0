From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed,  3 Oct 2018 15:31:04 -0700
Subject: [PATCH i2c-next v5 2/5] i2c: Add support for 'timeout-ms' and
 '#retries' OF properties
In-Reply-To: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for 'timeout-ms' and '#retries' OF
properties to set 'timeout' and 'retries' values in
'struct i2c_adapter' in case an adapter node has the properties.
Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
on cdev at runtime too.

These properties may not be supported by all drivers. However, if
a driver wants to support one of them, it should adapt the
bindings in the dt-bindings document.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..b58aa17b287b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = -EINVAL;
+	u32 timeout_ms;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered)) {
@@ -1239,8 +1240,21 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	INIT_LIST_HEAD(&adap->userspace_clients);
 
 	/* Set default timeout to 1 second if not already set */
-	if (adap->timeout == 0)
-		adap->timeout = HZ;
+	if (adap->timeout == 0) {
+		if (adap->dev.of_node)
+			res = of_property_read_u32(adap->dev.of_node,
+						   "timeout-ms",
+						   &timeout_ms);
+		if (res)
+			timeout_ms = 0;
+
+		adap->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : HZ;
+	}
+
+	/* Set retries value if it has the OF property */
+	if (adap->dev.of_node)
+		of_property_read_u32(adap->dev.of_node, "#retries",
+				     &adap->retries);
 
 	/* register soft irqs for Host Notify */
 	res = i2c_setup_host_notify_irq_domain(adap);
-- 
2.19.0
