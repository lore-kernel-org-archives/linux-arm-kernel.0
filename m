From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Jul 2015 18:49:22 +0100
Subject: [PATCH v3 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <1437642643-11966-4-git-send-email-leilk.liu@mediatek.com>
References: <1437642643-11966-1-git-send-email-leilk.liu@mediatek.com>
 <1437642643-11966-4-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150724174922.GT11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 05:10:42PM +0800, Leilk Liu wrote:

This basically seems fine but there's a couple of issues that should be
relatively easy to fix:

> +	mdata->cur_transfer = xfer;
> +	mtk_spi_prepare_transfer(master, xfer);
> +	mtk_spi_setup_packet(master, xfer);
> +
> +	cnt = (xfer->len % 4) ? (xfer->len / 4 + 1) : (xfer->len / 4);

Please write this as an if statement for legibility.

> +static bool mtk_spi_can_dma(struct spi_master *master,
> +			    struct spi_device *spi,
> +			    struct spi_transfer *xfer)
> +{
> +	struct mtk_spi *mdata = spi_master_get_devdata(master);
> +
> +	if (xfer->len > MTK_SPI_MAX_FIFO_SIZE)
> +		mdata->use_dma = true;
> +	else
> +		mdata->use_dma = false;
> +
> +	return mdata->use_dma;
> +}

This is broken since can_dma() can be called multiple transfers before
actually doing a transfer (the current implementation loops over all
transfers in a message before starting the message) - you can't store
any local data.  The transfer_one() function should do another can_dma()
check to decide if it can DMA, it shouldn't rely on driver global data.  

> +	if (!mdata->use_dma) {
> +		if (trans->rx_buf) {

This should be a variable set when doing the transfer (or perhaps based
on checking spi->cur_xfer with can_dma()). 

> +			for (i = 0; i < trans->len; i++) {
> +				if (i % 4 == 0)
> +					reg_val =
> +					readl(mdata->base + SPI_RX_DATA_REG);
> +				*((u8 *)(trans->rx_buf + i)) =
> +					(reg_val >> ((i % 4) * 8)) & 0xff;

This isn't the clearest code ever...  a comment would help.

> +	if (mdata->tx_sgl && (mdata->tx_sgl_len == 0)) {
> +		mdata->tx_sgl = sg_next(mdata->tx_sgl);
> +		if (mdata->tx_sgl) {
> +			trans->tx_dma = sg_dma_address(mdata->tx_sgl);
> +			mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
> +		}
> +	}

There's a *lot* of code in this interrupt handler, and a lot of it looks
an awful lot like the contents of mtk_spi_dma_transfer() has been
cut'n'pasted in.  The shared code should all be factored out into a
function called from both places.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/752a405e/attachment.sig>
