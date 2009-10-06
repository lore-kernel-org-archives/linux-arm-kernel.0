From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 5 Oct 2009 22:06:50 -0700
Subject: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
In-Reply-To: <20090930200746.GA1384@ucw.cz>
References: <20090930200746.GA1384@ucw.cz>
Message-ID: <20091006050649.GH27881@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Wed, Sep 30, 2009 at 10:07:46PM +0200, Pavel Machek wrote:
> Hi!
> 
> It complains about unbalanced irq 113 wake disable. That one belongs
> to matrix-keypad...

I guess some of enable_irq_wake()s fail on your box. Do you see it if
you apply the patch below?

Thanks.

-- 
Dmitry


Input: matrix-keypad - report errors from enable_irq_wake()

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/matrix_keypad.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)


diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 91cfe51..488171c 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -218,14 +218,29 @@ static int matrix_keypad_suspend(struct platform_device *pdev, pm_message_t stat
 	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
+	int err;
 
 	matrix_keypad_stop(keypad->input_dev);
 
-	if (device_may_wakeup(&pdev->dev))
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+	if (device_may_wakeup(&pdev->dev)) {
+		for (i = 0; i < pdata->num_row_gpios; i++) {
+			err = enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+			if (err) {
+				dev_err(&pdev->dev,
+					"Failed to setup GPIO %d as "
+					"wakeup source, err: %d\n",
+					pdata->row_gpios[i], err);
+				goto err_out;
+			}
+		}
+	}
 
 	return 0;
+
+ err_out:
+	while (--i >= 0)
+		disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
+	return err;
 }
 
 static int matrix_keypad_resume(struct platform_device *pdev)
