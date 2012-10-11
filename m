From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 15:15:26 +0100
Subject: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
Message-ID: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Disable hardware if active when suspending if the hw can not
wake the system from suspend.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
Reviewed-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
---
 drivers/input/keyboard/gpio_keys.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index cbb1add..7947315 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -46,6 +46,8 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned int n_buttons;
+	bool enabled;
+	bool enable_after_suspend;
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
 	struct gpio_button_data data[0];
@@ -524,6 +526,7 @@ static int gpio_keys_open(struct input_dev *input)
 {
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
 
+	ddata->enabled = true;
 	return ddata->enable ? ddata->enable(input->dev.parent) : 0;
 }
 
@@ -533,6 +536,7 @@ static void gpio_keys_close(struct input_dev *input)
 
 	if (ddata->disable)
 		ddata->disable(input->dev.parent);
+	ddata->enabled = false;
 }
 
 /*
@@ -674,6 +678,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	ddata->n_buttons = pdata->nbuttons;
 	ddata->enable = pdata->enable;
 	ddata->disable = pdata->disable;
+	ddata->enabled = false;
 	mutex_init(&ddata->disable_lock);
 
 	platform_set_drvdata(pdev, ddata);
@@ -789,6 +794,10 @@ static int gpio_keys_suspend(struct device *dev)
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
 		}
+	} else {
+		ddata->enable_after_suspend = ddata->enabled;
+		if (ddata->enabled)
+			gpio_keys_close(ddata->input);
 	}
 
 	return 0;
@@ -807,6 +816,10 @@ static int gpio_keys_resume(struct device *dev)
 		if (gpio_is_valid(bdata->button->gpio))
 			gpio_keys_gpio_report_event(bdata);
 	}
+
+	if (!device_may_wakeup(dev) && ddata->enable_after_suspend)
+		gpio_keys_open(ddata->input);
+
 	input_sync(ddata->input);
 
 	return 0;
-- 
1.7.9.5
