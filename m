From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Thu, 28 May 2015 11:51:46 +0000
Subject: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
In-Reply-To: <20150520145552.GV31550@xsjsorenbubuntu>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150520145552.GV31550@xsjsorenbubuntu>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA6FAD0@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

Sorry for being late for this reply as this thread is moved a step ahead.

On Wed, 2015-05-20 at 12:57PM +0530, Ranjit Waghmode wrote:
> This patch adds support for GQSPI controller driver used by Zynq 
> Ultrascale+ MPSoC
> 
> Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
> ---
[...]
> +/**
> + * zynqmp_gqspi_read:	For GQSPI controller read operation
> + * @xqspi:	Pointer to the zynqmp_qspi structure
> + * @offset:	Offset from where to read
> + */
> +static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi, u32 offset) {
> +	return readl_relaxed(xqspi->regs + offset); }
> +
> +/**
> + * zynqmp_gqspi_write:	For GQSPI controller write operation
> + * @xqspi:	Pointer to the zynqmp_qspi structure
> + * @offset:	Offset where to write
> + * @val:	Value to be written
> + */
> +static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
> +				      u32 val)
> +{
> +	writel_relaxed(val, (xqspi->regs + offset)); }

why are you wrapping (readl|writel)_relaxed?

[...]
> +/**
> + * zynqmp_qspi_copy_read_data:	Copy data to RX buffer
> + * @xqspi:	Pointer to the zynqmp_qspi structure
> + * @data:	The 32 bit variable where data is stored
> + * @size:	Number of bytes to be copied from data to RX buffer
> + */
> +static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
> +				       u32 data, u8 size)
> +{
> +	memcpy(xqspi->rxbuf, ((u8 *) &data), size);

Is this cast really needed? IIRC, memcpy takes (void *). The outer parentheses for that argument are not needed.
[Ranjit] : taken care

> +	xqspi->rxbuf += size;
> +	xqspi->bytes_to_receive -= size;
> +}
> +
> +/**
> + * zynqmp_prepare_transfer_hardware:	Prepares hardware for transfer.
> + * @master:	Pointer to the spi_master structure which provides
> + *		information about the controller.
> + *
> + * This function enables SPI master controller.
> + *
> + * Return:	Always 0
> + */
> +static int zynqmp_prepare_transfer_hardware(struct spi_master 
> +*master) {
> +	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> +
> +	clk_enable(xqspi->refclk);
> +	clk_enable(xqspi->pclk);

Did you consider using runtime_pm? Then this would just bit
pm_runtime_get_sync(...)

> +	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_unprepare_transfer_hardware:	Relaxes hardware after transfer
> + * @master:	Pointer to the spi_master structure which provides
> + *		information about the controller.
> + *
> + * This function disables the SPI master controller.
> + *
> + * Return:	Always 0
> + */
> +static int zynqmp_unprepare_transfer_hardware(struct spi_master 
> +*master) {
> +	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> +
> +	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
> +	clk_disable(xqspi->refclk);
> +	clk_disable(xqspi->pclk);

and this would become pm_runtime_put()

[...]
> +/**
> + * zynqmp_qspi_filltxfifo:	Fills the TX FIFO as long as there is room in
> + *				the FIFO or the bytes required to be
> + *				transmitted.
> + * @xqspi:	Pointer to the zynqmp_qspi structure
> + * @size:	Number of bytes to be copied from TX buffer to TX FIFO
> + */
> +static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int 
> +size) {
> +	u32 count = 0;
> +
> +	while ((xqspi->bytes_to_transfer > 0) && (count < size)) {
> +		writel(*((u32 *) xqspi->txbuf), xqspi->regs + GQSPI_TXD_OFST);

Here the writel wrapper is not used. Is there a reason, then it would probably  deserve a comment.

[...]
> +/**
> + * zynqmp_process_dma_irq:	Handler for DMA done interrupt of QSPI
> + *				controller
> + * @xqspi:	zynqmp_qspi instance pointer
> + *
> + * This function handles DMA interrupt only.
> + */
> +static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi) {
> +	u32 config_reg, genfifoentry;
> +
> +	dma_unmap_single(xqspi->dev, xqspi->dma_addr,
> +				xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
> +	xqspi->rxbuf += xqspi->dma_rx_bytes;
> +	xqspi->bytes_to_receive -= xqspi->dma_rx_bytes;
> +	xqspi->dma_rx_bytes = 0;
> +
> +	/* Disabling the DMA interrupts */
> +	writel(GQSPI_QSPIDMA_DST_I_EN_DONE_MASK,
> +			xqspi->regs + GQSPI_QSPIDMA_DST_I_DIS_OFST);
> +
> +	if (xqspi->bytes_to_receive > 0) {
> +		/* Switch to IO mode,for remaining bytes to receive */
> +		config_reg = readl(xqspi->regs + GQSPI_CONFIG_OFST);
> +		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
> +		writel(config_reg, xqspi->regs + GQSPI_CONFIG_OFST);
> +
> +		/* Initiate the transfer of remaining bytes */
> +		genfifoentry = xqspi->genfifoentry;
> +		genfifoentry |= xqspi->bytes_to_receive;
> +		writel(genfifoentry,
> +				xqspi->regs + GQSPI_GEN_FIFO_OFST);
> +
> +		/* Dummy generic FIFO entry */
> +		writel(0x0, xqspi->regs + GQSPI_GEN_FIFO_OFST);

not using wrapper?

> +
> +		/* Manual start */
> +		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> +			(readl(xqspi->regs + GQSPI_CONFIG_OFST) |

not using wrapper?

Overall:
The usage of those readl/writel wrappers seems inconsistent to me. I usually prefer not wrapping things like that at all but at least it should be consistent.
[Ranjit]: Removing all inconsistencies by using wrapper function everywhere.

And I believe the handling of clocks would benefit from using of the runtime_pm framework.
[Ranjit]: Will add above suggestion and send next version.

Thanks & Regards,
Ranjit Waghmode
