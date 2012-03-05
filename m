From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Mar 2012 22:31:04 +0800
Subject: [PATCH v2 16/17] ASoC: fsl: add dt support for imx-audmux
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

It adds device tree probe support for imx-audmux driver.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/sound/imx-audmux.txt       |   13 +++++++++++++
 sound/soc/fsl/imx-audmux.c                         |   14 ++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audmux.txt b/Documentation/devicetree/bindings/sound/imx-audmux.txt
new file mode 100644
index 0000000..215aa98
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audmux.txt
@@ -0,0 +1,13 @@
+Freescale Digital Audio Mux (AUDMUX) device
+
+Required properties:
+- compatible : "fsl,imx21-audmux" for AUDMUX version firstly used on i.MX21,
+  or "fsl,imx31-audmux" for the version firstly used on i.MX31.
+- reg : Should contain AUDMUX registers location and length
+
+Example:
+
+audmux at 021d8000 {
+	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
+	reg = <0x021d8000 0x4000>;
+};
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 87f8768..b83699d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -22,6 +22,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -197,6 +199,13 @@ static struct platform_device_id imx_audmux_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_audmux_ids);
 
+static const struct of_device_id imx_audmux_dt_ids[] = {
+	{ .compatible = "fsl,imx21-audmux", .data = &imx_audmux_ids[0], },
+	{ .compatible = "fsl,imx31-audmux", .data = &imx_audmux_ids[1], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_audmux_dt_ids);
+
 static const uint8_t port_mapping[] = {
 	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
 };
@@ -243,6 +252,8 @@ EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 static int __init imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	const struct of_device_id *of_id =
+			of_match_device(imx_audmux_dt_ids, &pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	audmux_base = devm_request_and_ioremap(&pdev->dev, res);
@@ -256,6 +267,8 @@ static int __init imx_audmux_probe(struct platform_device *pdev)
 		audmux_clk = NULL;
 	}
 
+	if (of_id)
+		pdev->id_entry = of_id->data;
 	audmux_type = pdev->id_entry->driver_data;
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_init();
@@ -279,6 +292,7 @@ static struct platform_driver imx_audmux_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = imx_audmux_dt_ids,
 	}
 };
 
-- 
1.7.5.4
