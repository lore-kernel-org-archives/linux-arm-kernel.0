From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  9 Jan 2013 18:17:17 +0100
Subject: [RFC PATCH 3/5] staging: drm/imx: Use SRC to reset IPU
In-Reply-To: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1357751839-19680-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request the System Reset Controller to reset the IPU if
specified via device tree phandle.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 07654f0..e677f34 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -8,6 +8,8 @@ Required properties:
 - interrupts: Should contain sync interrupt and error interrupt,
   in this order.
 - #crtc-cells: 1, See below
+- reset: phandle pointing to the system reset controller and
+         reset line index, see reset/fsl,src.txt for details
 
 example:
 
@@ -16,6 +18,7 @@ ipu: ipu at 18000000 {
 	compatible = "fsl,imx53-ipu";
 	reg = <0x18000000 0x080000000>;
 	interrupts = <11 10>;
+	reset = <&src 2>;
 };
 
 Parallel display support
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index f7059cd..be972bf 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -28,6 +28,8 @@
 #include <linux/of_device.h>
 #include <asm/mach/irq.h>
 
+#include <linux/imx-src.h>
+
 #include "imx-ipu-v3.h"
 #include "ipu-prv.h"
 
@@ -660,7 +662,7 @@ int ipu_idmac_disable_channel(struct ipuv3_channel *channel)
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_disable_channel);
 
-static int ipu_reset(struct ipu_soc *ipu)
+static int ipu_memory_reset(struct ipu_soc *ipu)
 {
 	unsigned long timeout;
 
@@ -1022,6 +1024,7 @@ static int ipu_probe(struct platform_device *pdev)
 	unsigned long ipu_base;
 	int i, ret, irq_sync, irq_err;
 	const struct ipu_devtype *devtype;
+	struct of_phandle_args args;
 
 	devtype = of_id->data;
 
@@ -1104,7 +1107,18 @@ static int ipu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_failed_irq;
 
-	ret = ipu_reset(ipu);
+	ret = of_parse_phandle_with_args(pdev->dev.of_node,
+					 "reset", "#reset-cells", 0, &args);
+	if (ret || args.args_count <= 0) {
+		dev_warn(&pdev->dev, "failed to get reset controller\n");
+	} else {
+		ret = imx_src_reset(args.args[0]);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to reset: %d\n", ret);
+			goto out_failed_reset;
+		}
+	}
+	ret = ipu_memory_reset(ipu);
 	if (ret)
 		goto out_failed_reset;
 
@@ -1130,8 +1144,8 @@ static int ipu_probe(struct platform_device *pdev)
 failed_add_clients:
 	ipu_submodules_exit(ipu);
 failed_submodules_init:
-	ipu_irq_exit(ipu);
 out_failed_reset:
+	ipu_irq_exit(ipu);
 out_failed_irq:
 	clk_disable_unprepare(ipu->clk);
 failed_clk_get:
-- 
1.7.10.4
