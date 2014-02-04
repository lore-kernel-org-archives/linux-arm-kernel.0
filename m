From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Feb 2014 14:47:31 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <20140204143119.GA4627@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
Message-ID: <20140204144731.GA3154@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hold your horses. :)

> > > Add a driver for the BCM59056 PMU multi-function device. The driver
> > > initially supports regmap initialization and instantiation of the
> > > voltage regulator device function of the PMU.
> > > 
> > > Signed-off-by: Matt Porter <mporter@linaro.org>
> > > Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> > > Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > > ---
> > >  drivers/mfd/Kconfig          |   8 +++
> > >  drivers/mfd/Makefile         |   1 +
> > >  drivers/mfd/bcm59056.c       | 119 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/bcm59056.h |  35 +++++++++++++
> > >  4 files changed, 163 insertions(+)
> > >  create mode 100644 drivers/mfd/bcm59056.c
> > >  create mode 100644 include/linux/mfd/bcm59056.h

<snip>

> > I thought this was a DT only driver? If so, you probably want to use
> > of_match_device() instead.
> 
> Correct, I'll use of_match_device()

If you're going to use this ...

<snip>

> > You've gone to the trouble of setting a device version here, but you
> > don't seem to use it?
> 
> I'll drop the device version

... then you'll still need this.

> > > +static const struct i2c_device_id bcm59056_i2c_id[] = {
> > > +	{ "bcm59056", BCM59056 },
> > > +	{ }
> > > +};
> > 
> > Ah, I guess this is where id->driver comes from.
> > 
> > It's pretty silly that the I2C subsystem demands the presence of this
> > table, despite not using it if an of_device_id table is present.
> 
> It does make it very difficult to follow DT enabled I2C client drivers
> :( I'll drop the BCM59056 too.

And I don't think you can drop this, as the I2C subsystem still
insists on it.

> > > +/* chip id */
> > > +#define BCM59056		0
> > 
> > Lonely, oh so lonely!
> 
> Understood. Will remove.

I think you need to keep this to supply the silly I2C ID table.

I would just omit the '.data = (void *) VERSION' from the
of_match_table until you require it. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
