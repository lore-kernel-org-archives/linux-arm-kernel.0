From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 May 2010 10:23:57 +0100
Subject: [PATCH 5/7] ARM: add PrimeCell generic DMA to PL011 v6
In-Reply-To: <1272848113-29359-1-git-send-email-linus.walleij@stericsson.com>
References: <1272848113-29359-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100507092357.GA19936@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 02:55:13AM +0200, Linus Walleij wrote:
> +	/* Map DMA buffers */
> +	sglen = dma_map_sg(uap->port.dev, &dmarx->scatter_a,
> +			   1, DMA_FROM_DEVICE);
> +	if (sglen != 1)
> +		goto err_rx_sgmap_a;
> +
> +	sglen = dma_map_sg(uap->port.dev, &dmarx->scatter_b,
> +			   1, DMA_FROM_DEVICE);
> +	if (sglen != 1)
> +		goto err_rx_sgmap_b;
> +
> +	sglen = dma_map_sg(uap->port.dev, &dmatx->scatter,
> +			   1, DMA_TO_DEVICE);
> +	if (sglen != 1)
> +		goto err_tx_sgmap;


So as soon as we allocate these, we hand them over to DMA device ownership...

> +	/* Else proceed to copy the TX chars to the DMA buffer and fire DMA */
> +	count = uart_circ_chars_pending(xmit);
> +	if (count > PL011_DMA_BUFFER_SIZE)
> +		count = PL011_DMA_BUFFER_SIZE;
> +
> +	if (xmit->tail < xmit->head)
> +		memcpy(&dmatx->tx_dma_buf[0], &xmit->buf[xmit->tail], count);
> +	else {
> +		size_t first = UART_XMIT_SIZE - xmit->tail;
> +		size_t second = xmit->head;
> +
> +		memcpy(&dmatx->tx_dma_buf[0], &xmit->buf[xmit->tail], first);
> +		memcpy(&dmatx->tx_dma_buf[first], &xmit->buf[0], second);
> +	}

But here we write to the buffers without switching them to CPU ownership.
Only one device of {CPU, DMA} actively owns the DMA buffer at any one time,
and only the active owner is permited under DMA API rules to access that
buffer.

Consider the situation where you've written to the first half of a cache
line, but the DMA device has yet to read from the second half of that
cache line - the result is a corrupted transfer.
