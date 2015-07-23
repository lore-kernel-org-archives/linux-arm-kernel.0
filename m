From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 23 Jul 2015 17:10:42 +0800
Subject: [PATCH v3 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1437642643-11966-1-git-send-email-leilk.liu@mediatek.com>
References: <1437642643-11966-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1437642643-11966-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic spi bus for MT8173.

Change-Id: I52a48526105f3de49f6253d1ffb449759a2a8140
Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/Kconfig                      |   9 +
 drivers/spi/Makefile                     |   1 +
 drivers/spi/spi-mt65xx.c                 | 817 +++++++++++++++++++++++++++++++
 include/linux/platform_data/spi-mt65xx.h |  22 +
 4 files changed, 849 insertions(+)
 create mode 100644 drivers/spi/spi-mt65xx.c
 create mode 100644 include/linux/platform_data/spi-mt65xx.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0cae169..38ddfba 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -326,6 +326,15 @@ config SPI_MESON_SPIFC
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic Meson SoCs.
 
+config SPI_MT65XX
+	tristate "MediaTek SPI controller"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  This selects the MediaTek(R) SPI bus driver.
+	  If you want to use MediaTek(R) SPI interface,
+	  say Y or M here.If you are not sure, say N.
+	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
+
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 1154dba..9746beb2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
+obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
new file mode 100644
index 0000000..1ed5c44
--- /dev/null
+++ b/drivers/spi/spi-mt65xx.c
@@ -0,0 +1,817 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Leilk Liu <leilk.liu@mediatek.com>
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
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/spi-mt65xx.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+
+#define SPI_CFG0_REG                      0x0000
+#define SPI_CFG1_REG                      0x0004
+#define SPI_TX_SRC_REG                    0x0008
+#define SPI_RX_DST_REG                    0x000c
+#define SPI_TX_DATA_REG                   0x0010
+#define SPI_RX_DATA_REG                   0x0014
+#define SPI_CMD_REG                       0x0018
+#define SPI_STATUS0_REG                   0x001c
+#define SPI_PAD_SEL_REG                   0x0024
+
+#define SPI_CFG0_SCK_HIGH_OFFSET          0
+#define SPI_CFG0_SCK_LOW_OFFSET           8
+#define SPI_CFG0_CS_HOLD_OFFSET           16
+#define SPI_CFG0_CS_SETUP_OFFSET          24
+
+#define SPI_CFG1_CS_IDLE_OFFSET           0
+#define SPI_CFG1_PACKET_LOOP_OFFSET       8
+#define SPI_CFG1_PACKET_LENGTH_OFFSET     16
+#define SPI_CFG1_GET_TICK_DLY_OFFSET      30
+
+#define SPI_CFG1_CS_IDLE_MASK             0xff
+#define SPI_CFG1_PACKET_LOOP_MASK         0xff00
+#define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
+
+#define SPI_CMD_ACT_OFFSET                0
+#define SPI_CMD_RESUME_OFFSET             1
+#define SPI_CMD_CPHA_OFFSET               8
+#define SPI_CMD_CPOL_OFFSET               9
+#define SPI_CMD_TXMSBF_OFFSET             12
+#define SPI_CMD_RXMSBF_OFFSET             13
+#define SPI_CMD_RX_ENDIAN_OFFSET          14
+#define SPI_CMD_TX_ENDIAN_OFFSET          15
+
+#define SPI_CMD_RST                  BIT(2)
+#define SPI_CMD_PAUSE_EN             BIT(4)
+#define SPI_CMD_DEASSERT             BIT(5)
+#define SPI_CMD_CPHA                 BIT(8)
+#define SPI_CMD_CPOL                 BIT(9)
+#define SPI_CMD_RX_DMA               BIT(10)
+#define SPI_CMD_TX_DMA               BIT(11)
+#define SPI_CMD_TXMSBF               BIT(12)
+#define SPI_CMD_RXMSBF               BIT(13)
+#define SPI_CMD_RX_ENDIAN            BIT(14)
+#define SPI_CMD_TX_ENDIAN            BIT(15)
+#define SPI_CMD_FINISH_IE            BIT(16)
+#define SPI_CMD_PAUSE_IE             BIT(17)
+
+#define MTK_SPI_QUIRK_PAD_SELECT 1
+/* Must explicitly send dummy Tx bytes to do Rx only transfer */
+#define MTK_SPI_QUIRK_MUST_TX 1
+
+#define MT8173_SPI_MAX_PAD_SEL 3
+
+#define MTK_SPI_IDLE 0
+#define MTK_SPI_PAUSED 1
+
+#define MTK_SPI_MAX_FIFO_SIZE 32
+#define MTK_SPI_PACKET_SIZE 1024
+
+struct mtk_spi_compatible {
+	u32 need_pad_sel;
+	u32 must_tx;
+};
+
+struct mtk_spi {
+	void __iomem *base;
+	u32 state;
+	u32 pad_sel;
+	bool use_dma;
+	struct clk *clk;
+	struct spi_transfer *cur_transfer;
+	struct scatterlist *tx_sgl, *rx_sgl;
+	u32 tx_sgl_len, rx_sgl_len;
+	const struct mtk_spi_compatible *dev_comp;
+};
+
+static const struct mtk_spi_compatible mt6589_compat = {
+	.need_pad_sel = 0,
+	.must_tx = 0,
+};
+
+static const struct mtk_spi_compatible mt8135_compat = {
+	.need_pad_sel = 0,
+	.must_tx = 0,
+};
+
+static const struct mtk_spi_compatible mt8173_compat = {
+	.need_pad_sel = MTK_SPI_QUIRK_PAD_SELECT,
+	.must_tx = MTK_SPI_QUIRK_MUST_TX,
+};
+
+/*
+ * A piece of default chip info unless the platform
+ * supplies it.
+ */
+static const struct mtk_chip_config mtk_default_chip_info = {
+	.rx_mlsb = 1,
+	.tx_mlsb = 1,
+	.tx_endian = 0,
+	.rx_endian = 0,
+};
+
+static const struct of_device_id mtk_spi_of_match[] = {
+	{ .compatible = "mediatek,mt6589-spi", .data = (void *)&mt6589_compat },
+	{ .compatible = "mediatek,mt8135-spi", .data = (void *)&mt8135_compat },
+	{ .compatible = "mediatek,mt8173-spi", .data = (void *)&mt8173_compat },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
+
+static void mtk_spi_reset(struct mtk_spi *mdata)
+{
+	u32 reg_val;
+
+	/* set the software reset bit in SPI_CMD_REG. */
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	reg_val |= SPI_CMD_RST;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	reg_val &= ~SPI_CMD_RST;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+}
+
+static void mtk_spi_config(struct mtk_spi *mdata,
+			   struct mtk_chip_config *chip_config)
+{
+	u32 reg_val;
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+
+	/* set the mlsbx and mlsbtx */
+	reg_val &= ~(SPI_CMD_TXMSBF | SPI_CMD_RXMSBF);
+	reg_val |= (chip_config->tx_mlsb << SPI_CMD_TXMSBF_OFFSET);
+	reg_val |= (chip_config->rx_mlsb << SPI_CMD_RXMSBF_OFFSET);
+
+	/* set the tx/rx endian */
+	reg_val &= ~(SPI_CMD_TX_ENDIAN | SPI_CMD_RX_ENDIAN);
+	reg_val |= (chip_config->tx_endian << SPI_CMD_TX_ENDIAN_OFFSET);
+	reg_val |= (chip_config->rx_endian << SPI_CMD_RX_ENDIAN_OFFSET);
+
+	/* set finish and pause interrupt always enable */
+	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_EN;
+
+	/* disable dma mode */
+	reg_val &= ~(SPI_CMD_TX_DMA | SPI_CMD_RX_DMA);
+
+	/* disable deassert mode */
+	reg_val &= ~SPI_CMD_DEASSERT;
+
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+
+	/* pad select */
+	if (mdata->dev_comp->need_pad_sel)
+		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
+}
+
+static int mtk_spi_prepare_hardware(struct spi_master *master)
+{
+	struct spi_transfer *trans;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_message *msg = master->cur_msg;
+	int ret;
+
+	ret = clk_prepare_enable(mdata->clk);
+	if (ret < 0) {
+		dev_err(&master->dev, "failed to enable clock (%d)\n", ret);
+		return ret;
+	}
+
+	trans = list_first_entry(&msg->transfers, struct spi_transfer,
+				 transfer_list);
+	if (trans->cs_change == 0) {
+		mdata->state = MTK_SPI_IDLE;
+		mtk_spi_reset(mdata);
+	}
+
+	return ret;
+}
+
+static int mtk_spi_unprepare_hardware(struct spi_master *master)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(mdata->clk);
+
+	return 0;
+}
+
+static int mtk_spi_prepare_message(struct spi_master *master,
+				   struct spi_message *msg)
+{
+	u32 reg_val;
+	u8 cpha, cpol;
+	struct mtk_chip_config *chip_config;
+	struct spi_device *spi = msg->spi;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	cpha = spi->mode & SPI_CPHA ? 1 : 0;
+	cpol = spi->mode & SPI_CPOL ? 1 : 0;
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	reg_val &= ~(SPI_CMD_CPHA | SPI_CMD_CPOL);
+	reg_val |= (cpha << SPI_CMD_CPHA_OFFSET);
+	reg_val |= (cpol << SPI_CMD_CPOL_OFFSET);
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+
+	chip_config = spi->controller_data;
+	if (!chip_config) {
+		chip_config = (void *)&mtk_default_chip_info;
+		spi->controller_data = chip_config;
+	}
+	mtk_spi_config(mdata, chip_config);
+
+	return 0;
+}
+
+static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	u32 reg_val;
+	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	if (!enable)
+		reg_val |= SPI_CMD_PAUSE_EN;
+	else
+		reg_val &= ~SPI_CMD_PAUSE_EN;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
+}
+
+static void mtk_spi_prepare_transfer(struct spi_master *master,
+				     struct spi_transfer *xfer)
+{
+	u32 spi_clk_hz, div, high_time, low_time, holdtime,
+	    setuptime, cs_idletime, reg_val = 0;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	spi_clk_hz = clk_get_rate(mdata->clk);
+	if (xfer->speed_hz < spi_clk_hz / 2)
+		div = DIV_ROUND_UP(spi_clk_hz, xfer->speed_hz);
+	else
+		div = 1;
+
+	high_time = (div + 1) / 2;
+	low_time = (div + 1) / 2;
+	holdtime = (div + 1) / 2 * 2;
+	setuptime = (div + 1) / 2 * 2;
+	cs_idletime = (div + 1) / 2 * 2;
+
+	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
+	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
+	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
+	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
+	writel(reg_val, mdata->base + SPI_CFG0_REG);
+
+	reg_val = readl(mdata->base + SPI_CFG1_REG);
+	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
+	reg_val |= (((cs_idletime - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
+	writel(reg_val, mdata->base + SPI_CFG1_REG);
+}
+
+static void mtk_spi_setup_packet(struct spi_master *master,
+				 struct spi_transfer *xfer)
+{
+	u32 packet_size, packet_loop, reg_val;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	packet_size = min_t(unsigned, xfer->len, MTK_SPI_PACKET_SIZE);
+	packet_loop = xfer->len / packet_size;
+
+	reg_val = readl(mdata->base + SPI_CFG1_REG);
+	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
+	reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
+	reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
+	writel(reg_val, mdata->base + SPI_CFG1_REG);
+}
+
+static int mtk_spi_enable_transfer(struct mtk_spi *mdata)
+{
+	int cmd;
+
+	cmd = readl(mdata->base + SPI_CMD_REG);
+
+	/* trigger to transfer */
+	if (mdata->state == MTK_SPI_IDLE)
+		cmd |= 1 << SPI_CMD_ACT_OFFSET;
+	else if (mdata->state == MTK_SPI_PAUSED)
+		cmd |= 1 << SPI_CMD_RESUME_OFFSET;
+	else
+		return -1;
+
+	writel(cmd, mdata->base + SPI_CMD_REG);
+
+	return 0;
+}
+
+static int mtk_spi_fifo_transfer(struct spi_master *master,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	int ret, cnt, i;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	mdata->cur_transfer = xfer;
+	mtk_spi_prepare_transfer(master, xfer);
+	mtk_spi_setup_packet(master, xfer);
+
+	cnt = (xfer->len % 4) ? (xfer->len / 4 + 1) : (xfer->len / 4);
+	for (i = 0; i < cnt; i++)
+		writel(*((u32 *)xfer->tx_buf + i),
+		       mdata->base + SPI_TX_DATA_REG);
+
+	ret = mtk_spi_enable_transfer(mdata);
+	if (ret != 0)
+		return ret;
+
+	return 1;
+}
+
+static int mtk_spi_dma_transfer(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	int cmd, ret, mult_len;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	mdata->cur_transfer = xfer;
+	mdata->tx_sgl = NULL;
+	mdata->rx_sgl = NULL;
+	mdata->tx_sgl_len = 0;
+	mdata->rx_sgl_len = 0;
+
+	mtk_spi_prepare_transfer(master, xfer);
+
+	cmd = readl(mdata->base + SPI_CMD_REG);
+	if (xfer->tx_buf)
+		cmd |= SPI_CMD_TX_DMA;
+	if (xfer->rx_buf)
+		cmd |= SPI_CMD_RX_DMA;
+	writel(cmd, mdata->base + SPI_CMD_REG);
+
+	if (xfer->tx_buf)
+		mdata->tx_sgl = xfer->tx_sg.sgl;
+	if (xfer->rx_buf)
+		mdata->rx_sgl = xfer->rx_sg.sgl;
+
+	if (mdata->tx_sgl) {
+		xfer->tx_dma = sg_dma_address(mdata->tx_sgl);
+		mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
+	}
+	if (mdata->rx_sgl) {
+		xfer->rx_dma = sg_dma_address(mdata->rx_sgl);
+		mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
+	}
+
+	if (mdata->tx_sgl_len && mdata->rx_sgl_len) {
+		if (mdata->tx_sgl_len > mdata->rx_sgl_len) {
+			if (mdata->rx_sgl_len > MTK_SPI_PACKET_SIZE)
+				mult_len = mdata->rx_sgl_len
+						% MTK_SPI_PACKET_SIZE;
+			else
+				mult_len = 0;
+
+			if (mult_len) {
+				xfer->len = mdata->rx_sgl_len - mult_len;
+				mdata->rx_sgl_len = mult_len;
+			} else {
+				xfer->len = mdata->rx_sgl_len;
+				mdata->rx_sgl_len = 0;
+			}
+			mdata->tx_sgl_len -= xfer->len;
+		} else {
+			if (mdata->tx_sgl_len > MTK_SPI_PACKET_SIZE)
+				mult_len = mdata->tx_sgl_len
+						% MTK_SPI_PACKET_SIZE;
+			else
+				mult_len = 0;
+
+			if (mult_len) {
+				xfer->len = mdata->tx_sgl_len - mult_len;
+				mdata->tx_sgl_len = mult_len;
+			} else {
+				xfer->len = mdata->tx_sgl_len;
+				mdata->tx_sgl_len = 0;
+			}
+			mdata->rx_sgl_len -= xfer->len;
+		}
+	} else if (mdata->tx_sgl_len) {
+		if (mdata->tx_sgl_len > MTK_SPI_PACKET_SIZE)
+			mult_len = mdata->tx_sgl_len % MTK_SPI_PACKET_SIZE;
+		else
+			mult_len = 0;
+
+		if (mult_len) {
+			xfer->len = mdata->tx_sgl_len - mult_len;
+			mdata->tx_sgl_len = mult_len;
+		} else {
+			xfer->len = mdata->tx_sgl_len;
+			mdata->tx_sgl_len = 0;
+		}
+	} else if (mdata->rx_sgl_len) {
+		if (mdata->rx_sgl_len > MTK_SPI_PACKET_SIZE)
+			mult_len = mdata->rx_sgl_len % MTK_SPI_PACKET_SIZE;
+		else
+			mult_len = 0;
+
+		if (mult_len) {
+			xfer->len = mdata->rx_sgl_len - mult_len;
+			mdata->rx_sgl_len = mult_len;
+		} else {
+			xfer->len = mdata->rx_sgl_len;
+			mdata->rx_sgl_len = 0;
+		}
+	}
+
+	mtk_spi_setup_packet(master, xfer);
+
+	/* set up the DMA bus address */
+	writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
+	writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
+
+	ret = mtk_spi_enable_transfer(mdata);
+	if (ret != 0)
+		return ret;
+
+	return 1;
+}
+
+static int mtk_spi_transfer_one(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	if (mdata->use_dma)
+		return mtk_spi_dma_transfer(master, spi, xfer);
+	else
+		return mtk_spi_fifo_transfer(master, spi, xfer);
+}
+
+static bool mtk_spi_can_dma(struct spi_master *master,
+			    struct spi_device *spi,
+			    struct spi_transfer *xfer)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	if (xfer->len > MTK_SPI_MAX_FIFO_SIZE)
+		mdata->use_dma = true;
+	else
+		mdata->use_dma = false;
+
+	return mdata->use_dma;
+}
+
+static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
+{
+	u32 cmd, reg_val, i, mult_len;
+	struct spi_master *master = dev_id;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	struct spi_transfer *trans = mdata->cur_transfer;
+
+	reg_val = readl(mdata->base + SPI_STATUS0_REG);
+	if (reg_val & 0x2)
+		mdata->state = MTK_SPI_PAUSED;
+	else
+		mdata->state = MTK_SPI_IDLE;
+
+	if (!mdata->use_dma) {
+		if (trans->rx_buf) {
+			for (i = 0; i < trans->len; i++) {
+				if (i % 4 == 0)
+					reg_val =
+					readl(mdata->base + SPI_RX_DATA_REG);
+				*((u8 *)(trans->rx_buf + i)) =
+					(reg_val >> ((i % 4) * 8)) & 0xff;
+			}
+		}
+		spi_finalize_current_transfer(master);
+		return IRQ_HANDLED;
+	}
+
+	if (mdata->tx_sgl)
+		trans->tx_dma += trans->len;
+	if (mdata->rx_sgl)
+		trans->rx_dma += trans->len;
+
+	if (mdata->tx_sgl && (mdata->tx_sgl_len == 0)) {
+		mdata->tx_sgl = sg_next(mdata->tx_sgl);
+		if (mdata->tx_sgl) {
+			trans->tx_dma = sg_dma_address(mdata->tx_sgl);
+			mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
+		}
+	}
+	if (mdata->rx_sgl && (mdata->rx_sgl_len == 0)) {
+		mdata->rx_sgl = sg_next(mdata->rx_sgl);
+		if (mdata->rx_sgl) {
+			trans->rx_dma = sg_dma_address(mdata->rx_sgl);
+			mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
+		}
+	}
+
+	if (mdata->tx_sgl_len && mdata->rx_sgl_len) {
+		if (mdata->tx_sgl_len > mdata->rx_sgl_len) {
+			if (mdata->rx_sgl_len > MTK_SPI_PACKET_SIZE)
+				mult_len = mdata->rx_sgl_len
+						% MTK_SPI_PACKET_SIZE;
+			else
+				mult_len = 0;
+
+			if (mult_len) {
+				trans->len = mdata->rx_sgl_len - mult_len;
+				mdata->rx_sgl_len = mult_len;
+			} else {
+				trans->len = mdata->rx_sgl_len;
+				mdata->rx_sgl_len = 0;
+			}
+			mdata->tx_sgl_len -= trans->len;
+		} else {
+			if (mdata->rx_sgl_len > MTK_SPI_PACKET_SIZE)
+				mult_len = mdata->tx_sgl_len
+						% MTK_SPI_PACKET_SIZE;
+			else
+				mult_len = 0;
+
+			if (mult_len) {
+				trans->len = mdata->tx_sgl_len - mult_len;
+				mdata->tx_sgl_len = mult_len;
+			} else {
+				trans->len = mdata->tx_sgl_len;
+				mdata->tx_sgl_len = 0;
+			}
+			mdata->rx_sgl_len -= trans->len;
+		}
+	} else if (mdata->tx_sgl_len) {
+		if (mdata->tx_sgl_len > MTK_SPI_PACKET_SIZE)
+			mult_len = mdata->tx_sgl_len % MTK_SPI_PACKET_SIZE;
+		else
+			mult_len = 0;
+
+		if (mult_len) {
+			trans->len = mdata->tx_sgl_len - mult_len;
+			mdata->tx_sgl_len = mult_len;
+		} else {
+			trans->len = mdata->tx_sgl_len;
+			mdata->tx_sgl_len = 0;
+		}
+	} else if (mdata->rx_sgl_len) {
+		if (mdata->rx_sgl_len > MTK_SPI_PACKET_SIZE)
+			mult_len = mdata->rx_sgl_len % MTK_SPI_PACKET_SIZE;
+		else
+			mult_len = 0;
+
+		if (mult_len) {
+			trans->len = mdata->rx_sgl_len - mult_len;
+			mdata->rx_sgl_len = mult_len;
+		} else {
+			trans->len = mdata->rx_sgl_len;
+			mdata->rx_sgl_len = 0;
+		}
+	}
+
+	if (!mdata->tx_sgl && !mdata->rx_sgl) {
+		/* spi disable dma */
+		cmd = readl(mdata->base + SPI_CMD_REG);
+		cmd &= ~SPI_CMD_TX_DMA;
+		cmd &= ~SPI_CMD_RX_DMA;
+		writel(cmd, mdata->base + SPI_CMD_REG);
+
+		spi_finalize_current_transfer(master);
+		return IRQ_HANDLED;
+	}
+
+	mtk_spi_setup_packet(master, trans);
+
+	/* set up the DMA bus address */
+	writel(cpu_to_le32(trans->tx_dma), mdata->base + SPI_TX_SRC_REG);
+	writel(cpu_to_le32(trans->rx_dma), mdata->base + SPI_RX_DST_REG);
+
+	mtk_spi_enable_transfer(mdata);
+	return IRQ_HANDLED;
+}
+
+static int mtk_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct mtk_spi *mdata;
+	const struct of_device_id *of_id;
+	struct resource *res;
+	int	irq, ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
+	if (!master) {
+		dev_err(&pdev->dev, "failed to alloc spi master\n");
+		return -ENOMEM;
+	}
+
+	master->auto_runtime_pm = true;
+	master->dev.of_node = pdev->dev.of_node;
+	master->mode_bits = SPI_CPOL | SPI_CPHA;
+
+	master->set_cs = mtk_spi_set_cs;
+	master->prepare_transfer_hardware = mtk_spi_prepare_hardware;
+	master->unprepare_transfer_hardware = mtk_spi_unprepare_hardware;
+	master->prepare_message = mtk_spi_prepare_message;
+	master->transfer_one = mtk_spi_transfer_one;
+	master->can_dma = mtk_spi_can_dma;
+
+	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
+	if (!of_id) {
+		dev_err(&pdev->dev, "failed to probe of_node\n");
+		ret = -EINVAL;
+		goto err_put_master;
+	}
+
+	mdata = spi_master_get_devdata(master);
+	mdata->dev_comp = of_id->data;
+	if (mdata->dev_comp->must_tx)
+		master->flags = SPI_MASTER_MUST_TX;
+
+	if (mdata->dev_comp->need_pad_sel) {
+		ret = of_property_read_u32(pdev->dev.of_node, "pad-select",
+					   &mdata->pad_sel);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to read pad select: %d\n",
+				ret);
+			goto err_put_master;
+		}
+
+		if (mdata->pad_sel > MT8173_SPI_MAX_PAD_SEL) {
+			dev_err(&pdev->dev, "wrong pad-select: %u\n",
+				mdata->pad_sel);
+			ret = -EINVAL;
+			goto err_put_master;
+		}
+	}
+
+	platform_set_drvdata(pdev, master);
+
+	mdata->clk = devm_clk_get(&pdev->dev, "main");
+	if (IS_ERR(mdata->clk)) {
+		ret = PTR_ERR(mdata->clk);
+		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
+		goto err_put_master;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		dev_err(&pdev->dev, "failed to determine base address\n");
+		goto err_put_master;
+	}
+
+	mdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mdata->base)) {
+		ret = PTR_ERR(mdata->base);
+		goto err_put_master;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq (%d)\n", irq);
+		ret = irq;
+		goto err_put_master;
+	}
+
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+
+	ret = clk_prepare_enable(mdata->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
+		goto err_put_master;
+	}
+	clk_disable_unprepare(mdata->clk);
+
+	ret = devm_request_irq(&pdev->dev, irq, mtk_spi_interrupt,
+			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), master);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
+		goto err_put_master;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
+		goto err_put_master;
+	}
+
+	return 0;
+
+err_put_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int mtk_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	pm_runtime_disable(&pdev->dev);
+
+	mtk_spi_reset(mdata);
+	clk_disable_unprepare(mdata->clk);
+	spi_master_put(master);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mtk_spi_suspend(struct device *dev)
+{
+	int ret;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		clk_disable_unprepare(mdata->clk);
+
+	return ret;
+}
+
+static int mtk_spi_resume(struct device *dev)
+{
+	int ret;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = clk_prepare_enable(mdata->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = spi_master_resume(master);
+	if (ret < 0)
+		clk_disable_unprepare(mdata->clk);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int mtk_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(mdata->clk);
+
+	return 0;
+}
+
+static int mtk_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	return clk_prepare_enable(mdata->clk);
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops mtk_spi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_spi_suspend, mtk_spi_resume)
+	SET_RUNTIME_PM_OPS(mtk_spi_runtime_suspend,
+			   mtk_spi_runtime_resume, NULL)
+};
+
+struct platform_driver mtk_spi_driver = {
+	.driver = {
+		.name = "mtk-spi",
+		.pm	= &mtk_spi_pm,
+		.of_match_table = mtk_spi_of_match,
+	},
+	.probe = mtk_spi_probe,
+	.remove = mtk_spi_remove,
+};
+
+module_platform_driver(mtk_spi_driver);
+
+MODULE_DESCRIPTION("MTK SPI Controller driver");
+MODULE_AUTHOR("Leilk Liu <leilk.liu@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform: mtk_spi");
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
new file mode 100644
index 0000000..7512255
--- /dev/null
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -0,0 +1,22 @@
+/*
+ *  MTK SPI bus driver definitions
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Leilk Liu <leilk.liu@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ____LINUX_PLATFORM_DATA_SPI_MTK_H
+#define ____LINUX_PLATFORM_DATA_SPI_MTK_H
+
+/* Board specific platform_data */
+struct mtk_chip_config {
+	u32 tx_mlsb;
+	u32 rx_mlsb;
+	u32 tx_endian;
+	u32 rx_endian;
+};
+#endif
-- 
1.8.1.1.dirty
