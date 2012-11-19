From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:06 +0100
Subject: [PATCH 28/30] dma: mv_xor: add Device Tree binding
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-29-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch finally adds a Device Tree binding to the mv_xor
driver. Thanks to the previous cleanup patches, the Device Tree
binding is relatively simply: one DT node per XOR engine, with
sub-nodes for each XOR channel of the XOR engine. The binding
obviously comes with the necessary documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 Documentation/devicetree/bindings/dma/mv-xor.txt |   40 +++++++++++++++
 drivers/dma/mv_xor.c                             |   58 ++++++++++++++++++++--
 2 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mv-xor.txt

diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
new file mode 100644
index 0000000..7c6cb7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mv-xor.txt
@@ -0,0 +1,40 @@
+* Marvell XOR engines
+
+Required properties:
+- compatible: Should be "marvell,orion-xor"
+- reg: Should contain registers location and length (two sets)
+    the first set is the low registers, the second set the high
+    registers for the XOR engine.
+- clocks: pointer to the reference clock
+
+The DT node must also contains sub-nodes for each XOR channel that the
+XOR engine has. Those sub-nodes have the following required
+properties:
+- interrupts: interrupt of the XOR channel
+
+And the following optional properties:
+- dmacap,memcpy to indicate that the XOR channel is capable of memcpy operations
+- dmacap,memset to indicate that the XOR channel is capable of memset operations
+- dmacap,xor to indicate that the XOR channel is capable of xor operations
+
+Example:
+
+xor at d0060900 {
+	compatible = "marvell,orion-xor";
+	reg = <0xd0060900 0x100
+	       0xd0060b00 0x100>;
+	clocks = <&coreclk 0>;
+	status = "okay";
+
+	xor00 {
+	      interrupts = <51>;
+	      dmacap,memcpy;
+	      dmacap,xor;
+	};
+	xor01 {
+	      interrupts = <52>;
+	      dmacap,memcpy;
+	      dmacap,xor;
+	      dmacap,memset;
+	};
+};
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d48245c..b1c4edd 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -26,6 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/memory.h>
 #include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/platform_data/dma-mv_xor.h>
 
 #include "dmaengine.h"
@@ -1278,7 +1281,42 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!IS_ERR(xordev->clk))
 		clk_prepare_enable(xordev->clk);
 
-	if (pdata && pdata->channels) {
+	if (pdev->dev.of_node) {
+		struct device_node *np;
+		int i = 0;
+
+		for_each_child_of_node(pdev->dev.of_node, np) {
+			dma_cap_mask_t cap_mask;
+			int irq;
+
+			dma_cap_zero(cap_mask);
+			if (of_property_read_bool(np, "dmacap,memcpy"))
+				dma_cap_set(DMA_MEMCPY, cap_mask);
+			if (of_property_read_bool(np, "dmacap,xor"))
+				dma_cap_set(DMA_XOR, cap_mask);
+			if (of_property_read_bool(np, "dmacap,memset"))
+				dma_cap_set(DMA_MEMSET, cap_mask);
+			if (of_property_read_bool(np, "dmacap,interrupt"))
+				dma_cap_set(DMA_INTERRUPT, cap_mask);
+
+			irq = irq_of_parse_and_map(np, 0);
+			if (irq < 0) {
+				ret = irq;
+				goto err_channel_add;
+			}
+
+			xordev->channels[i] =
+				mv_xor_channel_add(xordev, pdev, i,
+						   cap_mask, irq);
+			if (IS_ERR(xordev->channels[i])) {
+				ret = PTR_ERR(xordev->channels[i]);
+				irq_dispose_mapping(irq);
+				goto err_channel_add;
+			}
+
+			i++;
+		}
+	} else if (pdata && pdata->channels) {
 		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
 			struct mv_xor_channel_data *cd;
 			int irq;
@@ -1309,8 +1347,11 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 err_channel_add:
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
-		if (xordev->channels[i])
+		if (xordev->channels[i]) {
+			if (pdev->dev.of_node)
+				irq_dispose_mapping(xordev->channels[i]->irq);
 			mv_xor_channel_remove(xordev->channels[i]);
+		}
 
 	clk_disable_unprepare(xordev->clk);
 	clk_put(xordev->clk);
@@ -1335,12 +1376,21 @@ static int mv_xor_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_xor_dt_ids[] __devinitdata = {
+       { .compatible = "marvell,orion-xor", },
+       {},
+};
+MODULE_DEVICE_TABLE(of, mv_xor_dt_ids);
+#endif
+
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
 	.remove		= mv_xor_remove,
 	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= MV_XOR_NAME,
+		.owner	        = THIS_MODULE,
+		.name	        = MV_XOR_NAME,
+		.of_match_table = of_match_ptr(mv_xor_dt_ids),
 	},
 };
 
-- 
1.7.9.5
