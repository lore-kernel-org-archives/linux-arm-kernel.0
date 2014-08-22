From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Aug 2014 19:50:30 -0500
Subject: [PATCH v3] spi: spi-imx: add DMA support
In-Reply-To: <1408593190-1031-1-git-send-email-b38343@freescale.com>
References: <1408593190-1031-1-git-send-email-b38343@freescale.com>
Message-ID: <20140822005030.GR24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 11:53:10AM +0800, Robin Gong wrote:

> Change from v2:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/291722/focus=294363
> 1. dma setup only for imx51-ecspi
> 2. use one small dummy buffer(1 bd size) to templiy store data
>    for meanless rx/tx, instead of malloc the actual transfer size.

You can use the must_tx and must_rx flags to use the core implementation
of this functionality.  This will mean you get any performance or other
improvements we implement there.

> +	int (*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
> +	struct dma_chan *dma_chan_rx;
> +	struct dma_chan *dma_chan_tx;

The SPI controller has variables for this already - you should use them
(and the core support).  In general my main comment on this patch is
that you should be using the core DMA support, it fixes some problems
(like not having mapping for vmalloc() buffers) and factors out some
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/087c20a9/attachment.sig>
