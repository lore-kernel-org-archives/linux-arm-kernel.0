From: gaopan@freescale.com (Gao Pandy)
Date: Mon, 21 Sep 2015 08:13:37 +0000
Subject: [Patch V5] i2c: imx: implement bus recovery
In-Reply-To: <20150921063323.GA754@pengutronix.de>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <20150918075457.GT5327@pengutronix.de>
 <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150921063323.GA754@pengutronix.de>
Message-ID: <CY1PR0301MB085882BC97E7AA60F2BA7F0ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <mailto:u.kleine-koenig@pengutronix.de> Sent: Monday, September 21, 2015 2:33 PM
> To: Gao Pan-B54642
> Cc: Li Frank-B20596; wsa at the-dreams.de; linux-i2c at vger.kernel.org;
> kernel at pengutronix.de; Duan Fugang-B38611; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [Patch V5] i2c: imx: implement bus recovery
> 
> Hello,
> 
> On Mon, Sep 21, 2015 at 04:29:20AM +0000, Gao Pandy wrote:
> > > On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> > > > V5:
> > > >  -introduce a dedicated gpio state for bus recovery.
> > > >  -assign adapter.bus_recovery_info after the two gpios were aquired
> > > >   successfully.
> > >
> > > You also do this if the gpios were not acquired successfully.
> >
> > Thanks. If the gpios are not acquired successfully, the context goes
> > to label clk_disable. So the assignment is skipped.
> > Please see the following code.
> >
> >       ......
> >
> > 	if (IS_ERR(i2c_imx->pins.sda)) {
> > 		ret = PTR_ERR(i2c_imx->pins.sda);
> > 		goto clk_disable;
> > 	}
> > 	if (IS_ERR(i2c_imx->pins.scl)) {
> > 		ret = PTR_ERR(i2c_imx->pins.scl);
> > 		goto clk_disable;
> > 	}
> >
> > 	i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;
> >
> > 	......
> 
> Right, if devm_gpiod_get_optional returns an error probing fails and
> everything is right. If however devm_gpiod_get_optional returns NULL (i.e.
> the dt doesn't contain an scl-gpios property) you happily use them even
> though gpio_set_value are stubs in this case.
 
Thanks, you are right.

> > > IMHO pinctrl_lookup_state returning an error is enough to not try a
> > > recovery.
> >
> > Thanks, you are right. How about the following logic.
> >
> > 	if (!(IS_ERR(i2c_imx->pinctrl_pins_default)) &&
> > !(IS_ERR(i2c_imx->pinctrl_pins_gpio))) {
> 
> After the ! you don't need a (, but apart from this the logic is fine.
> 
> >                 i2c_imx->pins.sda =
> >                         devm_gpiod_get_optional(&pdev->dev, "sda-gpios",
> GPIOD_IN);
> >                 i2c_imx->pins.scl =
> >                         devm_gpiod_get_optional(&pdev->dev,
> > "scl-gpios", GPIOD_IN);
> >
> >                 if (IS_ERR(i2c_imx->pins.sda)) {
> >                         ret = PTR_ERR(i2c_imx->pins.sda);
> >                         goto clk_disable;
> >                 }
> >
> >                 if (IS_ERR(i2c_imx->pins.scl)) {
> >                         ret = PTR_ERR(i2c_imx->pins.scl);
> >                         goto clk_disable;
> >                 }
> 
> As said above, here you need an
> 
> 		if (i2c_imx->pins.scl && i2c_imx->pins.sda)
> >                 i2c_imx->adapter.bus_recovery_info =
> &i2c_imx_bus_recovery_info;
> > 	}
 
Thank you very much, will fix it in next version.

> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
