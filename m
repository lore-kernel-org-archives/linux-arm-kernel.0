From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jul 2015 17:11:25 +0100
Subject: [PATCH 4/7] dmaengine: st_fdma: Add xbar support
In-Reply-To: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1436371888-27863-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To increase the number of peripheral requests, the FDMA crossbar
can multiplex up to 96 peripheral requests to one of 3 fdma
controllers.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/Kconfig        |  11 ++++
 drivers/dma/Makefile       |   1 +
 drivers/dma/st_fdma.c      |  25 +++++++-
 drivers/dma/st_fdma.h      |  32 ++++++++++
 drivers/dma/st_fdma_xbar.c | 149 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 216 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/st_fdma_xbar.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7a016e0..21802b1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -522,4 +522,15 @@ config ST_FDMA
 	  Say Y here if you have such a chipset.
 	  If unsure, say N.
 
+config ST_FDMA_XBAR
+	bool "ST FDMA crossbar"
+	depends on ST_FDMA
+	default y
+	help
+	  Enable support for ST FDMA crossbar.
+	  xbar add flexibility and increase the number of peripheral request
+	  can be used by fdma xbar can multiplex until 96 peripheral requests
+	  to one of 3 fdma controller
+
+
 endif
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f68e6d8..19f18b1 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
 obj-$(CONFIG_QCOM_BAM_DMA) += qcom_bam_dma.o
+obj-$(CONFIG_ST_FDMA_XBAR) += st_fdma_xbar.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-y += xilinx/
 obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 07a6df1..a870902 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -336,7 +336,9 @@ static int st_fdma_dreq_get(struct st_fdma_chan *fchan)
 			return -EINVAL;
 		}
 
-		if (try || req_line_cfg >= ST_FDMA_NR_DREQS) {
+		if (fdev->xbar_dev)
+			dreq_line = ffz(fdev->dreq_mask);
+		else if (try || req_line_cfg >= ST_FDMA_NR_DREQS) {
 			dev_err(fdev->dev, "Invalid or used req line\n");
 			return -EINVAL;
 		} else {
@@ -903,6 +905,15 @@ static int st_fdma_slave_config(struct dma_chan *chan,
 	else
 		return -EINVAL;
 
+	if (fdev->xbar_dev) {
+		if (st_fdma_xbar_mux(fdev->xbar_dev, fchan->cfg.req_line,
+				     fchan->dreq_line)) {
+			dev_err(fdev->dev, "Error routing req line\n");
+			clear_bit(fchan->dreq_line, &fdev->dreq_mask);
+			return -EINVAL;
+		}
+	}
+
 	fchan->cfg.req_ctrl |= REQ_CTRL_NUM_OPS(maxburst-1);
 	dreq_write(fchan, fchan->cfg.req_ctrl, REQ_CTRL);
 
@@ -1044,6 +1055,13 @@ static int st_fdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
+	fdev->xbar_dev = st_fdma_xbar_request(&pdev->dev);
+	if (IS_ERR(fdev->xbar_dev)) {
+		dev_err(&pdev->dev, "Failed to request xbar:%ld\n",
+			PTR_ERR(fdev->xbar_dev));
+		goto err_clk;
+	}
+
 	/* Initialise the FDMA dreq (reserve 0 & 31 for FDMA use) */
 	fdev->dreq_mask = BIT(0) | BIT(31);
 
@@ -1081,7 +1099,10 @@ static int st_fdma_probe(struct platform_device *pdev)
 		goto err_dma_dev;
 	}
 
-	dev_info(&pdev->dev, "ST FDMA engine driver, irq:%d\n", irq);
+	dev_info(&pdev->dev, "ST FDMA engine driver, irq:%d xbar(%s, id:%d)\n",
+		 irq, fdev->xbar_dev ?
+		 dev_name(&fdev->xbar_dev->pdev->dev) : "no",
+		 fdev->xbar_dev ? fdev->xbar_dev->fdma_id : 0);
 
 	return 0;
 
diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index 533c811..dd46780 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -17,6 +17,20 @@
 #define ST_FDMA_NR_DREQS 32
 #define EM_SLIM	102	/* No official SLIM ELF ID */
 
+struct st_fdma_xbar {
+	void __iomem *io_base;
+	struct clk *clk;
+	u32 nr_requests;
+	u32 max_nr_requests;
+};
+
+struct st_fdma_xbar_dev {
+	struct platform_device *pdev;
+	struct st_fdma_xbar *xbar;
+	struct device *fdev;
+	u32 fdma_id;
+};
+
 enum {
 	CLK_SLIM,
 	CLK_HI,
@@ -135,6 +149,7 @@ struct st_fdma_dev {
 
 	struct st_fdma_chan *chans;
 
+	struct st_fdma_xbar_dev *xbar_dev;
 	spinlock_t dreq_lock;
 	unsigned long dreq_mask;
 
@@ -142,6 +157,23 @@ struct st_fdma_dev {
 	atomic_t fw_loaded;
 };
 
+#if defined(CONFIG_ST_FDMA_XBAR)
+struct st_fdma_xbar_dev *st_fdma_xbar_request(struct device *device);
+int st_fdma_xbar_mux(struct st_fdma_xbar_dev *xbar_dev,
+		     u32 in_dreq, u32 fdma_dreq);
+#else
+struct st_fdma_xbar_dev *st_fdma_xbar_request(struct device *device)
+{
+	return NULL;
+}
+
+int st_fdma_xbar_mux(struct st_fdma_xbar_dev *xbar_dev,
+		     u32 in_dreq, u32 fdma_dreq)
+{
+	return -ENODEV;
+}
+#endif
+
 /* Registers*/
 /* FDMA interface */
 #define FDMA_ID_OFST		0x00000
diff --git a/drivers/dma/st_fdma_xbar.c b/drivers/dma/st_fdma_xbar.c
new file mode 100644
index 0000000..c3b8e0f
--- /dev/null
+++ b/drivers/dma/st_fdma_xbar.c
@@ -0,0 +1,149 @@
+/*
+ * st_fdma_xbar.c
+ *
+ * Copyright (C) 2014 STMicroelectronics
+ * Author: Ludovic Barre <Ludovic.barre@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "st_fdma.h"
+
+#define XBAR_1_0_MAX_REQ	96
+
+int st_fdma_xbar_mux(struct st_fdma_xbar_dev *xbar_dev,
+		     u32 per_req, u32 fdma_req)
+{
+	u32 out_req;
+
+	if (per_req >= xbar_dev->xbar->nr_requests)
+		return -EINVAL;
+
+	out_req = (xbar_dev->fdma_id * ST_FDMA_NR_DREQS) + fdma_req;
+	writel(per_req, xbar_dev->xbar->io_base + (out_req << 2));
+
+	dev_dbg(&xbar_dev->pdev->dev, "in_req:%d out_req:%d\n",
+		per_req, out_req);
+
+	return 0;
+}
+
+struct st_fdma_xbar_dev *st_fdma_xbar_request(struct device *device)
+{
+	struct device_node *np = device->of_node;
+	struct st_fdma_xbar_dev *xbar_dev;
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(np, "st,fdma-xbar",
+					 "#st,fdma-xbar-cells", 0, &args);
+	if (err)
+		return NULL;
+
+	xbar_dev = kzalloc(sizeof(*xbar_dev), GFP_KERNEL);
+	if (!xbar_dev) {
+		of_node_put(args.np);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	xbar_dev->pdev = of_find_device_by_node(args.np);
+	if (!xbar_dev->pdev) {
+		of_node_put(args.np);
+		err = -ENODEV;
+		goto free;
+	}
+
+	of_node_put(args.np);
+
+	xbar_dev->xbar = platform_get_drvdata(xbar_dev->pdev);
+	if (!xbar_dev->xbar) {
+		err = -EPROBE_DEFER;
+		goto pdev_put;
+	}
+
+	xbar_dev->fdma_id = args.args[0];
+	xbar_dev->fdev = device;
+
+	return xbar_dev;
+
+pdev_put:
+	platform_device_put(xbar_dev->pdev);
+free:
+	kfree(xbar_dev);
+out:
+	return ERR_PTR(err);
+}
+
+void st_fdma_xbar_free(struct st_fdma_xbar_dev *device)
+{
+	platform_device_put(device->pdev);
+	kfree(device);
+}
+
+static const struct of_device_id st_fdma_xbar_match[] = {
+	{ .compatible = "st,fdma-xbar-1.0", .data = (void *)XBAR_1_0_MAX_REQ },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_fdma_xbar_match);
+
+static int st_fdma_xbar_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device_node *np = pdev->dev.of_node;
+	struct st_fdma_xbar *xbar;
+	struct resource *res;
+
+	match = of_match_device((st_fdma_xbar_match), &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "No device match found\n");
+		return -ENODEV;
+	}
+
+	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
+	if (!xbar)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xbar->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xbar->io_base))
+		return PTR_ERR(xbar->io_base);
+
+	xbar->max_nr_requests = (unsigned long)match->data;
+
+	if (of_property_read_u32(np, "dma-requests", &xbar->nr_requests))
+		xbar->nr_requests = xbar->max_nr_requests;
+
+	if (xbar->nr_requests > xbar->max_nr_requests) {
+		dev_err(&pdev->dev, "Nr requests not supported\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, xbar);
+
+	return 0;
+}
+
+static int st_fdma_xbar_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver st_fdma_xbar_driver = {
+	.driver	= {
+		.name = "st-fdma-xbar",
+		.of_match_table = st_fdma_xbar_match,
+	},
+	.probe = st_fdma_xbar_probe,
+	.remove = st_fdma_xbar_remove,
+};
+module_platform_driver(st_fdma_xbar_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("STMicroelectronics FDMA cross bar");
+MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
-- 
1.9.1
