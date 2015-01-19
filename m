From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 19 Jan 2015 11:30:20 +0100
Subject: [PATCH 2/2] remoteproc: microblaze: Add support for microblaze on Zynq
In-Reply-To: <a458462d2dc6901440bded015608f7a9df9e7942.1421662385.git.michal.simek@xilinx.com>
References: <a458462d2dc6901440bded015608f7a9df9e7942.1421662385.git.michal.simek@xilinx.com>
Message-ID: <10276362c737fc9da863f1a07737fd91f7340242.1421662385.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xilinx Microblaze is placed in programmable logic on Xilinx
Zynq architecture. Driver requires specific HW setting
described in DT binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 MAINTAINERS                        |   1 +
 drivers/remoteproc/Kconfig         |  11 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/mb_remoteproc.c | 425 +++++++++++++++++++++++++++++++++++++
 4 files changed, 438 insertions(+)
 create mode 100644 drivers/remoteproc/mb_remoteproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ab6610e6c610..b683990e0ca1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,7 @@ N:	xilinx
 F:	drivers/clocksource/cadence_ttc_timer.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
+F:	drivers/remoteproc/mb_remoteproc.c

 ARM SMMU DRIVER
 M:	Will Deacon <will.deacon@arm.com>
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 5e343bab9458..3955f42e9e9c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -64,4 +64,15 @@ config DA8XX_REMOTEPROC
 	  It's safe to say n here if you're not interested in multimedia
 	  offloading.

+config MB_REMOTEPROC
+	tristate "Support Microblaze remoteproc"
+	depends on ARCH_ZYNQ && !DEBUG_SG
+	select GPIO_XILINX
+	select REMOTEPROC
+	select RPMSG
+	default m
+	help
+	  Say y here to support Xilinx Microblaze remote processors
+	  on the Xilinx Zynq.
+
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index ac2ff75686d2..40e247ffac34 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,3 +10,4 @@ remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
+obj-$(CONFIG_MB_REMOTEPROC)		+= mb_remoteproc.o
diff --git a/drivers/remoteproc/mb_remoteproc.c b/drivers/remoteproc/mb_remoteproc.c
new file mode 100644
index 000000000000..699301c65dfd
--- /dev/null
+++ b/drivers/remoteproc/mb_remoteproc.c
@@ -0,0 +1,425 @@
+/*
+ * Microblaze Remote Processor driver
+ *
+ * Copyright (C) 2012 - 2015 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2013 - 2015 Xilinx, Inc.
+ * Copyright (C) 2012 PetaLogix
+ *
+ * Based on origin OMAP Remote Processor driver
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/remoteproc.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
+#include <asm/outercache.h>
+#include <asm/cacheflush.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+
+#include "remoteproc_internal.h"
+
+/* Module parameter */
+static char *firmware;
+
+/* Private data */
+struct mb_rproc_pdata {
+	struct rproc *rproc;
+	u32 mem_start;
+	u32 mem_end;
+	int reset_gpio;
+	int mb_debug_gpio;
+	int ipi;
+	int vring0;
+	int vring1;
+	void __iomem *vbase;
+	const unsigned char *bootloader;
+};
+
+/* Store rproc for IPI handler */
+static struct platform_device *remoteprocdev;
+static struct work_struct workqueue;
+
+static void handle_event(struct work_struct *work)
+{
+	struct mb_rproc_pdata *local = platform_get_drvdata(remoteprocdev);
+
+	flush_cache_all();
+	outer_flush_range(local->mem_start, local->mem_end);
+
+	if (rproc_vq_interrupt(local->rproc, 0) == IRQ_NONE)
+		dev_info(&remoteprocdev->dev, "no message found in vqid 0\n");
+}
+
+static irqreturn_t ipi_kick(int irq, void *dev_id)
+{
+	dev_dbg(&remoteprocdev->dev, "KICK Linux because of pending message\n");
+	schedule_work(&workqueue);
+	dev_dbg(&remoteprocdev->dev, "KICK Linux handled\n");
+
+	return IRQ_HANDLED;
+}
+
+static int mb_rproc_start(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mb_rproc_pdata *local = platform_get_drvdata(pdev);
+	const struct firmware *fw;
+	int ret;
+
+	dev_info(dev, "%s\n", __func__);
+	INIT_WORK(&workqueue, handle_event);
+
+	flush_cache_all();
+	outer_flush_range(local->mem_start, local->mem_end);
+
+	remoteprocdev = pdev;
+
+	ret = request_firmware(&fw, local->bootloader, &pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "request_firmware failed\n");
+		return ret;
+	}
+	/* Copy bootloader to memory */
+	memcpy(local->vbase, fw->data, fw->size);
+	release_firmware(fw);
+
+	/* Just for sure synchronize memories */
+	dsb();
+
+	/* Release Microblaze from reset */
+	gpio_set_value(local->reset_gpio, 0);
+
+	return 0;
+}
+
+/* kick a firmware */
+static void mb_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct device *dev = rproc->dev.parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mb_rproc_pdata *local = platform_get_drvdata(pdev);
+
+	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
+
+	flush_cache_all();
+	outer_flush_all();
+
+	/* Send swirq to firmware */
+	gpio_set_value(local->vring0, 0);
+	gpio_set_value(local->vring1, 0);
+	dsb();
+
+	if (!vqid) {
+		udelay(500);
+		gpio_set_value(local->vring0, 1);
+		dsb();
+	} else {
+		udelay(100);
+		gpio_set_value(local->vring1, 1);
+		dsb();
+	}
+}
+
+/* power off the remote processor */
+static int mb_rproc_stop(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mb_rproc_pdata *local = platform_get_drvdata(pdev);
+
+	/* Setup MB to the state where all memory transactions are done */
+	gpio_set_value(local->mb_debug_gpio, 1);
+	dsb(); /* Be sure that this write has been done */
+	/*
+	 * This should be enough to ensure one CLK as
+	 * it is written in MB ref guide
+	 */
+	gpio_set_value(local->mb_debug_gpio, 0);
+
+	udelay(1000); /* Wait some time to finish all mem transactions */
+
+	/* Add Microblaze to reset state */
+	gpio_set_value(local->reset_gpio, 1);
+
+	/* No reason to wait that operations where done */
+	return 0;
+}
+
+static struct rproc_ops mb_rproc_ops = {
+	.start		= mb_rproc_start,
+	.stop		= mb_rproc_stop,
+	.kick		= mb_rproc_kick,
+};
+
+/* Just to detect bug if interrupt forwarding is broken */
+static irqreturn_t mb_remoteproc_interrupt(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+
+	dev_err(dev, "GIC IRQ %d is not forwarded correctly\n", irq);
+
+	return IRQ_HANDLED;
+}
+
+static int mb_remoteproc_probe(struct platform_device *pdev)
+{
+	const unsigned char *prop;
+	struct platform_device *bram_pdev;
+	struct device_node *bram_dev;
+	struct resource *res; /* IO mem resources */
+	int ret = 0;
+	int count = 0;
+	struct mb_rproc_pdata *local;
+
+	local = devm_kzalloc(&pdev->dev, sizeof(*local), GFP_KERNEL);
+	if (!local)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, local);
+
+	/* Declare memory for firmware */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "invalid address\n");
+		return -ENODEV;
+	}
+
+	local->mem_start = res->start;
+	local->mem_end = res->end;
+
+	/* Alloc phys addr from 0 to max_addr for firmware */
+	ret = dma_declare_coherent_memory(&pdev->dev, local->mem_start,
+		local->mem_start, local->mem_end - local->mem_start + 1,
+		DMA_MEMORY_IO);
+	if (!ret) {
+		dev_err(&pdev->dev, "dma_declare_coherent_memory failed\n");
+		return -ENOMEM;
+	}
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
+		goto dma_mask_fault;
+	}
+
+	/* Alloc IRQ based on DTS to be sure that no other driver will use it */
+	while (1) {
+		int irq;
+		/* Allocating shared IRQs will ensure that any module will
+		 * use these IRQs */
+		irq = platform_get_irq(pdev, count++);
+		if (irq == -ENXIO || irq == -EINVAL)
+			break;
+		ret = devm_request_irq(&pdev->dev, irq, mb_remoteproc_interrupt,
+				       0, dev_name(&pdev->dev), &pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev, "IRQ %d already allocated\n", irq);
+			goto dma_mask_fault;
+		}
+
+		dev_info(&pdev->dev, "%d: Alloc irq: %d\n", count, irq);
+	}
+
+	/* Find out reset gpio and keep microblaze in reset */
+	local->reset_gpio = of_get_named_gpio(pdev->dev.of_node, "reset", 0);
+	if (local->reset_gpio < 0) {
+		dev_err(&pdev->dev, "reset-gpio property not found\n");
+		ret = local->reset_gpio;
+		goto dma_mask_fault;
+	}
+	ret = devm_gpio_request_one(&pdev->dev, local->reset_gpio,
+				    GPIOF_OUT_INIT_HIGH, "mb_reset");
+	if (ret) {
+		dev_err(&pdev->dev, "Please specify gpio reset addr\n");
+		goto dma_mask_fault;
+	}
+
+	/* Find out reset gpio and keep microblaze in reset */
+	local->mb_debug_gpio = of_get_named_gpio(pdev->dev.of_node, "debug", 0);
+	if (local->mb_debug_gpio < 0) {
+		dev_err(&pdev->dev, "mb-debug-gpio property not found\n");
+		ret = local->mb_debug_gpio;
+		goto dma_mask_fault;
+	}
+	ret = devm_gpio_request_one(&pdev->dev, local->mb_debug_gpio,
+				    GPIOF_OUT_INIT_LOW, "mb_debug");
+	if (ret) {
+		dev_err(&pdev->dev, "Please specify gpio debug pin\n");
+		goto dma_mask_fault;
+	}
+
+	/* IPI number for getting irq from firmware */
+	local->ipi = of_get_named_gpio(pdev->dev.of_node, "ipino", 0);
+	if (local->ipi < 0) {
+		dev_err(&pdev->dev, "ipi-gpio property not found\n");
+		ret = local->ipi;
+		goto dma_mask_fault;
+	}
+	ret = devm_gpio_request_one(&pdev->dev, local->ipi, GPIOF_IN, "mb_ipi");
+	if (ret) {
+		dev_err(&pdev->dev, "Please specify gpio reset addr\n");
+		goto dma_mask_fault;
+	}
+	ret = devm_request_irq(&pdev->dev, gpio_to_irq(local->ipi),
+			       ipi_kick, IRQF_SHARED|IRQF_TRIGGER_RISING,
+			       dev_name(&pdev->dev), local);
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ %d already allocated\n", local->ipi);
+		goto dma_mask_fault;
+	}
+
+	/* Find out vring0 pin */
+	local->vring0 = of_get_named_gpio(pdev->dev.of_node, "vring0", 0);
+	if (local->vring0 < 0) {
+		dev_err(&pdev->dev, "reset-gpio property not found\n");
+		ret = local->vring0;
+		goto dma_mask_fault;
+	}
+	ret = devm_gpio_request_one(&pdev->dev, local->vring0,
+				    GPIOF_DIR_OUT, "mb_vring0");
+	if (ret) {
+		dev_err(&pdev->dev, "Please specify gpio reset addr\n");
+		goto dma_mask_fault;
+	}
+
+	/* Find out vring1 pin */
+	local->vring1 = of_get_named_gpio(pdev->dev.of_node, "vring1", 0);
+	if (local->vring1 < 0) {
+		dev_err(&pdev->dev, "reset-gpio property not found\n");
+		ret = local->vring1;
+		goto dma_mask_fault;
+	}
+	ret = devm_gpio_request_one(&pdev->dev, local->vring1,
+				    GPIOF_DIR_OUT, "mb_vring1");
+	if (ret) {
+		dev_err(&pdev->dev, "Please specify gpio reset addr\n");
+		goto dma_mask_fault;
+	}
+
+	/* Allocate bram device */
+	bram_dev = of_parse_phandle(pdev->dev.of_node, "bram", 0);
+	if (!bram_dev) {
+		dev_err(&pdev->dev, "Please specify bram connection\n");
+		ret = -ENODEV;
+		goto dma_mask_fault;
+	}
+	bram_pdev = of_find_device_by_node(bram_dev);
+	if (!bram_pdev) {
+		dev_err(&pdev->dev, "BRAM device hasn't found\n");
+		ret = -ENODEV;
+		goto dma_mask_fault;
+	}
+	res = platform_get_resource(bram_pdev, IORESOURCE_MEM, 0);
+	local->vbase = devm_ioremap_resource(&pdev->dev, res);
+	if (!local->vbase) {
+		ret = -ENODEV;
+		goto dma_mask_fault;
+	}
+
+	/* Load simple bootloader to bram */
+	local->bootloader = of_get_property(pdev->dev.of_node,
+					    "bram-firmware", NULL);
+	if (!local->bootloader) {
+		dev_err(&pdev->dev, "Please specify BRAM firmware\n");
+		ret = -ENODEV;
+		goto dma_mask_fault;
+	}
+
+	dev_info(&pdev->dev, "Using microblaze BRAM bootloader: %s\n",
+		 local->bootloader);
+
+	/* Module param firmware first */
+	if (firmware)
+		prop = firmware;
+	else
+		prop = of_get_property(pdev->dev.of_node, "firmware", NULL);
+
+	if (prop) {
+		dev_info(&pdev->dev, "Using firmware: %s\n", prop);
+		local->rproc = rproc_alloc(&pdev->dev, dev_name(&pdev->dev),
+				&mb_rproc_ops, prop, sizeof(struct rproc));
+		if (!local->rproc) {
+			dev_err(&pdev->dev, "rproc allocation failed\n");
+			ret = -ENODEV;
+			goto dma_mask_fault;
+		}
+
+		ret = rproc_add(local->rproc);
+		if (ret) {
+			dev_err(&pdev->dev, "rproc registration failed\n");
+			rproc_put(local->rproc);
+			goto dma_mask_fault;
+		}
+		return 0;
+	}
+
+	ret = -ENODEV;
+
+dma_mask_fault:
+	dma_release_declared_memory(&pdev->dev);
+
+	return ret;
+}
+
+static int mb_remoteproc_remove(struct platform_device *pdev)
+{
+	struct mb_rproc_pdata *local = platform_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "%s\n", __func__);
+
+	dma_release_declared_memory(&pdev->dev);
+
+	rproc_del(local->rproc);
+	rproc_put(local->rproc);
+
+	return 0;
+}
+
+/* Match table for OF platform binding */
+static struct of_device_id mb_remoteproc_match[] = {
+	{ .compatible = "xlnx,mb_remoteproc", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, mb_remoteproc_match);
+
+static struct platform_driver mb_remoteproc_driver = {
+	.probe = mb_remoteproc_probe,
+	.remove = mb_remoteproc_remove,
+	.driver = {
+		.name = "mb_remoteproc",
+		.of_match_table = mb_remoteproc_match,
+	},
+};
+module_platform_driver(mb_remoteproc_driver);
+
+module_param(firmware, charp, 0);
+MODULE_PARM_DESC(firmware, "Override the firmware image name. Default value in DTS.");
+
+MODULE_AUTHOR("Michal Simek <monstr@monstr.eu");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Microblaze remote processor control driver");
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/fe68e977/attachment.sig>
