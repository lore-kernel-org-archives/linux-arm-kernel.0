From: B44548@freescale.com (Fu Chao-B44548)
Date: Thu, 8 Aug 2013 06:54:03 +0000
Subject: [PATCH v2 4/4] spi:Add Freescale DSPI driver for Vybrid VF610
 platform
In-Reply-To: <20130726072130.GA3029@pengutronix.de>
References: <1374643943-3324-1-git-send-email-b44548@freescale.com>
 <1374643943-3324-5-git-send-email-b44548@freescale.com>
 <20130726072130.GA3029@pengutronix.de>
Message-ID: <CC21DA4CC22BA845BF83A9324A91CE6209CFA63D@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Sascha Hauer [mailto:s.hauer at pengutronix.de] 
Sent: 2013?7?26? 15:22
To: Fu Chao-B44548
Cc: linux-spi at vger.kernel.org; linux-arm-kernel at lists.infradead.org; grant.likely at linaro.org; broonie at kernel.org; Wang Huan-B18965; shawn.guo at linaro.org
Subject: Re: [PATCH v2 4/4] spi:Add Freescale DSPI driver for Vybrid VF610 platform

On Wed, Jul 24, 2013 at 01:32:23PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> The serial peripheral interface (SPI) module implemented on Freescale 
> Vybrid platform provides a synchronous serial bus for communication 
> between Vybrid and the external peripheral device.
> The SPI supports full-duplex, three-wire synchronous transfer, has 
> TX/RX FIFO with depth of four entries.
> 
> This driver is the SPI master mode driver and has been tested on Vybrid VF610TWR board.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Chao Fu  <b44548@freescale.com>
> ---
> Changes in v2: None
> 
>  drivers/spi/Kconfig        |   6 +
>  drivers/spi/Makefile       |   1 +
>  drivers/spi/spi-fsl-dspi.c | 673 
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 680 insertions(+)
>  create mode 100644 drivers/spi/spi-fsl-dspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index 
> 89cbbab..068715d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -248,6 +248,12 @@ config SPI_FSL_SPI
>  	  This also enables using the Aeroflex Gaisler GRLIB SPI controller in
>  	  master mode.
>  
> +config SPI_FSL_DSPI
> +         tristate "Freescale DSPI controller"
> +         help
> +         This enables support for the Freescale DSPI controller in master
> +         mode.
> +
>  config SPI_FSL_ESPI
>  	bool "Freescale eSPI controller"
>  	depends on FSL_SOC
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile index 
> 33f9c09..78416fd 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
>  obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
>  obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
>  obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
> +obj-$(CONFIG_SPI_FSL_DSPI)		+= spi-fsl-dspi.o
>  obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c 
> new file mode 100644 index 0000000..a187b6f
> --- /dev/null
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -0,0 +1,673 @@
> +/*
> + * drivers/spi/spi-fsl-dspi.c
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * Freescale DSPI driver
> + * This file contains a driver for the Freescale DSPI
> + *
> + * This program is free software; you can redistribute it and/or 
> +modify
> + * it under the terms of the GNU General Public License as published 
> +by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
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
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#define DRIVER_NAME "fsl-dspi"
> +
> +#define TRAN_STATE_RX_VOID		0x01
> +#define TRAN_STATE_TX_VOID		0x02
> +#define TRAN_STATE_WORD_ODD_NUM		0x04
> +
> +#define DSPI_FIFO_SIZE			4
> +
> +#define SPI_MCR			0x00
> +#define SPI_TCR			0x08
> +
> +#define SPI_CTAR(x)		(0x0c + (x * 4))
> +#define SPI_CTAR_FMSZ(x)	(((x) & 0x0000000f) << 27)
> +#define SPI_CTAR_CPOL(x)	((x) << 26)
> +#define SPI_CTAR_CPHA(x)	((x) << 25)
> +#define SPI_CTAR_PCSSCR(x)	(((x) & 0x00000003) << 22)
> +#define SPI_CTAR_PASC(x)	(((x) & 0x00000003) << 20)
> +#define SPI_CTAR_PDT(x)		(((x) & 0x00000003) << 18)
> +#define SPI_CTAR_PBR(x)		(((x) & 0x00000003) << 16)
> +#define SPI_CTAR_CSSCK(x)	(((x) & 0x0000000f) << 12)
> +#define SPI_CTAR_ASC(x)		(((x) & 0x0000000f) << 8)
> +#define SPI_CTAR_DT(x)		(((x) & 0x0000000f) << 4)
> +#define SPI_CTAR_BR(x)		((x) & 0x0000000f)
> +
> +#define SPI_CTAR0_SLAVE		0x0c
> +
> +#define SPI_SR			0x2c
> +#define SPI_SR_EOQF		0x10000000
> +
> +#define SPI_RSER		0x30
> +#define SPI_RSER_EOQFE		0x10000000
> +
> +#define SPI_PUSHR		0x34
> +#define SPI_PUSHR_CONT		(1 << 31)
> +#define SPI_PUSHR_CTAS(x)	(((x) & 0x00000007) << 28)
> +#define SPI_PUSHR_EOQ		(1 << 27)
> +#define SPI_PUSHR_CTCNT		(1 << 26)
> +#define SPI_PUSHR_PCS(x)	(((1 << x) & 0x0000003f) << 16)
> +#define SPI_PUSHR_TXDATA(x)	((x) & 0x0000ffff)
> +
> +#define SPI_PUSHR_SLAVE		0x34
> +
> +#define SPI_POPR		0x38
> +#define SPI_POPR_RXDATA(x)	((x) & 0x0000ffff)
> +
> +#define SPI_TXFR0		0x3c
> +#define SPI_TXFR1		0x40
> +#define SPI_TXFR2		0x44
> +#define SPI_TXFR3		0x48
> +#define SPI_RXFR0		0x7c
> +#define SPI_RXFR1		0x80
> +#define SPI_RXFR2		0x84
> +#define SPI_RXFR3		0x88
> +
> +#define SPI_FRAME_BITS		SPI_CTAR_FMSZ(0xf)
> +#define SPI_FRAME_BITS_16	SPI_CTAR_FMSZ(0xf)
> +#define SPI_FRAME_BITS_8	SPI_CTAR_FMSZ(0x7)

Wouldn't a define

SPI_FRAME_BITS(bits) SPI_CTAR_FMSZ((bits) - 1)

make more sense?

> +
> +#define SPI_CS_INIT		0x01
> +#define SPI_CS_ASSERT		0x02
> +#define SPI_CS_DROP		0x04
> +
> +struct DSPI_MCR {
> +	unsigned halt:1;
> +	unsigned reserved71:7;
> +	unsigned smpl_pt:2;
> +	unsigned clr_rxf:1;
> +	unsigned clr_tx:1;
> +	unsigned dis_rxf:1;
> +	unsigned dis_tx:1;
> +	unsigned mdis:1;
> +	unsigned reserved15:1;
> +	unsigned pcsis:8;
> +	unsigned rooe:1;
> +	unsigned pcsse:1;
> +	unsigned mtfe:1;
> +	unsigned frz:1;
> +	unsigned dconf:2;
> +	unsigned cont_scke:1;
> +	unsigned master:1;
> +};
> +
> +struct DSPI_CTAR {
> +	unsigned br:4;
> +	unsigned dt:4;
> +	unsigned asc:4;
> +	unsigned cssck:4;
> +	unsigned pbr:2;
> +	unsigned pdt:2;
> +	unsigned pasc:2;
> +	unsigned pcssck:2;
> +	unsigned lsbfe:1;
> +	unsigned cpha:1;
> +	unsigned cpol:1;
> +	unsigned fmsz:4;
> +	unsigned dbr:1;
> +};
> +
> +struct chip_data {
> +	/* dspi data */
> +	union {
> +		u32 mcr_val;
> +		struct DSPI_MCR mcr;
> +	};
> +	union {
> +		u32 ctar_val;
> +		struct DSPI_CTAR ctar;
> +	};

No. Never ever use bitfields and lay them over registers. This may work by accident, but the compiler is free to rearrange the fields.

> +	u16 void_write_data;
> +};
> +
> +struct fsl_dspi {
> +	struct platform_device *pdev;
> +	struct spi_master *master;
> +
> +	void *base;
> +	int irq;
> +	struct clk *clk;
> +
> +	struct spi_message *cur_msg;
> +	struct spi_transfer *cur_transfer;
> +	struct chip_data *cur_chip;
> +	size_t len;
> +	void *tx;
> +	void *tx_end;
> +	void *rx;
> +	void *rx_end;
> +	char dataflags;
> +	u8 cs;
> +	u16 void_write_data;
> +	unsigned	cs_change:1;
> +
> +	wait_queue_head_t waitq;
> +	u32 waitflags;
> +};
> +
> +/* SPI local functions */
> +static inline int is_word_transfer(struct fsl_dspi *dspi) {
> +	return ((readl(dspi->base + SPI_CTAR(dspi->cs)) & SPI_FRAME_BITS)
> +			== SPI_FRAME_BITS_8) ? 0 : 1;
> +}
> +
> +static void set_8bit_transfer_mode(struct fsl_dspi *dspi) {
> +	u32 temp;
> +
> +	temp = readl(dspi->base + SPI_CTAR(dspi->cs));
> +	temp &= ~SPI_FRAME_BITS;
> +	temp |= SPI_FRAME_BITS_8;
> +	writel(temp, dspi->base + SPI_CTAR(dspi->cs)); }
> +
> +static void set_16bit_transfer_mode(struct fsl_dspi *dspi) {
> +	u32 temp;
> +
> +	temp = readl(dspi->base + SPI_CTAR(dspi->cs));
> +	temp &= ~SPI_FRAME_BITS;
> +	temp |= SPI_FRAME_BITS_16;
> +	writel(temp, dspi->base + SPI_CTAR(dspi->cs)); }

No need to make these separate functions. And I don't think there's need to make this a read/modify/write operation. Just keep a local variable 'cs' where you need it and compose it as necessary.

> +
> +static unsigned char hz_to_spi_baud(int pbr, int dbr, int speed_hz,
> +		unsigned long clkrate)
> +{
> +	/* Valid baud rate pre-scaler values */
> +	int pbr_tbl[4] = {2, 3, 5, 7};
> +	int brs[16] = {	2,	4,	6,	8,
> +		16,	32,	64,	128,
> +		256,	512,	1024,	2048,
> +		4096,	8192,	16384,	32768 };
> +	int temp, index = 0;
> +
> +	/* table indexes out of range, go slow */
> +	if ((pbr < 0) || (pbr > 3) || (dbr < 0) || (dbr > 1))
> +		return 15;
> +
> +	/* cpu core clk need to check */
> +	temp = ((((clkrate / 2) / pbr_tbl[pbr]) * (1 + dbr)) / speed_hz);
> +
> +	while (temp > brs[index])
> +		if (index++ >= 15)

Use ARRAY_SIZE()

> +			break;
> +
> +	return index;
> +}
> +
> +static void dspi_setup_chip(struct fsl_dspi *dspi) {
> +	struct chip_data *chip = dspi->cur_chip;
> +
> +	writel(chip->mcr_val, dspi->base + SPI_MCR);
> +	writel(chip->ctar_val, dspi->base + SPI_CTAR(dspi->cs));
> +	writel(SPI_RSER_EOQFE, dspi->base + SPI_RSER); }

This is only called once. Make this code inline where you need it.

> +
> +static int dspi_transfer_write(struct fsl_dspi *dspi) {
> +	int tx_count = 0;
> +	int tx_word;
> +	u16 d16;
> +	u8  d8;
> +	u32 dspi_pushr = 0;
> +	int first = 1;
> +
> +	tx_word = is_word_transfer(dspi);
> +	/* If we are in word mode, but only have a single byte to transfer
> +	 * then switch to byte mode temporarily.  Will switch back at the
> +	 * end of the transfer. */

Not sure if I understand this, but if you are in word mode then I would consider it a bug when there's only one byte to transfer.

> +	if (tx_word && (dspi->len == 1)) {
> +		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
> +		set_8bit_transfer_mode(dspi);
> +		tx_word = 0;
> +	}
> +	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
> +		if (tx_word) {
> +			if (dspi->len == 1)
> +				break;
> +
> +			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
> +				d16 = *(u16 *)dspi->tx;
> +				dspi->tx += 2;
> +			} else {
> +				d16 = dspi->void_write_data;
> +			}
> +
> +			dspi_pushr = SPI_PUSHR_TXDATA(d16) |
> +				SPI_PUSHR_PCS(dspi->cs) |
> +				SPI_PUSHR_CTAS(dspi->cs) |
> +				SPI_PUSHR_CONT;
> +
> +			dspi->len -= 2;
> +		} else {
> +			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
> +
> +				d8 = *(u8 *)dspi->tx;
> +				dspi->tx++;
> +			} else {
> +				d8 = (u8)dspi->void_write_data;
> +			}
> +
> +			dspi_pushr = SPI_PUSHR_TXDATA(d8) |
> +				SPI_PUSHR_PCS(dspi->cs) |
> +				SPI_PUSHR_CTAS(dspi->cs) |
> +				SPI_PUSHR_CONT;
> +
> +			dspi->len--;
> +		}
> +
> +		if (dspi->len == 0
> +				|| tx_count == DSPI_FIFO_SIZE - 1) {
> +			/* last transfer in the queue */
> +			dspi_pushr |= SPI_PUSHR_EOQ;
> +			if ((dspi->cs_change)
> +					&& (!dspi->len))
> +				dspi_pushr &= ~SPI_PUSHR_CONT;
> +		} else if (tx_word && (dspi->len == 1))
> +			dspi_pushr |= SPI_PUSHR_EOQ;
> +
> +		if (first) {
> +			first = 0;
> +			dspi_pushr |= SPI_PUSHR_CTCNT; /* clear counter */
> +		}
> +
> +		writel(dspi_pushr, dspi->base + SPI_PUSHR);
> +		tx_count++;
> +	}
> +
> +	return tx_count * (tx_word + 1);
> +}
> +static int dspi_transfer_read(struct fsl_dspi *dspi) {
> +	int rx_count = 0;
> +	int rx_word = is_word_transfer(dspi);
> +	u16 d;
> +	while ((dspi->rx < dspi->rx_end)
> +			&& (rx_count < DSPI_FIFO_SIZE)) {
> +		if (rx_word) {
> +			if ((dspi->rx_end - dspi->rx) == 1)
> +				break;
> +
> +			d = SPI_POPR_RXDATA(readl(dspi->base + SPI_POPR));
> +
> +			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
> +				*(u16 *)dspi->rx = d;
> +			dspi->rx += 2;
> +
> +		} else {
> +			d = SPI_POPR_RXDATA(readl(dspi->base + SPI_POPR));
> +			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
> +				*(u8 *)dspi->rx = d;
> +			dspi->rx++;
> +		}
> +		rx_count++;
> +	}
> +
> +	return rx_count;
> +}
> +
> +static int dspi_transfer_one_message(struct spi_master *master,
> +		struct spi_message *message)
> +{
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +	struct spi_device *spi = message->spi;
> +	struct spi_transfer *transfer;
> +	int status = 0;
> +	message->actual_length = 0;
> +
> +	list_for_each_entry(transfer, &message->transfers, transfer_list) {

Since your hardware can't handle whole messages at once: Have you considered using the bitbang driver?


[Chao Fu]Do you mean I need to use workqueue method?
Use  master->transfer() method? 

> +		dspi->cur_msg = message;
> +		dspi->cur_transfer = transfer;
> +		dspi->cur_chip = spi_get_ctldata(spi);
> +		dspi->cs = spi->chip_select;
> +		if (dspi->cur_transfer->transfer_list.next
> +				== &dspi->cur_msg->transfers)
> +			transfer->cs_change = 1;
> +		dspi->cs_change = transfer->cs_change;
> +		dspi->void_write_data = dspi->cur_chip->void_write_data;
> +
> +		dspi_setup_chip(dspi);
> +
> +		dspi->dataflags = 0;
> +		dspi->tx = (void *)transfer->tx_buf;
> +		dspi->tx_end = dspi->tx + transfer->len;
> +		dspi->rx = transfer->rx_buf;
> +		dspi->rx_end = dspi->rx + transfer->len;
> +		dspi->len = transfer->len;
> +
> +		if (!dspi->rx)
> +			dspi->dataflags |= TRAN_STATE_RX_VOID;
> +
> +		if (!dspi->tx)
> +			dspi->dataflags |= TRAN_STATE_TX_VOID;
> +
> +		if (transfer->speed_hz)
> +			writel((dspi->cur_chip->ctar_val & ~0xf) |
> +				hz_to_spi_baud(dspi->cur_chip->ctar.pbr,
> +					dspi->cur_chip->ctar.dbr,
> +					transfer->speed_hz,
> +					clk_get_rate(dspi->clk)),
> +					dspi->base + SPI_CTAR(dspi->cs));
> +
> +		message->actual_length += dspi_transfer_write(dspi);
> +
> +		wait_event_interruptible(dspi->waitq, dspi->waitflags);

This function can fail.

> +		dspi->waitflags = 0;
> +
> +		if (transfer->delay_usecs)
> +			udelay(transfer->delay_usecs);
> +	}
> +	message->status = status;
> +	spi_finalize_current_message(master);
> +
> +	return status;
> +}
> +
> +static int dspi_prepare_transfer_hw(struct spi_master *master) {
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +
> +	pm_runtime_get_sync(&dspi->pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int dspi_unprepare_transfer_hw(struct spi_master *master) {
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +
> +	pm_runtime_put_sync(&dspi->pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int dspi_setup(struct spi_device *spi) {
> +	struct chip_data *chip;
> +	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
> +	struct device_node *np = spi->dev.of_node;
> +	unsigned char br = 0;
> +	unsigned int dbr = 0 , pbr = 0;
> +
> +	/* Only alloc on first setup */
> +	chip = spi_get_ctldata(spi);
> +	if (chip == NULL) {
> +		chip = kcalloc(1, sizeof(struct chip_data), GFP_KERNEL);
> +		if (!chip)
> +			return -ENOMEM;
> +	}
> +
> +	chip->mcr.master = 1;
> +	chip->mcr.cont_scke = 0;
> +	chip->mcr.dconf = 0;
> +	chip->mcr.frz = 0;
> +	chip->mcr.mtfe = 0;
> +	chip->mcr.pcsse = 0;
> +	chip->mcr.rooe = 0;
> +	chip->mcr.pcsis = 0xFF;
> +	chip->mcr.reserved15 = 0;
> +	chip->mcr.mdis = 0;
> +	chip->mcr.dis_tx = 0;
> +	chip->mcr.dis_rxf = 0;
> +	chip->mcr.clr_tx = 1;
> +	chip->mcr.clr_rxf = 1;
> +	chip->mcr.smpl_pt = 0;
> +	chip->mcr.reserved71 = 0;
> +	chip->mcr.halt = 0;
> +
> +	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
> +		chip->ctar.fmsz = spi->bits_per_word - 1;
> +	} else {
> +		printk(KERN_ERR "Invalid wordsize\n");

Use dev_* functions for printing messages in drivers.

> +		kfree(chip);
> +		return -ENODEV;
> +	}
> +
> +	chip->void_write_data = 0;
> +	chip->ctar.cpha = (spi->mode & SPI_CPHA) ? 1 : 0;
> +	chip->ctar.cpol = (spi->mode & SPI_CPOL) ? 1 : 0;
> +	chip->ctar.lsbfe = (spi->mode & SPI_LSB_FIRST) ? 1 : 0;
> +	of_property_read_u32(np, "dspi,ctar-dbr", &dbr);
> +	of_property_read_u32(np, "dspi,ctar-pbr", &pbr);

I doubt this is a valid binding. Even if it is you shouldn't read of properties each time in setup()

> +	chip->ctar.dbr = dbr;
> +	chip->ctar.pbr = pbr;
> +	if (spi->max_speed_hz == 0)
> +		return -ENODEV;

This check is probably not necessary.

> +	br = hz_to_spi_baud(chip->ctar.pbr, chip->ctar.dbr,
> +			spi->max_speed_hz, clk_get_rate(dspi->clk));
> +	chip->ctar.br = br;
> +	chip->ctar.pcssck = 0;
> +	chip->ctar.pasc = 0;
> +	chip->ctar.pdt = 0;
> +	chip->ctar.cssck = 0;
> +	chip->ctar.asc = 0;
> +	chip->ctar.dt = 0;
> +
> +	spi_set_ctldata(spi, chip);
> +
> +	return 0;
> +}
> +
> +static void dspi_cleanup(struct spi_device *spi) {
> +	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
> +
> +	dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
> +			spi->master->bus_num, spi->chip_select);
> +
> +	kfree(chip);
> +}
> +
> +static irqreturn_t dspi_interrupt(int irq, void *dev_id) {
> +	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
> +	struct spi_message *msg = dspi->cur_msg;
> +
> +	writel(SPI_SR_EOQF, dspi->base + SPI_SR);
> +
> +	if (!dspi->cur_msg) {
> +		u32 irq_status = readl(dspi->base + SPI_SR);
> +		printk(KERN_ERR "Bad message or transfer state handler. "
> +				"IRQ status = %x\n", irq_status);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dspi_transfer_read(dspi);
> +
> +	if (!dspi->len) {
> +		/*
> +		 * Finished now - fall through and schedule next
> +		 * transfer tasklet
> +		 */
> +		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
> +			set_16bit_transfer_mode(dspi);
> +		dspi->waitflags = 1;
> +		wake_up_interruptible(&dspi->waitq);
> +
> +	} else {
> +		/* not finished yet - keep going */
> +		msg->actual_length += dspi_transfer_write(dspi);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct of_device_id fsl_dspi_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-dspi", .data = NULL, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dspi_suspend(struct device *dev) {
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +	clk_disable_unprepare(dspi->clk);
> +
> +	return 0;
> +}
> +
> +static int dspi_resume(struct device *dev) {
> +
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +
> +	clk_prepare_enable(dspi->clk);
> +	spi_master_resume(master);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops dspi_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dspi_suspend, dspi_resume) };
> +
> +static int dspi_probe(struct platform_device *pdev) {
> +	struct device_node *np = pdev->dev.of_node;
> +	struct spi_master *master;
> +	struct fsl_dspi *dspi;
> +	struct resource *res;
> +	int ret = 0, cs_num, bus_num;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	dspi = spi_master_get_devdata(master);
> +	dspi->master = master;
> +
> +	master->cleanup = dspi_cleanup;
> +	master->setup = dspi_setup;
> +	master->transfer = NULL;
> +	master->transfer_one_message = dspi_transfer_one_message;
> +	master->prepare_transfer_hardware = dspi_prepare_transfer_hw;
> +	master->unprepare_transfer_hardware = dspi_unprepare_transfer_hw;
> +	master->mode_bits = SPI_CPOL | SPI_CPHA;
> +	master->bits_per_word_mask = SPI_BPW_MASK(4) | SPI_BPW_MASK(8) |
> +					SPI_BPW_MASK(16);
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
> +	if (ret < 0)
> +		goto fail;
> +	master->num_chipselect = cs_num;
> +
> +	ret = of_property_read_u32(np, "bus-num", &bus_num);
> +	if (ret < 0)
> +		goto fail;
> +	master->bus_num = bus_num;

Drop this. It's not necessary.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get platform resource\n");
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	dspi->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!dspi->base) {
> +		ret = EINVAL;
> +		goto fail;
> +	}
> +
> +	dspi->irq = platform_get_irq(pdev, 0);
> +	if (dspi->irq < 0) {
> +		dev_err(&pdev->dev, "can't get platform irq\n");
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt, 0,
> +			pdev->name, dspi);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
> +		goto fail;
> +	}
> +
> +	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
> +	if (IS_ERR(dspi->clk)) {
> +		dev_err(&pdev->dev, "unable to get clock\n");
> +		goto fail;
> +	}
> +	clk_prepare_enable(dspi->clk);
> +
> +	init_waitqueue_head(&dspi->waitq);
> +
> +	/* Register with the SPI framework */
> +	platform_set_drvdata(pdev, dspi);
> +	ret = spi_register_master(master);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Problem registering DSPI master\n");
> +		ret = -EINVAL;

Propagate the error value instead of rewriting it.

> +		goto fail;
> +	}
> +
> +	printk(KERN_INFO "Freescale DSPI master initialized\n");
> +	return ret;
> +
> +fail:
> +	spi_master_put(master);
> +	return ret;
> +}
> +
> +static int dspi_remove(struct platform_device *pdev) {
> +	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
> +
> +	if (!dspi)
> +		return 0;

Unnecessary. Drop this.

> +
> +	clk_disable_unprepare(dspi->clk);
> +	clk_put(dspi->clk);

You can't drop resources allocated with devm_* with their non devm_ conterparts. Drop this.

> +
> +	/* Disconnect from the SPI framework */
> +	spi_unregister_master(dspi->master);
> +	spi_master_put(dspi->master);
> +
> +	/* Prevent double remove */
> +	platform_set_drvdata(pdev, NULL);

Unnecessary. Drop this.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver fsl_dspi_driver = {
> +	.driver.name    = DRIVER_NAME,
> +	.driver.of_match_table = fsl_dspi_dt_ids,
> +	.driver.owner   = THIS_MODULE,
> +	.driver.pm = &dspi_pm,
> +	.probe          = dspi_probe,
> +	.remove		= dspi_remove,
> +};
> +module_platform_driver(fsl_dspi_driver);
> +
> +MODULE_DESCRIPTION("Freescale DSPI Controller Driver"); 
> +MODULE_LICENSE("GPL v2"); MODULE_ALIAS("platform:" DRIVER_NAME);
> --
> 1.8.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
