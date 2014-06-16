From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:26 -0300
Subject: [PATCH 01/10] dma: sun4i: Add support for the DMA engine on sun[457]i
 SoCs
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the DMA engine present on Allwinner A10,
A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
and dedicated. The main difference is in the mode of operation;
while a single normal channel may be operating at any given time,
dedicated channels may operate simultaneously provided there is no
overlap of source or destination.

Hardware documentation can be found on A10 User Manual (section 12), A13
User Manual (section 14) and A20 User Manual (section 1.12)

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

For some mem2dev/dev2mem transfers, we need to configure some magic delays
for things to work - on my experimental testing, 0x00010001 seems to work
for SPI. Is there some place in the API to pass these kinds of values from
client drivers when configuring a transfer? Currently I have just hardcoded
this value on the driver, but it'll probably cause trouble in the future
for other devices.

 .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1065 ++++++++++++++++++++
 4 files changed, 1121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
new file mode 100644
index 0000000..f5661a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
@@ -0,0 +1,45 @@
+Allwinner A10 DMA Controller
+
+This driver follows the generic DMA bindings defined in dma.txt.
+
+Required properties:
+
+- compatible:	Must be "allwinner,sun4i-a10-dma"
+- reg:		Should contain the registers base address and length
+- interrupts:	Should contain a reference to the interrupt used by this device
+- clocks:	Should contain a reference to the parent AHB clock
+- #dma-cells :	Should be 1, a single cell holding a line request number
+
+Example:
+	dma: dma-controller at 01c02000 {
+		compatible = "allwinner,sun4i-a10-dma";
+		reg = <0x01c02000 0x1000>;
+		interrupts = <27>;
+		clocks = <&ahb_gates 6>;
+		#dma-cells = <1>;
+	};
+
+Clients:
+
+DMA clients connected to the Allwinner A10 DMA controller must use the
+format described in the dma.txt file, using a three-cell specifier for
+each channel: a phandle plus two integer cells.
+The three cells in order are:
+
+1. A phandle pointing to the DMA controller.
+2. Whether it is using normal (0) or dedicated (1) channels
+2. The port ID as specified in the datasheet
+
+Example:
+	spi2: spi at 01c17000 {
+		compatible = "allwinner,sun4i-a10-spi";
+		reg = <0x01c17000 0x1000>;
+		interrupts = <0 12 4>;
+		clocks = <&ahb_gates 22>, <&spi2_clk>;
+		clock-names = "ahb", "mod";
+		dmas = <&dma 1 29>, <&dma 1 28>;
+		dma-names = "rx", "tx";
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ba06d1d..a9ee0c9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -361,6 +361,16 @@ config FSL_EDMA
 	  multiplexing capability for DMA request sources(slot).
 	  This module can be found on Freescale Vybrid and LS-1 SoCs.
 
+config SUN4I_DMA
+	tristate "Allwinner A10/A10S/A13/A20 DMA support"
+	depends on ARCH_SUNXI
+	select DMA_ENGINE
+	select DMA_OF
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for the DMA controller present in the sun4i,
+	  sun5i and sun7i Allwinner ARM SoCs.
+
 config DMA_ENGINE
 	bool
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 5150c82..13a7d5d 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
 obj-$(CONFIG_QCOM_BAM_DMA) += qcom_bam_dma.o
+obj-$(CONFIG_SUN4I_DMA) += sun4i-dma.o
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
new file mode 100644
index 0000000..0b14b3f
--- /dev/null
+++ b/drivers/dma/sun4i-dma.c
@@ -0,0 +1,1065 @@
+/*
+ * Copyright (C) 2014 Emilio L?pez
+ * Emilio L?pez <emilio@elopez.com.ar>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "virt-dma.h"
+
+/** General DMA register values **/
+
+/* DMA source/destination burst length values */
+#define DMA_BURST_LENGTH_1			0
+#define DMA_BURST_LENGTH_4			1
+#define DMA_BURST_LENGTH_8			2
+
+/* DMA source/destination data width */
+#define DMA_DATA_WIDTH_8BIT			0
+#define DMA_DATA_WIDTH_16BIT			1
+#define DMA_DATA_WIDTH_32BIT			2
+
+/** Normal DMA register values **/
+
+/* Normal DMA source/destination data request type values */
+#define NDMA_DRQ_TYPE_IR0			0x0
+#define NDMA_DRQ_TYPE_IR1			0x1
+#define NDMA_DRQ_TYPE_SPDIF			0x2
+#define NDMA_DRQ_TYPE_IIS0			0x3
+#define NDMA_DRQ_TYPE_IIS1			0x4
+#define NDMA_DRQ_TYPE_AC97			0x5
+#define NDMA_DRQ_TYPE_IIS2			0x6
+#define NDMA_DRQ_TYPE_UART0			0x8
+#define NDMA_DRQ_TYPE_UART1			0x9
+#define NDMA_DRQ_TYPE_UART2			0xA
+#define NDMA_DRQ_TYPE_UART3			0xB
+#define NDMA_DRQ_TYPE_UART4			0xC
+#define NDMA_DRQ_TYPE_UART5			0xD
+#define NDMA_DRQ_TYPE_UART6			0xE
+#define NDMA_DRQ_TYPE_UART7			0xF
+#define NDMA_DRQ_TYPE_HDMI_DDC			0x10
+#define NDMA_DRQ_TYPE_USB_EP1			0x11
+#define NDMA_DRQ_TYPE_AUDIO_CODEC		0x13
+#define NDMA_DRQ_TYPE_SRAM			0x15
+#define NDMA_DRQ_TYPE_SDRAM			0x16
+#define NDMA_DRQ_TYPE_TP_AD			0x17
+#define NDMA_DRQ_TYPE_SPI0			0x18
+#define NDMA_DRQ_TYPE_SPI1			0x19
+#define NDMA_DRQ_TYPE_SPI2			0x1A
+#define NDMA_DRQ_TYPE_SPI3			0x1B
+#define NDMA_DRQ_TYPE_USB_EP2			0x1C
+#define NDMA_DRQ_TYPE_USB_EP3			0x1D
+#define NDMA_DRQ_TYPE_USB_EP4			0x1E
+#define NDMA_DRQ_TYPE_USB_EP5			0x1F
+#define NDMA_DRQ_TYPE_LIMIT			(0x1F+1)
+
+/** Normal DMA register layout **/
+
+/* Normal DMA configuration register layout */
+#define NDMA_CFG_LOADING			BIT(31)
+#define NDMA_CFG_CONT_MODE			BIT(30)
+#define NDMA_CFG_WAIT_STATE(n)			(n << 27)
+#define NDMA_CFG_DEST_DATA_WIDTH(width)		(width << 25)
+#define NDMA_CFG_DEST_BURST_LENGTH(len)		(len << 23)
+#define NDMA_CFG_DEST_NON_SECURE		BIT(22)
+#define NDMA_CFG_DEST_FIXED_ADDR		BIT(21)
+#define NDMA_CFG_DEST_DRQ_TYPE(type)		(type << 16)
+#define NDMA_CFG_BYTE_COUNT_MODE_REMAIN		BIT(15)
+#define NDMA_CFG_SRC_DATA_WIDTH(width)		(width << 9)
+#define NDMA_CFG_SRC_BURST_LENGTH(len)		(len << 7)
+#define NDMA_CFG_SRC_NON_SECURE			BIT(6)
+#define NDMA_CFG_SRC_FIXED_ADDR			BIT(5)
+#define NDMA_CFG_SRC_DRQ_TYPE(type)		(type << 0)
+
+/** Dedicated DMA register values **/
+
+/* Dedicated DMA source/destination address mode values */
+#define DDMA_ADDR_MODE_LINEAR			0
+#define DDMA_ADDR_MODE_IO			1
+#define DDMA_ADDR_MODE_HORIZONTAL_PAGE		2
+#define DDMA_ADDR_MODE_VERTICAL_PAGE		3
+
+/* Dedicated DMA source/destination data request type values
+ * Note: some of these values are only sensible when used only as
+ * source or destination */
+#define DDMA_DRQ_TYPE_SRAM			0x0
+#define DDMA_DRQ_TYPE_SDRAM			0x1
+#define DDMA_DRQ_TYPE_PATA			0x2
+#define DDMA_DRQ_TYPE_NFC			0x3
+#define DDMA_DRQ_TYPE_USB0			0x4
+#define DDMA_DRQ_TYPE_EMAC_TX			0x6
+#define DDMA_DRQ_TYPE_EMAC_RX			0x7
+#define DDMA_DRQ_TYPE_SPI1_TX			0x8
+#define DDMA_DRQ_TYPE_SPI1_RX			0x9
+#define DDMA_DRQ_TYPE_SS_TX			0xA
+#define DDMA_DRQ_TYPE_SS_RX			0xB
+#define DDMA_DRQ_TYPE_TCON0			0xE
+#define DDMA_DRQ_TYPE_TCON1			0xF
+#define DDMA_DRQ_TYPE_MSC			0x17
+#define DDMA_DRQ_TYPE_HDMI_AUDIO		0x18
+#define DDMA_DRQ_TYPE_SPI0_TX			0x1A
+#define DDMA_DRQ_TYPE_SPI0_RX			0x1B
+#define DDMA_DRQ_TYPE_SPI2_TX			0x1C
+#define DDMA_DRQ_TYPE_SPI2_RX			0x1D
+#define DDMA_DRQ_TYPE_SPI3_TX			0x1E
+#define DDMA_DRQ_TYPE_SPI3_RX			0x1F
+#define DDMA_DRQ_TYPE_LIMIT			(0x1F+1)
+
+/** Dedicated DMA register layout **/
+
+/* Dedicated DMA configuration register layout */
+#define DDMA_CFG_LOADING			BIT(31)
+#define DDMA_CFG_BUSY				BIT(30)
+#define DDMA_CFG_CONT_MODE			BIT(29)
+#define DDMA_CFG_DEST_NON_SECURE		BIT(28)
+#define DDMA_CFG_DEST_DATA_WIDTH(width)		(width << 25)
+#define DDMA_CFG_DEST_BURST_LENGTH(len)		(len << 23)
+#define DDMA_CFG_DEST_ADDR_MODE(mode)		(mode << 21)
+#define DDMA_CFG_DEST_DRQ_TYPE(type)		(type << 16)
+#define DDMA_CFG_BYTE_COUNT_MODE_REMAIN		BIT(15)
+#define DDMA_CFG_SRC_NON_SECURE			BIT(12)
+#define DDMA_CFG_SRC_DATA_WIDTH(width)		(width << 9)
+#define DDMA_CFG_SRC_BURST_LENGTH(len)		(len << 7)
+#define DDMA_CFG_SRC_ADDR_MODE(mode)		(mode << 5)
+#define DDMA_CFG_SRC_DRQ_TYPE(type)		(type << 0)
+
+/* Dedicated DMA parameter register layout */
+#define DDMA_PARA_DEST_DATA_BLK_SIZE(n)		(n-1 << 24)
+#define DDMA_PARA_DEST_WAIT_CYCLES(n)		(n-1 << 16)
+#define DDMA_PARA_SRC_DATA_BLK_SIZE(n)		(n-1 << 8)
+#define DDMA_PARA_SRC_WAIT_CYCLES(n)		(n-1 << 0)
+
+/** DMA register offsets **/
+
+/* Normal DMA register offsets */
+#define NDMA_CHANNEL_REG_BASE(n)		(0x100+n*0x20)
+#define NDMA_CFG_REG				0x0
+#define NDMA_SRC_ADDR_REG			0x4
+#define NDMA_DEST_ADDR_REG			0x8
+#define NDMA_BYTE_COUNT_REG			0xC
+
+/* Dedicated DMA register offsets */
+#define DDMA_CHANNEL_REG_BASE(n)		(0x300+n*0x20)
+#define DDMA_CFG_REG				0x0
+#define DDMA_SRC_ADDR_REG			0x4
+#define DDMA_DEST_ADDR_REG			0x8
+#define DDMA_BYTE_COUNT_REG			0xC
+#define DDMA_PARA_REG				0x18
+
+/* General register offsets */
+#define DMA_IRQ_ENABLE_REG			0x0
+#define DMA_IRQ_PENDING_STATUS_REG		0x4
+
+/** DMA Driver **/
+
+/* Normal DMA has 8 channels, and Dedicated DMA has another 8, so that's
+ * 16 channels. As for endpoints, there's 29 and 21 respectively. Given
+ * that the Normal DMA endpoints can be used as tx/rx, we need 79 vchans
+ * in total
+ */
+#define NDMA_NR_MAX_CHANNELS	8
+#define DDMA_NR_MAX_CHANNELS	8
+#define DMA_NR_MAX_CHANNELS	(NDMA_NR_MAX_CHANNELS + DDMA_NR_MAX_CHANNELS)
+#define NDMA_NR_MAX_VCHANS	(29*2)
+#define DDMA_NR_MAX_VCHANS	21
+#define DMA_NR_MAX_VCHANS	(NDMA_NR_MAX_VCHANS + DDMA_NR_MAX_VCHANS)
+
+struct sun4i_dma_pchan {
+	/* Register base of channel */
+	void __iomem			*base;
+	/* vchan currently being serviced */
+	struct sun4i_dma_vchan		*vchan;
+	/* Is this a dedicated pchan? */
+	int				is_dedicated;
+};
+
+struct sun4i_dma_vchan {
+	struct virt_dma_chan		vc;
+	struct dma_slave_config		cfg;
+	struct sun4i_dma_pchan		*pchan;
+	struct sun4i_dma_promise	*processing;
+	struct sun4i_dma_contract	*contract;
+	u8				endpoint;
+	int				is_dedicated;
+};
+
+struct sun4i_dma_promise {
+	u32				cfg;
+	u32				para;
+	dma_addr_t			src;
+	dma_addr_t			dst;
+	size_t				len;
+	struct list_head		list;
+};
+
+/* A contract is a set of promises */
+struct sun4i_dma_contract {
+	struct virt_dma_desc		vd;
+	struct list_head		demands;
+	struct list_head		completed_demands;
+};
+
+struct sun4i_dma_dev {
+	DECLARE_BITMAP(pchans_used, DDMA_NR_MAX_CHANNELS);
+	struct tasklet_struct		tasklet;
+	struct dma_device		slave;
+	struct sun4i_dma_pchan		*pchans;
+	struct sun4i_dma_vchan		*vchans;
+	void __iomem			*base;
+	struct clk			*clk;
+	int				irq;
+	spinlock_t			lock;
+};
+
+static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
+{
+	return container_of(dev, struct sun4i_dma_dev, slave);
+}
+
+static struct sun4i_dma_vchan *to_sun4i_dma_vchan(struct dma_chan *chan)
+{
+	return container_of(chan, struct sun4i_dma_vchan, vc.chan);
+}
+
+static struct sun4i_dma_contract *to_sun4i_dma_contract(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct sun4i_dma_contract, vd);
+}
+
+static struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static int convert_burst(u32 maxburst)
+{
+	if (maxburst > 8)
+		maxburst = 8;
+
+	/* 1 -> 0, 4 -> 1, 8 -> 2 */
+	return (maxburst >> 2);
+}
+
+static int convert_buswidth(enum dma_slave_buswidth addr_width)
+{
+	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
+		return -EINVAL;
+
+	/* 8 -> 0, 16 -> 1, 32 -> 2 */
+	return (addr_width >> 4);
+}
+
+static int sun4i_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	return 0;
+}
+
+static void sun4i_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+
+	vchan_free_chan_resources(&vchan->vc);
+}
+
+static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
+						  struct sun4i_dma_vchan *vchan)
+{
+	struct sun4i_dma_pchan *pchan = NULL, *pchans = priv->pchans;
+	unsigned long flags;
+	int i, max;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
+	 * NDMA_NR_MAX_CHANNELS+ are dedicated ones */
+	if (vchan->is_dedicated) {
+		i = NDMA_NR_MAX_CHANNELS;
+		max = DMA_NR_MAX_CHANNELS;
+	} else {
+		i = 0;
+		max = NDMA_NR_MAX_CHANNELS;
+	}
+
+	for_each_clear_bit_from(i, &priv->pchans_used, max) {
+		pchan = &pchans[i];
+		pchan->vchan = vchan;
+		set_bit(i, priv->pchans_used);
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return pchan;
+}
+
+static void release_pchan(struct sun4i_dma_dev *priv,
+			  struct sun4i_dma_pchan *pchan)
+{
+	unsigned long flags;
+	int nr = pchan - priv->pchans;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	clear_bit(nr, priv->pchans_used);
+	pchan->vchan = NULL;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void configure_pchan(struct sun4i_dma_pchan *pchan,
+			    struct sun4i_dma_promise *d)
+{
+	if (pchan->is_dedicated) {
+		/* Configure addresses and misc parameters */
+		writel_relaxed(d->src, pchan->base + DDMA_SRC_ADDR_REG);
+		writel_relaxed(d->dst, pchan->base + DDMA_DEST_ADDR_REG);
+		writel_relaxed(d->len, pchan->base + DDMA_BYTE_COUNT_REG);
+		writel_relaxed(d->para, pchan->base + DDMA_PARA_REG);
+
+		/* We use a writel here because CFG_LOADING may be set,
+		 * and it requires that the rest of the configuration
+		 * takes place before the engine is started */
+		writel(d->cfg, pchan->base + DDMA_CFG_REG);
+	} else {
+		/* Configure addresses and misc parameters */
+		writel_relaxed(d->src, pchan->base + NDMA_SRC_ADDR_REG);
+		writel_relaxed(d->dst, pchan->base + NDMA_DEST_ADDR_REG);
+		writel_relaxed(d->len, pchan->base + NDMA_BYTE_COUNT_REG);
+
+		/* We use a writel here because CFG_LOADING may be set,
+		 * and it requires that the rest of the configuration
+		 * takes place before the engine is started */
+		writel(d->cfg, pchan->base + NDMA_CFG_REG);
+	}
+}
+
+static void set_pchan_interrupt(struct sun4i_dma_dev *priv,
+				struct sun4i_dma_pchan *pchan,
+				int half, int end)
+{
+	u32 reg = readl_relaxed(priv->base + DMA_IRQ_ENABLE_REG);
+	int pchan_number = pchan - priv->pchans;
+
+	if (half)
+		reg |= BIT(pchan_number*2);
+	else
+		reg &= ~BIT(pchan_number*2);
+
+	if (end)
+		reg |= BIT(pchan_number*2 + 1);
+	else
+		reg &= ~BIT(pchan_number*2 + 1);
+
+	writel(reg, priv->base + DMA_IRQ_ENABLE_REG);
+}
+
+static int execute_vchan_pending(struct sun4i_dma_dev *priv,
+				 struct sun4i_dma_vchan *vchan)
+{
+	struct sun4i_dma_promise *promise = NULL;
+	struct sun4i_dma_contract *contract = NULL;
+	struct sun4i_dma_pchan *pchan;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+	int ret;
+
+	/* We need a pchan to do anything, so secure one if available */
+	pchan = find_and_use_pchan(priv, vchan);
+	if (!pchan)
+		return -EBUSY;
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+
+	/* Channel endpoints must not be repeated, so if this vchan
+	 * has already submitted some work, we can't do anything else
+	 */
+	if (vchan->processing) {
+		dev_dbg(chan2dev(&vchan->vc.chan),
+			"processing something to this endpoint already\n");
+		ret = -EBUSY;
+		goto release_pchan;
+	}
+
+	do {
+		/* Figure out which contract we're working with today */
+		vd = vchan_next_desc(&vchan->vc);
+		if (!vd) {
+			dev_dbg(chan2dev(&vchan->vc.chan),
+				"No pending contract found");
+			ret = 0;
+			goto release_pchan;
+		}
+
+		contract = to_sun4i_dma_contract(vd);
+		if (list_empty(&contract->demands)) {
+			/* The contract has been completed so mark it as such */
+			list_del(&contract->vd.node);
+			vchan_cookie_complete(&contract->vd);
+			dev_dbg(chan2dev(&vchan->vc.chan),
+				"Empty contract found and marked complete");
+		}
+	} while (list_empty(&contract->demands));
+
+	/* Now find out what we need to do */
+	promise = list_first_entry(&contract->demands, struct sun4i_dma_promise, list);
+	vchan->processing = promise;
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	/* ... and make it reality */
+	if (promise) {
+		vchan->contract = contract;
+		set_pchan_interrupt(priv, pchan, 0, 1);
+		configure_pchan(pchan, promise);
+	}
+
+	return 0;
+
+release_pchan:
+	release_pchan(priv, pchan);
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+	return ret;
+}
+
+/**
+ * Generate a promise, to be used in a normal DMA contract.
+ *
+ * A NDMA promise contains all the information required to program the
+ * normal part of the DMA Engine and get data copied. A non-executed
+ * promise will live in the demands list on a contract. Once it has been
+ * completed, it will be moved to the completed demands list for later freeing.
+ * All linked promises will be freed when the corresponding contract is freed
+ */
+static struct sun4i_dma_promise *
+generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
+		      size_t len, struct dma_slave_config *sconfig)
+{
+	struct sun4i_dma_promise *promise;
+	int ret;
+
+	promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
+	if (!promise)
+		return NULL;
+
+	promise->src = src;
+	promise->dst = dest;
+	promise->len = len;
+	promise->cfg = NDMA_CFG_LOADING | NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
+
+	/* Source burst */
+	ret = convert_burst(sconfig->src_maxburst);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= NDMA_CFG_SRC_BURST_LENGTH(ret);
+
+	/* Destination burst */
+	ret = convert_burst(sconfig->dst_maxburst);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= NDMA_CFG_DEST_BURST_LENGTH(ret);
+
+	/* Source bus width */
+	ret = convert_buswidth(sconfig->src_addr_width);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= NDMA_CFG_SRC_DATA_WIDTH(ret);
+
+	/* Destination bus width */
+	ret = convert_buswidth(sconfig->dst_addr_width);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= NDMA_CFG_DEST_DATA_WIDTH(ret);
+
+	return promise;
+
+fail:
+	kfree(promise);
+	return NULL;
+}
+
+/**
+ * Generate a promise, to be used in a dedicated DMA contract.
+ *
+ * A DDMA promise contains all the information required to program the
+ * Dedicated part of the DMA Engine and get data copied. A non-executed
+ * promise will live in the demands list on a contract. Once it has been
+ * completed, it will be moved to the completed demands list for later freeing.
+ * All linked promises will be freed when the corresponding contract is freed
+ */
+static struct sun4i_dma_promise *
+generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
+		      size_t len, struct dma_slave_config *sconfig)
+{
+	struct sun4i_dma_promise *promise;
+	int ret;
+
+	promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
+	if (!promise)
+		return NULL;
+
+	promise->src = src;
+	promise->dst = dest;
+	promise->len = len;
+	promise->cfg = DDMA_CFG_LOADING | DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
+
+	/* Source burst */
+	ret = convert_burst(sconfig->src_maxburst);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= DDMA_CFG_SRC_BURST_LENGTH(ret);
+
+	/* Destination burst */
+	ret = convert_burst(sconfig->dst_maxburst);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= DDMA_CFG_DEST_BURST_LENGTH(ret);
+
+	/* Source bus width */
+	ret = convert_buswidth(sconfig->src_addr_width);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= DDMA_CFG_SRC_DATA_WIDTH(ret);
+
+	/* Destination bus width */
+	ret = convert_buswidth(sconfig->dst_addr_width);
+	if (IS_ERR_VALUE(ret))
+		goto fail;
+	promise->cfg |= DDMA_CFG_DEST_DATA_WIDTH(ret);
+
+	return promise;
+
+fail:
+	kfree(promise);
+	return NULL;
+}
+
+/**
+ * Generate a contract
+ *
+ * Contracts function as DMA descriptors. As our hardware does not support
+ * linked lists, we need to implement SG via software. We use a contract
+ * to hold all the pieces of the request and process them serially one
+ * after another. Each piece is represented as a promise.
+ */
+static struct sun4i_dma_contract *generate_dma_contract(void)
+{
+	struct sun4i_dma_contract *contract;
+
+	contract = kzalloc(sizeof(*contract), GFP_NOWAIT);
+	if (!contract)
+		return NULL;
+
+	INIT_LIST_HEAD(&contract->demands);
+	INIT_LIST_HEAD(&contract->completed_demands);
+
+	return contract;
+}
+
+/**
+ * Free a contract and all its associated promises
+ */
+static void sun4i_dma_free_contract(struct virt_dma_desc *vd)
+{
+	struct sun4i_dma_contract *contract = to_sun4i_dma_contract(vd);
+	struct sun4i_dma_promise *promise;
+
+	/* Free all the demands and completed demands */
+	list_for_each_entry(promise, &contract->demands, list) {
+		kfree(promise);
+	}
+
+	list_for_each_entry(promise, &contract->completed_demands, list) {
+		kfree(promise);
+	}
+
+	kfree(contract);
+}
+
+static struct dma_async_tx_descriptor *
+sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
+			  dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+	struct dma_slave_config *sconfig = &vchan->cfg;
+	struct sun4i_dma_promise *promise;
+	struct sun4i_dma_contract *contract;
+
+	contract = generate_dma_contract();
+	if (!contract)
+		return NULL;
+
+	if (vchan->is_dedicated)
+		promise = generate_ddma_promise(chan, src, dest, len, sconfig);
+	else
+		promise = generate_ndma_promise(chan, src, dest, len, sconfig);
+
+	if (!promise) {
+		kfree(contract);
+		return NULL;
+	}
+
+	/* Configure memcpy mode */
+	if (vchan->is_dedicated) {
+		promise->cfg |= DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+				DDMA_CFG_SRC_NON_SECURE |
+				DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+				DDMA_CFG_DEST_NON_SECURE;
+	} else {
+		promise->cfg |= NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
+				NDMA_CFG_SRC_NON_SECURE |
+				NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
+				NDMA_CFG_DEST_NON_SECURE;
+	}
+
+	/* Fill the contract with our only promise */
+	list_add_tail(&promise->list, &contract->demands);
+
+	/* And add it to the vchan */
+	return vchan_tx_prep(&vchan->vc, &contract->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *
+sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction dir,
+			unsigned long flags, void *context)
+{
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+	struct dma_slave_config *sconfig = &vchan->cfg;
+	struct sun4i_dma_promise *promise;
+	struct sun4i_dma_contract *contract;
+	struct scatterlist *sg;
+	dma_addr_t srcaddr, dstaddr;
+	u32 endpoints, para;
+	int i;
+
+	if (!sgl)
+		return NULL;
+
+	if (!is_slave_direction(dir)) {
+		dev_err(chan2dev(chan), "Invalid DMA direction\n");
+		return NULL;
+	}
+
+	contract = generate_dma_contract();
+	if (!contract)
+		return NULL;
+
+	/* Figure out endpoints */
+	if (vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
+		endpoints = DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+			    DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_LINEAR) |
+			    DDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
+			    DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_IO);
+	} else if (!vchan->is_dedicated && dir == DMA_MEM_TO_DEV) {
+		endpoints = NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
+			    NDMA_CFG_DEST_DRQ_TYPE(vchan->endpoint) |
+			    NDMA_CFG_DEST_FIXED_ADDR;
+	} else if (vchan->is_dedicated) {
+		endpoints = DDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+			    DDMA_CFG_SRC_ADDR_MODE(DDMA_ADDR_MODE_IO) |
+			    DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
+			    DDMA_CFG_DEST_ADDR_MODE(DDMA_ADDR_MODE_LINEAR);
+	} else {
+		endpoints = NDMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+			    NDMA_CFG_SRC_FIXED_ADDR |
+			    NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM);
+	}
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		/* Figure out addresses */
+		if (dir == DMA_MEM_TO_DEV) {
+			srcaddr = sg_dma_address(sg);
+			dstaddr = sconfig->dst_addr;
+			para = 0;
+		} else {
+			srcaddr = sconfig->src_addr;
+			dstaddr = sg_dma_address(sg);
+			para = 0x00010001; /* TODO spi magic? */
+		}
+
+		/* And make a suitable promise */
+		promise = generate_ddma_promise(chan, srcaddr, dstaddr,
+						sg_dma_len(sg), sconfig);
+		if (!promise)
+			return NULL; /* TODO */
+
+		promise->cfg |= endpoints;
+		promise->para = para;
+
+		/* Then add it to the contract */
+		list_add_tail(&promise->list, &contract->demands);
+	}
+
+	/* Once we've got all the promises ready, add the contract
+	 * to the pending list on the vchan */
+	return vchan_tx_prep(&vchan->vc, &contract->vd, flags);
+}
+
+static int sun4i_dma_terminate_all(struct sun4i_dma_vchan *vchan)
+{
+	struct sun4i_dma_pchan *pchan = vchan->pchan;
+	LIST_HEAD(head);
+	unsigned long flags, timeout;
+	u32 d_busy = DDMA_CFG_LOADING | DDMA_CFG_BUSY;
+	u32 n_busy = NDMA_CFG_LOADING;
+
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+	vchan_get_all_descriptors(&vchan->vc, &head);
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	/* If this vchan is operating, wait until it's no longer busy */
+	if (pchan) {
+		timeout = jiffies + msecs_to_jiffies(2000);
+		if (pchan->is_dedicated) {
+			while (readl(pchan->base + DDMA_CFG_REG) & d_busy)
+				if (time_after(jiffies, timeout))
+					return -ETIMEDOUT;
+		} else {
+			while (readl(pchan->base + NDMA_CFG_REG) & n_busy)
+				if (time_after(jiffies, timeout))
+					return -ETIMEDOUT;
+		}
+	}
+
+	/* TODO: wait until IRQ handler has run? */
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+	vchan_dma_desc_free_list(&vchan->vc, &head);
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	return 0;
+}
+
+static int sun4i_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
+			     unsigned long arg)
+{
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+	int ret = 0;
+
+	switch (cmd) {
+	case DMA_RESUME:
+	case DMA_PAUSE:
+		ret = -EINVAL;
+		break;
+
+	case DMA_TERMINATE_ALL:
+		dev_dbg(chan2dev(chan), "Terminating everything on channel\n");
+		ret = sun4i_dma_terminate_all(vchan);
+		break;
+
+	case DMA_SLAVE_CONFIG:
+		memcpy(&vchan->cfg, (void *)arg, sizeof(vchan->cfg));
+		break;
+
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+static struct dma_chan *sun4i_dma_of_xlate(struct of_phandle_args *dma_spec,
+					   struct of_dma *ofdma)
+{
+	struct sun4i_dma_dev *priv = ofdma->of_dma_data;
+	struct sun4i_dma_vchan *vchan;
+	struct dma_chan *chan;
+	u8 is_dedicated = dma_spec->args[0];
+	u8 endpoint = dma_spec->args[1];
+
+	/* Check if type is Normal or Dedicated */
+	if (is_dedicated != 0 && is_dedicated != 1)
+		return NULL;
+
+	/* Make sure the endpoint looks sane */
+	if ((is_dedicated && endpoint >= DDMA_DRQ_TYPE_LIMIT) ||
+	    (!is_dedicated && endpoint >= NDMA_DRQ_TYPE_LIMIT))
+		return NULL;
+
+	chan = dma_get_any_slave_channel(&priv->slave);
+	if (!chan)
+		return NULL;
+
+	/* Assign the endpoint to the vchan */
+	vchan = to_sun4i_dma_vchan(chan);
+	vchan->is_dedicated = is_dedicated;
+	vchan->endpoint = endpoint;
+
+	return chan;
+}
+
+static enum dma_status sun4i_dma_tx_status(struct dma_chan *chan,
+					   dma_cookie_t cookie,
+					   struct dma_tx_state *state)
+{
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+	struct sun4i_dma_pchan *pchan = vchan->pchan;
+	struct sun4i_dma_contract *contract;
+	struct sun4i_dma_promise *promise = NULL;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+	enum dma_status ret;
+	size_t bytes = 0;
+
+	ret = dma_cookie_status(chan, cookie, state);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+	vd = vchan_find_desc(&vchan->vc, cookie);
+	if (!vd) /* TODO */
+		goto exit;
+	contract = to_sun4i_dma_contract(vd);
+
+	list_for_each_entry_reverse(promise, &contract->demands, list) {
+		bytes += promise->len;
+	}
+
+	/* The hardware is configured to return the remaining byte
+	 * quantity. If possible, replace the first listed element's
+	 * full size with the actual remaining amount */
+	if (promise && pchan) {
+		bytes -= promise->len;
+		if (pchan->is_dedicated)
+			bytes += readl(pchan->base + DDMA_BYTE_COUNT_REG);
+		else
+			bytes += readl(pchan->base + NDMA_BYTE_COUNT_REG);
+	}
+
+exit:
+
+	dma_set_residue(state, bytes);
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+
+	return ret;
+}
+
+static void sun4i_dma_issue_pending(struct dma_chan *chan)
+{
+	struct sun4i_dma_dev *priv = to_sun4i_dma_dev(chan->device);
+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vchan->vc.lock, flags);
+
+	/* If there are pending transactions for this vchan, schedule
+	 * the tasklet so they are issued soon */
+	if (vchan_issue_pending(&vchan->vc))
+		tasklet_schedule(&priv->tasklet);
+
+	spin_unlock_irqrestore(&vchan->vc.lock, flags);
+}
+
+static irqreturn_t sun4i_dma_interrupt(int irq, void *dev_id)
+{
+	struct sun4i_dma_dev *priv = dev_id;
+	struct sun4i_dma_pchan *pchans = priv->pchans, *pchan;
+	struct sun4i_dma_vchan *vchan;
+	struct sun4i_dma_contract *contract;
+	unsigned long pendirq, irqs;
+	int bit;
+
+	pendirq = readl_relaxed(priv->base + DMA_IRQ_PENDING_STATUS_REG);
+	irqs = readl_relaxed(priv->base + DMA_IRQ_ENABLE_REG);
+
+	for_each_set_bit(bit, &pendirq, 32) {
+		pchan = &pchans[bit >> 1];
+		vchan = pchan->vchan;
+		contract = vchan->contract;
+
+		/* Disable the IRQ and free the pchan if it's an end
+		 * interrupt (odd bit) */
+		if (bit & 1) {
+			spin_lock(&vchan->vc.lock);
+			/* Move the promise into the completed list now that
+			 * we're done with it */
+			list_del(&vchan->processing->list);
+			list_add_tail(&vchan->processing->list, &contract->completed_demands);
+			vchan->processing = NULL;
+			vchan->pchan = NULL;
+			spin_unlock(&vchan->vc.lock);
+
+			irqs &= ~BIT(bit);
+			release_pchan(priv, pchan);
+		}
+	}
+
+	writel_relaxed(irqs, priv->base + DMA_IRQ_ENABLE_REG);
+
+	/* Writing 1 to the pending field will clear the pending interrupt */
+	writel(pendirq, priv->base + DMA_IRQ_PENDING_STATUS_REG);
+
+	tasklet_schedule(&priv->tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static void sun4i_dma_tasklet(unsigned long data)
+{
+	struct sun4i_dma_dev *priv = (void *)data;
+	int i;
+
+	for (i = 0; i < DMA_NR_MAX_VCHANS; i++)
+		execute_vchan_pending(priv, &priv->vchans[i]);
+}
+
+static int sun4i_dma_probe(struct platform_device *pdev)
+{
+	struct sun4i_dma_dev *priv;
+	struct resource *res;
+	int i, j, ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+		return priv->irq;
+	}
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "No clock specified\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	spin_lock_init(&priv->lock);
+	tasklet_init(&priv->tasklet, sun4i_dma_tasklet, (unsigned long)priv);
+
+	dma_cap_zero(priv->slave.cap_mask);
+	dma_cap_set(DMA_PRIVATE, priv->slave.cap_mask);
+	dma_cap_set(DMA_MEMCPY, priv->slave.cap_mask);
+	dma_cap_set(DMA_SLAVE, priv->slave.cap_mask);
+
+	INIT_LIST_HEAD(&priv->slave.channels);
+	priv->slave.device_alloc_chan_resources	= sun4i_dma_alloc_chan_resources;
+	priv->slave.device_free_chan_resources	= sun4i_dma_free_chan_resources;
+	priv->slave.device_tx_status		= sun4i_dma_tx_status;
+	priv->slave.device_issue_pending	= sun4i_dma_issue_pending;
+	priv->slave.device_prep_slave_sg	= sun4i_dma_prep_slave_sg;
+	priv->slave.device_prep_dma_memcpy	= sun4i_dma_prep_dma_memcpy;
+	priv->slave.device_control		= sun4i_dma_control;
+	priv->slave.chancnt			= DDMA_NR_MAX_VCHANS;
+
+	priv->slave.dev = &pdev->dev;
+
+	priv->pchans = devm_kcalloc(&pdev->dev, DMA_NR_MAX_CHANNELS,
+				    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
+	priv->vchans = devm_kcalloc(&pdev->dev, DMA_NR_MAX_VCHANS,
+				    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
+	if (!priv->vchans || !priv->pchans)
+		return -ENOMEM;
+
+	/* [0..NDMA_NR_MAX_CHANNELS) are normal pchans, and
+	 * [NDMA_NR_MAX_CHANNELS..DMA_NR_MAX_CHANNELS) are dedicated ones */
+	for (i = 0; i < NDMA_NR_MAX_CHANNELS; i++)
+		priv->pchans[i].base = priv->base + NDMA_CHANNEL_REG_BASE(i);
+	for (j = 0; i < DMA_NR_MAX_CHANNELS; i++, j++) {
+		priv->pchans[i].base = priv->base + DDMA_CHANNEL_REG_BASE(j);
+		priv->pchans[i].is_dedicated = 1;
+	}
+
+	for (i = 0; i < DMA_NR_MAX_VCHANS; i++) {
+		struct sun4i_dma_vchan *vchan = &priv->vchans[i];
+
+		spin_lock_init(&vchan->vc.lock);
+		vchan->vc.desc_free = sun4i_dma_free_contract;
+		vchan_init(&vchan->vc, &priv->slave);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't enable the clock\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt, 0,
+			       dev_name(&pdev->dev), priv);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot request IRQ\n");
+		goto err_clk_disable;
+	}
+
+	ret = dma_async_device_register(&priv->slave);
+	if (ret) {
+		dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
+		goto err_clk_disable;
+	}
+
+	ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
+					 priv);
+	if (ret) {
+		dev_err(&pdev->dev, "of_dma_controller_register failed\n");
+		goto err_dma_unregister;
+	}
+
+	dev_dbg(&pdev->dev, "Successfully probed SUN4I_DMA\n");
+
+	return 0;
+
+err_dma_unregister:
+	dma_async_device_unregister(&priv->slave);
+err_clk_disable:
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int sun4i_dma_remove(struct platform_device *pdev)
+{
+	struct sun4i_dma_dev *priv = platform_get_drvdata(pdev);
+
+	/* Disable IRQ so the tasklet doesn't schedule any longer, then
+	 * kill it */
+	disable_irq(priv->irq);
+	tasklet_kill(&priv->tasklet);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&priv->slave);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static struct of_device_id sun4i_dma_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-dma" }
+};
+
+static struct platform_driver sun4i_dma_driver = {
+	.probe	= sun4i_dma_probe,
+	.remove	= sun4i_dma_remove,
+	.driver	= {
+		.name		= "sun4i-dma",
+		.of_match_table	= sun4i_dma_match,
+	},
+};
+
+module_platform_driver(sun4i_dma_driver);
+
+MODULE_DESCRIPTION("Allwinner A10 Dedicated DMA Controller Driver");
+MODULE_AUTHOR("Emilio L?pez <emilio@elopez.com.ar>");
+MODULE_LICENSE("GPL");
-- 
2.0.0
