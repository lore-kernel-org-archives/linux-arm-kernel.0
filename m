From: sourav.poddar@ti.com (Sourav Poddar)
Date: Mon, 22 Oct 2012 18:43:00 +0530
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Message-ID: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adapt keypad to use pinctrl framework.

Tested on omap4430 sdp with 3.7-rc1 kernel.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2
- Added "PROBE_DEFER" check 
 drivers/input/keyboard/omap4-keypad.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index c05f98c..502b832 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -31,6 +31,7 @@
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <linux/platform_data/omap4-keypad.h>
 
@@ -76,6 +77,7 @@ enum {
 
 struct omap4_keypad {
 	struct input_dev *input;
+	struct pinctrl	*pins;
 
 	void __iomem *base;
 	unsigned int irq;
@@ -298,6 +300,15 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 		goto err_release_mem;
 	}
 
+	keypad_data->pins = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(keypad_data->pins)) {
+		if (PTR_ERR(keypad_data->pins) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(&pdev->dev, "did not get pins for keypad error: %li\n",
+					PTR_ERR(keypad_data->pins));
+		keypad_data->pins = NULL;
+	}
 
 	/*
 	 * Enable clocks for the keypad module so that we can read
-- 
1.7.1
