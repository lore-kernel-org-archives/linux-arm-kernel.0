From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  4 Apr 2013 23:20:55 -0300
Subject: [PATCH v4 2/2] video: mxsfb: Use devm_regulator_get()
In-Reply-To: <1365128456-8762-1-git-send-email-festevam@gmail.com>
References: <1365128456-8762-1-git-send-email-festevam@gmail.com>
Message-ID: <1365128456-8762-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of using a custom binding for retrieving the GPIO that activates the 
LCD from devicetree, use the standard devm_regulator_get().

This approach has the advantage to be more generic. 

For example: in the case of a board that has a PMIC supplying the LCD voltage, 
the current approach would not work, as it only searches for a GPIO pin.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- None
Changes since v2:
- Use devm_regulator_get()
Changes since v1:
- No changes
 drivers/video/mxsfb.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index eac7c1a..c536887 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -42,7 +42,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <video/of_display_timing.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -51,6 +50,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/fb.h>
 #include <video/videomode.h>
+#include <linux/regulator/consumer.h>
 
 #define REG_SET	4
 #define REG_CLR	8
@@ -859,9 +859,8 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
 	struct pinctrl *pinctrl;
-	int panel_enable;
-	enum of_gpio_flags flags;
 	int ret;
+	struct regulator *reg_lcd;
 
 	if (of_id)
 		pdev->id_entry = of_id->data;
@@ -904,18 +903,12 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
-	panel_enable = of_get_named_gpio_flags(pdev->dev.of_node,
-					       "panel-enable-gpios", 0, &flags);
-	if (gpio_is_valid(panel_enable)) {
-		unsigned long f = GPIOF_OUT_INIT_HIGH;
-		if (flags == OF_GPIO_ACTIVE_LOW)
-			f = GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&pdev->dev, panel_enable,
-					    f, "panel-enable");
+	reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
+	if (!IS_ERR(reg_lcd)) {
+		ret = regulator_enable(reg_lcd);
 		if (ret) {
 			dev_err(&pdev->dev,
-				"failed to request gpio %d: %d\n",
-				panel_enable, ret);
+				"Failed to enable lcd regulator: %d\n", ret);
 			goto fb_release;
 		}
 	}
-- 
1.7.9.5
