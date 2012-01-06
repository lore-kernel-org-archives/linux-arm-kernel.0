From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jan 2012 22:49:30 -0800
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <4F05F509.6020405@metafoo.de>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <4F05F509.6020405@metafoo.de>
Message-ID: <20120106064929.GB3496@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 08:07:53PM +0100, Lars-Peter Clausen wrote:

> > +- lcd,pwrctrl-min-uV: If a regulator controls the Vcc voltage of the lcd panel,
> > +  this property specifies the minimum voltage the regulator should supply.
> > +  The value of this property should in in micro-volts.
> > +- lcd,pwrctrl-max-uV: If a regulator controls the Vcc voltage of the lcd panel,
> > +  this property specifies the maximum voltage the regulator should limit to
> > +  on the Vcc line. The value of this property should in in micro-volts.

> The min and max voltage should rather be specified through the regulator
> constraints.

In principle it should be specified in both places to account for shared
supplies though for all practical purposes for an LCD panel I can't see
multiple users sharing the same regulator and varying the voltage at
runtime.

> > +	if (lcd_enable) {
> > +		if ((pd->min_uV || pd->max_uV) &&
> > +			regulator_set_voltage(lp->regulator,
> > +						pd->min_uV, pd->max_uV))
> > +				dev_info(lp->dev,
> > +					"regulator voltage set failed\n");
> > +		if (regulator_enable(lp->regulator))
> > +			dev_info(lp->dev, "failed to enable regulator\n");
> > +	} else {
> > +		regulator_disable(lp->regulator);
> > +	}

> I think you have to make sure that the regulator enable and disable calls are
> balanced.

Yes.

> > +#ifdef CONFIG_OF

> I think you can remove all the CONFIG_OF ifdefs, the of API should stub itself out.

It's reasonably idiomatic to do this if the parsing code is in a
separate function.
