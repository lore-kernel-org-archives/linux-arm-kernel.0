From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 14:12:06 +0200
Subject: [PATCH 3/4] dmaengine: add driver for lpc18xx dmamux
In-Reply-To: <1436616727-4847-1-git-send-email-manabian@gmail.com>
References: <1436616727-4847-1-git-send-email-manabian@gmail.com>
Message-ID: <1436616727-4847-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for DMA on NXP LPC18xx/43xx platforms which has
a multiplexer in front of the PL080 dma request lines.

The mux is a single register in the LPC18xx/43xx CREG block
and can multiplex up to 4 request lines to each of the 16
lines on the PL080.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/dma/Kconfig          |   9 +++
 drivers/dma/Makefile         |   1 +
 drivers/dma/lpc18xx-dmamux.c | 183 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/dma/lpc18xx-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 88d474b78076..9d5a77cb9715 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -63,6 +63,15 @@ config AMBA_PL08X
 	  Platform has a PL08x DMAC device
 	  which can provide DMA engine support
 
+config LPC18XX_DMAMUX
+	bool "NXP LPC18xx/43xx DMA MUX for PL080"
+	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on OF && AMBA_PL08X
+	select MFD_SYSCON
+	help
+	  Enable support for DMA on NXP LPC18xx/43xx platforms
+	  with PL080 and multiplexed DMA request lines.
+
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
 	depends on PCI && X86
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 6a4d6f2827da..800cb2d20be8 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
+obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_PL330_DMA) += pl330.o
 obj-$(CONFIG_PCH_DMA) += pch_dma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
new file mode 100644
index 000000000000..761f32687055
--- /dev/null
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -0,0 +1,183 @@
+/*
+ * DMA Router driver for LPC18xx/43xx DMA MUX
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on TI DMA Crossbar driver by:
+ *   Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ *   Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+/* CREG register offset and macros for mux manipulation */
+#define LPC18XX_CREG_DMAMUX		0x11c
+#define LPC18XX_DMAMUX_VAL(v, n)	((v) << (n * 2))
+#define LPC18XX_DMAMUX_MASK(n)		(0x3 << (n * 2))
+#define LPC18XX_DMAMUX_MAX_VAL		0x3
+
+struct lpc18xx_dmamux {
+	u32 value;
+	bool busy;
+};
+
+struct lpc18xx_dmamux_data {
+	struct dma_router dmarouter;
+	struct lpc18xx_dmamux *muxes;
+	u32 dma_master_requests;
+	u32 dma_mux_requests;
+	struct regmap *reg;
+	spinlock_t lock;
+};
+
+static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
+{
+	struct lpc18xx_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct lpc18xx_dmamux *mux = route_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+	mux->busy = false;
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+}
+
+static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
+				    struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	unsigned long flags;
+	unsigned mux;
+
+	if (dma_spec->args_count != 3) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mux = dma_spec->args[0];
+	if (mux >= dmamux->dma_master_requests) {
+		dev_err(&pdev->dev, "invalid mux number: %d\n",
+			dma_spec->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (dma_spec->args[1] > LPC18XX_DMAMUX_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid dma mux value: %d\n",
+			dma_spec->args[1]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* The of_node_put() will be done in the core for the node */
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+	if (dmamux->muxes[mux].busy) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
+		dev_err(&pdev->dev, "dma request %u busy with %u.%u\n",
+			mux, mux, dmamux->muxes[mux].value);
+		of_node_put(dma_spec->np);
+		return ERR_PTR(-EBUSY);
+	}
+
+	dmamux->muxes[mux].busy = true;
+	dmamux->muxes[mux].value = dma_spec->args[1];
+
+	regmap_update_bits(dmamux->reg, LPC18XX_CREG_DMAMUX,
+			   LPC18XX_DMAMUX_MASK(mux),
+			   LPC18XX_DMAMUX_VAL(dmamux->muxes[mux].value, mux));
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dma_spec->args[1] = dma_spec->args[2];
+	dma_spec->args_count = 2;
+
+	dev_dbg(&pdev->dev, "mapping dmamux %u.%u to dma request %u\n", mux,
+		dmamux->muxes[mux].value, mux);
+
+	return &dmamux->muxes[mux];
+}
+
+static int lpc18xx_dmamux_probe(struct platform_device *pdev)
+{
+	struct device_node *dma_np, *np = pdev->dev.of_node;
+	struct lpc18xx_dmamux_data *dmamux;
+	int ret;
+
+	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	if (!dmamux)
+		return -ENOMEM;
+
+	dmamux->reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
+	if (IS_ERR(dmamux->reg)) {
+		dev_err(&pdev->dev, "syscon lookup failed\n");
+		return PTR_ERR(dmamux->reg);
+	}
+
+	ret = of_property_read_u32(np, "dma-requests",
+				   &dmamux->dma_mux_requests);
+	if (ret) {
+		dev_err(&pdev->dev, "missing dma-requests property\n");
+		return ret;
+	}
+
+	dma_np = of_parse_phandle(np, "dma-masters", 0);
+	if (!dma_np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(dma_np, "dma-requests",
+				   &dmamux->dma_master_requests);
+	of_node_put(dma_np);
+	if (ret) {
+		dev_err(&pdev->dev, "missing master dma-requests property\n");
+		return ret;
+	}
+
+	dmamux->muxes = devm_kcalloc(&pdev->dev, dmamux->dma_master_requests,
+				     sizeof(struct lpc18xx_dmamux),
+				     GFP_KERNEL);
+	if (!dmamux->muxes)
+		return -ENOMEM;
+
+	spin_lock_init(&dmamux->lock);
+	platform_set_drvdata(pdev, dmamux);
+	dmamux->dmarouter.dev = &pdev->dev;
+	dmamux->dmarouter.route_free = lpc18xx_dmamux_free;
+
+	return of_dma_router_register(np, lpc18xx_dmamux_reserve,
+				      &dmamux->dmarouter);
+}
+
+static const struct of_device_id lpc18xx_dmamux_match[] = {
+	{ .compatible = "nxp,lpc1850-dmamux" },
+	{},
+};
+
+static struct platform_driver lpc18xx_dmamux_driver = {
+	.probe	= lpc18xx_dmamux_probe,
+	.driver = {
+		.name = "lpc18xx-dmamux",
+		.of_match_table = lpc18xx_dmamux_match,
+	},
+};
+
+static int __init lpc18xx_dmamux_init(void)
+{
+	return platform_driver_register(&lpc18xx_dmamux_driver);
+}
+arch_initcall(lpc18xx_dmamux_init);
-- 
1.8.0
