From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 00:21:10 +0000
Subject: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140131224704.GI2950@lukather>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
 <20140131224704.GI2950@lukather>
Message-ID: <20140204002110.GP22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 11:47:04PM +0100, Maxime Ripard wrote:
> On Fri, Jan 31, 2014 at 12:48:09PM +0000, Mark Brown wrote:
> > On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:

> > > +	pm_runtime_enable(&pdev->dev);
> > > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > > +		ret = sun6i_spi_runtime_resume(&pdev->dev);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> > > +			return ret;
> > > +		}
> > > +	}

> > No, as discussed don't do this - notice how other drivers aren't written
> > this way either.  Like I said leave the device powered on startup and
> > then let it be idled by runtime PM.

> Well, some SPI drivers are actually written like that (all the tegra

It's not been done consistently, no - that should be fixed.

> SPI drivers for example). It's not an excuse, but waking up the device
> only to put it back in suspend right away seems kind of

It isn't awesome, no.  Ideally the runtime PM code would do this but
then you couldn't ifdef the operations which as far as I can tell is the
main thing people want from disabling it and it gets complicated for
devices that genuinely do power up on startup so here we are.

> inefficient. Plus, the pm_runtime_idle callback you suggested are
> actually calling runtime_idle, while we want to call runtime_suspend.

Yeah, I didn't actually check if I was looking at the right call there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/f016f8c3/attachment.sig>
