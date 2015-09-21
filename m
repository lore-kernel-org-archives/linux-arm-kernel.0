From: gaopan@freescale.com (Gao Pandy)
Date: Mon, 21 Sep 2015 04:29:20 +0000
Subject: [Patch V5] i2c: imx: implement bus recovery
In-Reply-To: <20150918075457.GT5327@pengutronix.de>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
 <20150918075457.GT5327@pengutronix.de>
Message-ID: <CY1PR0301MB0858E1C589215DBAFBE9E35ECF460@CY1PR0301MB0858.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: linux-i2c-owner@vger.kernel.org <mailto:linux-i2c-owner@vger.kernel.org> Sent: Friday, September 18, 2015 3:55 PM
> To: Gao Pan-B54642
> Cc: wsa at the-dreams.de; shawnguo at kernel.org; kernel at pengutronix.de; linux-
> i2c at vger.kernel.org; Li Frank-B20596; Duan Fugang-B38611; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [Patch V5] i2c: imx: implement bus recovery
> 
> Hello,
> 
> On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> > V5:
> >  -introduce a dedicated gpio state for bus recovery.
> >  -assign adapter.bus_recovery_info after the two gpios were aquired
> successfully.
> 
> You also do this if the gpios were not acquired successfully.
 
Thanks. If the gpios are not acquired successfully, the context goes to label clk_disable. So the assignment is skipped.
Please see the following code.

      ......
  
	if (IS_ERR(i2c_imx->pins.sda)) {
		ret = PTR_ERR(i2c_imx->pins.sda);
		goto clk_disable;
	}
	if (IS_ERR(i2c_imx->pins.scl)) {
		ret = PTR_ERR(i2c_imx->pins.scl);
		goto clk_disable;
	}
	
	i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;

	......


> 
> > +	if (IS_ERR(i2c_imx->pinctrl_pins_default))
> > +		dev_warn(&pdev->dev, "could not get default state\n");
> > +	else {
> > +		i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx-
> >pinctrl,
> > +						I2C_PINCTRL_STATE_GPIO);
> > +		if (IS_ERR(i2c_imx->pinctrl_pins_gpio))
> > +			dev_warn(&pdev->dev, "could not get gpio state\n");
> 
> IMHO pinctrl_lookup_state returning an error is enough to not try a
> recovery.
 
Thanks, you are right. How about the following logic.

	if (!(IS_ERR(i2c_imx->pinctrl_pins_default)) && !(IS_ERR(i2c_imx->pinctrl_pins_gpio))) {
                i2c_imx->pins.sda =
                        devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
                i2c_imx->pins.scl =
                        devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);

                if (IS_ERR(i2c_imx->pins.sda)) {
                        ret = PTR_ERR(i2c_imx->pins.sda);
                        goto clk_disable;
                }

                if (IS_ERR(i2c_imx->pins.scl)) {
                        ret = PTR_ERR(i2c_imx->pins.scl);
                        goto clk_disable;
                }

                i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;
	} 


> 
> > +	}
> > +
> >  	/* Request IRQ */
> >  	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
> >  				pdev->name, i2c_imx);
> > @@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
> >  	if (ret < 0)
> >  		goto rpm_disable;
> >
> > +	/* Init recover pins */
> > +	i2c_imx->pins.sda =
> > +		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
> > +	i2c_imx->pins.scl =
> > +		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);
> > +
> > +	if (IS_ERR(i2c_imx->pins.sda)) {
> > +		ret = PTR_ERR(i2c_imx->pins.sda);
> > +		goto clk_disable;
> > +	}
> > +
> > +	if (IS_ERR(i2c_imx->pins.scl)) {
> > +		ret = PTR_ERR(i2c_imx->pins.scl);
> > +		goto clk_disable;
> > +	}
> > +
> 
> if (i2c_imx->pins.sda && i2c_imx->pins.scl)
> 
> > +	i2c_imx->adapter.bus_recovery_info = &i2c_imx_bus_recovery_info;
> > +
> >  	/* Set up clock divider */
> >  	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
> >  	ret = of_property_read_u32(pdev->dev.of_node,
> 
> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
