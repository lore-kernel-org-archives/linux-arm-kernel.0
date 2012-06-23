From: marex@denx.de (Marek Vasut)
Date: Sat, 23 Jun 2012 20:43:53 +0200
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <1340477033-2761-1-git-send-email-marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
Message-ID: <1340477033-2761-7-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is slightly reworked version of the SPI driver.
Support for DT has been added and it's been converted
to queued API.

Based on previous attempt by:
Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/spi/Kconfig   |    6 +
 drivers/spi/Makefile  |    1 +
 drivers/spi/spi-mxs.c |  407 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)
 create mode 100644 drivers/spi/spi-mxs.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..85ca6a7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -355,6 +355,12 @@ config SPI_STMP3XXX
 	help
 	  SPI driver for Freescale STMP37xx/378x SoC SSP interface
 
+config SPI_MXS
+	tristate "Freescale MXS SPI controller"
+	depends on ARCH_MXS
+	help
+	  SPI driver for Freescale MXS devices.
+
 config SPI_TEGRA
 	tristate "Nvidia Tegra SPI controller"
 	depends on ARCH_TEGRA && TEGRA_SYSTEM_DMA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9d75d21..a684d1e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
+obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
new file mode 100644
index 0000000..81a2643
--- /dev/null
+++ b/drivers/spi/spi-mxs.c
@@ -0,0 +1,407 @@
+/*
+ * Freescale MXS SPI master driver
+ *
+ * Copyright 2012 DENX Software Engineering, GmbH.
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
+ *
+ * Rework and transition to new API by:
+ * Marek Vasut <marex@denx.de>
+ *
+ * Based on previous attempt by:
+ * Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * Based on code from U-Boot bootloader by:
+ * Marek Vasut <marex@denx.de>
+ *
+ * Based on spi-stmp.c, which is:
+ * Author: Dmitry Pervushin <dimka@embeddedalley.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/highmem.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/completion.h>
+#include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
+#include <linux/module.h>
+#include <linux/fsl/mxs-dma.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/stmp_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/mxs-spi.h>
+
+#define SSP_TIMEOUT		200	/* 200 ms */
+
+static int mxs_spi_setup_transfer(struct spi_device *spi,
+				struct spi_transfer *t)
+{
+	struct mxs_ssp *ssp = spi_master_get_devdata(spi->master);
+	uint8_t bits_per_word;
+	uint32_t hz = 0;
+
+	bits_per_word = spi->bits_per_word;
+	if (t && t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+
+	if (bits_per_word != 8) {
+		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
+					__func__, bits_per_word);
+		return -EINVAL;
+	}
+
+	if (spi->max_speed_hz)
+		hz = spi->max_speed_hz;
+	if (t && t->speed_hz)
+		hz = t->speed_hz;
+	if (hz == 0) {
+		dev_err(&spi->dev, "Cannot continue with zero clock\n");
+		return -EINVAL;
+	}
+
+	mxs_ssp_set_clk_rate(ssp, hz);
+
+	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
+		     BF_SSP_CTRL1_WORD_LENGTH
+		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
+		     ((spi->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
+		     ((spi->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
+		     ssp->base + HW_SSP_CTRL1(ssp));
+
+	writel(0x0, ssp->base + HW_SSP_CMD0 + STMP_OFFSET_REG_SET);
+
+	return 0;
+}
+
+static void mxs_spi_cleanup(struct spi_device *spi)
+{
+	return;
+}
+
+/* the spi->mode bits understood by this driver: */
+static int mxs_spi_setup(struct spi_device *spi)
+{
+	int err = 0;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~(SPI_CPOL | SPI_CPHA))
+		return -EINVAL;
+
+	err = mxs_spi_setup_transfer(spi, NULL);
+	if (err) {
+		dev_err(&spi->dev,
+			"Failed to setup transfer, error = %d\n", err);
+	}
+
+	return err;
+}
+
+static void mxs_spi_set_cs(struct mxs_ssp *ssp, unsigned cs)
+{
+	const uint32_t mask =
+		BM_SSP_CTRL0_WAIT_FOR_CMD | BM_SSP_CTRL0_WAIT_FOR_IRQ;
+	uint32_t select = 0;
+
+	writel(mask, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+
+	if (cs & 1)
+		select |= BM_SSP_CTRL0_WAIT_FOR_CMD;
+	if (cs & 2)
+		select |= BM_SSP_CTRL0_WAIT_FOR_IRQ;
+
+	writel(select, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+}
+
+static inline void mxs_spi_enable(struct mxs_ssp *ssp)
+{
+	writel(BM_SSP_CTRL0_LOCK_CS,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+	writel(BM_SSP_CTRL0_IGNORE_CRC,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+}
+
+static inline void mxs_spi_disable(struct mxs_ssp *ssp)
+{
+	writel(BM_SSP_CTRL0_LOCK_CS,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+	writel(BM_SSP_CTRL0_IGNORE_CRC,
+		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+}
+
+static int mxs_ssp_wait_set(struct mxs_ssp *ssp, int offset, int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+
+	while (!(readl_relaxed(ssp->base + offset) & mask)) {
+		udelay(1);
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int mxs_ssp_wait_clr(struct mxs_ssp *ssp, int offset, int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+
+	while ((readl_relaxed(ssp->base + offset) & mask)) {
+		udelay(1);
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int mxs_spi_txrx_pio(struct mxs_ssp *ssp, int cs,
+			    unsigned char *buf, int len,
+			    int *first, int *last, int write)
+{
+	if (*first) {
+		mxs_spi_enable(ssp);
+		*first = 0;
+	}
+
+	mxs_spi_set_cs(ssp, cs);
+
+	while (len--) {
+		if (*last && len == 0) {
+			mxs_spi_disable(ssp);
+			*last = 0;
+		}
+
+		if (ssp->devid == IMX23_SSP) {
+			writel(BM_SSP_CTRL0_XFER_COUNT,
+				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+			writel(1,
+				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+		} else {
+			writel(1, ssp->base + HW_SSP_XFER_SIZE);
+		}
+
+		if (write)
+			writel(BM_SSP_CTRL0_READ,
+				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+		else
+			writel(BM_SSP_CTRL0_READ,
+				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+
+		writel(BM_SSP_CTRL0_RUN,
+				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+
+		if (mxs_ssp_wait_set(ssp, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
+			return -ETIMEDOUT;
+
+		if (write)
+			writel(*buf, ssp->base + HW_SSP_DATA);
+
+		writel(BM_SSP_CTRL0_DATA_XFER,
+			     ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+
+		if (!write) {
+			if (mxs_ssp_wait_clr(ssp, HW_SSP_STATUS(ssp),
+						BM_SSP_STATUS_FIFO_EMPTY))
+				return -ETIMEDOUT;
+
+			*buf = (readl(ssp->base + HW_SSP_DATA) & 0xff);
+		}
+
+		if (mxs_ssp_wait_clr(ssp, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
+			return -ETIMEDOUT;
+
+		buf++;
+	}
+
+	if (len <= 0)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int mxs_spi_transfer_one(struct spi_master *spi, struct spi_message *m)
+{
+	struct mxs_ssp *ssp = spi_master_get_devdata(spi);
+	int first, last;
+	struct spi_transfer *t, *tmp_t;
+	int status = 0;
+	int cs;
+
+	first = last = 0;
+
+	cs = m->spi->chip_select;
+
+	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
+
+		mxs_spi_setup_transfer(m->spi, t);
+
+		if (&t->transfer_list == m->transfers.next)
+			first = !0;
+		if (&t->transfer_list == m->transfers.prev)
+			last = !0;
+		if (t->rx_buf && t->tx_buf) {
+			pr_debug("%s: cannot send and receive simultaneously\n",
+				 __func__);
+			return -EINVAL;
+		}
+
+		if (t->tx_buf)
+			status = mxs_spi_txrx_pio(ssp, cs, (void *)t->tx_buf,
+					     t->len, &first, &last, 1);
+		if (t->rx_buf)
+			status = mxs_spi_txrx_pio(ssp, cs, t->rx_buf,
+					     t->len, &first, &last, 0);
+		m->actual_length += t->len;
+		if (status)
+			break;
+
+		first = last = 0;
+	}
+
+	m->status = 0;
+	spi_finalize_current_message(spi);
+
+	return status;
+}
+
+static const struct of_device_id mxs_spi_dt_ids[] = {
+	{ .compatible = "fsl,imx23-spi", .data = (void *) IMX23_SSP, },
+	{ .compatible = "fsl,imx28-spi", .data = (void *) IMX28_SSP, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_spi_dt_ids);
+
+static int __devinit mxs_spi_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+			of_match_device(mxs_spi_dt_ids, &pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	struct spi_master *host;
+	struct mxs_ssp *ssp;
+	struct resource *iores;
+	struct pinctrl *pinctrl;
+	int ret = 0;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -EINVAL;
+
+	host = spi_alloc_master(&pdev->dev, sizeof(struct mxs_ssp));
+	if (!host)
+		return -ENOMEM;
+
+	ssp = spi_master_get_devdata(host);
+	ssp->dev = &pdev->dev;
+	ssp->base = devm_request_and_ioremap(&pdev->dev, iores);
+	if (!ssp->base) {
+		ret = -EADDRNOTAVAIL;
+		goto out_spi_free;
+	}
+
+	if (np)
+		ssp->devid = (enum mxs_ssp_id) of_id->data;
+	else
+		ssp->devid = pdev->id_entry->driver_data;
+
+	host->transfer_one_message = mxs_spi_transfer_one;
+	host->setup = mxs_spi_setup;
+	host->cleanup = mxs_spi_cleanup;
+	host->mode_bits = SPI_CPOL | SPI_CPHA;
+	host->num_chipselect = 3;
+	host->dev.of_node = np;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto out_spi_free;
+	}
+
+	ssp->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk)) {
+		ret = PTR_ERR(ssp->clk);
+		goto out_spi_free;
+	}
+
+	clk_prepare_enable(ssp->clk);
+	ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
+
+	stmp_reset_block(ssp->base);
+
+	platform_set_drvdata(pdev, host);
+
+	ret = spi_register_master(host);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot register SPI master, %d\n", ret);
+		goto out_clk_put;
+	}
+
+	return 0;
+
+out_clk_put:
+	clk_disable_unprepare(ssp->clk);
+	clk_put(ssp->clk);
+out_spi_free:
+	spi_master_put(host);
+	return ret;
+}
+
+static int __devexit mxs_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *host;
+	struct mxs_ssp *ssp;
+
+	host = platform_get_drvdata(pdev);
+	if (host)
+		return 0;
+
+	ssp = spi_master_get_devdata(host);
+
+	spi_unregister_master(host);
+
+	platform_set_drvdata(pdev, NULL);
+
+	clk_disable_unprepare(ssp->clk);
+	clk_put(ssp->clk);
+
+	spi_master_put(host);
+
+	return 0;
+}
+
+static struct platform_driver mxs_spi_driver = {
+	.probe	= mxs_spi_probe,
+	.remove	= __devexit_p(mxs_spi_remove),
+	.driver	= {
+		.name	= "mxs-spi",
+		.owner	= THIS_MODULE,
+		.of_match_table = mxs_spi_dt_ids,
+	},
+};
+
+module_platform_driver(mxs_spi_driver);
+
+MODULE_AUTHOR("Dmitry Pervushin <dimka@embeddedalley.com>");
+MODULE_DESCRIPTION("MXS SPI master driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxs-spi");
-- 
1.7.10
