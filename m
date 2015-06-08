From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Mon, 8 Jun 2015 12:55:13 +0000
Subject: [LINUX RFC V2 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
In-Reply-To: <CAM=Q2cue_4tcuu+vHYcrrzfrgS0UO3xYveb0ChY8t6fFJFHNTw@mail.gmail.com>
References: <1433509653-15142-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1433509653-15142-2-git-send-email-ranjit.waghmode@xilinx.com>
 <CAM=Q2cue_4tcuu+vHYcrrzfrgS0UO3xYveb0ChY8t6fFJFHNTw@mail.gmail.com>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA71150@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >
> > + */
> > +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool
> > +is_high) {
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(qspi->master);
> > +       u32 genfifoentry = 0x0, statusreg, timeout;
> > +
> > +       genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
> > +       genfifoentry |= xqspi->genfifobus;
> > +
> > +       if (!is_high) {
> > +               genfifoentry |= xqspi->genfifocs;
> > +               genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
> > +       } else {
> > +               genfifoentry |= GQSPI_GENFIFO_CS_HOLD;
> > +       }
> > +
> > +       zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
> > +
> > +       /* Dummy generic FIFO entry */
> > +       zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> > +
> > +       /* Manually start the generic FIFO command */
> > +       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > +                       zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> > +                       GQSPI_CFG_START_GEN_FIFO_MASK);
> > +       timeout = 10000;
> > +       /* Wait until the generic FIFO command is empty */
> > +       do {
> > +               statusreg = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
> > +               timeout--;
>
> Can this be not busy.
Ok, will try to see the other way by which it can be implemented.
>
> > +       } while (!(statusreg &
> > +                  GQSPI_ISR_GENFIFOEMPTY_MASK) &&
> > +                (statusreg & GQSPI_ISR_TXEMPTY_MASK) && timeout);
> > +       if (!timeout)
> > +               dev_err(xqspi->dev, "Chip select timed out\n"); }
> > +
> > +/**
> > + * zynqmp_qspi_setup_transfer: Configure QSPI controller for specified
> > + *                             transfer
> > + * @qspi:      Pointer to the spi_device structure
> > + * @transfer:  Pointer to the spi_transfer structure which provides
> > + *             information about next transfer setup parameters
> > + *
> > + * Sets the operational mode of QSPI controller for the next QSPI
> > +transfer and
> > + * sets the requested clock frequency.
> > + *
> > + * Return:     Always 0
> > + *
> > + * Note:
> > + *     If the requested frequency is not an exact match with what can be
> > + *     obtained using the pre-scalar value, the driver sets the clock
> > + *     frequency which is lower than the requested frequency (maximum lower)
> > + *     for the transfer.
> > + *
> > + *     If the requested frequency is higher or lower than that is supported
> > + *     by the QSPI controller the driver will set the highest or lowest
> > + *     frequency supported by controller.
> > + */
> > +static int zynqmp_qspi_setup_transfer(struct spi_device *qspi,
> > +                                     struct spi_transfer *transfer) {
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(qspi->master);
> > +       ulong clk_rate;
> > +       u32 config_reg, req_hz, baud_rate_val = 0;
> > +
> > +       if (transfer)
> > +               req_hz = transfer->speed_hz;
> > +       else
> > +               req_hz = qspi->max_speed_hz;
> > +
> > +       /* Set the clock frequency */
> > +       /* If req_hz == 0, default to lowest speed */
> > +       clk_rate = clk_get_rate(xqspi->refclk);
> > +
> > +       while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
> > +              (clk_rate /
> > +               (GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > req_hz)
> > +               baud_rate_val++;
> > +
> > +       config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
> > +
> > +       /* Set the QSPI clock phase and clock polarity */
> > +       config_reg &= (~GQSPI_CFG_CLK_PHA_MASK) &
> > + (~GQSPI_CFG_CLK_POL_MASK);
> > +
> > +       if (qspi->mode & SPI_CPHA)
> > +               config_reg |= GQSPI_CFG_CLK_PHA_MASK;
> > +       if (qspi->mode & SPI_CPOL)
> > +               config_reg |= GQSPI_CFG_CLK_POL_MASK;
> > +
> > +       config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
> > +       config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
> > +       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
> > +       return 0;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_setup:  Configure the QSPI controller
> > + * @qspi:      Pointer to the spi_device structure
> > + *
> > + * Sets the operational mode of QSPI controller for the next QSPI
> > +transfer,
> > + * baud rate and divisor value to setup the requested qspi clock.
> > + *
> > + * Return:     0 Always
>
> doesnt seem to be true
Will update this.
>
> > + */
> > +static int zynqmp_qspi_setup(struct spi_device *qspi) {
> > +       if (qspi->master->busy)
> > +               return -EBUSY;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_filltxfifo:     Fills the TX FIFO as long as there is room in
> > + *                             the FIFO or the bytes required to be
> > + *                             transmitted.
> > + * @xqspi:     Pointer to the zynqmp_qspi structure
> > + * @size:      Number of bytes to be copied from TX buffer to TX FIFO
> > + */
> > +static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int
> > +size) {
> > +       u32 count = 0, intermediate;
> > +
> > +       while ((xqspi->bytes_to_transfer > 0) && (count < size)) {
> > +               memcpy(&intermediate, xqspi->txbuf, 4);
> > +               zynqmp_gqspi_write(xqspi, GQSPI_TXD_OFST,
> > + intermediate);
> > +
> > +               if (xqspi->bytes_to_transfer >= 4) {
> > +                       xqspi->txbuf += 4;
> > +                       xqspi->bytes_to_transfer -= 4;
> > +               } else {
> > +                       xqspi->txbuf += xqspi->bytes_to_transfer;
> > +                       xqspi->bytes_to_transfer = 0;
> > +               }
> > +               count++;
> > +       }
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_readrxfifo:     Fills the RX FIFO as long as there is room in
> > + *                             the FIFO.
> > + * @xqspi:     Pointer to the zynqmp_qspi structure
> > + * @size:      Number of bytes to be copied from RX buffer to RX FIFO
> > + */
> > +static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *xqspi, u32
> > +size) {
> > +       ulong data;
> > +       int count = 0;
> > +
> > +       while ((count < size) && (xqspi->bytes_to_receive > 0)) {
> > +               if (xqspi->bytes_to_receive >= 4) {
> > +                       (*(u32 *) xqspi->rxbuf) =
> > +                       zynqmp_gqspi_read(xqspi, GQSPI_RXD_OFST);
> > +                       xqspi->rxbuf += 4;
> > +                       xqspi->bytes_to_receive -= 4;
> > +                       count += 4;
> > +               } else {
> > +                       data = zynqmp_gqspi_read(xqspi, GQSPI_RXD_OFST);
> > +                       count += xqspi->bytes_to_receive;
> > +                       zynqmp_qspi_copy_read_data(xqspi, data,
> > +                                                  xqspi->bytes_to_receive);
> > +                       xqspi->bytes_to_receive = 0;
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * zynqmp_process_dma_irq:     Handler for DMA done interrupt of QSPI
> > + *                             controller
> > + * @xqspi:     zynqmp_qspi instance pointer
> > + *
> > + * This function handles DMA interrupt only.
> > + */
> > +static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi) {
> > +       u32 config_reg, genfifoentry;
> > +
> > +       dma_unmap_single(xqspi->dev, xqspi->dma_addr,
> > +                               xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
> > +       xqspi->rxbuf += xqspi->dma_rx_bytes;
> > +       xqspi->bytes_to_receive -= xqspi->dma_rx_bytes;
> > +       xqspi->dma_rx_bytes = 0;
> > +
> > +       /* Disabling the DMA interrupts */
> why?
Since logic is shifting to IO mode for remaining bytes to transfer, we are not depending on DMA.
>
> > +       zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_DIS_OFST,
> > +
> > + GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
> > +
> > +       if (xqspi->bytes_to_receive > 0) {
> > +               /* Switch to IO mode,for remaining bytes to receive */
> > +               config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
> > +               config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
> > +               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > + config_reg);
> > +
> > +               /* Initiate the transfer of remaining bytes */
> > +               genfifoentry = xqspi->genfifoentry;
> > +               genfifoentry |= xqspi->bytes_to_receive;
> > +               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
> > + genfifoentry);
> > +
> > +               /* Dummy generic FIFO entry */
> > +               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> > +
> > +               /* Manual start */
> > +               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > +                       (zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> > +                       GQSPI_CFG_START_GEN_FIFO_MASK));
> > +
> > +               /* Enable the RX interrupts for IO mode */
> > +               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
> > +                               GQSPI_IER_GENFIFOEMPTY_MASK |
> > +                               GQSPI_IER_RXNEMPTY_MASK |
> > +                               GQSPI_IER_RXEMPTY_MASK);
> > +       }
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_irq:    Interrupt service routine of the QSPI controller
> > + * @irq:       IRQ number
> > + * @dev_id:    Pointer to the xqspi structure
> > + *
> > + * This function handles TX empty only.
> > + * On TX empty interrupt this function reads the received data from
> > +RX FIFO
> > + * and fills the TX FIFO if there is any data remaining to be transferred.
> > + *
> > + * Return:     IRQ_HANDLED when interrupt is handled
> > + *             IRQ_NONE otherwise.
> > + */
> > +static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id) {
> > +       struct spi_master *master = dev_id;
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> > +       int ret = IRQ_NONE;
> > +       u32 status, mask, dma_status = 0;
> > +
> > +       status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
> > +       zynqmp_gqspi_write(xqspi, GQSPI_ISR_OFST, status);
> > +       mask = (status & ~(zynqmp_gqspi_read(xqspi,
> > + GQSPI_IMASK_OFST)));
> > +
> > +       /* Read and clear DMA status */
> > +       if (xqspi->mode == GQSPI_MODE_DMA) {
> > +               dma_status =
> > +                       zynqmp_gqspi_read(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST);
> > +               zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST,
> > +                                                               dma_status);
> > +       }
> > +
> > +       if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
> > +               zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
> > +               ret = IRQ_HANDLED;
> > +       }
> > +
> > +       if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
> > +               zynqmp_process_dma_irq(xqspi);
> > +               ret = IRQ_HANDLED;
> > +       } else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
> > +                       (mask & GQSPI_IER_GENFIFOEMPTY_MASK)) {
> > +               zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
> > +               ret = IRQ_HANDLED;
> > +       }
> > +
> > +       if ((xqspi->bytes_to_receive == 0) && (xqspi->bytes_to_transfer == 0)
> > +                       && ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
> > +               zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST,
> GQSPI_ISR_IDR_MASK);
> > +               spi_finalize_current_transfer(master);
> > +               ret = IRQ_HANDLED;
> > +       }
> > +       return ret;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_selectspimode:  Selects SPI mode - x1 or x2 or x4.
> > + * @xqspi:     xqspi is a pointer to the GQSPI instance
> > + * @spimode:   spimode - SPI or DUAL or QUAD.
> > + * Return:     Mask to set desired SPI mode in GENFIFO entry.
> > + */
> > +static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
> > +                                               u8 spimode) {
> > +       u32 mask = 0;
> > +
> > +       switch (spimode) {
> > +       case GQSPI_SELECT_MODE_DUALSPI:
> > +               mask = GQSPI_GENFIFO_MODE_DUALSPI;
> > +               break;
> > +       case GQSPI_SELECT_MODE_QUADSPI:
> > +               mask = GQSPI_GENFIFO_MODE_QUADSPI;
> > +               break;
> > +       case GQSPI_SELECT_MODE_SPI:
> > +               mask = GQSPI_GENFIFO_MODE_SPI;
> > +               break;
> > +       default:
> > +               dev_warn(xqspi->dev, "Invalid SPI mode\n");
> > +       }
> > +
> > +       return mask;
> > +}
> > +
> > +/**
> > + * zynq_qspi_setuprxdma:       This function sets up the RX DMA operation
> > + * @xqspi:     xqspi is a pointer to the GQSPI instance.
> > + */
> > +static void zynq_qspi_setuprxdma(struct zynqmp_qspi *xqspi) {
> > +       u32 rx_bytes, rx_rem, config_reg;
> > +       dma_addr_t addr;
> > +       u64 dma_align =  (u64)(uintptr_t)xqspi->rxbuf;
> > +
> > +       if ((xqspi->bytes_to_receive < 8) ||
> > +               ((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
> > +               /* Setting to IO mode */
> > +               config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
> > +               config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
> > +               zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
> > +               xqspi->mode = GQSPI_MODE_IO;
> > +               xqspi->dma_rx_bytes = 0;
> > +               return;
> > +       }
> > +
> > +       rx_rem = xqspi->bytes_to_receive % 4;
> > +       rx_bytes = (xqspi->bytes_to_receive - rx_rem);
> > +
> > +       addr = dma_map_single(xqspi->dev, (void *)xqspi->rxbuf,
> > +                                               rx_bytes, DMA_FROM_DEVICE);
> > +       if (dma_mapping_error(xqspi->dev, addr))
> > +               dev_err(xqspi->dev, "ERR:rxdma:memory not mapped\n");
> > +
> > +       xqspi->dma_rx_bytes = rx_bytes;
> > +       xqspi->dma_addr = addr;
> > +       zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_OFST,
> > +                               (u32)(addr & 0xffffffff));
> > +       addr = ((addr >> 16) >> 16);
> > +       zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_MSB_OFST,
> > +                               ((u32)addr) & 0xfff);
> > +
> > +       /* Enabling the DMA mode */
> > +       config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
> > +       config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
> > +       config_reg |= GQSPI_CFG_MODE_EN_DMA_MASK;
> > +       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
> > +
> > +       /* Switch to DMA mode */
> > +       xqspi->mode = GQSPI_MODE_DMA;
> > +
> > +       /* Write the number of bytes to transfer */
> > +       zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_SIZE_OFST,
> > +rx_bytes); }
> > +
> > +/**
> > + * zynqmp_qspi_txrxsetup:      This function checks the TX/RX buffers in
> > + *                             the transfer and sets up the GENFIFO entries,
> > + *                             TX FIFO as required.
> > + * @xqspi:     xqspi is a pointer to the GQSPI instance.
> > + * @transfer:  It is a pointer to the structure containing transfer data.
> > + * @genfifoentry:      genfifoentry is pointer to the variable in which
> > + *                     GENFIFO mask is returned to calling function
> > + */
> > +static void zynqmp_qspi_txrxsetup(struct zynqmp_qspi *xqspi,
> > +                                 struct spi_transfer *transfer,
> > +                                 u32 *genfifoentry) {
> > +       u32 config_reg;
> > +
> > +       /* Transmit */
> > +       if ((xqspi->txbuf != NULL) && (xqspi->rxbuf == NULL)) {
> > +               /* Setup data to be TXed */
> > +               *genfifoentry &= ~GQSPI_GENFIFO_RX;
> > +               *genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
> > +               *genfifoentry |= GQSPI_GENFIFO_TX;
> > +               *genfifoentry |=
> > +                       zynqmp_qspi_selectspimode(xqspi, transfer->tx_nbits);
> > +               xqspi->bytes_to_transfer = transfer->len;
> > +               if (xqspi->mode == GQSPI_MODE_DMA) {
> > +                       config_reg = zynqmp_gqspi_read(xqspi,
> > +                                                       GQSPI_CONFIG_OFST);
> > +                       config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
> > +                       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > +                                                               config_reg);
> > +                       xqspi->mode = GQSPI_MODE_IO;
> > +               }
> > +               zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
> > +               /* Discard RX data */
> > +               xqspi->bytes_to_receive = 0;
> > +       } else if ((xqspi->txbuf == NULL) && (xqspi->rxbuf != NULL)) {
> > +               /* Receive */
> > +
> > +               /* TX auto fill */
> > +               *genfifoentry &= ~GQSPI_GENFIFO_TX;
> > +               /* Setup RX */
> > +               *genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
> > +               *genfifoentry |= GQSPI_GENFIFO_RX;
> > +               *genfifoentry |=
> > +                       zynqmp_qspi_selectspimode(xqspi, transfer->rx_nbits);
> > +               xqspi->bytes_to_transfer = 0;
> > +               xqspi->bytes_to_receive = transfer->len;
> > +               zynq_qspi_setuprxdma(xqspi);
> > +       }
>
> Not a comment rather a query what happens in case of both rx and tx.
SPI core is sending either TX or RX transfer at a time.
>
>
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_start_transfer: Initiates the QSPI transfer
> > + * @master:    Pointer to the spi_master structure which provides
> > + *             information about the controller.
> > + * @qspi:      Pointer to the spi_device structure
> > + * @transfer:  Pointer to the spi_transfer structure which provide information
> > + *             about next transfer parameters
> > + *
> > + * This function fills the TX FIFO, starts the QSPI transfer, and
> > +waits for the
> > + * transfer to be completed.
> > + *
> > + * Return:     Number of bytes transferred in the last transfer
> > + */
> > +static int zynqmp_qspi_start_transfer(struct spi_master *master,
> > +                                     struct spi_device *qspi,
> > +                                     struct spi_transfer *transfer) {
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> > +       u32 genfifoentry = 0x0, transfer_len;
> > +
> > +       xqspi->txbuf = transfer->tx_buf;
> > +       xqspi->rxbuf = transfer->rx_buf;
> > +
> > +       zynqmp_qspi_setup_transfer(qspi, transfer);
> > +
> > +       genfifoentry |= xqspi->genfifocs;
> > +       genfifoentry |= xqspi->genfifobus;
> > +
> > +       zynqmp_qspi_txrxsetup(xqspi, transfer, &genfifoentry);
> > +
> > +       if (xqspi->mode == GQSPI_MODE_DMA)
> > +               transfer_len = xqspi->dma_rx_bytes;
> > +       else
> > +               transfer_len = transfer->len;
> > +
> > +       xqspi->genfifoentry = genfifoentry;
> > +       if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
> > +               genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
> > +               genfifoentry |= transfer_len;
> > +               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
> > +       } else {
> > +               int tempcount = transfer_len;
> > +               u32 exponent = 8;       /* 2^8 = 256 */
> > +               u8 imm_data = tempcount & 0xFF;
> > +
> > +               tempcount &= ~(tempcount & 0xFF);
> > +               /* Immediate entry */
> > +               if (tempcount != 0) {
> > +                       /* Exponent entries */
> > +                       genfifoentry |= GQSPI_GENFIFO_EXP;
> > +                       while (tempcount != 0) {
> > +                               if (tempcount & GQSPI_GENFIFO_EXP_START) {
> > +                                       genfifoentry &=
> > +                                           ~GQSPI_GENFIFO_IMM_DATA_MASK;
> > +                                       genfifoentry |= exponent;
> > +                                       zynqmp_gqspi_write(xqspi,
> > +                                                          GQSPI_GEN_FIFO_OFST,
> > +                                                          genfifoentry);
> > +                               }
> > +                               tempcount = tempcount >> 1;
> > +                               exponent++;
> > +                       }
> > +               }
> > +               if (imm_data != 0) {
> > +                       genfifoentry &= ~GQSPI_GENFIFO_EXP;
> > +                       genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
> > +                       genfifoentry |= (u8) (imm_data & 0xFF);
> > +                       zynqmp_gqspi_write(xqspi,
> > +                                          GQSPI_GEN_FIFO_OFST, genfifoentry);
> > +               }
> > +       }
> > +
> > +       if ((xqspi->mode == GQSPI_MODE_IO) &&
> > +                       (xqspi->rxbuf != NULL)) {
> > +               /* Dummy generic FIFO entry */
> > +               zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> > +       }
> > +
> > +       /* Since we are using manual mode */
> > +       zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> > +                          zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> > +                          GQSPI_CFG_START_GEN_FIFO_MASK);
> > +
> > +       if (xqspi->txbuf != NULL)
> > +               /* Enable interrupts for TX */
> > +               zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
> > +                                  GQSPI_IER_TXEMPTY_MASK |
> > +                                       GQSPI_IER_GENFIFOEMPTY_MASK |
> > +                                       GQSPI_IER_TXNOT_FULL_MASK);
> > +
> > +       if (xqspi->rxbuf != NULL) {
> > +               /* Enable interrupts for RX */
> > +               if (xqspi->mode == GQSPI_MODE_DMA) {
> > +                       /* Enable DMA interrupts */
> > +                       zynqmp_gqspi_write(xqspi,
> > +                                       GQSPI_QSPIDMA_DST_I_EN_OFST,
> > +                                       GQSPI_QSPIDMA_DST_I_EN_DONE_MASK);
> > +               } else {
> > +                       zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
> > +                                       GQSPI_IER_GENFIFOEMPTY_MASK |
> > +                                       GQSPI_IER_RXNEMPTY_MASK |
> > +                                       GQSPI_IER_RXEMPTY_MASK);
> > +               }
> > +       }
> > +
> > +       return transfer->len;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_suspend:        Suspend method for the QSPI driver
> > + * @_dev:      Address of the platform_device structure
> > + *
> > + * This function stops the QSPI driver queue and disables the QSPI
> > +controller
> > + *
> > + * Return:     Always 0
> > + */
> > +static int __maybe_unused zynqmp_qspi_suspend(struct device *dev) {
> > +       struct platform_device *pdev = container_of(dev,
> > +                                                   struct platform_device,
> > +                                                   dev);
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +
> > +       spi_master_suspend(master);
> > +
> > +       zynqmp_unprepare_transfer_hardware(master);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_resume: Resume method for the QSPI driver
> > + * @dev:       Address of the platform_device structure
> > + *
> > + * The function starts the QSPI driver queue and initializes the QSPI
> > + * controller
> > + *
> > + * Return:     0 on success and error value on error
> > + */
> > +static int __maybe_unused zynqmp_qspi_resume(struct device *dev) {
> > +       struct platform_device *pdev = container_of(dev,
> > +                                                   struct platform_device,
> > +                                                   dev);
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> > +       int ret = 0;
>
> is the initialisation required
I will update this.
>
> > +
> > +       ret = clk_enable(xqspi->pclk);
> > +       if (ret) {
> > +               dev_err(dev, "Cannot enable APB clock.\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_enable(xqspi->refclk);
> > +       if (ret) {
> > +               dev_err(dev, "Cannot enable device clock.\n");
> > +               clk_disable(xqspi->pclk);
> > +               return ret;
> > +       }
> > +
> > +       spi_master_resume(master);
> > +
> > +       return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(zynqmp_qspi_dev_pm_ops,
> zynqmp_qspi_suspend,
> > +                        zynqmp_qspi_resume);
> > +
> > +/**
> > + * zynqmp_qspi_probe:  Probe method for the QSPI driver
> > + * @pdev:      Pointer to the platform_device structure
> > + *
> > + * This function initializes the driver data structures and the hardware.
> > + *
> > + * Return:     0 on success and error value on failure
> > + */
> > +static int zynqmp_qspi_probe(struct platform_device *pdev) {
> > +       int ret = 0;
> > +       struct spi_master *master;
> > +       struct zynqmp_qspi *xqspi;
> > +       struct resource *res;
> > +       struct device *dev = &pdev->dev;
> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
> > +       if (!master)
> > +               return -ENOMEM;
> > +
> > +       xqspi = spi_master_get_devdata(master);
> > +       master->dev.of_node = pdev->dev.of_node;
> > +       platform_set_drvdata(pdev, master);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(xqspi->regs)) {
> > +               ret = PTR_ERR(xqspi->regs);
> > +               goto remove_master;
> > +       }
> > +
> > +       xqspi->dev = dev;
> > +       xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
> > +       if (IS_ERR(xqspi->pclk)) {
> > +               dev_err(dev, "pclk clock not found.\n");
> > +               ret = PTR_ERR(xqspi->pclk);
> > +               goto remove_master;
> > +       }
> > +
> > +       xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
> > +       if (IS_ERR(xqspi->refclk)) {
> > +               dev_err(dev, "ref_clk clock not found.\n");
> > +               ret = PTR_ERR(xqspi->refclk);
> > +               goto remove_master;
> > +       }
> > +
> > +       ret = clk_prepare_enable(xqspi->pclk);
> > +       if (ret) {
> > +               dev_err(dev, "Unable to enable APB clock.\n");
> > +               goto remove_master;
> > +       }
> > +
> > +       ret = clk_prepare_enable(xqspi->refclk);
> > +       if (ret) {
> > +               dev_err(dev, "Unable to enable device clock.\n");
> > +               goto clk_dis_pclk;
> > +       }
> > +
> > +       /* QSPI controller initializations */
> > +       zynqmp_qspi_init_hw(xqspi);
> > +
> > +       xqspi->irq = platform_get_irq(pdev, 0);
> > +       if (xqspi->irq <= 0) {
> > +               ret = -ENXIO;
> > +               dev_err(dev, "irq resource not found\n");
> > +               goto remove_master;
> > +       }
> > +       ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
> > +                              0, pdev->name, master);
> > +       if (ret != 0) {
> > +               ret = -ENXIO;
> > +               dev_err(dev, "request_irq failed\n");
> > +               goto remove_master;
> > +       }
>
> Shouldnt the clk disable be called here.
Will update this too.
>
>
> > +       if (master->dev.parent == NULL)
> > +               master->dev.parent = &master->dev;
> > +
> > +       ret = spi_register_master(master);
> > +       if (ret)
> > +               goto clk_dis_all;
> > +
> > +       return 0;
> > +
> > +clk_dis_all:
> > +       clk_disable_unprepare(xqspi->refclk);
> > +clk_dis_pclk:
> > +       clk_disable_unprepare(xqspi->pclk);
> > +remove_master:
> > +       spi_master_put(master);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * zynqmp_qspi_remove: Remove method for the QSPI driver
> > + * @pdev:      Pointer to the platform_device structure
> > + *
> > + * This function is called if a device is physically removed from the
> > +system or
> > + * if the driver module is being unloaded. It frees all resources
> > +allocated to
> > + * the device.
> > + *
> > + * Return:     0 Always
> > + */
> > +static int zynqmp_qspi_remove(struct platform_device *pdev) {
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> > +
> > +       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
> > +       clk_disable_unprepare(xqspi->refclk);
> > +       clk_disable_unprepare(xqspi->pclk);
> > +
> > +       spi_unregister_master(master);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id zynqmp_qspi_of_match[] = {
> > +       { .compatible = "xlnx,zynqmp-qspi-1.0", },
> > +       { /* End of table */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
> > +
> > +static struct platform_driver zynqmp_qspi_driver = {
> > +       .probe = zynqmp_qspi_probe,
> > +       .remove = zynqmp_qspi_remove,
> > +       .driver = {
> > +               .name = "zynqmp-qspi",
> > +               .of_match_table = zynqmp_qspi_of_match,
> > +               .pm = &zynqmp_qspi_dev_pm_ops,
> > +       },
> > +};
> > +
> > +module_platform_driver(zynqmp_qspi_driver);
> > +
> > +MODULE_AUTHOR("Xilinx, Inc.");
> > +MODULE_DESCRIPTION("Xilinx Zynqmp QSPI driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.1.2
> >

Thanks for your review.

Regards,
Ranjit Abhimanyu Waghmode,
ranjit.waghmode at xilinx.com


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
