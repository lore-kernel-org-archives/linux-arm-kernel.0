From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Dec 2016 16:34:21 +0000
Subject: [PATCH v3 2/5] spi: armada-3700: Add support for the FIFO mode
In-Reply-To: <a9b86043-b631-8154-edc8-5abe49e47114@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-3-romain.perier@free-electrons.com>
 <20161205133728.sza2pt4tfkywu35k@sirena.org.uk>
 <a9b86043-b631-8154-edc8-5abe49e47114@free-electrons.com>
Message-ID: <20161207163421.2efafvlpapgdsxwx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 05:19:57PM +0100, Romain Perier wrote:
> Le 05/12/2016 ? 14:37, Mark Brown a ?crit :

> > Why?  If the hardware supports a more efficient mode of operation it
> > doesn't seem sensible not to use it.

> That's just that our customer want to keep both modes, this is why I decided
> to use the more efficient mode by default and disable it via a module
> parameter. Previously the more efficient mode was always enabled, based on
> the "compatible string" of the DT (the PIO mode was simply useless in this
> case and dead code)

Keep that out of tree, if the user wants to do silly things then let
them pay the cost.

> > > +	if (xfer->rx_buf) {
> > > +		/* Set read data length */
> > > +		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
> > > +			     a3700_spi->buf_len);
> > > +		/* Start READ transfer */
> > > +		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> > > +		val &= ~A3700_SPI_RW_EN;
> > > +		val |= A3700_SPI_XFER_START;
> > > +		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> > > +	} else if (xfer->tx_buf) {
> > > +		/* Start Write transfer */

> > So this only supports single duplex transfers but there doesn't seem to
> > be anything that enforces this.

> A flag or a capability, typically? I will investigate

SPI_MASTER_HALF_DUPLEX.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/af74c861/attachment.sig>
