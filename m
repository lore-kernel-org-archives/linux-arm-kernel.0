From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:36 +0200
Subject: [PATCH 1/8] ARM i.MX dma: implement wrapper for dma functions
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is only one i.MX DMA implementation in the tree,
the one for i.MX1/21/27. The SDMA support for i.MX25/31/35/51 can
be implemented similarly. This wrapper for the DMA is implemented
so that drivers do not have to care about the implementation
present and don't have to #ifdef DMA support

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/include/mach/dma-v1.h |    8 +--
 arch/arm/plat-mxc/Makefile              |    2 +-
 arch/arm/plat-mxc/dma.c                 |  112 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/dma.h    |   92 +++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/plat-mxc/dma.c
 create mode 100644 arch/arm/plat-mxc/include/mach/dma.h

diff --git a/arch/arm/mach-imx/include/mach/dma-v1.h b/arch/arm/mach-imx/include/mach/dma-v1.h
index 287431c..ac6fd71 100644
--- a/arch/arm/mach-imx/include/mach/dma-v1.h
+++ b/arch/arm/mach-imx/include/mach/dma-v1.h
@@ -27,6 +27,8 @@
 
 #define imx_has_dma_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
 
+#include <mach/dma.h>
+
 #define IMX_DMA_CHANNELS  16
 
 #define DMA_MODE_READ		0
@@ -96,12 +98,6 @@ int imx_dma_request(int channel, const char *name);
 
 void imx_dma_free(int channel);
 
-enum imx_dma_prio {
-	DMA_PRIO_HIGH = 0,
-	DMA_PRIO_MEDIUM = 1,
-	DMA_PRIO_LOW = 2
-};
-
 int imx_dma_request_by_prio(const char *name, enum imx_dma_prio prio);
 
 #endif	/* __MACH_DMA_V1_H__ */
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 78d405e..ff9880c 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o
+obj-y := irq.o clock.o gpio.o time.o devices.o cpu.o system.o dma.o
 
 # MX51 uses the TZIC interrupt controller, older platforms use AVIC (irq.o)
 obj-$(CONFIG_MXC_TZIC) += tzic.o
diff --git a/arch/arm/plat-mxc/dma.c b/arch/arm/plat-mxc/dma.c
new file mode 100644
index 0000000..1a241ab
--- /dev/null
+++ b/arch/arm/plat-mxc/dma.c
@@ -0,0 +1,112 @@
+
+#include <mach/dma.h>
+
+static struct imx_dma_operations *imx_dma_ops;
+
+static DEFINE_MUTEX(dma_mutex);
+
+static int imxdma_check(int channel)
+{
+	if (!imx_dma_ops)
+		return -ENOSYS;
+	if (channel < 0 || channel >= imx_dma_ops->num_channels)
+		return -EINVAL;
+	return 0;
+}
+
+int imxdma_setup_single(int channel, dma_addr_t mem, int dma_length,
+		unsigned int dmamode)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return ret;
+
+	return imx_dma_ops->setup_single(channel, mem, dma_length, dmamode);
+}
+
+int imxdma_setup_sg(int channel, struct scatterlist *sg, unsigned int sgcount,
+			unsigned int dma_length, unsigned int dmamode)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return ret;
+
+	return imx_dma_ops->setup_sg(channel, sg, sgcount, dma_length, dmamode);
+}
+
+void imxdma_enable(int channel)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return;
+
+	imx_dma_ops->enable(channel);
+}
+
+void imxdma_disable(int channel)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return;
+
+	imx_dma_ops->disable(channel);
+}
+
+int imxdma_config(int channel, struct imx_dma_config *cfg)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return ret;
+
+	return imx_dma_ops->config_channel(channel, cfg);
+}
+
+int imxdma_request(enum imx_dma_prio prio)
+{
+	int ret;
+
+	if (!imx_dma_ops)
+		return -ENOSYS;
+
+	mutex_lock(&dma_mutex);
+
+	ret = imx_dma_ops->request(prio);
+
+	mutex_unlock(&dma_mutex);
+
+	return ret;
+}
+
+void imxdma_free(int channel)
+{
+	int ret;
+
+	ret = imxdma_check(channel);
+	if (ret)
+		return;
+
+	mutex_lock(&dma_mutex);
+
+	imx_dma_ops->free(channel);
+
+	mutex_unlock(&dma_mutex);
+}
+
+int imx_dma_ops_register(struct imx_dma_operations *ops)
+{
+	BUG_ON(imx_dma_ops);
+
+	imx_dma_ops = ops;
+
+	return 0;
+}
diff --git a/arch/arm/plat-mxc/include/mach/dma.h b/arch/arm/plat-mxc/include/mach/dma.h
new file mode 100644
index 0000000..3ee9541
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/dma.h
@@ -0,0 +1,92 @@
+/*
+ * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_MXC_DMA_H__
+#define __ASM_ARCH_MXC_DMA_H__
+
+#include <linux/scatterlist.h>
+
+#define DMA_MODE_READ	0
+#define DMA_MODE_WRITE	1
+
+/*
+ * This enumerates peripheral types. Used for SDMA.
+ */
+typedef enum {
+	IMX_DMATYPE_SSI,	/* MCU domain SSI */
+	IMX_DMATYPE_SSI_SP,	/* Shared SSI */
+	IMX_DMATYPE_MMC,	/* MMC */
+	IMX_DMATYPE_SDHC,	/* SDHC */
+	IMX_DMATYPE_UART,	/* MCU domain UART */
+	IMX_DMATYPE_UART_SP,	/* Shared UART */
+	IMX_DMATYPE_FIRI,	/* FIRI */
+	IMX_DMATYPE_CSPI,	/* MCU domain CSPI */
+	IMX_DMATYPE_CSPI_SP,	/* Shared CSPI */
+	IMX_DMATYPE_SIM,	/* SIM */
+	IMX_DMATYPE_ATA,	/* ATA */
+	IMX_DMATYPE_CCM,	/* CCM */
+	IMX_DMATYPE_EXT,	/* External peripheral */
+	IMX_DMATYPE_MSHC,	/* Memory Stick Host Controller */
+	IMX_DMATYPE_MSHC_SP,	/* Shared Memory Stick Host Controller */
+	IMX_DMATYPE_DSP,	/* DSP */
+	IMX_DMATYPE_MEMORY,	/* Memory */
+	IMX_DMATYPE_FIFO_MEMORY,/* FIFO type Memory */
+	IMX_DMATYPE_SPDIF,	/* SPDIF */
+	IMX_DMATYPE_IPU_MEMORY,	/* IPU Memory */
+	IMX_DMATYPE_ASRC,	/* ASRC */
+	IMX_DMATYPE_ESAI,	/* ESAI */
+} sdma_peripheral_type;
+
+struct imx_dma_config {
+	int burstlen; /* number of words (*not* bytes) to transfer during
+		       * a single burst
+		       */
+	dma_addr_t dma_address; /* the physical address of the peripheral */
+	int word_size; /* FIFO width of the peripheral in bytes */
+	int peripheral_type; /* Needed for SDMA */
+	int dma_request; /* DMA request line */
+	/* completion callback */
+	void (*completion_handler) (int channel, void *data, int error);
+	void *driver_data; /* passed to handler above */
+#define IMX_DMA_SG_LOOP		(1 << 0)
+	unsigned long flags;
+};
+
+enum imx_dma_prio {
+	DMA_PRIO_HIGH = 0,
+	DMA_PRIO_MEDIUM = 1,
+	DMA_PRIO_LOW = 2
+};
+
+int imxdma_request(enum imx_dma_prio);
+void imxdma_free(int channel);
+int imxdma_setup_single(int channel, dma_addr_t mem, int dma_length,
+		unsigned int dmamode);
+int imxdma_setup_sg(int channel, struct scatterlist *sg, unsigned int sgcount,
+			unsigned int dma_length, unsigned int dmamode);
+void imxdma_enable(int channel);
+void imxdma_disable(int channel);
+int imxdma_config(int channel, struct imx_dma_config *cfg);
+
+struct imx_dma_operations {
+	int (*config_channel)(int channel, struct imx_dma_config *cfg);
+	int (*setup_single)(int channel, dma_addr_t mem, int dma_length,
+		unsigned int dmamode);
+	int (*setup_sg)(int channel, struct scatterlist *sg,
+			unsigned int sgcount, unsigned int dma_length,
+			unsigned int dmamode);
+	void (*enable)(int channel);
+	void (*disable)(int channel);
+	int (*request)(enum imx_dma_prio);
+	void (*free)(int channel);
+	int num_channels;
+};
+
+int imx_dma_ops_register(struct imx_dma_operations *ops);
+
+#endif
-- 
1.7.1
