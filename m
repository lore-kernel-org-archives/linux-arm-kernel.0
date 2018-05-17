From: daniel@zonque.org (Daniel Mack)
Date: Thu, 17 May 2018 11:05:50 +0200
Subject: [PATCH v2 1/3] input: touchscreen: edt-ft5x06: don't make device a
 wakeup source by default
In-Reply-To: <20180517090552.5704-1-daniel@zonque.org>
References: <20180517090552.5704-1-daniel@zonque.org>
Message-ID: <20180517090552.5704-2-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow configuring the device as wakeup source through device properties, as
not all platforms want to wake up on touch screen activity.

The I2C core automatically reads the "wakeup-source" DT property to
configure a device's wakeup capability, and board supports files can set
I2C_CLIENT_WAKE in the flags.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 3 +++
 drivers/input/touchscreen/edt-ft5x06.c                             | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 025cf8c9324a..83f792d4d88c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -52,6 +52,8 @@ Optional properties:
  - touchscreen-inverted-y  : See touchscreen.txt
  - touchscreen-swapped-x-y : See touchscreen.txt
 
+ - wakeup-source: touchscreen acts as wakeup source
+
 Example:
 	polytouch: edt-ft5x06 at 38 {
 		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
@@ -62,4 +64,5 @@ Example:
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 	};
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 5bf63f76ddda..e18a2f215500 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1007,7 +1007,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		goto err_remove_attrs;
 
 	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
-	device_init_wakeup(&client->dev, 1);
 
 	dev_dbg(&client->dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
-- 
2.14.3
