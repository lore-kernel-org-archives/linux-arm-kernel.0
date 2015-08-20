From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:58:50 -0700
Subject: [PATCH 4/9] spi: sun4i: add DMA support
In-Reply-To: <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820185850.GQ12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Emilio L?pez wrote:

> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
> +		/* The receive transfer should be the last one to finish */
> +		dma_wait_for_async_tx(desc_rx);

What if it's a transmit only transfer?  We'll fall over to this...

> +	} else {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	}

...which manually reads data from the FIFO which doesn't seem like what
we want, won't it conflict with the DMA?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/5d89ea8e/attachment.sig>
