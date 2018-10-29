From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 29 Oct 2018 14:14:11 -0700
Subject: [PATCH i2c-next v8 2/5] i2c: core: Add support reading of
 'bus-timeout-ms' and '#retries' properties
In-Reply-To: <20181029211414.20771-1-jae.hyun.yoo@linux.intel.com>
References: <20181029211414.20771-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181029211414.20771-3-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for 'bus-timeout-ms' and '#retries'
properties to set 'timeout' and 'retries' values in
'struct i2c_adapter' in case an adapter node has the properties.
Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
on cdev at runtime too.

These properties may not be supported by all drivers. However, if
a driver wants to support one of them, it should adapt the
bindings in the dt-bindings document.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index dc78aa7369de..abf8e78bdb82 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = -EINVAL;
+	u32 bus_timeout_ms = 0;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered)) {
@@ -1239,8 +1240,15 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	INIT_LIST_HEAD(&adap->userspace_clients);
 
 	/* Set default timeout to 1 second if not already set */
-	if (adap->timeout == 0)
-		adap->timeout = HZ;
+	if (adap->timeout == 0) {
+		device_property_read_u32(&adap->dev, "bus-timeout-ms",
+					 &bus_timeout_ms);
+		adap->timeout = bus_timeout_ms ?
+					msecs_to_jiffies(bus_timeout_ms) : HZ;
+	}
+
+	/* Set retries count if it has the property setting */
+	device_property_read_u32(&adap->dev, "#retries", &adap->retries);
 
 	/* register soft irqs for Host Notify */
 	res = i2c_setup_host_notify_irq_domain(adap);
-- 
2.19.1
