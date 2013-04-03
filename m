From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Apr 2013 20:30:40 -0300
Subject: [PATCH v2 2/3] video: mxsfb: Remove custom method for retrieving GPIO
In-Reply-To: <1365031841-3864-1-git-send-email-festevam@gmail.com>
References: <1365031841-3864-1-git-send-email-festevam@gmail.com>
Message-ID: <1365031841-3864-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mxs device tree files should use the standard gpio reset binding, so no need to
have this code inside the driver anymore.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes
 drivers/video/mxsfb.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index eac7c1a..acfb871 100644
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
@@ -859,8 +858,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
 	struct pinctrl *pinctrl;
-	int panel_enable;
-	enum of_gpio_flags flags;
 	int ret;
 
 	if (of_id)
@@ -904,22 +901,6 @@ static int mxsfb_probe(struct platform_device *pdev)
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
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to request gpio %d: %d\n",
-				panel_enable, ret);
-			goto fb_release;
-		}
-	}
-
 	fb_info->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
 					       GFP_KERNEL);
 	if (!fb_info->pseudo_palette) {
-- 
1.7.9.5
