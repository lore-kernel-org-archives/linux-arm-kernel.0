From: denis@eukrea.com (Denis Carikli)
Date: Mon,  4 Nov 2013 17:15:20 +0100
Subject: [PATCHv4][ 2/6] dma: ipu: Add devicetree support.
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
Message-ID: <1383581724-14817-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Synced the documentation with the code.

ChangeLog v2->v3:
- The DMA channels are not exposed anymore in order to look more like the IPUv3
  bindings.
---
 .../devicetree/bindings/dma/fsl-imx-ipu.txt        |   20 ++++++++++++++++++++
 drivers/dma/ipu/ipu_idmac.c                        |    8 ++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
new file mode 100644
index 0000000..2f3c976
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
@@ -0,0 +1,20 @@
+* Freescale Image Processing Unit (IPU) support for i.MX3x.
+
+This driver supports the imx31 and imx35 devices.
+
+Required properties:
+- compatible : Should be "fsl,imx31-ipu".
+- reg : Should contain IPU registers location and length.
+- interrupts : First item should be IPU interrupt, second one is optional and
+    should contain IPU Error interrupt.
+
+Example:
+
+	ipu: ipu at 53fc0000 {
+		compatible = "fsl,imx31-ipu";
+		reg = <	0x53fc0000 0x5f
+			0x53fc0088 0x2b >;
+		interrupts = <42 41>;
+		clocks = <&clks 55>;
+		clock-names = "";
+	};
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index cb9c0bc..d853ee1 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/dma/ipu-dma.h>
 
 #include "../dmaengine.h"
@@ -1768,6 +1769,12 @@ static int ipu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ipu_dma_of_dev_id[] = {
+	{ .compatible = "fsl,imx31-ipu", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ipu_dma_of_dev_id);
+
 /*
  * We need two MEM resources - with IPU-common and Image Converter registers,
  * including PF_CONF and IDMAC_* registers, and two IRQs - function and error
@@ -1775,6 +1782,7 @@ static int ipu_remove(struct platform_device *pdev)
 static struct platform_driver ipu_platform_driver = {
 	.driver = {
 		.name	= "ipu-core",
+		.of_match_table = of_match_ptr(ipu_dma_of_dev_id),
 		.owner	= THIS_MODULE,
 	},
 	.remove		= ipu_remove,
-- 
1.7.9.5
