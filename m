From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 17:35:55 +0800
Subject: [PATCH v2 07/15] Bluetooth: hci_bcm: Use "txco" and "extclk" to get
 clock reference
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
Message-ID: <20181115093603.26729-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally the device tree binding only specified one clock reference,
with the name "extclk". The driver simply retrieves the clock without
bothering to specify a name.

Since we added a second clock to the binding, we need to fetch the
clocks by name now. First we try the new name "txco", then fall back
to the old name "extclk", and finally try retrieving a clock without
using any name, to cover any instances where a bad device tree or
firmware worked by accident.

In the last case, we should take care that we don't get the same
clock twice when we add support for the "lpo" clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ff73ecb8215f..1584c95c9c34 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -71,8 +71,8 @@
  * @btlp: Apple ACPI method to toggle BT_WAKE pin ("Bluetooth Low Power")
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
- * @clk: clock used by Bluetooth device
- * @clk_enabled: whether @clk is prepared and enabled
+ * @txco_clk: external reference frequency clock used by Bluetooth device
+ * @clk_enabled: whether @txco_clk is prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -102,7 +102,7 @@ struct bcm_device {
 	int			gpio_int_idx;
 #endif
 
-	struct clk		*clk;
+	struct clk		*txco_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,7 +215,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->clk);
+		err = clk_prepare_enable(dev->txco_clk);
 		if (err)
 			return err;
 	}
@@ -229,7 +229,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 		goto err_revert_shutdown;
 
 	if (!powered && dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 
 	dev->clk_enabled = powered;
 
@@ -239,7 +239,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
 	if (powered && !dev->clk_enabled)
-		clk_disable_unprepare(dev->clk);
+		clk_disable_unprepare(dev->txco_clk);
 	return err;
 }
 
@@ -896,6 +896,25 @@ static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
+/* Try a bunch of names for TXCO */
+static struct clk *bcm_get_txco(struct device *dev)
+{
+	struct clk *clk;
+
+	/* New explicit name */
+	clk = devm_clk_get(dev, "txco");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Deprecated name */
+	clk = devm_clk_get(dev, "extclk");
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	/* Original code used no name at all */
+	return devm_clk_get(dev, NULL);
+}
+
 static int bcm_get_resources(struct bcm_device *dev)
 {
 	const struct dmi_system_id *dmi_id;
@@ -905,15 +924,15 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (x86_apple_machine && !bcm_apple_get_resources(dev))
 		return 0;
 
-	dev->clk = devm_clk_get(dev->dev, NULL);
+	dev->txco_clk = bcm_get_txco(dev->dev);
 
 	/* Handle deferred probing */
-	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
-		return PTR_ERR(dev->clk);
+	if (dev->txco_clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->txco_clk);
 
 	/* Ignore all other errors as before */
-	if (IS_ERR(dev->clk))
-		dev->clk = NULL;
+	if (IS_ERR(dev->txco_clk))
+		dev->txco_clk = NULL;
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.19.1
