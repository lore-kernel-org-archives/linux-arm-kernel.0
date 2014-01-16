From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jan 2014 19:40:03 +0000
Subject: [PATCH 3/4] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <1389892285-11745-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140116194003.GN17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 06:11:24PM +0100, Maxime Ripard wrote:

Looks pretty clean, a few fairly small things below.

> +- clocks: phandle to the clocks feeding the SPI controller. Two are
> +          needed:
> +  - "ahb": the gated AHB parent clock
> +  - "mod": the parent module clock

I guess you should specify that this needs to be done with clock-names
too then?

> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_SPI_SH_HSPI)		+= spi-sh-hspi.o
>  obj-$(CONFIG_SPI_SH_MSIOF)		+= spi-sh-msiof.o
>  obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
>  obj-$(CONFIG_SPI_SIRF)		+= spi-sirf.o
> +obj-$(CONFIG_ARCH_SUNXI)		+= spi-sun6i.o

I would expect a new Kconfig symbol for this.

> +static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
> +{
> +	u32 reg, cnt;
> +	u8 byte;
> +
> +	/* See how much data are available */

data is available.

> +	while (len--) {
> +		byte = readb(sspi->base_addr + SUN6I_RXDATA_REG);
> +		if (sspi->rx_buf)
> +			*sspi->rx_buf++ = byte;
> +	}

It seems like this hardware is only able to handle bidirectional
operation - this is actually quite common and isn't always as simple as
it is here.  Can I persuade you to put something in the core which
provides dummy data buffers for this case?  I was thinking flags like
must_tx and must_rx or something but didn't get around to this yet.

> +static int sun6i_spi_finish_transfer(struct spi_device *spi,
> +				     struct spi_transfer *tfr,
> +				     bool cs_change)
> +{
> +	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
> +
> +	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
> +
> +	if (tfr->delay_usecs)
> +		udelay(tfr->delay_usecs);

If you implement this using transfer_one() (as you should) the core will
do this for you.

> +	if (status & SUN6I_INT_CTL_RF_OVF) {
> +		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
> +		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_OVF);
> +		return IRQ_HANDLED;
> +	}

This looks like an overflow - a log message would be helpful for users
and you should possibly be flagging an error on the current transfer.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sspi->base_addr = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!sspi->base_addr) {
> +		dev_err(&pdev->dev, "Unable to remap IO\n");
> +		ret = -ENXIO;
> +		goto err;
> +	}

devm_ioremap_resource() is nicer in that it returns an error and then
you don't need to log either since it's noisy itself.

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "No spi IRQ specified\n");
> +		ret = -ENXIO;

Don't overwrite the error code.

> +	ret = clk_set_rate(sspi->mclk, 100000000);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't change module clock rate\n");
> +		goto err2;
> +	}

Does this really need to be fatal (or done at all)?  There seems to be
another reasonably flexible divider in the IP and it's more common to
either set this per transfer to something that rounds nicely or just use
the default and rely on the dividers.

> +	ret = clk_prepare_enable(sspi->mclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't enable clock 'ahb spi'\n");
> +		goto err2;
> +	}

I would recommend moving these to runtime PM so the clocks are only
active when the device is actually in use, the core will do the runtime
PM management if you set auto_runtime_pm so it's really easy to
implement.

> +	ret = reset_control_deassert(sspi->rstc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't deassert the device from reset\n");
> +		goto err3;
> +	}
> +
> +	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
> +			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);

Similarly here the IP could be kept in reset when not in use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140116/523e5d60/attachment.sig>
