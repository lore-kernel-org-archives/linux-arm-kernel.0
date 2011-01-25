From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 25 Jan 2011 16:25:20 +0100
Subject: [PATCH 1/4] mach-ux500: add platform data for musb
Message-ID: <1295969120-12038-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>

USB resources and DMA40 configurations are dynamically with
the data provided in ux500_add_usb() call. Though only DMA40
configurations differ between U8500 and U5500 (USB resource
are common between them).

Signed-off-by: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Makefile           |    2 +-
 arch/arm/mach-ux500/include/mach/usb.h |   26 +++++
 arch/arm/mach-ux500/usb.c              |  165 ++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/usb.h
 create mode 100644 arch/arm/mach-ux500/usb.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 1cb588e..eec3279 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o \
-				   id.o
+				   id.o usb.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/include/mach/usb.h b/arch/arm/mach-ux500/include/mach/usb.h
new file mode 100644
index 0000000..096ba2a
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/usb.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2011 ST-Ericsson.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __ASM_ARCH_USB_H
+#define __ASM_ARCH_USB_H
+
+#include <linux/dmaengine.h>
+
+#define UX500_MUSB_DMA_NUM_RX_CHANNELS 8
+#define UX500_MUSB_DMA_NUM_TX_CHANNELS 8
+
+struct ux500_musb_board_data {
+	void	**dma_rx_param_array;
+	void	**dma_tx_param_array;
+	u32	num_rx_channels;
+	u32	num_tx_channels;
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+};
+
+void ux500_add_usb(resource_size_t base, int irq, int *dma_rx_cfg,
+	int *dma_tx_cfg);
+#endif
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
new file mode 100644
index 0000000..c0da1fd
--- /dev/null
+++ b/arch/arm/mach-ux500/usb.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) ST-Ericsson AB 2011
+ *
+ * Author: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/platform_device.h>
+#include <linux/usb/musb.h>
+#include <plat/ste_dma40.h>
+#include <mach/hardware.h>
+#include <mach/usb.h>
+
+#ifdef CONFIG_STE_DMA40
+#define MUSB_DMA40_RX_CH { \
+		.mode = STEDMA40_MODE_LOGICAL, \
+		.dir = STEDMA40_PERIPH_TO_MEM, \
+		.dst_dev_type = STEDMA40_DEV_DST_MEMORY, \
+		.src_info.data_width = STEDMA40_WORD_WIDTH, \
+		.dst_info.data_width = STEDMA40_WORD_WIDTH, \
+		.src_info.psize = STEDMA40_PSIZE_LOG_16, \
+		.dst_info.psize = STEDMA40_PSIZE_LOG_16, \
+	}
+
+#define MUSB_DMA40_TX_CH { \
+		.mode = STEDMA40_MODE_LOGICAL, \
+		.dir = STEDMA40_MEM_TO_PERIPH, \
+		.src_dev_type = STEDMA40_DEV_SRC_MEMORY, \
+		.src_info.data_width = STEDMA40_WORD_WIDTH, \
+		.dst_info.data_width = STEDMA40_WORD_WIDTH, \
+		.src_info.psize = STEDMA40_PSIZE_LOG_16, \
+		.dst_info.psize = STEDMA40_PSIZE_LOG_16, \
+	}
+
+static struct stedma40_chan_cfg musb_dma_rx_ch[UX500_MUSB_DMA_NUM_RX_CHANNELS]
+	= {
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH,
+	MUSB_DMA40_RX_CH
+};
+
+static struct stedma40_chan_cfg musb_dma_tx_ch[UX500_MUSB_DMA_NUM_TX_CHANNELS]
+	= {
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+	MUSB_DMA40_TX_CH,
+};
+
+static void *ux500_dma_rx_param_array[UX500_MUSB_DMA_NUM_RX_CHANNELS] = {
+	&musb_dma_rx_ch[0],
+	&musb_dma_rx_ch[1],
+	&musb_dma_rx_ch[2],
+	&musb_dma_rx_ch[3],
+	&musb_dma_rx_ch[4],
+	&musb_dma_rx_ch[5],
+	&musb_dma_rx_ch[6],
+	&musb_dma_rx_ch[7]
+};
+
+static void *ux500_dma_tx_param_array[UX500_MUSB_DMA_NUM_TX_CHANNELS] = {
+	&musb_dma_tx_ch[0],
+	&musb_dma_tx_ch[1],
+	&musb_dma_tx_ch[2],
+	&musb_dma_tx_ch[3],
+	&musb_dma_tx_ch[4],
+	&musb_dma_tx_ch[5],
+	&musb_dma_tx_ch[6],
+	&musb_dma_tx_ch[7]
+};
+
+static struct ux500_musb_board_data musb_board_data = {
+	.dma_rx_param_array = ux500_dma_rx_param_array,
+	.dma_tx_param_array = ux500_dma_tx_param_array,
+	.num_rx_channels = UX500_MUSB_DMA_NUM_RX_CHANNELS,
+	.num_tx_channels = UX500_MUSB_DMA_NUM_TX_CHANNELS,
+	.dma_filter = stedma40_filter,
+};
+#endif
+
+static u64 ux500_musb_dmamask = DMA_BIT_MASK(32);
+
+static struct musb_hdrc_config musb_hdrc_config = {
+	.multipoint	= true,
+	.dyn_fifo	= true,
+	.num_eps	= 16,
+	.ram_bits	= 16,
+};
+
+static struct musb_hdrc_platform_data musb_platform_data = {
+#if defined(CONFIG_USB_MUSB_OTG)
+	.mode = MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
+	.mode = MUSB_PERIPHERAL,
+#else /* defined(CONFIG_USB_MUSB_HOST) */
+	.mode = MUSB_HOST,
+#endif
+	.config = &musb_hdrc_config,
+#ifdef CONFIG_STE_DMA40
+	.board_data = &musb_board_data,
+#endif /* CONFIG_STE_DMA40 */
+};
+
+static struct resource usb_resources[] = {
+	[0] = {
+		.name	= "usb-mem",
+		.flags	=  IORESOURCE_MEM,
+	},
+
+	[1] = {
+		.name   = "mc", /* hard-coded in musb */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ux500_musb_device = {
+	.name = "musb-ux500",
+	.id = 0,
+	.dev = {
+		.platform_data = &musb_platform_data,
+		.dma_mask = &ux500_musb_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources = ARRAY_SIZE(usb_resources),
+	.resource = usb_resources,
+};
+
+static inline void ux500_usb_dma_update_rx_ch_config(int *src_dev_type)
+{
+	u32 idx;
+
+	for (idx = 0; idx < UX500_MUSB_DMA_NUM_RX_CHANNELS; idx++)
+		musb_dma_rx_ch[idx].src_dev_type = src_dev_type[idx];
+}
+
+static inline void ux500_usb_dma_update_tx_ch_config(int *dst_dev_type)
+{
+	u32 idx;
+
+	for (idx = 0; idx < UX500_MUSB_DMA_NUM_TX_CHANNELS; idx++)
+		musb_dma_tx_ch[idx].dst_dev_type = dst_dev_type[idx];
+}
+
+void ux500_add_usb(resource_size_t base, int irq, int *dma_rx_cfg,
+	int *dma_tx_cfg)
+{
+	ux500_musb_device.resource[0].start = base;
+	ux500_musb_device.resource[0].end = base + SZ_64K - 1;
+	ux500_musb_device.resource[1].start = irq;
+	ux500_musb_device.resource[1].end = irq;
+
+	ux500_usb_dma_update_rx_ch_config(dma_rx_cfg);
+	ux500_usb_dma_update_tx_ch_config(dma_tx_cfg);
+
+	platform_device_register(&ux500_musb_device);
+}
-- 
1.7.3.2
