From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Mar 2012 20:29:59 +0000
Subject: [PATCH 1/5 v2] ARM: kirkwood: covert orion-spi to fdt.
In-Reply-To: <201203041912.21137.michael@walle.cc>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <a3c65ac8146eab1796dec771c1ddfe403d1471a9.1330709314.git.jason@lakedaemon.net>
 <201203041912.21137.michael@walle.cc>
Message-ID: <201203042030.00064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 March 2012, Michael Walle wrote:
> > @@ -481,8 +485,26 @@ static int __init orion_spi_probe(struct
> > platform_device *pdev) spi->master = master;
> >       spi->spi_info = spi_info;
> > 
> > -     spi->max_speed = DIV_ROUND_UP(spi_info->tclk, 4);
> > -     spi->min_speed = DIV_ROUND_UP(spi_info->tclk, 30);
> > +     if (spi_info)
> > +             spi->tclk = spi_info->tclk;
> > +
> > +     of_property_read_u32(master->dev.of_node,
> > +                             "clock-frequency", &spi->tclk);
> > +
> > +     if (!spi->tclk) {
> > +             dev_err(&pdev->dev, "cannot set clock rate\n");
> shouldn't you check the return value of of_property_read_u32 instead? and 
> report a more meaningful error message, eg no valid clock-frequency property 
> in the OF case?

I suggested this version, because it keeps the code very simple. Checking
the return value would of course be correct, but I don't think we
need any extra information here: there are only a few ways how this can
go wrong and it will be pretty obvious from the device tree when you
see the message.

	Arnd
