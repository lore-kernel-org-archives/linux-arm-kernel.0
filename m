From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 6 Jul 2017 14:20:20 +0200
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the STM32 DMAMUX driver.

The DMAMUX request multiplexer allows routing a DMA request line between
the peripherals and the DMA controllers of the product. The routing
function is ensured by a programmable multi-channel DMA request line
multiplexer. Each channel selects a unique DMA request line,
unconditionally or synchronously with events from its DMAMUX
synchronization inputs. The DMAMUX may also be used as a DMA request
generator from programmable events on its input trigger signals

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v3:
        * change compatible to st,stm32h7-dmamux to be mode Soc specific
    v2:
        * Dynamic channelID allocation.
        * Change of_property_... by device_property.
        * New clock management.
        * DMAMUX Configuration API.
---
---
 drivers/dma/Kconfig              |   9 ++
 drivers/dma/Makefile             |   1 +
 drivers/dma/stm32-dmamux.c       | 253 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma/stm32-dmamux.h |  21 ++++
 4 files changed, 284 insertions(+)
 create mode 100644 drivers/dma/stm32-dmamux.c
 create mode 100644 include/linux/dma/stm32-dmamux.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fa8f9c0..34d9088 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -477,6 +477,15 @@ config STM32_DMA
 	  If you have a board based on such a MCU and wish to use DMA say Y
 	  here.
 
+config STM32_DMAMUX
+	bool "STMicroelectronics STM32 dma multiplexer support"
+	depends on STM32_DMA || COMPILE_TEST
+	help
+	  Enable support for the on-chip DMA multiplexer on STMicroelectronics
+	  STM32 MCUs.
+	  If you have a board based on such a MCU and wish to use DMAMUX say Y
+	  here.
+
 config S3C24XX_DMAC
 	bool "Samsung S3C24XX DMA support"
 	depends on ARCH_S3C24XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index d12ab29..96bd47e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SIRF_DMA) += sirf-dma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_STM32_DMA) += stm32-dma.o
+obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
 obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
new file mode 100644
index 0000000..d2756d5
--- /dev/null
+++ b/drivers/dma/stm32-dmamux.c
@@ -0,0 +1,253 @@
+/*
+ * DMA Router driver for STM32 DMA MUX
+ *
+ * Copyright (C) 2017 M'Boumba Cedric Madianga <cedric.madianga@gmail.com>
+ *
+ * Based on TI DMA Crossbar driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/dma/stm32-dmamux.h>
+
+#define STM32_DMAMUX_CCR(x)		(0x4 * (x))
+#define STM32_DMAMUX_MAX_CHANNELS	32
+#define STM32_DMAMUX_MAX_REQUESTS	255
+
+struct stm32_dmamux {
+	u32 request;
+	u32 chan_id;
+	bool busy;
+};
+
+struct stm32_dmamux_data {
+	struct dma_router dmarouter;
+	struct clk *clk;
+	struct reset_control *rst;
+	void __iomem *iomem;
+	u32 dmamux_requests; /* number of DMA requests connected to DMAMUX */
+	u32 dmamux_channels; /* Number of DMA channels supported */
+	spinlock_t lock; /* Protects register access */
+};
+
+static inline u32 stm32_dmamux_read(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void stm32_dmamux_write(void __iomem *iomem, u32 reg, u32 val)
+{
+	writel_relaxed(val, iomem + reg);
+}
+
+int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id)
+{
+	struct stm32_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct stm32_dmamux *mux = route_data;
+	u32 request = mux->request;
+	unsigned long flags;
+	int ret;
+
+	if (chan_id >= dmamux->dmamux_channels) {
+		dev_err(dev, "invalid channel id\n");
+		return -EINVAL;
+	}
+
+	/* Set dma request */
+	spin_lock_irqsave(&dmamux->lock, flags);
+	if (!IS_ERR(dmamux->clk)) {
+		ret = clk_enable(dmamux->clk);
+		if (ret < 0) {
+			spin_unlock_irqrestore(&dmamux->lock, flags);
+			dev_err(dev, "clk_prep_enable issue: %d\n", ret);
+			return ret;
+		}
+	}
+
+	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(chan_id), request);
+
+	mux->chan_id = chan_id;
+	mux->busy = true;
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dev_dbg(dev, "Mapping dma-router%dchan%d to request%d\n", dev->id,
+		mux->chan_id, mux->request);
+
+	return 0;
+}
+
+static void stm32_dmamux_free(struct device *dev, void *route_data)
+{
+	struct stm32_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct stm32_dmamux *mux = route_data;
+	unsigned long flags;
+
+	/* Clear dma request */
+	spin_lock_irqsave(&dmamux->lock, flags);
+	if (!mux->busy) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
+		goto end;
+	}
+
+	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
+	if (!IS_ERR(dmamux->clk))
+		clk_disable(dmamux->clk);
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dev_dbg(dev, "Unmapping dma-router%dchan%d (was routed to request%d)\n",
+		dev->id, mux->chan_id, mux->request);
+
+end:
+	kfree(mux);
+}
+
+static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct stm32_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct stm32_dmamux *mux;
+
+	if (dma_spec->args_count != 3) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (dma_spec->args[0] > dmamux->dmamux_requests) {
+		dev_err(&pdev->dev, "invalid mux request number: %d\n",
+			dma_spec->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* The of_node_put() will be done in of_dma_router_xlate function */
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux) {
+		of_node_put(dma_spec->np);
+		return ERR_PTR(-ENOMEM);
+	}
+	mux->request = dma_spec->args[0];
+
+	dma_spec->args[3] = dma_spec->args[2];
+	dma_spec->args[2] = dma_spec->args[1];
+	dma_spec->args[1] = 0;
+	dma_spec->args[0] = 0;
+	dma_spec->args_count = 4;
+
+	return mux;
+}
+
+static int stm32_dmamux_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *dma_node;
+	struct stm32_dmamux_data *stm32_dmamux;
+	struct resource *res;
+	void __iomem *iomem;
+	int i, ret;
+
+	if (!node)
+		return -ENODEV;
+
+	stm32_dmamux = devm_kzalloc(&pdev->dev, sizeof(*stm32_dmamux),
+				    GFP_KERNEL);
+	if (!stm32_dmamux)
+		return -ENOMEM;
+
+	dma_node = of_parse_phandle(node, "dma-masters", 0);
+	if (!dma_node) {
+		dev_err(&pdev->dev, "Can't get DMA master node\n");
+		return -ENODEV;
+	}
+
+	if (device_property_read_u32(&pdev->dev, "dma-channels",
+				     &stm32_dmamux->dmamux_channels))
+		stm32_dmamux->dmamux_channels = STM32_DMAMUX_MAX_CHANNELS;
+
+	if (device_property_read_u32(&pdev->dev, "dma-requests",
+				     &stm32_dmamux->dmamux_requests))
+		stm32_dmamux->dmamux_requests = STM32_DMAMUX_MAX_REQUESTS;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	iomem = devm_ioremap_resource(&pdev->dev, res);
+	if (!iomem)
+		return -ENOMEM;
+
+	spin_lock_init(&stm32_dmamux->lock);
+
+	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(stm32_dmamux->clk)) {
+		dev_info(&pdev->dev, "Missing controller clock\n");
+		return PTR_ERR(stm32_dmamux->clk);
+	}
+
+	stm32_dmamux->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(stm32_dmamux->rst)) {
+		reset_control_assert(stm32_dmamux->rst);
+		udelay(2);
+		reset_control_deassert(stm32_dmamux->rst);
+	}
+
+	stm32_dmamux->iomem = iomem;
+	stm32_dmamux->dmarouter.dev = &pdev->dev;
+	stm32_dmamux->dmarouter.route_free = stm32_dmamux_free;
+
+	platform_set_drvdata(pdev, stm32_dmamux);
+
+	if (!IS_ERR(stm32_dmamux->clk)) {
+		ret = clk_prepare_enable(stm32_dmamux->clk);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "clk_prep_enable issue: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Reset the dmamux */
+	for (i = 0; i < stm32_dmamux->dmamux_channels; i++)
+		stm32_dmamux_write(stm32_dmamux->iomem, STM32_DMAMUX_CCR(i), 0);
+
+	if (!IS_ERR(stm32_dmamux->clk))
+		clk_disable(stm32_dmamux->clk);
+
+	return of_dma_router_register(node, stm32_dmamux_route_allocate,
+				     &stm32_dmamux->dmarouter);
+}
+
+static const struct of_device_id stm32_dmamux_match[] = {
+	{ .compatible = "st,stm32h7-dmamux" },
+	{},
+};
+
+static struct platform_driver stm32_dmamux_driver = {
+	.probe	= stm32_dmamux_probe,
+	.driver = {
+		.name = "stm32-dmamux",
+		.of_match_table = stm32_dmamux_match,
+	},
+};
+
+static int __init stm32_dmamux_init(void)
+{
+	return platform_driver_register(&stm32_dmamux_driver);
+}
+arch_initcall(stm32_dmamux_init);
diff --git a/include/linux/dma/stm32-dmamux.h b/include/linux/dma/stm32-dmamux.h
new file mode 100644
index 0000000..3a4eae1
--- /dev/null
+++ b/include/linux/dma/stm32-dmamux.h
@@ -0,0 +1,21 @@
+/*
+ * stm32-dmamux.h
+ *
+ * Copyright (C) M'Boumba Cedric Madianga 2017
+ * Author:  M'Boumba Cedric Madianga <cedric.madianga@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef __DMA_STM32_DMAMUX_H
+#define __DMA_STM32_DMAMUX_H
+
+#if defined(CONFIG_STM32_DMAMUX)
+int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
+#else
+int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_STM32_DMAMUX */
+
+#endif /* __DMA_STM32_DMAMUX_H */
-- 
2.7.4
