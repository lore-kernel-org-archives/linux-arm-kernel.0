From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:13:01 +0800
Subject: [PATCH 08/15] Bluetooth: hci_bcm: Add support for LPO clock
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Bluetooth controllers support a secondary LPO clock at
32.768 kHz. This external clock provides low power timing, and also
a way to detect the frequency of the main reference clock. On many
designs without NVRAM and a non-default reference clock, this must
be used or the controller will not function correctly.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 41 ++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7556f8fac8aa..ab6e527952a9 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -72,7 +72,8 @@
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
  * @txco_clk: external reference frequency clock used by Bluetooth device
- * @clk_enabled: whether @txco_clk is prepared and enabled
+ * @lpo_clk: external LPO clock used by Bluetooth device
+ * @clk_enabled: whether clocks are prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
  *	the host UART is initially set to this baudrate so that
  *	it can configure the Bluetooth device for @oper_speed
@@ -103,6 +104,7 @@ struct bcm_device {
 #endif
 
 	struct clk		*txco_clk;
+	struct clk		*lpo_clk;
 	bool			clk_enabled;
 
 	u32			init_speed;
@@ -215,21 +217,34 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->clk_enabled) {
-		err = clk_prepare_enable(dev->txco_clk);
+		/* LPO clock needs to be 32.768 kHz */
+		err = clk_set_rate(dev->lpo_clk, 32768);
+		if (err) {
+			dev_err(dev->dev, "Could not set LPO clock rate\n");
+			return err;
+		}
+
+		err = clk_prepare_enable(dev->lpo_clk);
 		if (err)
 			return err;
+
+		err = clk_prepare_enable(dev->txco_clk);
+		if (err)
+			goto err_lpo_clk_disable;
 	}
 
 	err = dev->set_shutdown(dev, powered);
 	if (err)
-		goto err_clk_disable;
+		goto err_txco_clk_disable;
 
 	err = dev->set_device_wakeup(dev, powered);
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && dev->clk_enabled)
+	if (!powered && dev->clk_enabled) {
 		clk_disable_unprepare(dev->txco_clk);
+		clk_disable_unprepare(dev->lpo_clk);
+	}
 
 	dev->clk_enabled = powered;
 
@@ -237,9 +252,12 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
-err_clk_disable:
+err_txco_clk_disable:
 	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->txco_clk);
+err_lpo_clk_disable:
+	if (powered && !dev->clk_enabled)
+		clk_disable_unprepare(dev->lpo_clk);
 	return err;
 }
 
@@ -934,6 +952,19 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->txco_clk))
 		dev->txco_clk = NULL;
 
+	dev->lpo_clk = devm_clk_get(dev->dev, "lpo");
+	if (IS_ERR(dev->lpo_clk) && PTR_ERR(dev->lpo_clk) == -EPROBE_DEFER)
+		return PTR_ERR(dev->lpo_clk);
+
+	if (IS_ERR(dev->lpo_clk))
+		dev->lpo_clk = NULL;
+
+	/* Check if we accidentally fetched the lpo clock twice */
+	if (dev->lpo_clk && clk_is_match(dev->lpo_clk, dev->txco_clk)) {
+		devm_clk_put(dev->dev, dev->txco_clk);
+		dev->txco_clk = NULL;
+	}
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1
