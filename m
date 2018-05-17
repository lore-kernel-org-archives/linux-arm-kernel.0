From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 14:04:06 +0900
Subject: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <20180511103822.31698-6-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
Message-ID: <20180517050406.GF20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 01:38:21PM +0300, Radu Pirea wrote:

> +config SPI_AT91_USART
> +        tristate "Atmel USART Controller as SPI"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +        select MFD_AT91_USART
> +	help
> +	  This selects a driver for the AT91 USART Controller as SPI Master,
> +	  present on AT91 and SAMA5 SoC series.
> +

This looks like there's some tab/space mixing going on here.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.

Make the entire block a C++ comment so it looks more intentional rather
tha mixing C and C++.

> +static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
> +{
> +	unsigned int len = aus->current_transfer->len;
> +	unsigned int remaining = aus->current_tx_remaining_bytes;
> +	const u8  *tx_buf = aus->current_transfer->tx_buf;
> +
> +	if (tx_buf && remaining) {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, tx_buf[len - remaining]);
> +			aus->current_tx_remaining_bytes--;

Missing braces here - we only write to the FIFO if there's space but we
unconditionally decrement the counter.

> +	} else {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, US_DUMMY_TX);
> +	}
> +}

This looks like you're open coding SPI_CONTROLLER_MUST_TX

> +	int len = aus->current_transfer->len;
> +	int remaining = aus->current_rx_remaining_bytes;
> +	u8  *rx_buf = aus->current_transfer->rx_buf;
> +
> +	if (aus->current_rx_remaining_bytes) {
> +		rx_buf[len - remaining] = spi_readb(aus, RHR);
> +		aus->current_rx_remaining_bytes--;
> +	} else {
> +		spi_readb(aus, RHR);
> +	}

Similarly for _MUST_RX.

> +	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

You're actually setting both flags...  this means that the handling for
cases with missing TX or RX buffers can't happen.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/75f75572/attachment-0001.sig>
