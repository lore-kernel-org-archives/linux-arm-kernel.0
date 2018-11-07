From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:13:02 +0800
Subject: [PATCH 09/15] Bluetooth: hci_bcm: Add support for regulator supplies
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Bluetooth chips have two power inputs, VBAT and VDDIO.
The former provides overall power for the chip, while the latter powers
the I/O pins and buffers.

Model these two as regulator supplies, and let the driver manage them
in the same way as it does the clock supply.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ab6e527952a9..060001f11a98 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -31,6 +31,7 @@
 #include <linux/property.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
@@ -53,6 +54,8 @@
 
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
+#define BCM_NUM_SUPPLIES 2
+
 /**
  * struct bcm_device - device driver resources
  * @serdev_hu: HCI UART controller struct
@@ -73,7 +76,8 @@
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
  * @txco_clk: external reference frequency clock used by Bluetooth device
  * @lpo_clk: external LPO clock used by Bluetooth device
- * @clk_enabled: whether clocks are prepared and enabled
+ * @supplies: VBAT and VDDIO supplies used by Bluetooth device
+ * @res_enabled: whether clocks and supplies are prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -105,7 +109,8 @@ struct bcm_device {
 
 	struct clk		*txco_clk;
 	struct clk		*lpo_clk;
-	bool			clk_enabled;
+	struct regulator_bulk_data supplies[BCM_NUM_SUPPLIES];
+	bool			res_enabled;
 
 	u32			init_speed;
 	u32			oper_speed;
@@ -216,17 +221,21 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	int err;
 
-	if (powered && !dev->clk_enabled) {
+	if (powered && !dev->res_enabled) {
+		err = regulator_bulk_enable(BCM_NUM_SUPPLIES, dev->supplies);
+		if (err)
+			return err;
+
 		/* LPO clock needs to be 32.768 kHz */
 		err = clk_set_rate(dev->lpo_clk, 32768);
 		if (err) {
 			dev_err(dev->dev, "Could not set LPO clock rate\n");
-			return err;
+			goto err_regulator_disable;
 		}
 
 		err = clk_prepare_enable(dev->lpo_clk);
 		if (err)
-			return err;
+			goto err_regulator_disable;
 
 		err = clk_prepare_enable(dev->txco_clk);
 		if (err)
@@ -241,23 +250,27 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && dev->clk_enabled) {
+	if (!powered && dev->res_enabled) {
 		clk_disable_unprepare(dev->txco_clk);
 		clk_disable_unprepare(dev->lpo_clk);
+		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
 	}
 
-	dev->clk_enabled = powered;
+	dev->res_enabled = powered;
 
 	return 0;
 
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
 err_txco_clk_disable:
-	if (powered && !dev->clk_enabled)
+	if (powered && !dev->res_enabled)
 		clk_disable_unprepare(dev->txco_clk);
 err_lpo_clk_disable:
-	if (powered && !dev->clk_enabled)
+	if (powered && !dev->res_enabled)
 		clk_disable_unprepare(dev->lpo_clk);
+err_regulator_disable:
+	if (powered && !dev->res_enabled)
+		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
 	return err;
 }
 
@@ -936,6 +949,7 @@ static struct clk *bcm_get_txco(struct device *dev)
 static int bcm_get_resources(struct bcm_device *dev)
 {
 	const struct dmi_system_id *dmi_id;
+	int err;
 
 	dev->name = dev_name(dev->dev);
 
@@ -978,6 +992,13 @@ static int bcm_get_resources(struct bcm_device *dev)
 	dev->set_device_wakeup = bcm_gpio_set_device_wakeup;
 	dev->set_shutdown = bcm_gpio_set_shutdown;
 
+	dev->supplies[0].supply = "vbat";
+	dev->supplies[1].supply = "vddio";
+	err = devm_regulator_bulk_get(dev->dev, BCM_NUM_SUPPLIES,
+				      dev->supplies);
+	if (err)
+		return err;
+
 	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
 	if (dev->irq <= 0) {
 		struct gpio_desc *gpio;
-- 
2.19.1
