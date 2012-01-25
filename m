From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:40:55 +0000
Subject: [PATCH 32/33] MFD: ucb1x00-assabet: add support for UCB1x00 GPIO
 switches
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq41v-0000Zy-BZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for UCB1x00 GPIO buttons found on the Assabet platform.
We can now trivially support these buttons as we have standardized
gpiolib, genirq and gpio keyboard support in place for this device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-assabet.c |   43 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ucb1x00-assabet.c b/drivers/mfd/ucb1x00-assabet.c
index b7be613..b63c075 100644
--- a/drivers/mfd/ucb1x00-assabet.c
+++ b/drivers/mfd/ucb1x00-assabet.c
@@ -11,9 +11,13 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
 #include <linux/proc_fs.h>
-#include <linux/device.h>
 #include <linux/mfd/ucb1x00.h>
 
 #define UCB1X00_ATTR(name,input)\
@@ -35,14 +39,45 @@ UCB1X00_ATTR(batt_temp, UCB_ADC_INP_AD2);
 
 static int ucb1x00_assabet_add(struct ucb1x00_dev *dev)
 {
-	device_create_file(&dev->ucb->dev, &dev_attr_vbatt);
-	device_create_file(&dev->ucb->dev, &dev_attr_vcharger);
-	device_create_file(&dev->ucb->dev, &dev_attr_batt_temp);
+	struct ucb1x00 *ucb = dev->ucb;
+	struct platform_device *pdev;
+	struct gpio_keys_platform_data keys;
+	static struct gpio_keys_button buttons[6];
+	unsigned i;
+
+	memset(buttons, 0, sizeof(buttons));
+	memset(&keys, 0, sizeof(keys));
+
+	for (i = 0; i < ARRAY_SIZE(buttons); i++) {
+		buttons[i].code = BTN_0 + i;
+		buttons[i].gpio = ucb->gpio.base + i;
+		buttons[i].type = EV_KEY;
+		buttons[i].can_disable = true;
+	}
+
+	keys.buttons = buttons;
+	keys.nbuttons = ARRAY_SIZE(buttons);
+	keys.poll_interval = 50;
+	keys.name = "ucb1x00";
+
+	pdev = platform_device_register_data(&ucb->dev, "gpio-keys", -1,
+		&keys, sizeof(keys));
+
+	device_create_file(&ucb->dev, &dev_attr_vbatt);
+	device_create_file(&ucb->dev, &dev_attr_vcharger);
+	device_create_file(&ucb->dev, &dev_attr_batt_temp);
+
+	dev->priv = pdev;
 	return 0;
 }
 
 static void ucb1x00_assabet_remove(struct ucb1x00_dev *dev)
 {
+	struct platform_device *pdev = dev->priv;
+
+	if (!IS_ERR(pdev))
+		platform_device_unregister(pdev);
+
 	device_remove_file(&dev->ucb->dev, &dev_attr_batt_temp);
 	device_remove_file(&dev->ucb->dev, &dev_attr_vcharger);
 	device_remove_file(&dev->ucb->dev, &dev_attr_vbatt);
-- 
1.7.4.4
