From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:07 +0800
Subject: [PATCH v2 8/9] ASoC: imx: add dt support for audmux-v2
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 .../bindings/sound/soc/imx/audmux-v2.txt           |   11 +++++++++++
 sound/soc/imx/audmux-v2.c                          |    8 ++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/imx/audmux-v2.txt

diff --git a/Documentation/devicetree/bindings/sound/soc/imx/audmux-v2.txt b/Documentation/devicetree/bindings/sound/soc/imx/audmux-v2.txt
new file mode 100644
index 0000000..b8ec5aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc/imx/audmux-v2.txt
@@ -0,0 +1,11 @@
+* Freescale audmux device for imx3, imx5, imx6 etc.
+
+Required properties:
+- compatible : "fsl,imx31-audmux".
+
+Example:
+
+audmux at 021d8000 {
+	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
+	reg = <0x021d8000 0x4000>;
+};
diff --git a/sound/soc/imx/audmux-v2.c b/sound/soc/imx/audmux-v2.c
index d53c029..af42fca 100644
--- a/sound/soc/imx/audmux-v2.c
+++ b/sound/soc/imx/audmux-v2.c
@@ -20,7 +20,9 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <mach/audmux.h>
 #include <mach/hardware.h>
 
@@ -244,11 +246,17 @@ static int __exit mxc_audmux_v2_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id audmux_v2_dt_ids[] = {
+	{ .compatible = "fsl,imx31-audmux", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver mxc_audmux_v2_driver = {
 	.remove		= __exit_p(mxc_audmux_v2_remove),
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = audmux_v2_dt_ids,
 	}
 };
 
-- 
1.7.5.4
