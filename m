From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 12:35:29 +0100
Subject: [PATCH v3 5/8] staging: drm/imx: Use SRC to reset IPU
In-Reply-To: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1361273732-23357-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Request the System Reset Controller to reset the IPU if
specified via device tree phandle.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt    |    3 +++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c                |   12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index 07654f0..f769857 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -8,6 +8,8 @@ Required properties:
 - interrupts: Should contain sync interrupt and error interrupt,
   in this order.
 - #crtc-cells: 1, See below
+- resets: phandle pointing to the system reset controller and
+          reset line index, see reset/fsl,imx-src.txt for details
 
 example:
 
@@ -16,6 +18,7 @@ ipu: ipu at 18000000 {
 	compatible = "fsl,imx53-ipu";
 	reg = <0x18000000 0x080000000>;
 	interrupts = <11 10>;
+	resets = <&src 2>;
 };
 
 Parallel display support
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index 366f259..04b8320 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/reset.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/spinlock.h>
@@ -660,7 +661,7 @@ int ipu_idmac_disable_channel(struct ipuv3_channel *channel)
 }
 EXPORT_SYMBOL_GPL(ipu_idmac_disable_channel);
 
-static int ipu_reset(struct ipu_soc *ipu)
+static int ipu_memory_reset(struct ipu_soc *ipu)
 {
 	unsigned long timeout;
 
@@ -1104,7 +1105,12 @@ static int ipu_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_failed_irq;
 
-	ret = ipu_reset(ipu);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reset: %d\n", ret);
+		goto out_failed_reset;
+	}
+	ret = ipu_memory_reset(ipu);
 	if (ret)
 		goto out_failed_reset;
 
@@ -1130,8 +1136,8 @@ static int ipu_probe(struct platform_device *pdev)
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
