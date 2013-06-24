From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Jun 2013 09:32:27 +0200
Subject: [PATCH 2/2] spi: Add Freescale QuadSpi driver
In-Reply-To: <1371809590-29648-1-git-send-email-b41219@freescale.com>
References: <1371809590-29648-1-git-send-email-b41219@freescale.com>
Message-ID: <20130624073227.GE26397@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:13:10PM +0800, Xiaochun Li wrote:
> Add QuadSpi driver for Freescale's Quad Spi controller.
> This controller is designed for serial flash access.
> This driver has been tested on vf610-twr board with m25p80 type chips.
> The hardware has no support for other types of spi peripherals.
> Chip select control is handled via Serial Flash Address Register.

This really needs serious rework. If possible find someone in your
company who can help you with this driver.

> +static inline unsigned int fsl_qspi_check_status(struct fsl_qspi *fsl_qspi)
> +{
> +	return readl(fsl_qspi->iobase + QUADSPI_SR) & QSPI_SR_BUSY_MASK;
> +}

What does a function calles check_status return? Does it return "Yes,
I'm busy" or does it return "Yes, I'm idle". Use fsl_qspi_is_busy or
fsl_qspi_is_idle instead.

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

Consistently add a fsl_qspi_ namespace to all functions in this driver.

> +static void waiting_for_end(struct fsl_qspi *fsl_qspi,
> +		u32 current_bit, u32 bitvalue, u32 timeout)
> +{
> +	u32 reg, status_reg;
> +
> +	fsl_qspi->wait_timer.expires = jiffies + timeout;
> +	add_timer(&fsl_qspi->wait_timer);
> +
> +	status_reg = !bitvalue << current_bit;
> +	while ((status_reg & (0x1 << current_bit)) != bitvalue << current_bit) {
> +		if (fsl_qspi->timeout) {
> +			dev_err(fsl_qspi->dev, "tired waiting for end status\n");
> +			break;
> +		}
> +		writel((READSTATU_SEQID << QSPI_IPCR_SEQID_SHIFT) | 1,
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

What the hell are you doing here??

You have interrupts. Use them! Interrupts are for triggering actions,
not for polling until they happen. The driver logic is completely wrong.

Each wait_event possibly deadlocks the driver. Don't do this. Also each
wait_event is either unnecessary in this context or means that there is
an interrupt. I lost track how many wait_events you have in your
execution path, but get rid of them all.

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

Why do you have two function which both iterate over all transfers of a
message?
To clean this up start with a function which handles one transfer. Then
add one function which iterates over all transfers and calls the
transfer function.

Then, since your hardware doesn't seem to be able to handle spi messages
directly you should probably use the bitbanging helpers instead of
implementing a master directly.

> +
> +		if (xfer->rx_buf && trans_counter > 0) {
> +			set_receive_lut(fsl_qspi, opr, num, xfer->len, tx_len);

set_receive_lut is not at all interested in the number of transfers.
What it wants to know is whether this transfer is the last one of a
message...

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

...which means that you no longer have to count the number of transfers
here.

> +	}
> +
> +	if (!rx_buf)
> +		fsl_qspi_write_trans(master, m, xfer_num);
> +	else
> +		fsl_qspi_read_trans(master, m, xfer_num);

There shouldn't be any need to distinguish between messages with no read
transfers and messages with at least one read transfer. Get rid of this.

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
> +				spi->bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	if (spi->chip_select >= spi->master->num_chipselect) {
> +		dev_dbg(&spi->dev, "%d chip select is out of range\n",
> +				spi->chip_select);
> +		return -EINVAL;
> +	}

This will never happen. The spi core checks this in spi_add_device.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
