From: angelo@sysam.it (Angelo Dureghello)
Date: Sat, 11 Aug 2018 13:26:49 +0200
Subject: [PATCH v9 4/4] dmaengine: fsl-edma: add ColdFire mcf5441x edma support
In-Reply-To: <20180811112649.20752-1-angelo@sysam.it>
References: <20180811112649.20752-1-angelo@sysam.it>
Message-ID: <20180811112649.20752-4-angelo@sysam.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ColdFire mcf5441x-family edma
module.

The ColdFire edma module is slightly different from fsl-edma,
so a new driver is added. But most of the code is common
between fsl-edma and mcf-edma so it has been collected into a
separate common module fsl-edma-common (patch 1/3).

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
---
Changes for v8:
- patch rewritten from scratch, this patch (3/3) has just been added.

Changes for v9:
- add compile test for Kconfig,
- fix include guard.
---
 drivers/dma/Kconfig                        |  11 +
 drivers/dma/Makefile                       |   1 +
 drivers/dma/fsl-edma-common.c              |  24 +-
 drivers/dma/mcf-edma.c                     | 315 +++++++++++++++++++++
 include/linux/platform_data/dma-mcf-edma.h |  38 +++
 5 files changed, 385 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dma/mcf-edma.c
 create mode 100644 include/linux/platform_data/dma-mcf-edma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ca1680afa20a..45ca5e556774 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -320,6 +320,17 @@ config LPC18XX_DMAMUX
 	  Enable support for DMA on NXP LPC18xx/43xx platforms
 	  with PL080 and multiplexed DMA request lines.
 
+config MCF_EDMA
+	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
+	depends on M5441x || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the Freescale ColdFire eDMA engine, 64-channel
+	  implementation that performs complex data transfers with
+	  minimal intervention from a host processor.
+	  This module can be found on Freescale ColdFire mcf5441x SoCs.
+
 config MMP_PDMA
 	bool "MMP PDMA support"
 	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 66022f59fca4..d97f317f4b34 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
+obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
 obj-$(CONFIG_HSU_DMA) += hsu/
 obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 227034de256e..8ba80f4b6f55 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -46,8 +46,16 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
-	edma_writeb(fsl_chan->edma, ch, regs->serq);
+	if (fsl_chan->edma->version == v1) {
+		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
+		edma_writeb(fsl_chan->edma, ch, regs->serq);
+	} else {
+		/* ColdFire is big endian, and accesses natively
+		 * big endian I/O peripherals
+		 */
+		iowrite8(EDMA_SEEI_SEEI(ch), regs->seei);
+		iowrite8(ch, regs->serq);
+	}
 }
 
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
@@ -55,8 +63,16 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	edma_writeb(fsl_chan->edma, ch, regs->cerq);
-	edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
+	if (fsl_chan->edma->version == v1) {
+		edma_writeb(fsl_chan->edma, ch, regs->cerq);
+		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
+	} else {
+		/* ColdFire is big endian, and accesses natively
+		 * big endian I/O peripherals
+		 */
+		iowrite8(ch, regs->cerq);
+		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
new file mode 100644
index 000000000000..d4b2fd871ff4
--- /dev/null
+++ b/drivers/dma/mcf-edma.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2013-2014 Freescale Semiconductor, Inc
+// Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/dma-mcf-edma.h>
+
+#include "fsl-edma-common.h"
+
+#define EDMA_CHANNELS		64
+#define EDMA_MASK_CH(x)		((x) & GENMASK(5, 0))
+
+static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *mcf_edma = dev_id;
+	struct edma_regs *regs = &mcf_edma->regs;
+	unsigned int ch;
+	struct fsl_edma_chan *mcf_chan;
+	u64 intmap;
+
+	intmap = ioread32(regs->inth);
+	intmap <<= 32;
+	intmap |= ioread32(regs->intl);
+	if (!intmap)
+		return IRQ_NONE;
+
+	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
+		if (intmap & BIT(ch)) {
+			iowrite8(EDMA_MASK_CH(ch), regs->cint);
+
+			mcf_chan = &mcf_edma->chans[ch];
+
+			spin_lock(&mcf_chan->vchan.lock);
+			if (!mcf_chan->edesc->iscyclic) {
+				list_del(&mcf_chan->edesc->vdesc.node);
+				vchan_cookie_complete(&mcf_chan->edesc->vdesc);
+				mcf_chan->edesc = NULL;
+				mcf_chan->status = DMA_COMPLETE;
+				mcf_chan->idle = true;
+			} else {
+				vchan_cyclic_callback(&mcf_chan->edesc->vdesc);
+			}
+
+			if (!mcf_chan->edesc)
+				fsl_edma_xfer_desc(mcf_chan);
+
+			spin_unlock(&mcf_chan->vchan.lock);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *mcf_edma = dev_id;
+	struct edma_regs *regs = &mcf_edma->regs;
+	unsigned int err, ch;
+
+	err = ioread32(regs->errl);
+	if (!err)
+		return IRQ_NONE;
+
+	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
+		if (err & BIT(ch)) {
+			fsl_edma_disable_request(&mcf_edma->chans[ch]);
+			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
+			mcf_edma->chans[ch].status = DMA_ERROR;
+			mcf_edma->chans[ch].idle = true;
+		}
+	}
+
+	err = ioread32(regs->errh);
+	if (!err)
+		return IRQ_NONE;
+
+	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
+		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
+			fsl_edma_disable_request(&mcf_edma->chans[ch]);
+			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
+			mcf_edma->chans[ch].status = DMA_ERROR;
+			mcf_edma->chans[ch].idle = true;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mcf_edma_irq_init(struct platform_device *pdev,
+				struct fsl_edma_engine *mcf_edma)
+{
+	int ret = 0, i;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev,
+				IORESOURCE_IRQ, "edma-tx-00-15");
+	if (!res)
+		return -1;
+
+	for (ret = 0, i = res->start; i <= res->end; ++i)
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	if (ret)
+		return ret;
+
+	res = platform_get_resource_byname(pdev,
+			IORESOURCE_IRQ, "edma-tx-16-55");
+	if (!res)
+		return -1;
+
+	for (ret = 0, i = res->start; i <= res->end; ++i)
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	if (ret)
+		return ret;
+
+	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
+	if (ret != -ENXIO) {
+		ret = request_irq(ret, mcf_edma_tx_handler,
+				  0, "eDMA", mcf_edma);
+		if (ret)
+			return ret;
+	}
+
+	ret = platform_get_irq_byname(pdev, "edma-err");
+	if (ret != -ENXIO) {
+		ret = request_irq(ret, mcf_edma_err_handler,
+				  0, "eDMA", mcf_edma);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void mcf_edma_irq_free(struct platform_device *pdev,
+				struct fsl_edma_engine *mcf_edma)
+{
+	int irq;
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev,
+			IORESOURCE_IRQ, "edma-tx-00-15");
+	if (res) {
+		for (irq = res->start; irq <= res->end; irq++)
+			free_irq(irq, mcf_edma);
+	}
+
+	res = platform_get_resource_byname(pdev,
+			IORESOURCE_IRQ, "edma-tx-16-55");
+	if (res) {
+		for (irq = res->start; irq <= res->end; irq++)
+			free_irq(irq, mcf_edma);
+	}
+
+	irq = platform_get_irq_byname(pdev, "edma-tx-56-63");
+	if (irq != -ENXIO)
+		free_irq(irq, mcf_edma);
+
+	irq = platform_get_irq_byname(pdev, "edma-err");
+	if (irq != -ENXIO)
+		free_irq(irq, mcf_edma);
+}
+
+static int mcf_edma_probe(struct platform_device *pdev)
+{
+	struct mcf_edma_platform_data *pdata;
+	struct fsl_edma_engine *mcf_edma;
+	struct fsl_edma_chan *mcf_chan;
+	struct edma_regs *regs;
+	struct resource *res;
+	int ret, i, len, chans;
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata)
+		return PTR_ERR(pdata);
+
+	chans = pdata->dma_channels;
+	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
+	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!mcf_edma)
+		return -ENOMEM;
+
+	mcf_edma->n_chans = chans;
+
+	/* Set up version for ColdFire edma */
+	mcf_edma->version = v2;
+	mcf_edma->big_endian = 1;
+
+	if (!mcf_edma->n_chans) {
+		dev_info(&pdev->dev, "setting default channel number to 64");
+		mcf_edma->n_chans = 64;
+	}
+
+	mutex_init(&mcf_edma->fsl_edma_mutex);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	mcf_edma->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mcf_edma->membase))
+		return PTR_ERR(mcf_edma->membase);
+
+	fsl_edma_setup_regs(mcf_edma);
+	regs = &mcf_edma->regs;
+
+	INIT_LIST_HEAD(&mcf_edma->dma_dev.channels);
+	for (i = 0; i < mcf_edma->n_chans; i++) {
+		struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
+
+		mcf_chan->edma = mcf_edma;
+		mcf_chan->slave_id = i;
+		mcf_chan->idle = true;
+		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
+		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
+		iowrite32(0x0, &regs->tcd[i].csr);
+	}
+
+	iowrite32(~0, regs->inth);
+	iowrite32(~0, regs->intl);
+
+	ret = mcf_edma_irq_init(pdev, mcf_edma);
+	if (ret)
+		return ret;
+
+	dma_cap_set(DMA_PRIVATE, mcf_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_SLAVE, mcf_edma->dma_dev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, mcf_edma->dma_dev.cap_mask);
+
+	mcf_edma->dma_dev.dev = &pdev->dev;
+	mcf_edma->dma_dev.device_alloc_chan_resources =
+			fsl_edma_alloc_chan_resources;
+	mcf_edma->dma_dev.device_free_chan_resources =
+			fsl_edma_free_chan_resources;
+	mcf_edma->dma_dev.device_config = fsl_edma_slave_config;
+	mcf_edma->dma_dev.device_prep_dma_cyclic =
+			fsl_edma_prep_dma_cyclic;
+	mcf_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
+	mcf_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
+	mcf_edma->dma_dev.device_pause = fsl_edma_pause;
+	mcf_edma->dma_dev.device_resume = fsl_edma_resume;
+	mcf_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
+	mcf_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
+
+	mcf_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
+	mcf_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
+	mcf_edma->dma_dev.directions =
+			BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+
+	mcf_edma->dma_dev.filter.fn = mcf_edma_filter_fn;
+	mcf_edma->dma_dev.filter.map = pdata->slave_map;
+	mcf_edma->dma_dev.filter.mapcnt = pdata->slavecnt;
+
+	platform_set_drvdata(pdev, mcf_edma);
+
+	ret = dma_async_device_register(&mcf_edma->dma_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA engine. (%d)\n", ret);
+		return ret;
+	}
+
+	/* Enable round robin arbitration */
+	iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+
+	return 0;
+}
+
+static int mcf_edma_remove(struct platform_device *pdev)
+{
+	struct fsl_edma_engine *mcf_edma = platform_get_drvdata(pdev);
+
+	mcf_edma_irq_free(pdev, mcf_edma);
+	fsl_edma_cleanup_vchan(&mcf_edma->dma_dev);
+	dma_async_device_unregister(&mcf_edma->dma_dev);
+
+	return 0;
+}
+
+static struct platform_driver mcf_edma_driver = {
+	.driver		= {
+		.name	= "mcf-edma",
+	},
+	.probe		= mcf_edma_probe,
+	.remove		= mcf_edma_remove,
+};
+
+bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
+{
+	if (chan->device->dev->driver == &mcf_edma_driver.driver) {
+		struct fsl_edma_chan *mcf_chan = to_fsl_edma_chan(chan);
+
+		return (mcf_chan->slave_id == (int)param);
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(mcf_edma_filter_fn);
+
+static int __init mcf_edma_init(void)
+{
+	return platform_driver_register(&mcf_edma_driver);
+}
+subsys_initcall(mcf_edma_init);
+
+static void __exit mcf_edma_exit(void)
+{
+	platform_driver_unregister(&mcf_edma_driver);
+}
+module_exit(mcf_edma_exit);
+
+MODULE_ALIAS("platform:mcf-edma");
+MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/dma-mcf-edma.h b/include/linux/platform_data/dma-mcf-edma.h
new file mode 100644
index 000000000000..d718ccfa3421
--- /dev/null
+++ b/include/linux/platform_data/dma-mcf-edma.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Freescale eDMA platform data, ColdFire SoC's family.
+ *
+ * Copyright (c) 2017 Angelo Dureghello <angelo@sysam.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_MCF_EDMA_H__
+#define __LINUX_PLATFORM_DATA_MCF_EDMA_H__
+
+struct dma_slave_map;
+
+bool mcf_edma_filter_fn(struct dma_chan *chan, void *param);
+
+#define MCF_EDMA_FILTER_PARAM(ch)	((void *)ch)
+
+/**
+ * struct mcf_edma_platform_data - platform specific data for eDMA engine
+ *
+ * @ver			The eDMA module version.
+ * @dma_channels	The number of eDMA channels.
+ */
+struct mcf_edma_platform_data {
+	int dma_channels;
+	const struct dma_slave_map *slave_map;
+	int slavecnt;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_MCF_EDMA_H__ */
-- 
2.18.0
