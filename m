From: Ramiro.Oliveira@synopsys.com (Ramiro Oliveira)
Date: Wed, 14 Dec 2016 17:18:24 +0000
Subject: [PATCH 2/2] xilinx_dma: Add reset support
In-Reply-To: <cover.1481735244.git.roliveir@synopsys.com>
References: <cover.1481735244.git.roliveir@synopsys.com>
Message-ID: <4220c66c29d83bec1ded798ee383b5460c162cfc.1481735244.git.roliveir@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT property to control an optional external reset line

Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5c9f11b..b845224 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/reset.h>
 
 #include "../dmaengine.h"
 
@@ -409,6 +410,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	struct reset_control *rst;
 };
 
 /* Macros */
@@ -2543,6 +2545,27 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(xdev->regs))
 		return PTR_ERR(xdev->regs);
 
+	xdev->rst = devm_reset_control_get_optional(&pdev->dev, "reset");
+	if (IS_ERR(xdev->rst)) {
+		err = PTR_ERR(xdev->rst);
+		switch (err) {
+		case -ENOENT:
+		case -ENOTSUPP:
+			xdev->rst = NULL;
+		break;
+		default:
+			dev_err(xdev->dev, "error getting reset %d\n", err);
+		return err;
+		}
+	} else {
+		err = reset_control_deassert(xdev->rst);
+		if (err) {
+			dev_err(xdev->dev, "failed to deassert reset: %d\n",
+					err);
+			return err;
+		}
+	}
+
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
-- 
2.10.2
