From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Dec 2016 10:09:09 +0100
Subject: [PATCH 3/7] iio: adc: sun4i-gpadc-iio: add support for A33
 thermal sensor
In-Reply-To: <b668c7f1-99ac-f2ba-eaab-f3c0f9e1cfb2@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-4-quentin.schulz@free-electrons.com>
 <20161220144434.2u6ivige6kdto6an@lukather>
 <b668c7f1-99ac-f2ba-eaab-f3c0f9e1cfb2@free-electrons.com>
Message-ID: <20161221090909.e34jdythb4rsdu57@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 20, 2016 at 04:20:04PM +0100, Quentin Schulz wrote:
> >> +	select MFD_SUN4I_GPADC if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
> > 
> > Why did you change the depends on to a select?
> > 
> 
> The "depends on" does not have an if condition but "select" has. See:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt

I think something like that should work:

depends on (MFD_SUN4I_GPADC && MACH_SUN4I) || MACH_SUN8I

> >> +	depends on THERMAL_OF || MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
> > 
> > So you can't disable THERMAL_OF on MACH_SUN8I?
> > 
> 
> Not in the current state. devm_thermal_zone_of_sensor_register from
> sun4i_gpadc_probe_dt returns an error if THERMAL_OF is disabled and
> thus, the probe fails. Maybe it should rather fail silently and let the
> user choose whether (s)he wants the thermal framework to be able to read
> data from this driver?

I'm usually not a big fan of inconsistencies in the behaviour of
drivers, but let's wait for the second version to discuss that.

> >> +	depends on !TOUCHSCREEN_SUN4I
> > 
> > This should be a different patch.
> > 
> >> +	help
> >> +	  Say yes here to build support for Allwinner (A10, A13, A31 and A33)
> >> +	  SoCs GPADC.
> >> +
> >> +	  The ADC on A10, A13 and A31 provides 4 channels which can be used as
> >> +	  an ADC or as a touchscreen input and one channel for thermal sensor.
> >> +	  Their thermal sensor slows down ADC readings and can be disabled by
> > 
> > Again, I'm not sure putting all those details in the Kconfig help
> > really helps. This is only going to grow with more and more cases, and
> > this isn't something really helpful anyway.
> > 
> 
> Are you suggesting to remove completely the paragraph on why it is
> possible to disable CONFIG_THERMAL_OF for the A10, A13 and A31 or only
> to remove the mention to SoCs?

Both actually :)

> >> @@ -246,6 +269,19 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
> >>  static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> >>  {
> >>  	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	if (info->use_dt) {
> >> +		pm_runtime_get_sync(indio_dev->dev.parent);
> >> +
> >> +		ret = regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> >> +		if (!ret)
> >> +			pm_runtime_mark_last_busy(indio_dev->dev.parent);
> >> +
> >> +		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> >> +
> >> +		return 0;
> >> +	}
> > 
> > Why is runtime_pm linked to the DT support or not?
> > 
> >>  
> >>  	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
> >>  }
> 
> The same runtime_pm functions are called when the driver is not probed
> from DT.
> 
> sun4i_gpadc_read will call sun4i_prepare_for_irq which does a
> pm_runtime_get_sync and then at the end of sun4i_gpadc_read,
> pm_runtime_mark_last_busy and pm_runtime_put_autosuspend are called.
> 
> I just noticed I forgot to add a comment on this one. The A33
> documentation tells us there is an interrupt for the thermal sensor but
> after struggling with it, it is just false. I validated my guess with
> Allwinner Linux kernel which does not wait an interrupt to read the data
> register of the thermal sensor.
> 
> sun4i_gpadc_read always wait for an interrupt before reading data regs,
> so I'm just not calling it and doing the "logic" (reading the data reg
> and interfacing with runtime_pm) directly here in sun4i_gpadc_temp.
> 
> I'll add a comment on this one. Maybe I should create a function just
> for the "logic" of the A33 thermal sensor, so it is less weird than
> currently.

Ok. So this is not really about using the DT or not, but rather
whether you're on an A33 or not. You could probably add a broken_irq
field to test against that.

You should probably share the pm_runtim calls too between the two
cases.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161221/bb0d5df4/attachment.sig>
