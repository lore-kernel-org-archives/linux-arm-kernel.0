From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 23:47:04 +0100
Subject: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140131124809.GE22609@sirena.org.uk>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
Message-ID: <20140131224704.GI2950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 12:48:09PM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:
> 
> > +	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
> > +	if (!master) {
> > +		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
> > +		return -ENOMEM;
> > +	}
> 
> This now depends on your other series which as I said doesn't look like
> the best approach.

Indeed, I forgot to mention it in the cover letter. My bad.

> 
> > +	pm_runtime_enable(&pdev->dev);
> > +	if (!pm_runtime_enabled(&pdev->dev)) {
> > +		ret = sun6i_spi_runtime_resume(&pdev->dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> > +			return ret;
> > +		}
> > +	}
> 
> No, as discussed don't do this - notice how other drivers aren't written
> this way either.  Like I said leave the device powered on startup and
> then let it be idled by runtime PM.

Well, some SPI drivers are actually written like that (all the tegra
SPI drivers for example). It's not an excuse, but waking up the device
only to put it back in suspend right away seems kind of
inefficient. Plus, the pm_runtime_idle callback you suggested are
actually calling runtime_idle, while we want to call runtime_suspend.


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/3f2c9212/attachment.sig>
