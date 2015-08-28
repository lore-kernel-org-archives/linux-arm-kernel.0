From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 11:31:50 +0100
Subject: [PATCH v2 3/4] remoteproc: Supply controller driver for ST's Remote
 Processors
In-Reply-To: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1440757911-9120-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/Kconfig         |   9 ++
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/st_remoteproc.c | 301 +++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)
 create mode 100644 drivers/remoteproc/st_remoteproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 28c711f..72e97d7 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -77,4 +77,13 @@ config DA8XX_REMOTEPROC
 	  It's safe to say n here if you're not interested in multimedia
 	  offloading.
 
+config ST_REMOTEPROC
+	tristate "ST remoteproc support"
+	depends on ARCH_STI
+	select REMOTEPROC
+	help
+	  Say y here to support ST's adjunct processors via the remote
+	  processor framework.
+	  This can be either built-in or a loadable module.
+
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 81b04d1..279cb2e 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
+obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
new file mode 100644
index 0000000..96b784d
--- /dev/null
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -0,0 +1,301 @@
+/*
+ * ST's Remote Processor Control Driver
+ *
+ * Copyright (C) 2015 STMicroelectronics - All Rights Reserved
+ *
+ * Author: Ludovic Barre <ludovic.barre@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/remoteproc.h>
+#include <linux/reset.h>
+
+struct st_rproc_config {
+	bool			sw_reset;
+	bool			pwr_reset;
+	u32			bootaddr_mask;
+};
+
+struct st_rproc {
+	struct st_rproc_config	*config;
+	struct reset_control	*sw_reset;
+	struct reset_control	*pwr_reset;
+	struct clk		*clk;
+	u32			clk_rate;
+	struct	regmap		*boot_base;
+	u32			boot_offset;
+};
+
+static int st_rproc_stop(struct rproc *rproc)
+{
+	struct st_rproc *st_rproc = rproc->priv;
+	int ret, err = 0;
+
+	if (st_rproc->config->sw_reset) {
+		ret = reset_control_assert(st_rproc->sw_reset);
+		if (ret)
+			dev_err(&rproc->dev, "Failed to assert S/W Reset\n");
+	}
+
+	if (st_rproc->config->pwr_reset) {
+		err = reset_control_assert(st_rproc->pwr_reset);
+		if (err)
+			dev_err(&rproc->dev, "Failed to assert Power Reset\n");
+	}
+
+	clk_disable(st_rproc->clk);
+
+	return ret ?: err;
+}
+
+static int st_rproc_start(struct rproc *rproc)
+{
+	struct st_rproc *st_rproc = rproc->priv;
+	int err;
+
+	regmap_update_bits(st_rproc->boot_base, st_rproc->boot_offset,
+			   st_rproc->config->bootaddr_mask, rproc->bootaddr);
+
+	err = clk_enable(st_rproc->clk);
+	if (err) {
+		dev_err(&rproc->dev, "Failed to enable clock\n");
+		return err;
+	}
+
+	if (st_rproc->config->sw_reset) {
+		err = reset_control_deassert(st_rproc->sw_reset);
+		if (err) {
+			dev_err(&rproc->dev, "Failed to deassert S/W Reset\n");
+			return err;
+		}
+	}
+
+	if (st_rproc->config->pwr_reset) {
+		err = reset_control_deassert(st_rproc->pwr_reset);
+		if (err) {
+			dev_err(&rproc->dev, "Failed to deassert Power Reset\n");
+			return err;
+		}
+	}
+
+	dev_info(&rproc->dev, "Started from 0x%x\n", rproc->bootaddr);
+
+	return 0;
+}
+
+static struct rproc_ops st_rproc_ops = {
+	.start		= st_rproc_start,
+	.stop		= st_rproc_stop,
+};
+
+/*
+ * Fetch state of the processor: 0 is off, 1 is on.
+ */
+static int st_rproc_state(struct st_rproc *st_rproc)
+{
+	int reset_sw, reset_pwr;
+
+	reset_sw = st_rproc->config->sw_reset ?
+		reset_control_status(st_rproc->sw_reset) : 0;
+
+	reset_pwr = st_rproc->config->pwr_reset ?
+		reset_control_status(st_rproc->pwr_reset) : 0;
+
+	if (reset_sw < 0 || reset_pwr < 0)
+		return -EINVAL;
+
+	return !reset_sw && !reset_pwr;
+}
+
+static const struct st_rproc_config st40_rproc_cfg = {
+	.sw_reset = true,
+	.pwr_reset = true,
+	.bootaddr_mask = GENMASK(28, 1),
+};
+
+static const struct st_rproc_config st231_rproc_cfg = {
+	.sw_reset = true,
+	.pwr_reset = false,
+	.bootaddr_mask = GENMASK(31, 6),
+};
+
+static struct of_device_id st_rproc_match[] = {
+	{ .compatible = "st,st40-rproc", .data = &st40_rproc_cfg },
+	{ .compatible = "st,st231-rproc", .data = &st231_rproc_cfg },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_rproc_match);
+
+static int st_rproc_parse_dt(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct st_rproc *st_rproc = rproc->priv;
+	struct device_node *np = dev->of_node;
+	struct resource	*mem;
+	int err;
+
+	if (st_rproc->config->sw_reset) {
+		st_rproc->sw_reset = devm_reset_control_get(dev, "sw_reset");
+		if (IS_ERR(st_rproc->sw_reset)) {
+			dev_err(dev, "Failed to get S/W Reset\n");
+			return PTR_ERR(st_rproc->sw_reset);
+		}
+	}
+
+	if (st_rproc->config->pwr_reset) {
+		st_rproc->pwr_reset = devm_reset_control_get(dev, "pwr_reset");
+		if (IS_ERR(st_rproc->pwr_reset)) {
+			dev_err(dev, "Failed to get Power Reset\n");
+			return PTR_ERR(st_rproc->pwr_reset);
+		}
+	}
+
+	st_rproc->clk = devm_clk_get(dev, "rproc_clk");
+	if (IS_ERR(st_rproc->clk)) {
+		dev_err(dev, "Failed to get clock\n");
+		return PTR_ERR(st_rproc->clk);
+	}
+
+	err = of_property_read_u32(np, "clock-frequency", &st_rproc->clk_rate);
+	if (err) {
+		dev_err(dev, "failed to get clock frequency\n");
+		return err;
+	}
+
+
+	st_rproc->boot_base =
+		syscon_regmap_lookup_by_phandle(np, "st,syscfg-boot");
+	if (!st_rproc->boot_base) {
+		dev_err(dev, "Boot base not found\n");
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32_index(np, "st,syscfg-boot", 1,
+					 &st_rproc->boot_offset);
+	if (err) {
+		dev_err(dev, "Boot offset not found\n");
+		return -EINVAL;
+	}
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "carveout");
+	if (!mem) {
+		dev_err(dev, "no rproc memory definition\n");
+		return -ENXIO;
+	}
+
+	if (!devm_request_mem_region(dev, mem->start,
+				     resource_size(mem), pdev->name)) {
+		dev_err(dev, "failed to get memory region resource\n");
+		return -EBUSY;
+	}
+	err = dmam_declare_coherent_memory(dev, mem->start, mem->start,
+					  resource_size(mem),
+					  DMA_MEMORY_MAP |
+					  DMA_MEMORY_EXCLUSIVE);
+	if (err < 0) {
+		dev_err(dev, "cannot declare coherent memory: %d\n", err);
+		return -ENXIO;
+	}
+
+	err = clk_prepare(st_rproc->clk);
+	if (err)
+		dev_err(dev, "failed to get clock\n");
+
+	return err;
+}
+
+static int st_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct st_rproc *st_rproc;
+	struct device_node *np = dev->of_node;
+	struct rproc *rproc;
+	int enabled;
+	int ret;
+
+	match = of_match_device((st_rproc_match), dev);
+	if (!match || !match->data) {
+		dev_err(dev, "No device match found\n");
+		return -ENODEV;
+	}
+
+	rproc = rproc_alloc(dev, np->name, &st_rproc_ops,
+			    NULL, sizeof(*st_rproc));
+	if (!rproc)
+		return -ENOMEM;
+
+	st_rproc = rproc->priv;
+	st_rproc->config = (struct st_rproc_config *)match->data;
+	platform_set_drvdata(pdev, rproc);
+
+	ret = st_rproc_parse_dt(pdev);
+	if (ret)
+		goto free_rproc;
+
+	ret = st_rproc_state(st_rproc);
+	if (ret < 0)
+		goto free_rproc;
+	enabled = ret;
+
+	if (enabled) {
+		atomic_inc(&rproc->power);
+		rproc->state = RPROC_RUNNING;
+	} else {
+		clk_set_rate(st_rproc->clk, st_rproc->clk_rate);
+	}
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto free_rproc;
+
+	return 0;
+
+free_rproc:
+	rproc_put(rproc);
+	return ret;
+}
+
+static int st_rproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct st_rproc *st_rproc = rproc->priv;
+
+	rproc_del(rproc);
+
+	clk_disable_unprepare(st_rproc->clk);
+
+	rproc_put(rproc);
+
+	return 0;
+}
+
+static struct platform_driver st_rproc_driver = {
+	.probe = st_rproc_probe,
+	.remove = st_rproc_remove,
+	.driver = {
+		.name = "st-rproc",
+		.of_match_table = of_match_ptr(st_rproc_match),
+	},
+};
+module_platform_driver(st_rproc_driver);
+
+MODULE_DESCRIPTION("ST Remote Processor Control Driver");
+MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
