From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 01 Feb 2013 20:09:27 +0100
Subject: [PATCH v4 06/10] s5p-fimc: Use pinctrl API for camera ports
 configuration
In-Reply-To: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1359745771-23684-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the camera ports can be used the pinmux needs to be configured
properly. This patch adds a function to set the camera ports pinctrl
to a default state within the media driver's probe().
The camera port(s) are then configured for the video bus operation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Changes since v3:
 - removed the "inactive" pinctrl state, it will be added later if required
---
 .../devicetree/bindings/media/soc/samsung-fimc.txt |    7 +++++++
 drivers/media/platform/s5p-fimc/fimc-mdevice.c     |    9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt b/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt
index 6b81ad1..3788305 100644
--- a/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt
+++ b/Documentation/devicetree/bindings/media/soc/samsung-fimc.txt
@@ -18,6 +18,10 @@ Required properties:
 
 - compatible	   : must be "samsung,fimc", "simple-bus"
 
+- pinctrl-names    : pinctrl names for camera port pinmux control, at least
+		     "default" needs to be specified.
+- pinctrl-0...N	   : pinctrl properties corresponding to pinctrl-names
+
 The 'camera' node must include at least one 'fimc' child node.
 
 
@@ -133,6 +137,9 @@ Example:
 		#size-cells = <1>;
 		status = "okay";
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_port_a_clk_active>;
+
 		/* parallel camera ports */
 		parallel-ports {
 			/* camera A input */
diff --git a/drivers/media/platform/s5p-fimc/fimc-mdevice.c b/drivers/media/platform/s5p-fimc/fimc-mdevice.c
index 2bb501f..6c2c9e3 100644
--- a/drivers/media/platform/s5p-fimc/fimc-mdevice.c
+++ b/drivers/media/platform/s5p-fimc/fimc-mdevice.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
@@ -1197,6 +1198,14 @@ static int fimc_md_probe(struct platform_device *pdev)
 	/* Protect the media graph while we're registering entities */
 	mutex_lock(&fmd->media_dev.graph_mutex);
 
+	if (dev->of_node) {
+		struct pinctrl *pctl = devm_pinctrl_get_select_default(dev);
+		if (IS_ERR(pctl)) {
+			ret = PTR_ERR(pctl);
+			goto err_unlock;
+		}
+	}
+
 	if (fmd->pdev->dev.of_node)
 		ret = fimc_md_register_of_platform_entities(fmd, dev->of_node);
 	else
-- 
1.7.9.5
