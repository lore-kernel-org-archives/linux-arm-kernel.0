From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jan 2014 12:25:20 +0000
Subject: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140129122520.GY11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 12:10:48PM +0100, Maxime Ripard wrote:

> +config SPI_SUN6I
> +	tristate "Allwinner A31 SPI controller"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select PM_RUNTIME
> +	help
> +	  This enables using the SPI controller on the Allwinner A31 SoCs.
> +

A select of PM_RUNTIME is both surprising and odd - why is that there?
The usual idiom is that the device starts out powered up (flagged using
pm_runtime_set_active()) and then runtime PM then suspends it when it's
compiled in.  That way if for some reason people want to avoid runtime
PM they can still use the device.

> +static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
> +	u32 reg;
> +
> +	if (!enable)
> +		return;
> +
> +	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> +	reg &= ~SUN6I_TFR_CTL_CS_MASK;
> +	reg |= SUN6I_TFR_CTL_CS(spi->chip_select);
> +	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
> +}

The !enable means that it'll only ever be able to go one way.  Also note
that the documentation was clarified here to make the enable flag be the
absolute logic level, not if chip select was asserted.

> +	timeout = wait_for_completion_timeout(&sspi->done,
> +					      msecs_to_jiffies(1000));
> +	if (!timeout) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);

This means we can only transfer a single FIFO of data?  I didn't see a
check on the transfer length.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/34ca1e5b/attachment.sig>
