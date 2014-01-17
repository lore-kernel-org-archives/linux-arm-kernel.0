From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jan 2014 19:05:16 +0000
Subject: [PATCH 3/4] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140116211201.GC3351@lukather>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140116194003.GN17314@sirena.org.uk>
 <20140116211201.GC3351@lukather>
Message-ID: <20140117190516.GJ17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:12:01PM +0100, Maxime Ripard wrote:
> On Thu, Jan 16, 2014 at 07:40:03PM +0000, Mark Brown wrote:

> > > +	if (status & SUN6I_INT_CTL_RF_OVF) {
> > > +		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
> > > +		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_OVF);
> > > +		return IRQ_HANDLED;
> > > +	}

> > This looks like an overflow - a log message would be helpful for users
> > and you should possibly be flagging an error on the current transfer.

> Hmmm, that was an attempt at receiving more bytes than the FIFO can
> handle, but I guess the FIFO full interrupt would be more appropriate
> for this.

If you've got an overflow interrupt that suggests that the data is
already corrupted, assuming the interrupt isn't misnamed.

> > > +	ret = clk_set_rate(sspi->mclk, 100000000);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Couldn't change module clock rate\n");
> > > +		goto err2;
> > > +	}

> > Does this really need to be fatal (or done at all)?  There seems to be
> > another reasonably flexible divider in the IP and it's more common to
> > either set this per transfer to something that rounds nicely or just use
> > the default and rely on the dividers.

> The default parent of the module clock runs at 24MHz, that means that
> we won't be able to reach a spi clock higher than 12MHz, which seems
> quite low. We can always change the rate in the transfer setup code
> though, if needs be.

12MHz is actually quite a common limit for SPI interfaces (half of a
24MHz master clock like the IP itself has) but yeah, you want to go
higher if you can.  Doing it on transfer setup is going to mean that
you save a little power when you don't need the extra speed too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/4bb27fa4/attachment.sig>
