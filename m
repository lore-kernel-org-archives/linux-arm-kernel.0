From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 11:58:28 +0800
Subject: [PATCH 2/2] spi: Add Freescale QuadSpi driver
In-Reply-To: <1371809590-29648-1-git-send-email-b41219@freescale.com>
References: <1371809590-29648-1-git-send-email-b41219@freescale.com>
Message-ID: <20130624035826.GA25856@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:13:10PM +0800, Xiaochun Li wrote:
> Add QuadSpi driver for Freescale's Quad Spi controller.
> This controller is designed for serial flash access.
> This driver has been tested on vf610-twr board with m25p80 type chips.
> The hardware has no support for other types of spi peripherals.
> Chip select control is handled via Serial Flash Address Register.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> ---
>  drivers/spi/Kconfig           |   5 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-fsl-quadspi.c | 595 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/spi-fsl-quadspi.h | 167 ++++++++++++
>  4 files changed, 768 insertions(+)
>  create mode 100644 drivers/spi/spi-fsl-quadspi.c
>  create mode 100644 drivers/spi/spi-fsl-quadspi.h

There should be a binding doc along with the patch.  Check
Documentation/devicetree/bindings/spi/ for examples.

> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2015897..3c8b72c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -198,6 +198,11 @@ config SPI_IMX
>  	  This enables using the Freescale i.MX SPI controllers in master
>  	  mode.
>  
> +config SPI_FSL_QUADSPI
> +        tristate "Freescale Quad SPI controller"

I see indentation problem here, probably because you're using spaces
here.

> +	help
> +	  This enables support for the Quad SPI controller in master mode.
> +
>  config SPI_LM70_LLP
>  	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
>  	depends on PARPORT
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 33f9c09..c56aa2e 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>  obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
> +obj-$(CONFIG_SPI_FSL_QUADSPI)           += spi-fsl-quadspi.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
> diff --git a/drivers/spi/spi-fsl-quadspi.c b/drivers/spi/spi-fsl-quadspi.c
> new file mode 100644
> index 0000000..ceb46ab
> --- /dev/null
> +++ b/drivers/spi/spi-fsl-quadspi.c
> @@ -0,0 +1,595 @@
> +/*
> + * Freescale Quad SPI driver.
> + *
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/timer.h>
> +#include <linux/jiffies.h>
> +
> +#include "spi-fsl-quadspi.h"

If the header is only used by this file, we do not have to have the
header.  It's always easier to search definitions in a single file than
in two.

> +
> +static inline unsigned int fsl_qspi_check_status(struct fsl_qspi *fsl_qspi)

fsl_qspi_check_busy() could be a better name.

> +{
> +	return readl(fsl_qspi->iobase + QUADSPI_SR) & QSPI_SR_BUSY_MASK;
> +}
> +
> +static inline unsigned int fsl_qspi_check_txfull(struct fsl_qspi *fsl_qspi)
> +{
> +	return readl(fsl_qspi->iobase + QUADSPI_SR) & QSPI_SR_TXFULL_MASK;
> +}
> +
> +static void wait_do_timer(unsigned long arg)
> +{
> +	struct fsl_qspi *fsl_qspi = (struct fsl_qspi *)(arg);
> +	fsl_qspi->timeout = 1;

I expect "true" to be used here, since timeout is defined as bool and
"false" is used in probe() for initialization.

> +}
> +
> +static irqreturn_t fsl_qspi_irq_handler(int this_irq, void *dev_id)
> +{
> +	struct fsl_qspi *fsl_qspi = dev_id;
> +	u32 reg_fr = readl(fsl_qspi->iobase + QUADSPI_FR);
> +
> +	/* clear interrupt */
> +	writel(reg_fr, fsl_qspi->iobase + QUADSPI_FR);
> +	if (reg_fr & QSPI_FR_TFF_MASK)
> +		wake_up(&fsl_qspi->waitq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void set_lut(struct fsl_qspi *fsl_qspi)
> +{
> +	u32 lut_base;

Have a blank line here.

> +	/* Unlock the LUT */
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_UNLOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +
> +	/* SEQID 1 - Write enable */
> +	lut_base = WEN_SEQID * 4;
> +	writel(OPRND0(0x6) | PAD0(0x0) | INSTR0(CMD),
> +			fsl_qspi->iobase + QUADSPI_LUT(lut_base));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 1));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 2));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 3));
> +
> +	/* SEQID 3 - Read Status */
> +	lut_base = READSTATU_SEQID * 4;
> +	writel(OPRND0(0x05) | PAD0(0x0) | INSTR0(CMD) |
> +			OPRND1(0x1) | PAD1(0x0) | INSTR1(READ),
> +			fsl_qspi->iobase + QUADSPI_LUT(lut_base));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 1));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 2));
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_LUT(lut_base + 3));
> +
> +	/* Lock the LUT */
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_LOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +}
> +
> +static void waiting_for_end(struct fsl_qspi *fsl_qspi,
> +		u32 current_bit, u32 bitvalue, u32 timeout)
> +{
> +	u32 reg, status_reg;
> +
> +	fsl_qspi->wait_timer.expires = jiffies + timeout;
> +	add_timer(&fsl_qspi->wait_timer);

Shouldn't we always initialize timeout to be false when adding the
timer?  Otherwise, once we get one timeout event, we will timeout
all the time?

> +
> +	status_reg = !bitvalue << current_bit;
> +	while ((status_reg & (0x1 << current_bit)) != bitvalue << current_bit) {
> +		if (fsl_qspi->timeout) {
> +			dev_err(fsl_qspi->dev, "tired waiting for end status\n");
> +			break;
> +		}
> +		writel((READSTATU_SEQID << QSPI_IPCR_SEQID_SHIFT) | 1,

There are so many bit filed definitions, and no one for this magic "1"?

> +				fsl_qspi->iobase + QUADSPI_IPCR);
> +		wait_event(fsl_qspi->waitq, !fsl_qspi_check_status(fsl_qspi));
> +
> +		reg = readl(fsl_qspi->iobase + QUADSPI_RBSR);
> +		if (reg & QSPI_RBSR_RDBFL_MASK)
> +			status_reg = readl(fsl_qspi->iobase +
> +					QUADSPI_RBDR);
> +
> +		writel(readl(fsl_qspi->iobase + QUADSPI_MCR) |
> +				QSPI_MCR_CLR_RXF_MASK,
> +				fsl_qspi->iobase + QUADSPI_MCR);
> +	}
> +	del_timer(&fsl_qspi->wait_timer);
> +}
> +
> +static void set_send_lut(struct fsl_qspi *fsl_qspi, u8 opr,
> +		u32 num_of_trans, u32 len)
> +{
> +	u32 lut[4], lut_base;
> +
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_UNLOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +
> +	lut[0] = OPRND0(opr) | PAD0(0x0) | INSTR0(CMD);
> +	lut[1] = 0;
> +	lut[2] = 0;
> +	lut[3] = 0;
> +
> +	if (len > 1)
> +		lut[0] = lut[0] | OPRND1(ADDR24BIT) | PAD1(0x0) | INSTR1(ADDR);
> +	if (num_of_trans > 1)
> +		lut[1] = OPRND0(TX_BUFFER_SIZE) | PAD0(0x0) | INSTR0(WRITE);
> +	lut_base = TX_SEQID * 4;
> +	writel(lut[0], fsl_qspi->iobase + QUADSPI_LUT(lut_base));
> +	writel(lut[1], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 1));
> +	writel(lut[2], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 2));
> +	writel(lut[3], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 3));
> +
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_LOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +}
> +
> +static void set_receive_lut(struct fsl_qspi *fsl_qspi, u8 opr,
> +		u32 num_of_tran, u32 len, u32 tx_len)
> +{
> +	u32 lut[4], lut_base;
> +
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_UNLOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +
> +	lut[0] = OPRND0(opr) | PAD0(0x0) | INSTR0(CMD);
> +	lut[1] = OPRND0(ADDR24BIT) | PAD0(0x0) | INSTR0(ADDR);
> +	lut[2] = 0;
> +	lut[3] = 0;
> +
> +	if (tx_len > 1) {
> +		len = RX_BUFFER_SIZE;
> +		lut[0] = lut[0] | OPRND1(ADDR24BIT) | PAD1(0x0) | INSTR1(ADDR);
> +		lut[1] = OPRND0(len) | PAD0(0x0) | INSTR0(READ);
> +	} else {
> +		lut[0] = lut[0] | OPRND1(len) | PAD1(0x0) | INSTR1(READ);
> +	}
> +	lut_base = RX_SEQID * 4;
> +	writel(lut[0], fsl_qspi->iobase + QUADSPI_LUT(lut_base));
> +	writel(lut[1], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 1));
> +	writel(lut[2], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 2));
> +	writel(lut[3], fsl_qspi->iobase + QUADSPI_LUT(lut_base + 3));
> +
> +	writel(KEY_VALUE, fsl_qspi->iobase + QUADSPI_LUTKEY);
> +	writel(QSPI_LCKCR_LOCK, fsl_qspi->iobase + QUADSPI_LCKCR);
> +}
> +
> +static void fsl_qspi_do_rx(struct fsl_qspi *fsl_qspi, u32 position,
> +		u32 count, u32 *rxbuf)
> +{
> +	u32 tmp, i, size;
> +
> +	position += PSP_QSPI0_MEMMAP_BASE;
> +
> +	while (count > 0) {
> +		writel(position, fsl_qspi->iobase + QUADSPI_SFAR);
> +		size = (count > RX_BUFFER_SIZE) ?
> +			RX_BUFFER_SIZE : count;
> +
> +		writel(RX_SEQID << QSPI_IPCR_SEQID_SHIFT | size,
> +				fsl_qspi->iobase + QUADSPI_IPCR);
> +		wait_event(fsl_qspi->waitq, !fsl_qspi_check_status(fsl_qspi));
> +
> +		position += size;
> +		count -= size;
> +
> +		i = 0;
> +		while ((RX_BUFFER_SIZE >= size) && (size > 0)) {
> +			tmp = readl(fsl_qspi->iobase + QUADSPI_RBDR +
> +					i * 4);
> +			*rxbuf = endian_change_32bit(tmp);
> +			rxbuf++;
> +			size -= 4;
> +			i++;
> +		}
> +
> +		writel(readl(fsl_qspi->iobase + QUADSPI_MCR) |
> +				QSPI_MCR_CLR_RXF_MASK,
> +				fsl_qspi->iobase + QUADSPI_MCR);
> +	}
> +}
> +
> +static void fsl_qspi_do_tx(struct fsl_qspi *fsl_qspi,
> +		u32 position, u32 count, const u32 *txbuf)
> +{
> +	u32 tmp, i, j, size, tx_size;
> +
> +	position += PSP_QSPI0_MEMMAP_BASE;
> +
> +	while (count > 0) {
> +		writel(position, fsl_qspi->iobase + QUADSPI_SFAR);
> +
> +		writel((WEN_SEQID << QSPI_IPCR_SEQID_SHIFT) | 0,
> +				fsl_qspi->iobase + QUADSPI_IPCR);
> +		wait_event(fsl_qspi->waitq, !fsl_qspi_check_status(fsl_qspi));
> +
> +		waiting_for_end(fsl_qspi, WRITE_ENABLE_BIT,
> +				VALID_WRITE_ENABLE_BIT, WRITE_ENABLE_TIMEOUT);
> +
> +		writel(position, fsl_qspi->iobase + QUADSPI_SFAR);
> +		tx_size = (count > TX_BUFFER_SIZE) ?
> +			TX_BUFFER_SIZE : count;
> +
> +		position += tx_size;
> +		count -= tx_size;
> +
> +		size = (tx_size + 3) / 4;
> +		i = (size > 16) ? 16 : size;
> +		for (j = 0; j < i; j++) {
> +			tmp = endian_change_32bit(*txbuf);
> +			writel(tmp, fsl_qspi->iobase + QUADSPI_TBDR);
> +			txbuf++;
> +		}
> +
> +		writel(TX_SEQID << QSPI_IPCR_SEQID_SHIFT | tx_size,
> +				fsl_qspi->iobase + QUADSPI_IPCR);
> +
> +		for (j = i; j < size; j++) {
> +			wait_event(fsl_qspi->waitq,
> +					!fsl_qspi_check_txfull(fsl_qspi));
> +			tmp = endian_change_32bit(*txbuf);
> +			writel(tmp, fsl_qspi->iobase + QUADSPI_TBDR);
> +			txbuf++;
> +		}
> +
> +		wait_event(fsl_qspi->waitq, !fsl_qspi_check_status(fsl_qspi));
> +
> +		waiting_for_end(fsl_qspi, STATUS_BIT,
> +				VALID_STATUS_BIT, READ_STATUS_TIMEOUT);
> +	}
> +}
> +
> +static void fsl_qspi_do_tx_cmd(struct fsl_qspi *fsl_qspi,
> +		u32 position)
> +{
> +	position += PSP_QSPI0_MEMMAP_BASE;
> +	writel(position, fsl_qspi->iobase + QUADSPI_SFAR);
> +
> +	writel((TX_SEQID << QSPI_IPCR_SEQID_SHIFT) | 0,
> +			fsl_qspi->iobase + QUADSPI_IPCR);
> +
> +	wait_event(fsl_qspi->waitq, !fsl_qspi_check_status(fsl_qspi));
> +
> +	waiting_for_end(fsl_qspi, STATUS_BIT,
> +			VALID_STATUS_BIT, READ_STATUS_TIMEOUT);
> +}
> +
> +static void fsl_qspi_write_trans(struct spi_master *master,
> +		struct spi_message *msg, u32 num)
> +{
> +	struct fsl_qspi *fsl_qspi = spi_master_get_devdata(master);
> +	struct spi_transfer *xfer;
> +	u8 opr = 0;
> +	loff_t pos = 0;
> +	int status = 0;
> +	u32 mcr_reg, trans_counter = 0;
> +
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +
> +		if (xfer->tx_buf && trans_counter == 0) {
> +			opr = *(u8 *)xfer->tx_buf;
> +			if (xfer->len > 1)
> +				pos = *(u32 *)xfer->tx_buf & POS_LOCATION_MASK;
> +
> +			msg->actual_length += xfer->len;
> +			set_send_lut(fsl_qspi, opr, num, xfer->len);
> +		}
> +
> +		mcr_reg = readl(fsl_qspi->iobase + QUADSPI_MCR);
> +		writel(QSPI_MCR_CLR_RXF_MASK | QSPI_MCR_CLR_TXF_MASK | QSPI_MCR_RESERVED_MASK,
> +				fsl_qspi->iobase + QUADSPI_MCR);
> +		writel(QSPI_RBCT_WMRK_MASK | QSPI_RBCT_RXBRD_USEIPS,
> +				fsl_qspi->iobase + QUADSPI_RBCT);
> +
> +		if (xfer->tx_buf && num > 1 && trans_counter > 0) {
> +			fsl_qspi_do_tx(fsl_qspi, endian_change_32bit(pos),
> +					xfer->len, xfer->tx_buf);
> +			msg->actual_length += xfer->len;
> +		} else if (xfer->tx_buf && (num == 1) && (trans_counter == 0)) {
> +			fsl_qspi_do_tx_cmd(fsl_qspi, endian_change_32bit(pos));
> +		}
> +		writel(mcr_reg, fsl_qspi->iobase + QUADSPI_MCR);
> +
> +		if (xfer->delay_usecs)
> +			udelay(xfer->delay_usecs);
> +
> +		trans_counter++;
> +	}
> +
> +	msg->status = status;
> +	spi_finalize_current_message(master);
> +}
> +
> +static void fsl_qspi_read_trans(struct spi_master *master,
> +		struct spi_message *msg, u32 num)
> +{
> +	struct fsl_qspi *fsl_qspi = spi_master_get_devdata(master);
> +	struct spi_transfer *xfer;
> +	u32 tx_len = 0, trans_counter = 0, mcr_reg;
> +	u8 opr = 0;
> +	loff_t pos = 0;
> +	int status = 0;
> +
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +
> +		writel(QSPI_RBCT_WMRK_MASK | QSPI_RBCT_RXBRD_USEIPS,
> +				fsl_qspi->iobase + QUADSPI_RBCT);
> +
> +		if (xfer->tx_buf && trans_counter == 0) {
> +			opr = *(u8 *)xfer->tx_buf;
> +			if (xfer->len > 1)
> +				pos = *(u32 *)xfer->tx_buf & POS_LOCATION_MASK;
> +			else
> +				pos = 0;
> +			tx_len = xfer->len;
> +		}
> +
> +		if (xfer->rx_buf && trans_counter > 0) {
> +			set_receive_lut(fsl_qspi, opr, num, xfer->len, tx_len);
> +
> +			mcr_reg = readl(fsl_qspi->iobase + QUADSPI_MCR);
> +			writel(QSPI_MCR_CLR_RXF_MASK |
> +					QSPI_MCR_CLR_TXF_MASK | QSPI_MCR_RESERVED_MASK,
> +					fsl_qspi->iobase + QUADSPI_MCR);
> +
> +			fsl_qspi_do_rx(fsl_qspi, endian_change_32bit(pos),
> +					xfer->len, xfer->rx_buf);
> +
> +			writel(mcr_reg, fsl_qspi->iobase + QUADSPI_MCR);
> +		}
> +
> +		if (xfer->delay_usecs)
> +			udelay(xfer->delay_usecs);
> +		msg->actual_length += xfer->len;
> +
> +		trans_counter++;
> +	}
> +
> +	msg->status = status;
> +	spi_finalize_current_message(master);
> +}
> +
> +static int fsl_qspi_do_one_msg(struct spi_master *master,
> +		struct spi_message *m)
> +{
> +	struct spi_transfer *t;
> +	u8 *rx_buf = NULL;
> +	unsigned int xfer_num = 0;
> +	struct fsl_qspi *fsl_qspi = spi_master_get_devdata(master);
> +
> +	writel(INT_TFIE, fsl_qspi->iobase + QUADSPI_RSER);
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (t->rx_buf)
> +			rx_buf = t->rx_buf;
> +		xfer_num++;
> +	}
> +
> +	if (!rx_buf)
> +		fsl_qspi_write_trans(master, m, xfer_num);
> +	else
> +		fsl_qspi_read_trans(master, m, xfer_num);
> +
> +	return m->status;
> +}
> +
> +static int fsl_qspi_setup(struct spi_device *spi)
> +{
> +	u32 reg_val, smpr_val, seq_id;
> +	struct fsl_qspi *fsl_qspi;
> +
> +	fsl_qspi = spi_master_get_devdata(spi->master);
> +
> +	if ((spi->bits_per_word < 8) || (spi->bits_per_word > 16)) {
> +		dev_dbg(&spi->dev, "%d bits per word is not supported\n",

dev_err

> +				spi->bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	if (spi->chip_select >= spi->master->num_chipselect) {
> +		dev_dbg(&spi->dev, "%d chip select is out of range\n",

Ditto

> +				spi->chip_select);
> +		return -EINVAL;
> +	}
> +
> +	writel(QSPI_MCR_RESERVED_MASK | QSPI_MCR_MDIS_MASK,
> +			fsl_qspi->iobase + QUADSPI_MCR);
> +
> +	reg_val = readl(fsl_qspi->iobase + QUADSPI_SMPR);
> +
> +	writel(reg_val & ~(QSPI_SMPR_FSDLY_MASK
> +				| QSPI_SMPR_FSPHS_MASK
> +				| QSPI_SMPR_HSENA_MASK),
> +			fsl_qspi->iobase + QUADSPI_SMPR);
> +
> +	writel(QSPI_MCR_RESERVED_MASK, fsl_qspi->iobase + QUADSPI_MCR);
> +
> +	writel(TPADA | PSP_QSPI0_MEMMAP_BASE,
> +			fsl_qspi->iobase + QUADSPI_SFA1AD);
> +	writel(TPADA | PSP_QSPI0_MEMMAP_BASE,
> +			fsl_qspi->iobase + QUADSPI_SFA2AD);
> +	writel(TPADB | PSP_QSPI0_MEMMAP_BASE,
> +			fsl_qspi->iobase + QUADSPI_SFB1AD);
> +	writel(TPADB | PSP_QSPI0_MEMMAP_BASE,
> +			fsl_qspi->iobase + QUADSPI_SFB2AD);
> +
> +	set_lut(fsl_qspi);
> +
> +	reg_val = 0;
> +	reg_val |= QSPI_MCR_RESERVED_MASK;
> +	smpr_val = readl(fsl_qspi->iobase + QUADSPI_SMPR);
> +	smpr_val &= ~QSPI_SMPR_DDRSMP_MASK;
> +	writel(smpr_val, fsl_qspi->iobase + QUADSPI_SMPR);
> +	reg_val &= ~QSPI_MCR_DDR_EN_MASK;
> +	writel(reg_val, fsl_qspi->iobase + QUADSPI_MCR);
> +
> +	seq_id = 0;
> +	reg_val = readl(fsl_qspi->iobase + QUADSPI_BFGENCR);
> +	reg_val &= ~QSPI_BFGENCR_SEQID_MASK;
> +	reg_val |= (seq_id << QSPI_BFGENCR_SEQID_SHIFT);
> +	reg_val &= ~QSPI_BFGENCR_PAR_EN_MASK;
> +	writel(reg_val, fsl_qspi->iobase + QUADSPI_BFGENCR);
> +
> +	return 0;
> +}
> +
> +static int fsl_qspi_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct spi_master *master;
> +	struct fsl_qspi *fsl_qspi;
> +	struct resource *res;
> +	int ret, num_cs, status = 0;
> +	struct clk *gate;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "can't get the platform data\n");
> +		return -EINVAL;
> +	}

The driver supports DT probe only.  We can not get here at all if the np
is NULL.  The check is meaningless.

> +
> +	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "can't get the spi-mum-chipselects\n");
> +		return ret;
> +	}

If you move the block somewhere after spi_alloc_master() call, you can
use master->num_chipselect directly, and save one local variable and one
assignment.

> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*fsl_qspi));
> +	if (master == NULL) {
> +		dev_dbg(&pdev->dev, "spi_alloc_master failed\n");

It hits an error condition.  We should use dev_err().

> +		return -ENOMEM;
> +	}
> +
> +	fsl_qspi = spi_master_get_devdata(master);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_dbg(&pdev->dev, "platform_get_resource failed\n");
> +		status = -ENXIO;
> +		goto fail0;
> +	}

devm_ioremap_resource() covers the error checking, so we can save it.
Check kerenldoc of function devm_ioremap_resource() for usage example.

> +
> +	fsl_qspi->iobase = devm_ioremap_resource(&pdev->dev, res);
> +	if (!fsl_qspi->iobase) {
> +		dev_dbg(&pdev->dev, "ioremap failed\n");
> +		status = -ENOMEM;

We should return the error code returned by devm_ioremap_resource().
Again, check usage example in devm_ioremap_resource kerenldoc.

Nit, we generally name the variable used for return as "ret".

> +		goto fail0;

Can we name the label in a meaningful way, like out_put_master or
something?

> +	}
> +
> +	gate = devm_clk_get(&pdev->dev, "qspi_en");
> +	if (IS_ERR(gate)) {
> +		dev_dbg(&pdev->dev, "clk_get failed\n");
> +		status = PTR_ERR(fsl_qspi->clk);

Shouldn't be PTR_ERR(gate)?  Also why it can be a local variable while
the "qspi" clk below is a member variable of fsl_qspi.

> +		goto fail0;
> +	}
> +	clk_prepare_enable(gate);

The function call can fail.  Error check?

> +
> +	fsl_qspi->clk = devm_clk_get(&pdev->dev, "qspi");
> +	if (IS_ERR(fsl_qspi->clk)) {
> +		dev_dbg(&pdev->dev, "clk_get failed\n");
> +		status = PTR_ERR(fsl_qspi->clk);
> +		goto fail1;
> +	}
> +	clk_prepare_enable(fsl_qspi->clk);
> +
> +	fsl_qspi->irq = platform_get_irq(pdev, 0);

It seems to me that the "irq" can simply be a local variable?

> +	if (fsl_qspi->irq < 0) {
> +		dev_dbg(&pdev->dev, "platform_get_irq failed\n");
> +		status = -ENXIO;

fsl_qspi->irq is just the error code we should return here.

> +		goto fail2;
> +	}
> +
> +	status = devm_request_irq(&pdev->dev, fsl_qspi->irq,
> +			fsl_qspi_irq_handler, 0, pdev->name, fsl_qspi);
> +	if (status) {
> +		dev_dbg(&pdev->dev, "request_irq failed\n");
> +		goto fail2;
> +	}
> +
> +	init_timer(&fsl_qspi->wait_timer);
> +	fsl_qspi->wait_timer.function = &wait_do_timer;
> +	fsl_qspi->wait_timer.data = (unsigned long)fsl_qspi;
> +	fsl_qspi->timeout = false;
> +
> +	init_waitqueue_head(&fsl_qspi->waitq);
> +	fsl_qspi->dev = &pdev->dev;
> +
> +	master->bus_num = pdev->id;
> +	master->num_chipselect = num_cs;
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	master->setup = fsl_qspi_setup;
> +	master->transfer_one_message = fsl_qspi_do_one_msg;
> +	platform_set_drvdata(pdev, master);
> +
> +	status = spi_register_master(master);
> +	if (status) {
> +		dev_dbg(&pdev->dev, "spi_register_master failed\n");
> +		goto fail2;
> +	}
> +	dev_info(&pdev->dev, "QuadSpi bus driver\n");

Nit: I'm more comfortable with spelling it "QuadSPI", which is how
Reference Manual spells.

> +
> +	return 0;
> +
> +fail2:
> +	clk_disable_unprepare(fsl_qspi->clk);
> +fail1:
> +	clk_disable_unprepare(gate);
> +fail0:
> +	spi_master_put(master);
> +
> +	dev_dbg(&pdev->dev, "Fsl QuadSpi probe failed\n");

Nit: Either "FSL" or "Freescale" looks better than "Fsl" to me.

> +
> +	return status;
> +}
> +
> +static int fsl_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct fsl_qspi *fsl_qspi = spi_master_get_devdata(master);
> +
> +	/* disable the hardware */
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_MCR);
> +	writel(0x0, fsl_qspi->iobase + QUADSPI_RSER);
> +
> +	clk_disable_unprepare(fsl_qspi->clk);
> +	spi_master_put(master);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id fsl_qspi_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-qspi", .data = NULL, },

.data has been initialized to NULL.

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> +
> +static struct platform_driver fsl_qspi_driver = {
> +	.driver.name    = DRIVER_NAME,
> +	.driver.of_match_table = fsl_qspi_dt_ids,
> +	.driver.owner   = THIS_MODULE,
> +	.probe          = fsl_qspi_probe,
> +	.remove		= fsl_qspi_remove,
> +};
> +module_platform_driver(fsl_qspi_driver);
> +
> +MODULE_DESCRIPTION("Freescale QuadSPI Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> diff --git a/drivers/spi/spi-fsl-quadspi.h b/drivers/spi/spi-fsl-quadspi.h
> new file mode 100644
> index 0000000..2128128
> --- /dev/null
> +++ b/drivers/spi/spi-fsl-quadspi.h
> @@ -0,0 +1,167 @@
> +/*
> + * Freescale Quad SPI driver.
> + *
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __SPI_FSL_QSPI_H__
> +#define __SPI_FSL_QSPI_H__
> +
> +#define	DRIVER_NAME "fsl-qspi"

I'm not strong on this.  But I think it would be better if we have the
driver name matches file name.  Considering the abbr qspi is already
used in the compatible string, we may name all the files and definitions
in "qspi" (you already did this expect file names and register names
below.)  It makes some sense to me since even hardware spec uses this
abbr somewhere.

Quad SPI can still be used as the formal name of the block in Kconfig
help text, binding doc etc.

> +
> +/* Quad SPI Controller*/
> +#define QUADSPI_MCR             (0x00)

No need of parentheses for such constant.

> +#define QUADSPI_IPCR            (0x08)
> +#define QUADSPI_BFGENCR         (0x20)
> +#define QUADSPI_SFAR            (0x100)
> +#define QUADSPI_SMPR            (0x108)
> +#define QUADSPI_RBSR            (0x10c)
> +#define QUADSPI_RBCT            (0x110)
> +#define QUADSPI_TBSR            (0x150)
> +#define QUADSPI_TBDR            (0x154)
> +#define QUADSPI_SR              (0x15c)
> +#define QUADSPI_FR              (0x160)
> +#define QUADSPI_SFA1AD          (0x180)
> +#define QUADSPI_SFA2AD          (0x184)
> +#define QUADSPI_SFB1AD          (0x188)
> +#define QUADSPI_SFB2AD          (0x18c)
> +#define QUADSPI_RBDR            (0x200)
> +#define QUADSPI_LUTKEY          (0x300)
> +#define QUADSPI_LCKCR           (0x304)
> +#define QUADSPI_RSER            (0x164)
> +#define KEY_VALUE               (0x5AF05AF0)
> +#define QUADSPI_LUT(x)          (0x310 + (x) * 4)
> +
> +#define INT_TFIE                (0x1 << 0)
> +#define TPADA                   (0x1 << 24)
> +#define TPADB                   (0x1 << 25)
> +
> +/* Field definitions for LCKCR */
> +#define QSPI_LCKCR_LOCK		(0x1)		
> +#define QSPI_LCKCR_UNLOCK	(0x2)
> +
> +/* Field definitions for RBSR */
> +#define QSPI_RBSR_RDBFL_SHIFT	(8)
> +#define QSPI_RBSR_RDBFL_MASK	(0x3F << QSPI_RBSR_RDBFL_SHIFT)
> +
> +/* Field definitions for RBCT */
> +#define QSPI_RBCT_WMRK_MASK	(0x1F)
> +#define QSPI_RBCT_RXBRD_SHIFT	(8)
> +#define QSPI_RBCT_RXBRD_USEIPS	(0x1 << QSPI_RBCT_RXBRD_SHIFT)
> +
> +/* Field definitions for MCR */
> +#define QSPI_MCR_MDIS_SHIFT	(14)
> +#define QSPI_MCR_MDIS_MASK	(1 << QSPI_MCR_MDIS_SHIFT)
> +#define QSPI_MCR_CLR_TXF_SHIFT	(11)
> +#define QSPI_MCR_CLR_TXF_MASK	(1 << QSPI_MCR_CLR_TXF_SHIFT)
> +#define QSPI_MCR_CLR_RXF_SHIFT	(10)
> +#define QSPI_MCR_CLR_RXF_MASK	(1 << QSPI_MCR_CLR_RXF_SHIFT)
> +#define QSPI_MCR_DDR_EN_SHIFT	(7)
> +#define QSPI_MCR_DDR_EN_MASK	(1 << QSPI_MCR_DDR_EN_SHIFT)
> +#define QSPI_MCR_RESERVED_SHIFT	(16)
> +#define QSPI_MCR_RESERVED_MASK  (0xF << QSPI_MCR_RESERVED_SHIFT)
> +
> +/* Field definitions for SMPR */
> +#define QSPI_SMPR_DDRSMP_SHIFT		(16)
> +#define QSPI_SMPR_DDRSMP_MASK		(7 << QSPI_SMPR_DDRSMP_SHIFT)
> +#define QSPI_SMPR_FSDLY_SHIFT		(6)
> +#define QSPI_SMPR_FSDLY_MASK		(1 << QSPI_SMPR_FSDLY_SHIFT)
> +#define QSPI_SMPR_FSPHS_SHIFT		(5)
> +#define QSPI_SMPR_FSPHS_MASK		(1 << QSPI_SMPR_FSPHS_SHIFT)
> +#define QSPI_SMPR_HSENA_SHIFT		(0)
> +#define QSPI_SMPR_HSENA_MASK		(1 << QSPI_SMPR_HSENA_SHIFT)
> +
> +/* Field definitions for BFGENCR */
> +#define QSPI_BFGENCR_PAR_EN_SHIFT	(16)
> +#define QSPI_BFGENCR_PAR_EN_MASK	(1 << (QSPI_BFGENCR_PAR_EN_SHIFT))
> +#define QSPI_BFGENCR_SEQID_SHIFT	(12)
> +#define QSPI_BFGENCR_SEQID_MASK		(0xF << QSPI_BFGENCR_SEQID_SHIFT)
> +
> +/* Field definitions for SR */
> +#define QSPI_SR_TXFULL_SHIFT		(27)
> +#define QSPI_SR_TXFULL_MASK		(1 << QSPI_SR_TXFULL_SHIFT)
> +#define QSPI_SR_AHBTRN_SHIFT		(6)
> +#define QSPI_SR_AHBTRN_MASK		(1 << QSPI_SR_AHBTRN_SHIFT)
> +#define QSPI_SR_AHB_ACC_SHIFT		(2)
> +#define QSPI_SR_AHB_ACC_MASK		(1 << QSPI_SR_AHB_ACC_SHIFT)
> +#define QSPI_SR_IP_ACC_SHIFT		(1)
> +#define QSPI_SR_IP_ACC_MASK		(1 << QSPI_SR_IP_ACC_SHIFT)
> +#define QSPI_SR_BUSY_SHIFT		(0)
> +#define QSPI_SR_BUSY_MASK		(1 << QSPI_SR_BUSY_SHIFT)
> +
> +/* Field definitions for FR */
> +#define QSPI_FR_TFF_MASK		(0x1)
> +
> +/* Seqid */
> +#define WEN_SEQID			(1)	
> +#define READSTATU_SEQID			(3)	
> +#define TX_SEQID			(8)
> +#define RX_SEQID			(9)
> +
> +/* Field definitions for IPCR */
> +#define QSPI_IPCR_SEQID_SHIFT	(24)
> +#define QSPI_IPCR_SEQID_MASK	(0xF << QSPI_IPCR_SEQID_SHIFT)
> +#define OPRND0_SHIFT		(0)
> +#define OPRND0(x)		((x) << (OPRND0_SHIFT))
> +#define PAD0_SHIFT		(8)
> +#define PAD0(x)			((x) << (PAD0_SHIFT))
> +#define INSTR0_SHIFT		(10)
> +#define INSTR0(x)		((x) << (INSTR0_SHIFT))
> +#define OPRND1_SHIFT		(16)
> +#define OPRND1(x)		((x) << (OPRND1_SHIFT))
> +#define PAD1_SHIFT		(24)
> +#define PAD1(x)			((x) << (PAD1_SHIFT))
> +#define INSTR1_SHIFT		(26)
> +#define INSTR1(x)		((x) << (INSTR1_SHIFT))
> +
> +/* instruction set */
> +#define CMD			(1)
> +#define ADDR			(2)
> +#define ADDR24BIT		(0x18)
> +#define DUMMY			(3)
> +#define MODE			(4)
> +#define MODE2			(5)
> +#define MODE4			(6)
> +#define READ			(7)
> +#define WRITE			(8)
> +#define JMP_ON_CS		(9)
> +#define ADDR_DDR		(10)
> +#define MODE_DDR		(11)
> +#define MODE2_DDR		(12)
> +#define MODE4_DDR		(13)
> +
> +#define endian_change_32bit(A)	((((u32)(A) & 0xFF000000) >> 24) | \
> +		(((u32)(A) & 0x00FF0000) >> 8) | \
> +		(((u32)(A) & 0x0000FF00) << 8) | \
> +		(((u32)(A) & 0x000000FF) << 24))

The macros defined in include/linux/byteorder/generic.h can help, I
think.

Shawn

> +
> +#define PSP_QSPI0_MEMMAP_BASE	(0x20000000)
> +#define RX_BUFFER_SIZE		(0x80)
> +#define TX_BUFFER_SIZE		(0x40)
> +#define POS_LOCATION_MASK	(0xFFFFFF00)
> +#define STATUS_BIT		(24)
> +#define VALID_STATUS_BIT	(0)
> +#define READ_STATUS_TIMEOUT	(5000)
> +#define WRITE_ENABLE_BIT	(25)
> +#define VALID_WRITE_ENABLE_BIT	(1)
> +#define WRITE_ENABLE_TIMEOUT	(10)
> +
> +struct fsl_qspi {
> +	void __iomem *iobase;
> +	int irq;
> +	struct clk *clk;
> +	u32 quad_mode;
> +	u32 select_cs;
> +	struct device *dev;
> +
> +	wait_queue_head_t waitq;
> +	struct timer_list wait_timer;
> +	bool timeout;
> +};
> +
> +#endif
> -- 
> 1.8.0
> 
> 
