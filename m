From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 17 Jun 2010 20:59:01 +0200
Subject: [PATCH v2] input/imx_keypad: add PM support
Message-ID: <1276801147-4103-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use keypad_data to enable wakeup from platform data

suspend/resume is tested on an i.MX27 when keypad is not
in use and when it's is in use (in which case we immediatly
get the key pressed at wakeup)

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: maramaopercheseimorto at gmail.com
Cc: linux-input at vger.kernel.org
Cc: dmitry.torokhov at gmail.com
Cc: linux-arm-kernel at lists.infradead.org
---
v2 :
	- simplify suspend & resume functions
	- convert to pm_ops

 drivers/input/keyboard/imx_keypad.c |   40 +++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d92c15c..9aa0005 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -364,6 +364,38 @@ static void imx_keypad_inhibit(struct imx_keypad *keypad)
 	writew(0xff00, keypad->mmio_base + KPCR);
 }
 
+#ifdef CONFIG_PM
+static int mxc_kpp_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+
+	keypad->enabled = false;
+	synchronize_irq(keypad->irq);
+	disable_irq(keypad->irq);
+	clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static int mxc_kpp_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *keypad = platform_get_drvdata(pdev);
+
+	keypad->enabled = true;
+	clk_enable(keypad->clk);
+	enable_irq(keypad->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mxc_kpp_pm_ops = {
+	.suspend	= mxc_kpp_suspend,
+	.resume		= mxc_kpp_resume,
+};
+#endif
+
 static void imx_keypad_close(struct input_dev *dev)
 {
 	struct imx_keypad *keypad = input_get_drvdata(dev);
@@ -410,7 +442,8 @@ open_err:
 
 static int __devinit imx_keypad_probe(struct platform_device *pdev)
 {
-	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
+	const struct matrix_keypad_platform_data *keypad_data = pdev->dev.platform_data;
+	const struct matrix_keymap_data *keymap_data = keypad_data->keymap_data;
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -525,7 +558,7 @@ static int __devinit imx_keypad_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, keypad);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, keypad_data->wakeup);
 
 	return 0;
 
@@ -571,6 +604,9 @@ static struct platform_driver imx_keypad_driver = {
 	.driver		= {
 		.name	= "imx-keypad",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &mxc_kpp_pm_ops,
+#endif
 	},
 	.probe		= imx_keypad_probe,
 	.remove		= __devexit_p(imx_keypad_remove),
-- 
1.6.3.3
