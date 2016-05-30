From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 18:35:57 +0100
Subject: [PATCH v2 1/3] spi: xilinx: Remove bitbang and register with spi
 core
In-Reply-To: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
References: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
Message-ID: <20160530173557.GZ29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 03:16:49PM +0530, Naga Sureshkumar Relli wrote:
> This patch removes the bitbang layer registration.
> it directly register with spi core using spi_register_master and uses
> the call backs provided by spi_master struct.

This is doing a whole bunch of other stuff as well.  

> +/* Register Offsets */
> +#define XSPI_CR_OFFSET		0x60
> +#define XSPI_SR_OFFSET		0x64
> +#define XSPI_TXD_OFFSET		0x68
> +#define XSPI_RXD_OFFSET		0x6c
> +#define XSPI_SSR_OFFSET		0x70
> +#define XIPIF_V123B_DGIER_OFFSET	0x1c
> +#define XIPIF_V123B_IISR_OFFSET		0x20
> +#define XIPIF_V123B_IIER_OFFSET		0x28
> +#define XIPIF_V123B_RESETR_OFFSET	0x40

> -#define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
> -#define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
> -#define XSPI_SR_TX_EMPTY_MASK	0x04	/* Transmit FIFO is empty */
> -#define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
> -#define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */
> -
> -#define XSPI_TXD_OFFSET		0x68	/* Data Transmit Register */
> -#define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */
> -
> -#define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

There's unrelated code motion stuff here.

> +/**
> + * xspi_write32 - Write a value to the device register little endian
> + * @val:	Value to write at the Register offset
> + * @addr:	Register offset
> + *
> + * Write data to the paricular SPI register
> + */
>  static void xspi_write32(u32 val, void __iomem *addr)

There's adding some new documentation.

> -static void xilinx_spi_tx(struct xilinx_spi *xspi)
> -{
> -	u32 data = 0;

And what looks like a total rewrite of even the FIFO stuffing code
rather than the refactoring to go into the new framework that I'd
expect.  As a result of all this it's very hard to review this change,
welcome though it is.  Can you please split this out into a patch series
with smaller changes in each patch rather than one big rewrite
everything patch?

> -	if (!xspi->tx_ptr) {
> -		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
> -		return;
> -	}
> -
> -	switch (xspi->bytes_per_word) {
> -	case 1:
> -		data = *(u8 *)(xspi->tx_ptr);
> -		break;
> -	case 2:
> -		data = *(u16 *)(xspi->tx_ptr);
> -		break;
> -	case 4:
> -		data = *(u32 *)(xspi->tx_ptr);
> -		break;
> -	}
> -
> -	xspi->write_fn(data, xspi->regs + XSPI_TXD_OFFSET);
> -	xspi->tx_ptr += xspi->bytes_per_word;
> -}

For example this refactoring of the FIFO stuffing looks good but ought
to be a separate patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/29369a1b/attachment.sig>
