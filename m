From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Jul 2018 17:12:58 +0100
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <20180701110804.32415-16-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
Message-ID: <20180702161258.GA18744@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 01, 2018 at 01:08:04PM +0200, Andreas F?rber wrote:

> +static void sx1301_radio_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	int ret;
> +
> +	dev_dbg(&spi->dev, "setting SPI CS to %s\n", enable ? "1" : "0");
> +
> +	if (enable)
> +		return;
> +
> +	ret = sx1301_radio_set_cs(spi->controller, enable);
> +	if (ret)
> +		dev_warn(&spi->dev, "failed to write CS (%d)\n", ret);
> +}

So we never disable chip select?

> +	if (tx_buf) {
> +		ret = sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_ADDR, tx_buf ? tx_buf[0] : 0);

This looks confused.  We're in an if (tx_buf) block but there's a use of
the ternery operator that appears to be checking if we have a tx_buf?

> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio address write failed\n");
> +			return ret;
> +		}
> +
> +		ret = sx1301_write(ssx->parent, ssx->regs + REG_RADIO_X_DATA, (tx_buf && xfr->len >= 2) ? tx_buf[1] : 0);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data write failed\n");
> +			return ret;
> +		}

This looks awfully like you're coming in at the wrong abstraction layer
and the hardware actually implements a register abstraction rather than
a SPI one so you should be using regmap as the abstraction.

> +	if (rx_buf) {
> +		ret = sx1301_read(ssx->parent, ssx->regs + REG_RADIO_X_DATA_READBACK, &rx_buf[xfr->len - 1]);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI radio data read failed\n");
> +			return ret;
> +		}
> +	}

For a read we never set an address?

> +static void sx1301_radio_setup(struct spi_controller *ctrl)
> +{
> +	ctrl->mode_bits = SPI_CS_HIGH | SPI_NO_CS;

This controller has no chip select but we provided a set_cs operation?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/318d4e78/attachment-0001.sig>
