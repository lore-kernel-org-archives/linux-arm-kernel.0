From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 21 May 2010 13:12:41 +0200
Subject: [PATCH 3/5] imx_keypad: add PM support
In-Reply-To: <1274440363-435-2-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
Message-ID: <1274440363-435-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* add suspend/resume support
* use keypad_data to enable wakeup from platform data

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/input/keyboard/imx_keypad.c |   57 +++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d92c15c..0d44bce 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -364,6 +364,56 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
 	writew(0xff00, keypad->mmio_base + KPCR);
 }
 
+static int mxc_kpp_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+	unsigned short reg_val;
+
+	clk_disable(keypad->clk);
+
+	if (device_may_wakeup(&pdev->dev)) {
+		reg_val = readw(keypad->mmio_base + KPSR);
+		if ((reg_val & KBD_STAT_KDIE) == 0) {
+			/* If no depress interrupt enable the release interrupt */
+			reg_val |= KBD_STAT_KRIE;
+			writew(reg_val, keypad->mmio_base + KPSR);
+		}
+		enable_irq_wake(keypad->irq);
+	} else {
+		disable_irq(keypad->irq);
+		keypad->enabled = false;
+		imx_keypad_inhibit(keypad);
+	}
+
+	return 0;
+}
+
+/*!
+ * This function brings the Keypad controller back from low-power state.
+ * If Keypad is enabled as a wake source(i.e. it can resume the system
+ * from suspend mode), the Keypad controller doesn't enter low-power state.
+ *
+ * @param   pdev  the device structure used to give information on Keypad
+ *                to resume
+ *
+ * @return  The function always returns 0.
+ */
+static int mxc_kpp_resume(struct platform_device *pdev)
+{
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+
+	clk_enable(keypad->clk);
+	if (device_may_wakeup(&pdev->dev)) {
+		/* The irq routine already cleared KRIE if it was set */
+	} else {
+		enable_irq(keypad->irq);
+		keypad->enabled = true;
+		imx_keypad_config(keypad);
+	}
+
+	return 0;
+}
+
 static void imx_keypad_close(struct input_dev *dev)
 {
 	struct imx_keypad *keypad = input_get_drvdata(dev);
@@ -410,7 +460,8 @@ open_err:
 
 static int __devinit imx_keypad_probe(struct platform_device *pdev)
 {
-	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
+	const struct matrix_keypad_platform_data *keypad_data = pdev->dev.platform_data;
+	const struct matrix_keymap_data *keymap_data = keypad_data->keymap_data;
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -525,7 +576,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, keypad);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, keypad_data->wakeup);
 
 	return 0;
 
@@ -574,6 +625,8 @@ static struct platform_driver imx_keypad_driver = {
 	},
 	.probe		= imx_keypad_probe,
 	.remove		= __devexit_p(imx_keypad_remove),
+	.suspend = mxc_kpp_suspend,
+	.resume = mxc_kpp_resume,
 };
 
 static int __init imx_keypad_init(void)
-- 
1.6.3.3
