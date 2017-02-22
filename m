From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 22 Feb 2017 14:27:51 +0100
Subject: [PATCH] media: vpif: request enable-gpios
Message-ID: <1487770071-5157-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to make vpif capture work on the da850-evm board
where the capture function must be selected on the UI expander.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/media/platform/davinci/vpif_capture.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index b62a399..7dea358 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/gpio/consumer.h>
 
 #include <media/v4l2-ioctl.h>
 
@@ -1433,6 +1434,7 @@ static __init int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
+	struct gpio_descs *descs;
 	struct resource *res;
 	int subdev_count;
 	int res_idx = 0;
@@ -1443,6 +1445,11 @@ static __init int vpif_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	descs = devm_gpiod_get_array_optional(&pdev->dev,
+					      "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(descs))
+		dev_err(&pdev->dev, "Error requesting enable GPIOs\n");
+
 	vpif_dev = &pdev->dev;
 
 	err = initialize_vpif();
-- 
2.9.3
