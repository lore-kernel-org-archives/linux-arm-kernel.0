From: marex@denx.de (Marek Vasut)
Date: Wed, 1 Aug 2012 04:31:04 +0200
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120731205300.GA25721@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120731205300.GA25721@roeck-us.net>
Message-ID: <201208010431.04399.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Guenter Roeck,

[...]

> > +static int __devexit mxs_spi_remove(struct platform_device *pdev)
> > +{
> > +	struct spi_master *host;
> > +	struct mxs_spi *spi;
> > +	struct mxs_ssp *ssp;
> > +
> > +	host = platform_get_drvdata(pdev);
> > +	spi = spi_master_get_devdata(host);
> > +	ssp = &spi->ssp;
> > +
> > +	spi_unregister_master(host);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	clk_disable_unprepare(ssp->clk);
> > +
> > +	spi_master_put(host);
> > +	kfree(host);
> > +
> 
> Is the kfree() here and in the probe function really necessary ?

It certainly would seem that way.

> Couple of reasons for asking: No other SPI master driver calls it in the
> remove function (unless I missed it), most drivers don't call it in the
> probe function error path, and if I call it in the remove function in a
> SPI master driver I am working on, and load/unload the module several
> times in a row, I get a nasty kernel crash.

It seems the spi_master class takes care of that kfree() in 
spi.c:spi_master_release() . Good catch, thanks!

> Thanks,
> Guenter

Best regards,
Marek Vasut
